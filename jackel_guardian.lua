-- Nmobs jackel_guardian.lua
-- Copyright Duane Robertson (duane@duanerobertson.com), 2017
-- Distributed under the LGPLv2.1 (https://www.gnu.org/licenses/old-licenses/lgpl-2.1.en.html)

-- The nodebox and textures are distributed as Public Domain (WTFPL).


nmobs.register_mob({
  attacks_player = true,
  armor_class = 6,
  --environment = {'default:stone_block'},
  fly = true,
  hit_dice = 5,
  name = 'jackel guardian',
  nodebox = {
    {-0.04, 0.34375, -0.0625, 0.04, 0.42, 0.03}, -- head
    {-0.09375, 0.035, -0.0625, 0.09375, 0.25, 0.125}, -- chest
    {-0.09375, -0.125, -0.0625, 0.09375, 0, 0.1}, -- pelvis
    {0.02, -0.5, -0.04, 0.09, -0.125, 0.05}, -- rightleg
    {-0.07, 0, -0.0625, 0.07, 0.28, 0.08}, -- spine
    {-0.09, -0.5, -0.04, -0.02, -0.125, 0.05}, -- leftleg
    {0.09375, 0.2, 0, 0.3, 0.25, 0.04}, -- rightarm1
    {0.25, 0.2, 0, 0.3, 0.24, 0.24}, -- rightarm2
    {-0.3, 0.2, 0, -0.09375, 0.25, 0.04}, -- leftarm1
    {-0.3, 0.2, 0, -0.25, 0.24, 0.24}, -- leftarm2
    {-0.09, -0.5, -0.02, -0.02, -0.47, 0.12}, -- leftfoot
    {0.02, -0.5, -0.02, 0.09, -0.47, 0.12}, -- rightfoot
    {-0.31, 0.21, 0.24, -0.24, 0.23, 0.32}, -- lefthand
    {0.25, 0.19, 0.24, 0.3, 0.25, 0.32}, -- righthand
    {-0.025, 0.33, -0.0625, 0.025, 0.38, 0.15}, -- snout2
    {-0.03, 0.33, -0.0625, 0.03, 0.4, 0.1}, -- snout1
    {-0.05, 0.4, -0.06, -0.02, 0.5, -0.03}, -- leftear
    {0.02, 0.4, -0.06, 0.05, 0.5, -0.03}, -- rightear
    {-0.03, 0.25, -0.06, 0.03, 0.34375, 0.04}, -- neck
    {0.26, -0.5, 0.26, 0.28, 0.5, 0.29}, -- staff
  },
  rarity = 4000,
  size = 2,
  --tames = {'farming:wheat'},
})
