-- Nmobs fox.lua
-- Copyright Duane Robertson (duane@duanerobertson.com), 2017
-- Distributed under the LGPLv2.1 (https://www.gnu.org/licenses/old-licenses/lgpl-2.1.en.html)

-- The model and textures are Copyright (c) 2016 D00Med and distributed
--  under the LGPL 2.1 license and CC-by-SA 3.0. Contributions were made
--  by Mike Koenig, snottyboi, and TenPlus1.

-- https://forum.minetest.net/viewtopic.php?f=9&t=14382&hilit=mobs+monsters


do
  local def = {
    animation = {
      punch = {start = 36, stop = 51},
      run = {start = 1, stop = 16},
      stand = {start = 51, stop = 60, speed = 4},
      walk = {start = 25, stop = 35, speed = 6},
    },
    collisionbox = {-0.4, -0.4, -0.4, 0.3, 0.3, 0.3},
    drops = {
      {name = 'mobs:fur',},
    },
    hit_dice = 1,
    looks_for = {'default:dirt_with_grass'},
    name = 'fox',
    mesh = "fox.b3d",
    textures = {
      {"dmobs_fox.png"},
    },
  }

  nmobs.register_mob(def)

  def = table.copy(def)
  def.textures = { {"dmobs_fox_arctic.png"}, }
  def.looks_for = {'default:snow', 'default:dirt_with_snow'}
  def.name = 'arctic fox'

  nmobs.register_mob(def)
end
