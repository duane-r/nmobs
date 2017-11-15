-- Nmobs init.lua
-- Copyright Duane Robertson (duane@duanerobertson.com), 2017
-- Distributed under the LGPLv2.1 (https://www.gnu.org/licenses/old-licenses/lgpl-2.1.en.html)

-- turtle
-- crawling eye (snake eye)
-- ant/termite


local bored_with_standing = 10
local bored_with_walking = 20
local gravity = -10
local noise_rarity = 100
local run_if_cant_hit = 5
local stand_and_fight = 40
local terminal_height = 10
local time_grain = 0.5

-- These relate to making mobs tougher at the outer edges
--  of the world.
local good_loot_chance = 10  -- chance = floor(difficulty - 1) / n
local maximum_multiplier = 5  -- Set this to change the maximum difficulty.
local minimum_multiplier = 1  -- Set this to change the minimum difficulty.
local speed_factor = 0.5  -- Mob speed increases by n * difficulty (2.5).

local hardness = (31000 / maximum_multiplier) / minimum_multiplier


local default_hurts_me = {
  'default:lava_source',
  'default:lava_flowing',
  'fire:basic_flame',
  'fire:permanent_flame',
  'group:surface_hot',
}
nmobs.default_hurts_me = default_hurts_me

local good_loot_table = {
  'default:mese_crystal_fragment',
  'default:diamond',
  'default:gold_lump',
}
nmobs.good_loot_table = good_loot_table

local DEBUG


-- These are the only legitimate properties to pass to register.
local check = {
  {'animation', 'table', false},
  {'armor_class', 'number', false},
  {'aquatic', 'boolean', false},
  {'attacks_player', nil, false},
  {'collisionbox', 'table', false},
  {'damage', 'number', false},
  {'diurnal', 'boolean', false},
  {'drops', 'table', false},
  {'environment', 'table', false},
  {'fly', 'boolean', false},
  {'glow', 'number', false},
  {'higher_than', 'number', false},
  {'hit_dice', 'number', false},
  {'hurts_me', 'table', false},
  {'looks_for', 'table', false},
  {'lower_than', 'number', false},
  {'lifespan', 'number', false},
  {'media_prefix', 'string', false},
  {'mesh', 'string', false},
  {'name', 'string', true},
  {'nodebox', 'table', false},
  {'nocturnal', 'boolean', false},
  {'rarity', 'number', false},
  {'reach', 'number', false},
  {'replaces', 'table', false},
  {'run_speed', 'number', false},
  {'scared', 'boolean', false},
  {'size', 'number', false},
  {'spawn', 'table', false},
  {'sound', 'string', false},
  {'sound_angry', 'string', false},
  {'sound_scared', 'string', false},
  {'step_height', 'number', false},
  {'tames', 'table', false},
  {'textures', 'table', false},
  {'can_dig', 'table', false},
  {'vision', 'number', false},
  {'walk_speed', 'number', false},
  {'weapon_capabilities', 'table', false},
}

-- Don't save these variables between activations.
local skip_serializing = {}
skip_serializing['_last_pos'] = true
skip_serializing['_lock'] = true
skip_serializing['_destination'] = true
skip_serializing['_falling_from'] = true
skip_serializing['_target'] = true


local null_vector = {x=0,y=0,z=0}


local liquids = {}
local nonliquids = {}
for _, n in pairs(minetest.registered_nodes) do
  if n.groups and n.groups.liquid then
    liquids[n.name] = true
  else
    nonliquids[#nonliquids+1] = n.name
  end
end


-- Allow elixirs to multiply player attacks.
local damage_multiplier = {}
local elixirs_mod = minetest.get_modpath('elixirs')


-- Executed by every mob, every step.
function nmobs:step(dtime)
  -- Remove mobs outside of locked state.
  if self._kill_me then
    if DEBUG then
      print('Nmobs: removing a '..self._printed_name..'.')
    end
    self.object:remove()
    return
  end

  -- If the mob is locked, do not execute until the first step
  --  instance finishes.
  if self._lock then
    if DEBUG then
      print('Nmobs: slow response')
    end
    return
  end

  -- Everything else happens in lock state.
  self._lock = true
  self:_fall()

  -- Most behavior only happens once per second.
  self._last_step = self._last_step + dtime
  if self._last_step < time_grain then
    self._lock = nil
    return
  end

  local time = minetest.get_gametime()
  -- Check if a mob has lived too long.
  if not self._owner then
    if (not self._born) or ((time - self._born) > (self._lifespan or 200)) then
      self._kill_me = true
      self._lock = nil
      return
    end
  end

  self._last_step = 0
  local old_state = self._state

  do
    local hp = self.object:get_hp()
    if hp ~= self._hp then
      if hp ~= 2 then
        if DEBUG then
          print('* adjusted '..self.name..'\'s hp to '..hp)
        end
        self._hp = math.floor(hp + 0.5)
      else
        if DEBUG then
          print('** resetting hp -- to fix minetest\'s dumbass entity handling')
        end
        self.object:set_hp(self._hp)
      end
    end
  end

  self:_terrain_effects()

  if self._state ~= 'fighting' then
    self._cant_hit = nil
  end

  if self._state == 'fighting' then
    self:_fight()
  elseif self._state == 'fleeing' then
    self:_flee()
  elseif self._state == 'following' then
    self:_follow()
  elseif self._state == 'scared' then
    self:_run_scared()
  elseif self._state == 'traveling' then
    self:_walk()
  else -- standing
    self:_stand()
  end

  self:_noise()

  if self._animation and self._state ~= old_state then
    self:_change_animation()
  end


  self._lock = nil
  self._last_pos = nil
end


function nmobs:change_animation()  -- self:_change_animation
  if (self._state == 'fleeing' or self._state == 'scared') and self._animation.run then
    self.object:set_animation({x=self._animation.run.start, y=self._animation.run.stop}, self._animation.run.speed or 15, 0, not self._animation.run.noloop)
  elseif (self._state == 'traveling' or self._state == 'following') and self._animation.walk then
    self.object:set_animation({x=self._animation.walk.start, y=self._animation.walk.stop}, self._animation.walk.speed or 15, 0, not self._animation.walk.noloop)
  elseif (self._state == 'fighting') and self._animation.walk then
    self.object:set_animation({x=self._animation.walk.start, y=self._animation.walk.stop}, self._animation.walk.speed or 15, 0, not self._animation.walk.noloop)
  elseif self._animation.stand then
    self.object:set_animation({x=self._animation.stand.start, y=self._animation.stand.stop}, self._animation.stand.speed or 15, 0, not self._animation.stand.noloop)
  end
end


function nmobs:get_pos()  -- self._get_pos
  return self.object:get_pos()

  --if self._last_pos then
  --  return self._last_pos
  --else
  --  self._last_pos = self.object:get_pos()
  --  self._last_pos.y = math.floor(self._last_pos.y + 0.5)
  --  return table.copy(self._last_pos)
  --end
end


function nmobs:fall()  -- self._fall
  local falling
  local grav = gravity
  local pos = self.object:get_pos()
  pos = vector.round(pos)

  if self._fly then
    grav = 0
  end

  local pos_below = table.copy(pos)
  pos_below.y = pos_below.y - 1 + self.collisionbox[2]
  local node_below = minetest.get_node_or_nil(pos_below)

  if node_below and node_below.name == 'air' then
    falling = true
  end

  if not self._falling_from and falling then
    self._falling_from = pos.y
  elseif self._falling_from and not falling then
    if self._falling_from - pos.y > terminal_height then
      self._kill_me = true
      return
    end
    self._falling_from = nil
  end

  local node = minetest.get_node_or_nil(pos)
  if node and liquids[node.name] then
    if self._aquatic then
      grav = 0
    else
      grav = 1
    end
  end

  self.object:set_acceleration({x=0, y=grav, z=0})
end


function nmobs:line_of_sight(p1, p2)  -- _line_of_sight
  if not p1 or not p2 then
    print('nmobs: los function received bad parameters')
    return
  end

  local b = table.copy(p1)
  local los
  for i = 1, 100 do
    if vector.distance(b, p2) < 1 then
      return true
    end

    los, b = minetest.line_of_sight(b, p2)
    if los then
      return los
    end

    local n = minetest.get_node_or_nil(b)
    if not n or not minetest.registered_items[n.name] then
      return
    end

    if minetest.registered_items[n.name].walkable then
      return
    end

    local d = vector.direction(b, p2)
    b = vector.add(b, d)
  end
end


function nmobs:fight()  -- self._fight
  if not self._target then
    self._state = 'standing'
    return
  end

  local opponent_pos = self._target:get_pos()

  opponent_pos.y = opponent_pos.y + 1

  if self._aquatic then
    local n = minetest.get_node_or_nil(opponent_pos)
    if not n or not self._environment_match[n.name] then
      self.object:set_velocity(null_vector)
      self._state = 'fleeing'
      return
    end
  end

  local dist = vector.distance(self:_get_pos(), opponent_pos) - self.collisionbox[4] + self.collisionbox[1]
  if dist > self._vision then
    -- out of range
    self._target = nil
    self._state = 'standing'
    return
  end

  if dist < self._reach_eff then
    local p = self:_get_pos()
    p.y = p.y + self._viewpoint
    local los = self:_line_of_sight(p, opponent_pos)
    p.y = p.y + 1
    opponent_pos.y = opponent_pos.y + 1
    los = los or self:_line_of_sight(p, opponent_pos)

    if los then
      -- in punching range
      local thp = self._target:get_hp()
      self:_punch(self._target, 1, self._weapon_capabilities)
      if thp - self._target:get_hp() >= 1 then
        self._cant_hit = minetest.get_gametime()
      end
    end
  end

  if dist < self._reach_eff then
    local dir = nmobs.dir_to_target(self:_get_pos(), opponent_pos) + math.random()
    self.object:set_yaw(dir)
    self.object:set_velocity(null_vector)
  else
    -- chasing
    self._destination = self._target:get_pos()
    self:_travel(self._run_speed)
  end
end


function nmobs:punch(target, delay, capabilities)  -- self._punch
  if self._fractional_damage and self._fractional_damage > 1 and math.random(self._fractional_damage) ~= 1 then
    return
  end

  return target:punch(self.object, delay, capabilities, nil)
end


-- Mobs flee when wounded.
function nmobs:flee()  -- self._flee
  nmobs.walk_run(self, self._run_speed, 'flee', self._scared and nil or stand_and_fight, 'fighting')
end


-- Scared mobs just run away.
function nmobs:run_scared()  -- self._run_scared
  nmobs.walk_run(self, self._run_speed, 'flee', nil, 'walking')
end


function nmobs:follow()  -- self._follow
  if not self._owner then
    self._state = 'standing'
    return
  end

  local player = minetest.get_player_by_name(self._owner)
  if not player then
    self._state = 'standing'
    return
  end

  self._destination = player:get_pos()

  local pos = self:_get_pos()
  if vector.horizontal_distance(pos, self._destination) < self._walk_speed * 2 then
    self.object:set_velocity(null_vector)
    return
  end

  self:_travel(self._walk_speed)
end


function nmobs:walk()  -- self._walk
  if self:_fearful_behavior() or self:_aggressive_behavior() then
    return
  end

  -- This is a cheat to make more player-navigable tunnels.
  if self._diggable then
    local pos = self:_get_pos()
    pos.y = pos.y + 1
    local nodes = minetest.find_nodes_in_area(pos, pos, self._diggable)
    if nodes and #nodes > 0 and not minetest.is_protected(pos, '') then
      minetest.set_node(pos, {name='air'})
    end
  end

  nmobs.walk_run(self, self._walk_speed, 'looks_for', bored_with_walking, 'standing')
end


function nmobs:stand()  -- self._stand
  if self:_fearful_behavior() or self:_aggressive_behavior() then
    return
  end

  self.object:set_velocity(null_vector)
  self._destination = nil

  self:_replace()

  if math.random(bored_with_standing) == 1 then
    self._destination = self:_new_destination('looks_for')
    if self._destination then
      self._state = 'traveling'
      return
    else
      --print('Nmobs: Error finding destination')
    end
  end
end


function nmobs:noise()  -- self._noise
  local odds = noise_rarity
  local sound

  if self._sound then
    sound = self._sound
  end

  if self._state == 'fleeing' then
    odds = math.floor(odds / 20)
    sound = self._sound_scared or sound
  elseif self._state == 'fighting' then
    odds = math.floor(odds / 10)
    sound = self._sound_angry or sound
  elseif self._state == 'standing' then
    odds = math.floor(odds / 2)
  end

  if sound and math.random(odds) == 1 then
    minetest.sound_play(sound, {object = self.object})
  end
end


-- This just combines the walk/flee code, since they're very similar.
function nmobs.walk_run(self, max_speed, new_dest_type, fail_chance, fail_action)
  -- the chance of tiring and stopping or fighting
  if fail_chance and fail_action and math.random(fail_chance) == 1 then
    self._state = fail_action
    return
  end

  local pos = self:_get_pos()

  if not self._destination then
    self._destination = self:_new_destination(new_dest_type, self._target)
  end

  if self._destination then
    if vector.horizontal_distance(pos, self._destination) < max_speed * 2 then
      -- We've arrived.
      self._destination = nil
      if self._state ~= 'fleeing' then
        self._state = fail_action
      end
      self.object:set_velocity(null_vector)
    else
      local speed = max_speed
      if self.object:get_hp() <= self._hit_dice then
        -- Severe wounds slow the mob.
        speed = 1
      end
      self:_travel(speed)
    end
  else
    self._state = fail_action
    self.object:set_velocity(null_vector)

    -- Turn it around, just for appearance's sake.
    local yaw = self.object:get_yaw()
    if yaw < math.pi then
      yaw = yaw + math.pi
    else
      yaw = yaw - math.pi
    end
    self.object:set_yaw(yaw)
  end
end


function nmobs:tunnel()  -- self._tunnel
  local pos = self:_get_pos()
  self._chose_destination = minetest.get_gametime()

  -- Pick the node in the proper direction.
  local dir = vector.direction(pos, self._destination)
  if math.abs(dir.x) > math.abs(dir.z) then
    dir.x = dir.x > 0 and 1 or -1
    dir.z = 0
  else
    dir.x = 0
    dir.z = dir.z > 0 and 1 or -1
  end
  dir.y = self._destination.y > pos.y and (math.random(2) - 1) or 0

  -- Check if the node can be dug.
  local next_pos = vector.add(pos, dir)
  local nodes = minetest.find_nodes_in_area(vector.subtract(next_pos, self._reach_eff - 1), vector.add(next_pos, self._reach_eff - 1), self._diggable)
  if nodes and #nodes > 0 then
    local p = nodes[math.random(#nodes)]
    if minetest.is_protected(p, '') then
      return
    end

    if DEBUG then
      local node = minetest.get_node_or_nil(p)
      print('A '..self._printed_name..' tunnels a '..node.name..'.')
    end

    minetest.set_node(p, {name='air'})

    -- Move into the space.
    dir.y = 0
    self.object:set_velocity(dir)
    return true
  end
end


function nmobs:travel(speed)  -- self._travel
  -- Actually move the mob.
  local target

  -- Why doesn't this ever work?
  local path -- = minetest.find_path(pos,self._destination,10,2,2,'A*_noprefetch')
  if path then
    if DEBUG then
      print('pathing')
    end
    target = path[1]
  else
    target = self._destination
  end

  local pos = self:_get_pos()
  local dir = nmobs.dir_to_target(pos, target) + math.random() * 0.5 - 0.25

  if self._aquatic and self._state ~= 'fleeing' then
    local n = minetest.get_node_or_nil(pos)
    if not n or not self._environment_match[n.name] then
      self.object:set_velocity(vector.subtract({x=0,y=0,z=0}, self.object:get_velocity()))
      self._destination = nil
      self._state = 'fleeing'
      return
    end
  end

  do
    local velocity = self.object:get_velocity()
    local actual_speed = vector.horizontal_length(velocity)

    if actual_speed < 0.5 and minetest.get_gametime() - self._chose_destination > 1.5 then
      -- We've hit an obstacle.
      if self.collisionbox[5] - self.collisionbox[2] < 0.5 and math.random(2) == 1 then
        pos.y = pos.y + 1
        self.object:set_pos(pos)
      else
        if not self._diggable then
          self._destination = nil
        elseif self:_tunnel() then
          return
        end
      end
    end
  end

  local v = {x=0, y=0, z=0}
  self.object:set_yaw(dir)
  v.x = - speed * math.sin(dir)
  v.z = speed * math.cos(dir)
  if self._fly or self._aquatic then
    local off = target.y - pos.y
    if off ~= 0 then
      v.y = speed * off / math.abs(off) / 2
    end
  end
  self.object:set_velocity(v)
end


function nmobs:new_destination(dtype, object)  -- self._new_destination
  local dest
  local minp
  local maxp
  local pos = self:_get_pos()

  self._chose_destination = minetest.get_gametime()

  if self._tether then
    minp = vector.subtract(self._tether, 5)
    maxp = vector.add(self._tether, 5)
  end

  pos.y = pos.y + self.collisionbox[2]

  if dtype == 'looks_for' and self._looks_for then
    if not self._tether then
      minp = vector.subtract(pos, 10)
      maxp = vector.add(pos, 10)
      if not self._fly then
        minp.y = pos.y - 3
        maxp.y = pos.y + 3
      end
    end

    local nodes = minetest.find_nodes_in_area(minp, maxp, self._looks_for)
    if nodes and #nodes > 0 then
      dest = nodes[math.random(#nodes)]
    end
  elseif dtype == 'flee' and object then
    local opos = object:get_pos()

    if not self._tether then
      local toward = vector.add(pos, vector.direction(opos, pos))
      minp = vector.subtract(toward, 15)
      maxp = vector.add(toward, 15)
      if not (self._fly or self._aquatic) then
        minp.y = pos.y - 3
        maxp.y = pos.y + 3
      end
    end

    local nodes
    if self._aquatic then
      nodes = minetest.find_nodes_in_area(minp, maxp, self._environment)
    else
      nodes = minetest.find_nodes_in_area_under_air(minp, maxp, nonliquids)
    end

    if nodes and #nodes > 0 then
      dest = nodes[math.random(#nodes)]
    end
  end

  if (not dest or math.random(10) == 1) and not self._aquatic then
    if not self._tether then
      minp = vector.subtract(pos, 15)
      maxp = vector.add(pos, 15)
      if not self._fly then
        minp.y = pos.y - 3
        maxp.y = pos.y + 3
      end
    end

    local nodes = minetest.find_nodes_in_area_under_air(minp, maxp, nonliquids)
    if nodes and #nodes > 0 then
      dest = nodes[math.random(#nodes)]
    end
  end

  return dest
end


function nmobs.dir_to_target(pos, target)
  local direction = vector.direction(pos, target)

  if direction.x == 0 then
    direction.x = 0.1
  end

  local dir = (math.atan(direction.z / direction.x) + math.pi / 2)
  if target.x > pos.x then
    dir = dir + math.pi
  end

  return dir
end


function nmobs:fearful_behavior()  -- self._fearful_behavior
  if self._scared and not self._owner and not nmobs.nice_mobs then
    local prey = self:_find_prey()
    if prey then
      self._target = prey
      self._chose_destination = minetest.get_gametime()
      self._state = 'scared'
      return true
    end
  end
end


function nmobs:aggressive_behavior()  -- self._aggressive_behavior
  if self._attacks_player and not self._owner and not nmobs.nice_mobs then
    if type(self._attacks_player) == 'number' and math.random(100) > self._attacks_player then
      return
    end

    local prey = self:_find_prey()
    if prey then
      self._target = prey
      self._chose_destination = minetest.get_gametime()
      self._state = 'fighting'
      return true
    end
  end
end


function nmobs:find_prey()  -- self._find_prey
  local prey = {}

  for _, player in pairs(minetest.get_connected_players()) do
    local opos = player:get_pos()
    opos.y = opos.y + 1.5
    local p = self:_get_pos()
    p.y = p.y + self._viewpoint
    if vector.distance(p, opos) < self._vision and self:_line_of_sight(p, opos) then
      if self._aquatic then
        local n = minetest.get_node_or_nil(opos)
        if n and self._environment_match[n.name] then
          prey[#prey+1] = player
        end
      else
        prey[#prey+1] = player
      end
    end
  end
  if #prey > 0 then
    return prey[math.random(#prey)]
  end
end


function nmobs:simple_replace(replaces, with)
  if not (replaces and type(replaces) == 'table' and with and type(with) == 'table') then
    return
  end

  local pos = self:_get_pos()

  for r = 1, 1 + self._reach_eff do
    local minp = vector.subtract(pos, r)
    local maxp = vector.add(pos, r)
    local nodes = minetest.find_nodes_in_area(minp, maxp, replaces)

    if nodes and #nodes > 0 then
      local dpos = nodes[math.random(#nodes)]
      if not minetest.is_protected(dpos, '') then
        local node = minetest.get_node_or_nil(dpos)
        minetest.set_node(dpos, {name='air'})
        local wnode = with[math.random(#with)]
        minetest.set_node(dpos, {name=wnode})
        if DEBUG then
          print('Nmobs: a '..self._printed_name..' replaced '..node.name..' with '..wnode..'.')
        end
        return
      end
    end
  end
end


function nmobs:replace()  -- _replace
  if not self._replaces then
    return
  end

  local pos = self:_get_pos()
  --pos.y = pos.y + 0.5
  --pos = vector.round(pos)

  for _, instance in pairs(self._replaces) do
    for non_loop = 1, 1 do
      local with = instance.with or {'air'}
      if not type(with) == 'table' and #with > 0 then
        break
      end

      local when = instance.when or 10
      if not instance.replace or type(when) ~= 'number' or math.random(when) ~= 1 then
        break
      end

      for r = 1, 1 + self._reach_eff do
        local minp = vector.subtract(pos, r)
        if not (instance.down or instance.floor) then
          minp.y = pos.y
        end

        local maxp = vector.add(pos, r)
        if instance.floor then
          maxp.y = pos.y - 1
          minp.y = maxp.y
        end

        local nodes = minetest.find_nodes_in_area(minp, maxp, instance.replace)

        if nodes and #nodes > 0 then
          local dpos = nodes[math.random(#nodes)]
          if not minetest.is_protected(dpos, '') then
            local node = minetest.get_node_or_nil(dpos)
            local wnode = with[math.random(#with)]
            if not minetest.registered_items[wnode] then
              break
            end
            minetest.set_node(dpos, {name=wnode})
            if DEBUG then
              print('Nmobs: a '..self._printed_name..' replaced '..node.name..' with '..wnode..'.')
            end
            return
          end
        end
      end
    end
  end
end


function nmobs:terrain_effects()  -- self._terrain_effects
  local bug = true
  local pos = self:_get_pos()
  pos.y = pos.y + self.collisionbox[2]
  local p = minetest.find_node_near(pos, 1 + self.collisionbox[4], self._hurts_me, true)
  if p then
    self._hp = math.floor(self._hp - 2 + 0.5)
    self.object:set_hp(self._hp)
    self._state = 'fleeing'
    if DEBUG then
      local node = minetest.get_node_or_nil(p) or {name = '?'}
      print('*'..self.name..' takes damage from '..node.name..' -- '..self._hp..' hp')
    end

    if self._hp <= 0 and bug then
      self._kill_me = true
    end
  end
end


function nmobs:take_punch(puncher, time_from_last_punch, tool_capabilities, dir, damage)
  local hp = self.object:get_hp()
  local bug = true -- bug in minetest code prevents damage calculation

  local e_mult = 1
  local player_name
  if puncher and puncher.get_player_name then
    player_name = puncher:get_player_name()
    e_mult = damage_multiplier[player_name] or 1
  end

  if nmobs.nice_mobs or self._owner then
    return true
  end

  if bug or e_mult ~= 1 then
    local armor = self.object:get_armor_groups()
    local time_frac = 1
    local adj_damage
    if tool_capabilities and tool_capabilities.damage_groups then
      if tool_capabilities.full_punch_interval == 0 then
        tool_capabilities.full_punch_interval = 1
      end

      time_frac = math.limit(time_from_last_punch / tool_capabilities.full_punch_interval, 0, 1)
      for grp, dmg in pairs(tool_capabilities.damage_groups) do
        if not adj_damage then
          adj_damage = 0
        end

        adj_damage = adj_damage + dmg * time_frac * e_mult * (armor[grp] or 0) / 100
        if DEBUG then
          print('Nmobs: adj_damage ('..grp..') -- '..adj_damage)
        end
      end
    end

    if not adj_damage then
      adj_damage = damage
    end

    if DEBUG then
      print('Nmobs: adj_damage -- '..adj_damage)
    end

    -------------------------
    -- * display damage *
    -------------------------

    adj_damage = math.floor(adj_damage + 0.5)

    if player_name then
      minetest.chat_send_player(player_name, 'You did '..adj_damage..' damage.')
    end

    hp = math.max(0, hp - adj_damage)
    self._hp = math.floor(hp + 0.5)
    self.object:set_hp(self._hp)
  else
    hp = hp - damage
  end

  if hp < 1 then
    if bug then
      self._kill_me = true
    end

    if player_name and puncher:get_inventory() then
      for _, drop in ipairs(self._drops) do
        if drop.name and minetest.registered_items[drop.name] and (not drop.chance or math.random(1, drop.chance) == 1) then
          puncher:get_inventory():add_item("main", ItemStack(drop.name.." "..math.random((drop.min or 1), (drop.max or 1))))
        end
      end

      -- Give extra loot for (positionally) tough mobs.
      if self._difficulty and good_loot_table then
        local chance = math.floor(self._difficulty - 1)

        if math.random(good_loot_chance) <= chance then
          local loot = good_loot_table[math.random(#good_loot_table)]
          local num = 1
          puncher:get_inventory():add_item("main", ItemStack(loot.." "..num))
        end
      end
    end
  end

  if not self._cant_hit then
    self._cant_hit = minetest.get_gametime()
  end

  self._target = puncher
  self._chose_destination = minetest.get_gametime()
  if puncher and vector.distance(self:_get_pos(), puncher:get_pos()) > self._vision then
    self._state = 'fleeing'
  elseif puncher and self._cant_hit and minetest.get_gametime() - self._cant_hit > run_if_cant_hit then
    self._state = 'fleeing'
  elseif hp < damage * 2 then
    self._state = 'fleeing'
  else
    self._state = 'fighting'
  end

  return bug
end


function nmobs:activate(staticdata, dtime_s)
  -- This isn't a great place, but I want this assigned after
  --  the game starts.
  if elixirs_mod and elixirs and elixirs.damage_multiplier then
    damage_multiplier = elixirs.damage_multiplier
  end

  if staticdata then
    local data = minetest.deserialize(staticdata)
    if data and type(data) == 'table' then
      for k, d in pairs(data) do
        self[k] = d
      end
    end
  end

  self.object:set_armor_groups(self._armor_groups)
  self._state = 'standing'
  self._chose_destination = 0
  for prop, _ in pairs(skip_serializing) do
    self[prop] = nil
  end

  self.object:set_velocity(null_vector)
  if self._hp then
    self.object:set_hp(self._hp)
  elseif self._born then
    self._kill_me = true
    return
  end

  self.object:set_properties({
    textures = self.textures[math.random(#self.textures)],
  })

  if not self._born then
    self._born = minetest.get_gametime()
    local pos = vector.round(self.object:get_pos())

    local hp = 1
    if self._hit_dice < 1 then
      hp = hp + math.floor(self._hit_dice * 4)
    else
      for i = 1, self._hit_dice do
        hp = hp + math.random(8)
      end
    end

    -- This keeps sky realm mobs from becoming harder.
    --local y = (pos.y > 0) and 0 or pos.y

    -- Make mobs at the edges of the world tougher (even bunnies).
    local factor = 1 + (math.max(math.abs(pos.x), math.abs(pos.y), math.abs(pos.z)) * minimum_multiplier / hardness)

    hp = math.floor(hp * factor + 0.5)
    self._hp = hp
    self.object:set_hp(self._hp)
    self._damage = self._damage * factor
    --if change_walk_velocity then
    --  self._walk_speed = self._walk_speed * math.max(1, speed_factor * factor)
    --end
    self._run_speed = self._run_speed * math.max(math.min(self._walk_speed, 1), speed_factor * factor)
    self._difficulty = factor

    if DEBUG then
      print('Nmobs: activated a '..self._printed_name..' with '..hp..' HP (factor: '..(math.floor(factor * 100) / 100)..') at ('..pos.x..','..pos.y..','..pos.z..'). Game time: '..self._born)
    end
  end

  if self._sound then
    minetest.sound_play(self._sound, {object = self.object})
  end
end

function nmobs:get_staticdata()
  if not self._born then
    return
  end

  local data = {}

  for k, d in pairs(self) do
    if k:find('^_') and not skip_serializing[k] and not nmobs.mobs[self._name][k] then
      data[k] = d
    end
  end

  return minetest.serialize(data)
end


function nmobs.abm_callback(name, pos, node, active_object_count, active_object_count_wider)
  local proto = nmobs.mobs[name]
  if proto.lower_than and pos.y >= proto.lower_than then
    return
  end
  if proto.higher_than and pos.y <= proto.higher_than then
    return
  end
  if pos.y > -50 and (proto._nocturnal or proto._diurnal) then
    local time = minetest.get_timeofday()
    if proto._nocturnal and time > 0.15 and time < 0.65 then
      return
    elseif proto._diurnal and time < 0.15 or time > 0.65 then
      return
    end
  end

  local pos_above = {x=pos.x, y=pos.y+1, z=pos.z}
  local node_above = minetest.get_node_or_nil(pos_above)
  if node_above and node_above.name == 'air' and active_object_count < 3 then
    pos_above.y = pos_above.y + 2
    minetest.add_entity(pos_above, 'nmobs:'..name)
    if DEBUG then
      print('Nmobs: adding '..name)
    end
  end
end


function nmobs:on_rightclick(clicker)
  local player_name = clicker:get_player_name()

  if not self._tames then
    minetest.chat_send_player(player_name, 'You can\'t tame a '..self._printed_name..' that way.')

    if self._sound then
      minetest.sound_play(self._sound, {object = self.object})
    end

    return
  end

  -- check item
  --local hand = clicker:get_wielded_item()

  if not self._owner then
    self._state = 'following'
    self._owner = clicker:get_player_name()
    minetest.chat_send_player(player_name, 'You have tamed the '..self._printed_name..'.')
    return
  elseif self._owner == player_name then
    if self._state == 'following' then
      self._tether = self.object:get_pos()
      self._state = 'standing'
      minetest.chat_send_player(player_name, 'Your '..self._printed_name..' is tethered here.')
      return
    else
      minetest.chat_send_player(player_name, 'Your '..self._printed_name..' is following you.')
      self._state = 'following'
      return
    end
  elseif self._sound then
    minetest.sound_play(self._sound, {object = self.object})
  end
end


function nmobs.register_mob(def)
  local good_def = {}

  -- Check for legitimate properties.
  for _, att in pairs(check) do
    if att[3] and not def[att[1]] then
      print('Nmobs: registration missing '..att[1])
      return
    end

    if def[att[1]] and ((not att[2]) or type(def[att[1]]) == att[2]) then
      good_def[att[1]] = def[att[1]]
    end
  end

  -- Allow overrides (mainly for functions).
  for att, val in pairs(def) do
    if att:find('^_') then
      good_def[att] = val
    end
  end

  local name = good_def.name:gsub('^.*:', '')
  name = name:lower()
  name = name:gsub('[^a-z0-9]', '_')
  name = name:gsub('^_+', '')
  name = name:gsub('_+$', '')
  good_def.size = good_def.size or 1

  if not good_def.media_prefix then
    good_def.media_prefix = 'nmobs'
  end
  if not good_def.textures then
    local t = {
      good_def.media_prefix..'_'..name..'_top.png',
      good_def.media_prefix..'_'..name..'_bottom.png',
      good_def.media_prefix..'_'..name..'_right.png',
      good_def.media_prefix..'_'..name..'_left.png',
      good_def.media_prefix..'_'..name..'_front.png',
      good_def.media_prefix..'_'..name..'_back.png',
    }

    good_def.textures = t
  end

  if good_def.nodebox then
    local node = {
      drawtype = 'nodebox',
      node_box = {
        type = 'fixed',
        fixed = good_def.nodebox,
      },
      tiles = good_def.textures,
    }

    local reg_name = 'nmobs:'..name..'_block'
    if not reg_name:find('^:') then
      reg_name = reg_name:gsub('^', ':')
    end
    minetest.register_node(reg_name, node)
  end

  -- Make a useful collision box.
  local cbox = good_def.collisionbox
  if not cbox then
    if good_def.nodebox then
      -- measure nodebox
      cbox = {999, 999, 999, -999, -999, -999} 
      for _, box in pairs(good_def.nodebox) do
        for i = 1, 3 do
          if box[i] < cbox[i] then
            cbox[i] = box[i]
          end
        end
        for i = 4, 6 do
          if box[i] > cbox[i] then
            cbox[i] = box[i]
          end
        end
      end
      -- Since the collision box doesn't turn with the mob,
      --  make it the average of the z and x dimentions.
      cbox[1] = (cbox[1] + cbox[3]) / 2
      cbox[4] = (cbox[4] + cbox[6]) / 2
      cbox[3] = cbox[1]
      cbox[6] = cbox[4]

      local add = 0.3 - (cbox[5] - cbox[2])
      if add > 0 then
        if cbox[5] < 0.5 - add then
          cbox[5] = cbox[5] + add
        elseif cbox[2] > -0.5 + add then
          cbox[2] = cbox[2] - add
        end
      end
    else
      cbox = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5} 
    end
  end

  local sz = {x=0.66, y=0.66, z=0.66}  -- Why aren't objects the same size as nodes?
  sz = vector.multiply(sz, good_def.size)
  for i = 1, #cbox do
    cbox[i] = cbox[i] * good_def.size
  end

  if not good_def.damage or good_def.damage <= 0 then
    good_def.damage = 1
  elseif good_def.damage < 1 then
    good_def._fractional_damage = math.floor(1 / good_def.damage)
    good_def.damage = 1
  end

  if not good_def.weapon_capabilities then
    good_def.weapon_capabilities = {
      full_punch_interval=1,
      damage_groups = {fleshy=good_def.damage},
    }
  end

  if not good_def.armor_class then
    good_def.armor = {fleshy = 100}
  elseif good_def.armor_class > 0 then
    good_def.armor = {fleshy = good_def.armor_class * 10}
  else
    good_def.armor_class = math.max(good_def.armor_class, -8)
    good_def.armor = {fleshy = 9 + good_def.armor_class}
  end

  if good_def.looks_for and not good_def.environment then
    good_def.environment = table.copy(good_def.looks_for)
  elseif good_def.environment and not good_def.looks_for then
    good_def.looks_for = table.copy(good_def.environment)
  end

  if good_def.replaces and good_def.replaces[1] and type(good_def.replaces[1]) == 'table' and good_def.replaces[1].replace and type(good_def.replaces[1].replace) == 'table' then
    -- nop
  else
    good_def.replaces = nil
  end

  local proto = {
    collide_with_objects = true,
    collisionbox = cbox,
    get_staticdata = nmobs.get_staticdata,
    glow = good_def.glow,
    hp_max = 2,
    hp_min = 1,
    on_activate = nmobs.activate,
    on_step = nmobs.step,
    on_punch = good_def._take_punch or nmobs.take_punch,
    on_rightclick = nmobs.on_rightclick,
    physical = true,
    stepheight = good_def.step_height or 1.1,
    textures = { {'nmobs:'..name..'_block'}, },
    visual = 'wielditem',
    visual_size = sz,
    _aggressive_behavior = good_def._aggressive_behavior or nmobs.aggressive_behavior,
    _animation = good_def.animation,
    _aquatic = good_def.aquatic,
    _armor_groups = good_def.armor,
    _attacks_player = good_def.attacks_player,
    _change_animation = good_def.change_animation or nmobs.change_animation,
    _damage = good_def.damage,
    _diurnal = good_def.diurnal,
    _drops = good_def.drops or {},
    _environment = good_def.environment,
    _environment_match = {},
    _fall = good_def._fall or nmobs.fall,
    _fearful_behavior = good_def._fearful_behavior or nmobs.fearful_behavior,
    _fight = good_def._fight or nmobs.fight,
    _find_prey = good_def._find_prey or nmobs.find_prey,
    _flee = good_def._flee or nmobs.flee,
    _follow = good_def._follow or nmobs.follow,
    _fractional_damage = good_def._fractional_damage or 0,
    _fly = good_def.fly,
    _get_pos = good_def._get_pos or nmobs.get_pos,
    _hit_dice = (good_def.hit_dice or 1),
    _hurts_me = good_def.hurts_me or default_hurts_me,
    _is_a_mob = true,
    _last_step = 0,
    _lifespan = (good_def.lifespan or 200),
    _line_of_sight = (good_def._line_of_sight or nmobs.line_of_sight),
    _looks_for = good_def.looks_for,
    _name = name,
    _new_destination = good_def._new_destination or nmobs.new_destination,
    _nocturnal = good_def.nocturnal,
    _noise = good_def._noise or nmobs.noise,
    _printed_name = name:gsub('_', ' '),
    _punch = good_def._punch or nmobs.punch,
    _rarity = (good_def.rarity or 20000),
    _reach = (good_def.reach or 1),
    _reach_eff = math.ceil((good_def.reach or 3.5) + math.max(0, cbox[4], cbox[6])),
    _replace = good_def._replace or nmobs.replace,
    _replaces = good_def.replaces,
    _run_speed = (good_def.run_speed or 3),
    _run_scared = good_def._run_scared or nmobs.run_scared,
    _scared = good_def.scared,
    _sound = good_def.sound,
    _sound_angry = good_def.sound_angry,
    _sound_scared = good_def.sound_scared,
    _spawn_table = good_def.spawn,
    _stand = good_def._stand or nmobs.stand,
    _state = 'standing',
    _tames = good_def.tames,
    _target = nil,
    _terrain_effects = good_def._terrain_effects or nmobs.terrain_effects,
    _travel = good_def._travel or nmobs.travel,
    _tunnel = good_def._tunnel or nmobs.tunnel,
    _viewpoint = ((cbox[5] - cbox[2]) / 2) + cbox[2],
    _diggable = good_def.can_dig,
    _vision = (good_def.vision or 15),
    _walk = good_def._walk or nmobs.walk,
    _walk_speed = (good_def.walk_speed or 1),
    _weapon_capabilities = good_def.weapon_capabilities,
  }

  if good_def.mesh and good_def.textures then
    proto.visual = 'mesh'
    proto.mesh = good_def.mesh
    proto.textures = good_def.textures
  end

  for _, e in pairs(proto._environment) do
    proto._environment_match[e] = true
  end

  nmobs.mobs[name] = proto
  minetest.register_entity(':nmobs:'..name, proto)

  if proto._spawn_table then
    for _, instance in pairs(proto._spawn_table) do
      minetest.register_abm({
        nodenames = (instance.nodes or proto._environment or {'default:dirt_with_grass'}),
        neighbors = {'air'},
        interval = (instance.interval or 30),
        chance = (instance.rarity or 20000),
        catch_up = false,
        action = function(...)
          nmobs.abm_callback(name, ...)
        end,
      })
    end
  elseif proto._environment then
    minetest.register_abm({
      nodenames = proto._environment,
      neighbors = {'air'},
      interval = 30,
      chance = proto._rarity,
      catch_up = false,
      action = function(...)
        nmobs.abm_callback(name, ...)
      end,
    })
  end
end
