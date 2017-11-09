-- Nmobs bear.lua
-- Copyright Duane Robertson (duane@duanerobertson.com), 2017
-- Distributed under the LGPLv2.1 (https://www.gnu.org/licenses/old-licenses/lgpl-2.1.en.html)

-- Model and textures are Copyright (c) 2014 by PilzAdam and
--  KrupnovPavel and distributed under the MIT license.


do
  local def1 = {
    animation = {
      punch = {start = 70, stop = 100},
      run = {start = 105, stop = 135},
      stand = {start = 0, stop = 15, noloop = true},
      walk = {start = 35, stop = 65},
    },
    attacks_player = 10,
    armor_class = 6,
    collisionbox = {-0.4, -0.01, -0.4, 0.4, 1, 0.4},
    damage = 2,
    drops = {
      {name = 'mobs:meat_raw',},
      {name = 'mobs:fur',},
    },
    environment = {'default:dirt_with_grass'},
    hit_dice = 6,
    name = 'bear',
    mesh = "kpg_bear.x",
    size = 2,
    textures = {
      {"kpg_bear.png"},
    },
  }

  local def2 = table.copy(def1)
  def2.damage = 4
  def2.environment = {'default:snow', 'default:dirt_with_snow'}
  def2.hit_dice = 8
  def2.name = 'kodiak'
  def2.size = 2.5
  def2.textures = { {"polar_bear.png"}, }
  def2.vision = 20

  local def3 = table.copy(def1)
  def3.environment = {'default:stone'}
  def3.glow = 2
  def3.name = 'cave_bear'
  def3.size = 1
  def3.textures = { {"cave_bear.png"}, }
  def3.vision = 20

  nmobs.register_mob(def1)
  nmobs.register_mob(def2)
  nmobs.register_mob(def3)
end
