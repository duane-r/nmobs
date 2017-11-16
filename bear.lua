-- Nmobs bear.lua
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
    environment = {'default:dirt_with_grass'},
    hit_dice = 6,
    name = 'bear',
    nodebox = {
			{-0.25, -0.375, -0.5, 0.25, 0.125, 0.1875}, -- NodeBox1
			{-0.25, -0.5, -0.5, -0.0625, -0.375, -0.3125}, -- NodeBox2
			{0.0625, -0.5, -0.5, 0.25, -0.375, -0.3125}, -- NodeBox3
			{0.0625, -0.5, 0, 0.25, -0.375, 0.1875}, -- NodeBox4
			{0.0625, -0.5, 0, 0.25, -0.4375, 0.25}, -- NodeBox5
			{-0.25, -0.5, 0, -0.0625, -0.4375, 0.25}, -- NodeBox6
			{-0.25, -0.5, 0, -0.0625, -0.375, 0.1875}, -- NodeBox7
			{-0.25, -0.5, -0.5, -0.0625, -0.4375, -0.25}, -- NodeBox8
			{0.0625, -0.5, -0.5, 0.25, -0.4375, -0.25}, -- NodeBox9
			{-0.155, -0.0625, 0.1875, 0.155, 0.1875, 0.375}, -- NodeBox10
			{-0.0925, -0.0625, 0.375, 0.0925, 0.0625, 0.46}, -- NodeBox11
			{-0.125, 0.1875, 0.25, -0.0625, 0.25, 0.3125}, -- NodeBox12
			{0.0625, 0.1875, 0.25, 0.125, 0.25, 0.3125}, -- NodeBox13
    },
    size = 2,
  }

  local def2 = table.copy(def1)
  def2.damage = 4
  def2.environment = {'default:snow', 'default:dirt_with_snow'}
  def2.hit_dice = 8
  def2.name = 'kodiak'
  def2.size = 2.5

  local def3 = table.copy(def1)
  def3.environment = {'default:stone'}
  def3.glow = 2
  def3.name = 'bear_cave'
  def3.size = 1

  nmobs.register_mob(def1)
  nmobs.register_mob(def2)
  nmobs.register_mob(def3)
end
