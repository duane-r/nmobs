-- Nmobs lion.lua
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
    environment = {'default:dirt_with_dry_grass'},
    hit_dice = 5,
    name = 'lion',
    nodebox = {
      {-0.1875, -0.3125, -0.4375, 0.1875, 0.0625, 0.125}, -- NodeBox1
      {-0.25, -0.25, 0.125, 0.25, 0.25, 0.375}, -- NodeBox2
      {-0.0880776, -0.215586, 0.375, 0.0946835, -0.030798, 0.5}, -- NodeBox3
      {-0.1875, -0.4375, -0.4375, -0.125, -0.25, -0.3125}, -- NodeBox4
      {0.125, -0.4375, -0.4375, 0.1875, -0.25, -0.3125}, -- NodeBox5
      {0.125, -0.4375, 0, 0.1875, -0.25, 0.125}, -- NodeBox6
      {-0.1875, -0.4375, 0, -0.125, -0.25, 0.125}, -- NodeBox7
      {-0.0347875, -0.375, -0.5, 0.0324683, -0.0625, -0.4375}, -- NodeBox9
      {-0.1875, -0.5, -0.409721, -0.125, -0.4375, -0.279724}, -- NodeBox10
      {0.125, -0.5, -0.409721, 0.1875, -0.4375, -0.279724}, -- NodeBox11
      {0.125, -0.5, 0.0313384, 0.1875, -0.4375, 0.154371}, -- NodeBox12
      {-0.1875, -0.5, 0.0313384, -0.125, -0.4375, 0.154371}, -- NodeBox13
    },
    size = 2,
  }

  nmobs.register_mob(def1)
end
