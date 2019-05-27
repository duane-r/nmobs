-- Nmobs chicken.lua
-- Copyright Duane Robertson (duane@duanerobertson.com), 2017
-- Distributed under the LGPLv2.1 (https://www.gnu.org/licenses/old-licenses/lgpl-2.1.en.html)

-- Sounds Copyright (c) 2014 Krupnov Pavel and 2016 TenPlus1
-- Distributed under the MIT license

-- The nodebox and textures are distributed as Public Domain (WTFPL).

do
  local def = {
    armor_class = 7,
    damage = 0.5,
    drops = { { name = "mobs:meat_raw" }, },
    environment = { 'default:dirt_with_grass', 'default:dirt_with_dry_grass', },
    hit_dice = 1,
    name = 'chicken',
    nodebox = {
			{-0.1875, -0.5, -0.4375, 0.1875, 0.0625, 0.25}, -- NodeBox1
			{-0.25, -0.375, -0.375, 0.25, 0, 0.1875}, -- NodeBox3
			{-0.125, 0, 0.125, 0.125, 0.3125, 0.375}, -- NodeBox4
			{-0.04, 0.125, 0.375, 0.04, 0.1875, 0.48}, -- NodeBox5
			{-0.01, 0.3125, 0.15, 0.01, 0.375, 0.35}, -- NodeBox6
			{-0.125, -0.1875, -0.5, 0.125, 0.125, -0.4375}, -- NodeBox7
    },
    run_speed = 3,
    scared = true,
    size = 0.5,
    sound = "mobs_chicken",
    vision = 6,
    walk_speed = 1,
  }

  local def2 = table.copy(def)
  def2.armor_class = 8
  def2.attacks_player = true
  def2.damage = 3
  def2.drops = nil
  def2.environment = { 'default:stone', 'mapgen:stone_with_algae', 'mapgen:stone_with_moss', 'mapgen:stone_with_lichen', 'default:dirt_with_rainforest_litter' }
  def2.hit_dice = 5
  def2.name = 'cockatrice'
  def2.size = 1

  nmobs.register_mob(def)
  nmobs.register_mob(def2)
end
