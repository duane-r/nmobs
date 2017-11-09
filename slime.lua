-- Nmobs slime.lua
-- Copyright Duane Robertson (duane@duanerobertson.com), 2017
-- Distributed under the LGPLv2.1 (https://www.gnu.org/licenses/old-licenses/lgpl-2.1.en.html)

-- The nodebox and textures are distributed as Public Domain (WTFPL).


nmobs.register_mob({
  attacks_player = true,
  armor_class = 5,
  --drops = { {name = 'mobs:meat_raw', chance = 3,}, },
  environment = {'default:stone', 'default:cobble', 'default:stone_block'},
  glow = 2,
  hit_dice = 3,
  name = 'slime_green',
  nocturnal = true,
  nodebox = {
    {-0.5, -0.5, -0.5, 0.5, -0.45, 0.5},
  },
  run_speed = 0.1,
  walk_speed = 0.1,
  --tames = {'farming:wheat'},
})
