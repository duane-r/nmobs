-- Nmobs hape.lua
-- Copyright Duane Robertson (duane@duanerobertson.com), 2017
-- Distributed under the LGPLv2.1 (https://www.gnu.org/licenses/old-licenses/lgpl-2.1.en.html)

-- The nodebox and textures are distributed as Public Domain (WTFPL).

do
  local def1 = {
    attacks_player = 10,
    armor_class = 6,
    damage = 2,
    drops = {
      {name = 'mobs:meat_raw',},
      {name = 'mobs:fur',},
    },
    environment = {'default:dirt_with_rainforest_litter'},
    hit_dice = 3,
    name = 'ape',
    nodebox = {
      {0.25, -0.3125, -0.125, 0.5, 0.1875, 0.1875}, -- NodeBox1
      {-0.5, -0.3125, -0.125, -0.25, 0.25, 0.1875}, -- NodeBox2
      {-0.5, -0.4375, -0.125, -0.375, -0.25, 0.1875}, -- NodeBox3
      {-0.5, -0.4375, -0.125, -0.25, -0.375, 0.1875}, -- NodeBox4
      {0.25, -0.4375, -0.125, 0.5, -0.375, 0.1875}, -- NodeBox5
      {0.375, -0.4375, -0.125, 0.5, -0.25, 0.1875}, -- NodeBox6
      {-0.1875, -0.3125, -0.1875, 0.1875, 0.25, 0.1875}, -- NodeBox7
      {-0.5, 0.125, -0.125, 0.5, 0.3125, 0.1875}, -- NodeBox8
      {-0.1875, -0.5, -0.125, -0.0625, -0.25, 0.0625}, -- NodeBox9
      {0.0625, -0.5, -0.125, 0.1875, -0.25, 0.0625}, -- NodeBox10
      {0.0625, -0.5, -0.125, 0.1875, -0.4375, 0.125}, -- NodeBox11
      {-0.1875, -0.5, -0.125, -0.0625, -0.4375, 0.125}, -- NodeBox12
      {-0.1875, -0.3125, -0.25, 0.1875, -0.125, -0.0625}, -- NodeBox13
      {-0.1875, -0.125, 0, 0.1875, 0.25, 0.25}, -- NodeBox14
      {-0.375, 0.125, -0.125, 0.375, 0.375, 0.1875}, -- NodeBox15
      {-0.125, 0.1875, 0, 0.125, 0.5, 0.3125}, -- NodeBox16
      {-0.0625, 0.1875, 0.3125, 0.0625, 0.343671, 0.375}, -- NodeBox17
    },
  }

  nmobs.register_mob(def1)
end
