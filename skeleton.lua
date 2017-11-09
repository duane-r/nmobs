-- Nmobs skeleton.lua
-- Copyright Duane Robertson (duane@duanerobertson.com), 2017
-- Distributed under the LGPLv2.1 (https://www.gnu.org/licenses/old-licenses/lgpl-2.1.en.html)

-- The nodebox and textures are distributed as Public Domain (WTFPL).


nmobs.register_mob({
  attacks_player = true,
  armor_class = 8,
  drops = { {name = 'bonemeal:bone',}, },
  environment = {'default:dirt', 'default:dirt_with_grass', 'default:dirt_with_dry_grass', 'default:dirt_with_snow', 'default:desert_sand'},
  hit_dice = 3,
  name = 'skeleton',
  -- rotate arms to forward
  nodebox = {
    {-0.0625, 0.34375, -0.0625, 0.0625, 0.48, 0.125}, -- cranium
    {-0.045, 0.28125, 0, 0.045, 0.34375, 0.125}, -- mandible
    {-0.09375, 0.035, -0.0625, 0.09375, 0.25, 0.125}, -- ribcage
    {-0.09375, -0.125, -0.0625, 0.09375, 0, 0.08}, -- pelvis
    {0.05, -0.5, -0.02, 0.09, -0.125, 0.02}, -- rightleg
    {-0.02, 0, -0.0625, 0.02, 0.4, -0.02}, -- spine
    {-0.09, -0.5, -0.02, -0.05, -0.125, 0.02}, -- leftleg
    {0.09375, 0.2, 0, 0.3, 0.25, 0.04}, -- righthumerus
    {0.25, 0.2, 0, 0.3, 0.24, 0.24}, -- rightulna
    {-0.3, 0.2, 0, -0.09375, 0.25, 0.04}, -- lefthumerus
    {-0.3, 0.2, 0, -0.25, 0.24, 0.24}, -- leftulna
    {-0.09, -0.5, -0.02, -0.05, -0.48, 0.12}, -- leftfoot
    {0.05, -0.5, -0.02, 0.09, -0.48, 0.12}, -- rightfoot
    {-0.31, 0.21, 0.24, -0.24, 0.23, 0.32}, -- lefthand
    {0.31, 0.21, 0.24, 0.24, 0.23, 0.32}, -- righthand
  },
  nocturnal = true,
  size = 2,
  --tames = {'farming:wheat'},
})
