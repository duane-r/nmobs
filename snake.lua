-- Nmobs .lua
-- Copyright Duane Robertson (duane@duanerobertson.com), 2017
-- Distributed under the LGPLv2.1 (https://www.gnu.org/licenses/old-licenses/lgpl-2.1.en.html)

-- Textures, sounds, and model
-- Copyright (c) 2014 Krupnov Pavel and 2016 TenPlus1
-- Distributed under the MIT license


do
  if minetest.global_exists('status_mod') and status_mod.register_status and not status_mod.registered_status['poisoned'] then
    status_mod.register_status({
      name = 'poisoned',
      during = function(player)
        if not player then
          return
        end
        local player_name = player:get_player_name()
        if not player_name or player_name == '' then
          return
        end

        local damage = 1
        if status_mod.db.status and status_mod.db.status[player_name] and status_mod.db.status[player_name]['poisoned'] and status_mod.db.status[player_name]['poisoned']['damage'] then
          damage = tonumber(status_mod.db.status[player_name]['poisoned']['damage'])
        end

        local hp = player:get_hp()
        if hp and type(hp) == 'number' then
          hp = hp - damage
          player:set_hp(hp)
        end
      end,
      terminate = function(player)
        if not player then
          return
        end

        local player_name = player:get_player_name()
        minetest.chat_send_player(player_name, 'Your sickness ebbs away.')
      end,
    })
  end

  local def1 = {
    attacks_player = true,
    armor_class = 6,
    drops = {
      {name = 'mobs:meat_raw',},
    },
    environment = {'default:dirt_with_rainforest_litter'},
    hit_dice = 1,
    name = 'snake_jungle',
    nodebox = {
      {-0.0625, -0.5, -0.4375, 0, -0.4375, -0.3125},
      {0, -0.5, -0.375, 0.0625, -0.4375, -0.1875},
      {0.0625, -0.5, -0.25, 0.125, -0.4375, -0.0625},
      {0, -0.5, -0.125, 0.0625, -0.4375, 0.0625},
      {-0.0625, -0.5, 0, 0, -0.4375, 0.125},
      {-0.125, -0.5, 0.0625, -0.0625, -0.4375, 0.25},
      {-0.0625, -0.5, 0.1875, 0, -0.4375, 0.3125},
      {0, -0.5, 0.25, 0.0625, -0.4375, 0.4375},
    },
    _punch = function(self, target, delay, capabilities)
      if minetest.global_exists("status_mod") and status_mod.registered_status and status_mod.registered_status['poisoned'] and target.get_player_name then
        local player_name = target:get_player_name()
        if not player_name then
          return
        end

        minetest.chat_send_player(player_name, minetest.colorize('#FF0000', 'You\'ve been poisoned!'))
        status_mod.set_status(player_name, 'poisoned', 2 ^ math.random(8), {damage = 1})
      else
        nmobs.punch(self, target, delay, capabilities)
      end
    end,
    vision = 6,
  }

  local def2 = table.copy(def1)
  def2.name = 'snake'
  def2.environment = {'default:desert_sand', 'default:desert_stone'}

  nmobs.register_mob(def1)
  nmobs.register_mob(def2)
end

