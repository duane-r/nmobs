-- Nmobs elephant.lua
-- Copyright Duane Robertson (duane@duanerobertson.com), 2017
-- Distributed under the LGPLv2.1 (https://www.gnu.org/licenses/old-licenses/lgpl-2.1.en.html)

-- Textures, sounds, and model
-- Copyright (C) 2016 D00Med <heiselong@gmx.com>
-- Distributed under the CC by SA 3.0 license

do
  local def = {
    animation = {
      stand = { start = 20, stop = 30, speed = 3 },
      run = { start = 3, stop = 19, },
      walk = { start = 3, stop = 19, speed = 7 }
    },
    armor_class = 8,
    attacks_player = 10,
    collisionbox = { -0.36, -0.4, -0.36, 0.36, 0.36, 0.36 },
    damage = 7,
    drops = { { name = "mobs:meat_raw", min = 4, max = 8, } },
    environment = { 'default:dirt_with_dry_grass', },
    hit_dice = 10,
    mesh = 'elephant.b3d',
    name = 'elephant',
    run_speed = 2,
    size = 2.5,
    textures = {
      { "dmobs_elephant.png" }
    },
    walk_speed = 1,
  }

  nmobs.register_mob(def)
end
