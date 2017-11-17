-- Nmobs demon.lua
-- Copyright Duane Robertson (duane@duanerobertson.com), 2017
-- Distributed under the LGPLv2.1 (https://www.gnu.org/licenses/old-licenses/lgpl-2.1.en.html)

-- The nodebox and textures are distributed as Public Domain (WTFPL).

nmobs.register_mob({
  attacks_player = true,
  armor_class = 4,
  drops = { {name = 'default:mese_crystal',}, {name = 'default:gold_ingot',}, },
  damage = 5,
  environment = {'squaresville_c:hot_iron', 'squaresville_c:hot_brass'},
  fly = true,
  glow = 2,
  higher = -10200,
  hit_dice = 4,
  hurts_me = {},
  lower = -9800,
  name = 'demon',
  nodebox = {
    {-0.1875, -0.3125, -0.1875, 0.1875, 0.1875, 0.1875}, -- NodeBox1
    {-0.1875, -0.5, -0.1875, -0.0625, -0.3125, -0.0625}, -- NodeBox2
    {-0.125, -0.5, 0.0625, 0, -0.3125, 0.1875}, -- NodeBox3
    {0.0625, -0.5, -0.0625, 0.1875, -0.3125, 0.0625}, -- NodeBox4
    {-0.25, -0.5, -0.1875, 0, -0.4375, 0}, -- NodeBox5
    {-0.25, 0.25, -0.0625, 0, 0.5, 0.1875}, -- NodeBox6
    {0, 0.25, -0.1875, 0.25, 0.5, 0.0625}, -- NodeBox7
    {-0.25, -0.0625, 0, -0.1875, 0.125, 0.125}, -- NodeBox8
    {-0.4375, -0.25, 0, -0.25, 0.125, 0.125}, -- NodeBox9
    {-0.4375, -0.4375, 0, -0.375, -0.25, 0.125}, -- NodeBox10
    {-0.3125, -0.4375, 0, -0.25, -0.25, 0.125}, -- NodeBox11
    {0.25, -0.4375, -0.125, 0.3125, 0, -0.0625}, -- NodeBox12
    {0.1875, -0.0625, -0.125, 0.3125, 0, -0.0625}, -- NodeBox13
    {0.1875, -0.0625, 0.125, 0.375, 0, 0.1875}, -- NodeBox14
    {0.3125, -0.0625, 0.125, 0.375, 0, 0.5}, -- NodeBox15
    {0.25, -0.0625, 0.375, 0.375, 0, 0.5}, -- NodeBox16
    {0.125, -0.25, -0.3125, 0.1875, 0.125, -0.1875}, -- NodeBox17
    {0.125, -0.3125, -0.3125, 0.5, 0.1875, -0.25}, -- NodeBox18
    {-0.125, -0.5, 0.0625, 0, -0.4375, 0.25}, -- NodeBox19
    {0.0625, -0.5, -0.125, 0.1875, -0.4375, 0.0625}, -- NodeBox20
    {-0.1875, -0.0625, 0.1875, -0.125, 0, 0.5}, -- NodeBox21
    {-0.125, -0.0625, 0.375, -0.0625, 0, 0.4375}, -- NodeBox22
    {0.0625, 0.1875, -0.125, 0.1875, 0.25, 0}, -- NodeBox23
    {-0.1875, 0.1875, 0, -0.0625, 0.25, 0.125}, -- NodeBox24
    {-0.0953319, -0.0625, 0.410316, -0.0625, 0, 0.5}, -- NodeBox25
    {-0.5, -0.3125, -0.3125, -0.125, 0.1875, -0.25}, -- NodeBox26
    {-0.1875, -0.25, -0.3125, -0.125, 0.125, -0.1875}, -- NodeBox27
  },
  size = 2,
  spawn = {
    {
      nodes = {'squaresville_c:hot_iron', 'squaresville_c:hot_brass'},
      rarity = 1000,
    },
  },
  size = 2,
})
