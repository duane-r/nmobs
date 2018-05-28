-- Nmobs slime.lua
-- Copyright Duane Robertson (duane@duanerobertson.com), 2017
-- Distributed under the LGPLv2.1 (https://www.gnu.org/licenses/old-licenses/lgpl-2.1.en.html)

-- The nodebox and textures are distributed as Public Domain (WTFPL).


nmobs.register_mob({
  attacks_player = true,
  damage = 0.2,
  environment = {'default:stone', 'flats:stone_with_algae', 'flats:stone_with_lichen', 'flats:stone_with_moss', 'default:cobble', 'default:mossycobble'},
  glow = 2,
  hit_dice = 2,
  name = 'slime_green',
  nodebox = {
    {-0.5, -0.5, -0.5, 0.5, -0.45, 0.5},
  },
  reach = 0,
  run_speed = 0.2,
  spawn = {
    {
      nodes = {'default:stone', 'flats:stone_with_algae', 'flats:stone_with_lichen', 'flats:stone_with_moss', 'default:cobble', 'default:mossycobble'},
      rarity = 20000,
    },
    {
      nodes = {'flats:puddle_ooze'},
      rarity = 20,
    },
  },
  walk_speed = 0.2,

  -- can't be hurt by weapons
  _take_punch = function()
    return true
  end
})
