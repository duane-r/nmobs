-- Nmobs bear.lua
-- Copyright Duane Robertson (duane@duanerobertson.com), 2017
-- Distributed under the LGPLv2.1 (https://www.gnu.org/licenses/old-licenses/lgpl-2.1.en.html)

-- Model and textures are Copyright (c) 2014 by PilzAdam and
--  KrupnovPavel and distributed under the MIT license.


do
  local def = {
    attacks_player = true,
    armor_class = 6,
    hit_dice = 6,
    looks_for = {'default:dirt_with_grass'},
    name = 'bear',
    mesh = "kpg_bear.x",
    textures = {
      {"kpg_bear.png"},
    },
    size = 2,
    collisionbox = {-0.4, -0.01, -0.4, 0.4, 1, 0.4},
    animation = {
      punch = {start = 70, stop = 100},
      run = {start = 105, stop = 135},
      stand = {start = 0, stop = 15, noloop = true},
      walk = {start = 35, stop = 65},
    },
  }

  nmobs.register_mob(def)

  --def = table.copy(def)
  --def.textures = { {"dmobs_fox_arctic.png"}, }
  --def.looks_for = {'default:snow', 'default:dirt_with_snow'}
  --def.name = 'arctic fox'

  --nmobs.register_mob(def)
end
