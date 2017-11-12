-- Nmobs goblin.lua
-- Copyright Duane Robertson (duane@duanerobertson.com), 2017
-- Distributed under the LGPLv2.1 (https://www.gnu.org/licenses/old-licenses/lgpl-2.1.en.html)

-- The nodebox and textures are distributed as Public Domain (WTFPL).


nmobs.time_factor = 10


local drops = {
  {name = "default:mossycobble", chance = 2, max = 3},
  {name = "default:pick_stone", chance = 3, max = 3},
  {name = "default:sword_stone", chance = 5},
  {name = "default:torch", chance = 3, max = 10},
  {name = "nmobs:glowing_fungus", chance = 3, min = 2, max = 5},
  {name = "squaresville_c:mushroom_steak", chance = 2, max = 2},
}

local function goblin_travel(self, speed)
  local pos = self:_get_pos()
  if self._destination and self._destination.y >= pos.y - 1 then
    local dir = vector.direction(pos, self._destination)
    local next_pos = vector.add(pos, dir)
    next_pos.y = math.min(next_pos.y, pos.y) - 1
    next_pos = vector.round(next_pos)
    local n = minetest.get_node_or_nil(next_pos)
    if n and n.name == 'air' then
      minetest.set_node(next_pos, {name='default:dirt'})
      nmobs.travel(self, 0.5)
      return
    end
  end

  nmobs.travel(self, speed)
end

local function goblin_replace(self)
  local pos = self:_get_pos()
  local minp = vector.subtract(pos, self._reach + 1)
  local maxp = vector.add(pos, self._reach + 1)

  local ns = minetest.find_nodes_in_area(minp, maxp, {'default:stone_with_coal', 'default:stone_with_copper', 'default:stone_with_gold', 'default:stone_with_diamond'})
  if ns and #ns > 0 then
    local p = ns[math.random(#ns)]
    local n = minetest.get_node_or_nil(p)
    if n then
      local r = n.name:gsub('^default', 'nmobs'):gsub('$', '_trap')
      minetest.set_node(p, {name=r})
      return
    end
  end

  if math.random(3) == 1 then
    ns = minetest.find_nodes_in_area(minp, maxp, {'squaresville_c:giant_mushroom_stem'})
    if ns and #ns > 0 then
      local pl
      for _, p in pairs(ns) do
        if not pl or pl.y > p.y then
          pl = p
        end
      end
      for i = 1, 3 do
        local n = minetest.get_node_or_nil(pl)
        if n and (n.name == 'squaresville_c:giant_mushroom_stem' or n.name == 'squaresville_c:giant_mushroom_cap' or n.name == 'squaresville_c:huge_mushroom_cap') then
          minetest.remove_node(pl)
          pl.y = pl.y + 1
        end
      end

      return
    end
  end

  --[[
  if minetest.get_modpath('fun_caves') and math.random(20) == 1 then
    ns = minetest.find_nodes_in_area(minp, maxp, {'group:fungal_tree'})
    if ns and #ns > 0 then
      minetest.set_node(ns[math.random(#ns)], {name = 'fire:basic_flame'})
      return
    end
  end
  --]]

  if math.random(5) == 1 then
    local p = minetest.find_node_near(pos, self._reach + 1, {'air'})
    if p then
      minetest.set_node(p, {name='nmobs:fairy_light'})
    end

    return
  end

  if math.random(5) == 1 then
    local p = {x=pos.x, y=pos.y-1, z=pos.z}
    local n = minetest.get_node_or_nil(p)
    if n and minetest.registered_nodes[n.name] and minetest.registered_nodes[n.name].groups.cracky and n.name ~= 'bastet:bastet' then
      local sr = math.random(4)
      if sr == 1 then
        minetest.set_node(p, {name='nmobs:mossycobble_slimy'})
      elseif sr == 2 then
        minetest.set_node(p, {name='default:dirt'})
      elseif sr == 3 then
        if minetest.registered_nodes['squaresville_c:glowing_fungal_stone'] then
          minetest.set_node(p, {name='squaresville_c:glowing_fungal_stone'})
        else
          minetest.set_node(p, {name='nmobs:mossycobble_slimy'})
        end
      else
        minetest.set_node(p, {name='default:mossycobble'})
      end
    elseif n and minetest.registered_nodes[n.name] and minetest.registered_nodes[n.name].groups.soil then
      minetest.set_node(pos, {name='flowers:mushroom_brown'})
    end
  end
end

nmobs.register_mob({
  attacks_player = true,
  can_dig = {'group:cracky', 'group:crumbly'},
  drops = drops,
  environment = {'default:mossycobble', 'default:dirt', 'default:stone_with_algae', 'default:stone_with_lichen', 'default:stone_with_coal', 'default:stone_with_iron', 'default:stone_with_copper', 'default:stone_with_gold', 'default:stone_with_mese', 'default:stone_with_diamond', 'squaresville_c:giant_mushroom_stem'},
  hit_dice = 2,
  name = 'goblin',
  nocturnal = true,
  nodebox = {
    {-0.25, -0.3125, -0.25, 0.25, 0.1875, 0.25}, -- body1
    {-0.25, -0.5, -0.125, -0.0625, -0.3125, 0.0625}, -- leftleg
    {0.0625, -0.5, -0.125, 0.25, -0.3125, 0.0625}, -- rightleg
    {0.0625, -0.5, -0.125, 0.3125, -0.4375, 0.1875}, -- rightfoot
    {-0.3125, -0.5, -0.125, -0.0625, -0.4375, 0.1875}, -- leftfoot
    {0.25, -0.25, -0.25, 0.3125, 0.1875, 0.25}, -- body2
    {-0.3125, -0.25, -0.25, -0.25, 0.1875, 0.25}, -- body3
    {-0.25, -0.25, 0.25, 0.25, 0.1875, 0.3125}, -- body4
    {-0.25, -0.25, -0.3125, 0.25, 0.1875, -0.25}, -- body5
    {-0.25, 0.25, -0.25, 0.25, 0.3125, 0.1875}, -- body6
    {-0.1875, 0.3125, -0.1875, 0.1875, 0.375, 0.1875}, -- body7
    {-0.1875, 0.375, 0.0625, -0.0625, 0.4375, 0.1875}, -- lefteye
    {0.0625, 0.375, 0.0625, 0.1875, 0.4375, 0.1875}, -- righteye
    {-0.4375, 0.0625, 0.0625, -0.3125, 0.125, 0.125}, -- leftarm1
    {0.3125, 0.0625, 0.0625, 0.4375, 0.125, 0.125}, -- rightarm1
    {0.375, -0.375, 0.0625, 0.5, -0.1875, 0.125}, -- righthand
    {-0.5, -0.375, 0.0625, -0.375, -0.1875, 0.125}, -- lefthand
    {-0.25, 0.1875, -0.25, 0.25, 0.25, 0.1875}, -- body8
    {-0.1875, 0.1875, 0.1875, -0.125, 0.3125, 0.25}, -- lip1
    {0.125, 0.1875, 0.1875, 0.1875, 0.3125, 0.25}, -- lip2
    {-0.1875, 0.25, 0.1875, 0.1875, 0.3125, 0.25}, -- lip3
    {-0.0625, 0.3125, 0.1875, 0.0625, 0.375, 0.25}, -- nose
    {-0.4375, -0.375, 0.0625, -0.375, 0.125, 0.125}, -- leftarm2
    {0.375, -0.375, 0.0625, 0.4375, 0.125, 0.125}, -- rightarm2
  },
  _travel = goblin_travel,
  _replace = goblin_replace,
  size = 0.7,
  spawn = {
    {
      nodes = {'default:stone', 'squaresville_c:stone_with_algae', 'squaresville_c:stone_with_lichen', 'squaresville:concrete', 'squaresville:road', 'squaresville:sidewalk', 'squaresville:floor_ceiling', 'squaresville:concrete_broken', 'squaresville:road_broken', 'squaresville:sidewalk_broken', 'squaresville:floor_ceiling_broken'},
      rarity = 20000,
    },
    {
      nodes = {'flowers:mushroom_brown', 'flowers:mushroom_red', 'squaresville_c:giant_mushroom_cap', 'squaresville_c:fungal_tree_leaves_1', 'squaresville_c:fungal_tree_leaves_2', 'squaresville_c:fungal_tree_leaves_3', 'squaresville_c:fungal_tree_leaves_4'},
      rarity = 5000,
    },
    {
      nodes = {'default:mossycobble', 'nmobs:mossycobble_slimy'},
      rarity = 5000,
    },
  },
  tames = {'default:diamond'},
})


drops = table.copy(drops)
drops[#drops+1] = {name = "default:coal_lump", chance = 2, max = 2}
drops[#drops+1] = {name = "default:copper_lump", chance = 4, max = 2}
drops[#drops+1] = {name = "default:iron_lump", chance = 6, max = 2}

nmobs.register_mob({
  armor_class = 8,
  attacks_player = true,
  can_dig = {'group:cracky', 'group:crumbly'},
  drops = drops,
  environment = {'default:mossycobble', 'default:dirt', 'default:stone_with_algae', 'default:stone_with_lichen', 'default:stone_with_coal', 'default:stone_with_iron', 'default:stone_with_copper', 'default:stone_with_gold', 'default:stone_with_mese', 'default:stone_with_diamond', 'squaresville_c:giant_mushroom_stem'},
  hit_dice = 4,
  name = 'goblin basher',
  nocturnal = true,
  nodebox = {
    {-0.25, -0.3125, -0.25, 0.25, 0.1875, 0.25}, -- body1
    {-0.25, -0.5, -0.125, -0.0625, -0.3125, 0.0625}, -- leftleg
    {0.0625, -0.5, -0.125, 0.25, -0.3125, 0.0625}, -- rightleg
    {0.0625, -0.5, -0.125, 0.3125, -0.4375, 0.1875}, -- rightfoot
    {-0.3125, -0.5, -0.125, -0.0625, -0.4375, 0.1875}, -- leftfoot
    {0.25, -0.25, -0.25, 0.3125, 0.1875, 0.25}, -- body2
    {-0.3125, -0.25, -0.25, -0.25, 0.1875, 0.25}, -- body3
    {-0.25, -0.25, 0.25, 0.25, 0.1875, 0.3125}, -- body4
    {-0.25, -0.25, -0.3125, 0.25, 0.1875, -0.25}, -- body5
    {-0.25, 0.25, -0.25, 0.25, 0.3125, 0.1875}, -- body6
    {-0.1875, 0.3125, -0.1875, 0.1875, 0.375, 0.1875}, -- body7
    {-0.1875, 0.375, 0.0625, -0.0625, 0.4375, 0.1875}, -- lefteye
    {0.0625, 0.375, 0.0625, 0.1875, 0.4375, 0.1875}, -- righteye
    {-0.4375, 0.0625, 0.0625, -0.3125, 0.125, 0.125}, -- leftarm1
    {0.3125, 0.0625, 0.0625, 0.4375, 0.125, 0.125}, -- rightarm1
    {0.375, -0.375, 0.0625, 0.5, -0.1875, 0.125}, -- righthand
    {-0.5, -0.375, 0.0625, -0.375, -0.1875, 0.125}, -- lefthand
    {-0.25, 0.1875, -0.25, 0.25, 0.25, 0.1875}, -- body8
    {-0.1875, 0.1875, 0.1875, -0.125, 0.3125, 0.25}, -- lip1
    {0.125, 0.1875, 0.1875, 0.1875, 0.3125, 0.25}, -- lip2
    {-0.1875, 0.25, 0.1875, 0.1875, 0.3125, 0.25}, -- lip3
    {-0.0625, 0.3125, 0.1875, 0.0625, 0.375, 0.25}, -- nose
    {-0.4375, -0.375, 0.0625, -0.375, 0.125, 0.125}, -- leftarm2
    {0.375, -0.375, 0.0625, 0.4375, 0.125, 0.125}, -- rightarm2
  },
  _travel = goblin_travel,
  _replace = goblin_replace,
  size = 0.8,
  spawn = {
    {
      nodes = {'default:stone', 'squaresville_c:stone_with_algae', 'squaresville_c:stone_with_lichen', 'squaresville:concrete', 'squaresville:road', 'squaresville:sidewalk', 'squaresville:floor_ceiling', 'squaresville:concrete_broken', 'squaresville:road_broken', 'squaresville:sidewalk_broken', 'squaresville:floor_ceiling_broken'},
      rarity = 50000,
    },
    {
      nodes = {'flowers:mushroom_brown', 'flowers:mushroom_red', 'squaresville_c:giant_mushroom_cap', 'squaresville_c:fungal_tree_leaves_1', 'squaresville_c:fungal_tree_leaves_2', 'squaresville_c:fungal_tree_leaves_3', 'squaresville_c:fungal_tree_leaves_4'},
      rarity = 5000,
    },
    {
      nodes = {'default:mossycobble', 'nmobs:mossycobble_slimy'},
      rarity = 5000,
    },
  },
  tames = {'default:diamond'},
})


---------------------------------------------------------------
-- Nodes
---------------------------------------------------------------


local mushrooms = {"flowers:mushroom_brown", "flowers:mushroom_red"}
minetest.register_node("nmobs:fairy_light", {
  description = "Fairy Light",
  drawtype = "plantlike",
  visual_scale = 0.75,
  tiles = {"nmobs_fairy_light.png"},
  paramtype = "light",
  sunlight_propagates = true,
  light_source = 8,
  walkable = false,
  diggable = false,
  pointable = false,
  is_ground_content = false,
  on_construct = function(pos)
    local timer = minetest.get_node_timer(pos)
    local max = 3 * (nmobs.time_factor or 10)
    if timer then
      timer:set(max, max > 1 and math.random(max - 1) or 0)
    end
  end,
  on_timer = function(pos, elapsed)
    local node_down = minetest.get_node_or_nil({x=pos.x, y=pos.y-1, z=pos.z})
    if node_down and node_down.name == 'default:dirt' then
      minetest.set_node(pos, {name=mushrooms[math.random(#mushrooms)]})
    else
      minetest.remove_node(pos)
    end
  end,
})


---------------------------------------------------------------
-- Traps
---------------------------------------------------------------

minetest.register_node("nmobs:mossycobble_slimy", {
  description = "Messy Gobblestone",
  tiles = {"default_mossycobble.png"},
  is_ground_content = false,
  groups = {cracky = 2, stone = 1, slippery = 3},
  sounds = default.node_sound_stone_defaults(),
  paramtype = "light",
  light_source =  4,
})

minetest.register_craft({
  type = "cooking",
  output = "default:stone",
  recipe = "nmobs:mossycobble_trap",
})

minetest.register_node("nmobs:stone_with_coal_trap", {
  description = "Coal Trap",
  tiles = {"default_cobble.png^default_mineral_coal.png"},
  groups = {cracky = 3, trap = 1, fire_trap = 1},
  drop = 'default:coal_lump',
  is_ground_content = false,
  sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("nmobs:stone_with_copper_trap", {
  description = "Copper Trap",
  tiles = {"default_cobble.png^default_mineral_copper.png"},
  groups = {cracky = 3, trap = 1, electricity_trap = 1},
  drop = 'default:copper_lump',
  is_ground_content = false,
  sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("nmobs:stone_with_diamond_trap", {
  description = "Diamond Trap",
  tiles = {"default_cobble.png^default_mineral_diamond.png"},
  groups = {cracky = 3, trap = 1, explosive_trap = 1},
  drop = 'default:diamond_lump',
  is_ground_content = false,
  sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("nmobs:stone_with_gold_trap", {
  description = "Gold Trap",
  tiles = {"default_cobble.png^default_mineral_gold.png"},
  groups = {cracky = 3, trap = 1, lava_trap = 1},
  drop = 'default:gold_lump',
  is_ground_content = false,
  sounds = default.node_sound_stone_defaults(),
})
