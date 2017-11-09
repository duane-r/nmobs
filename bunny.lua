-- Nmobs bunny.lua
-- Copyright Duane Robertson (duane@duanerobertson.com), 2017
-- Distributed under the LGPLv2.1 (https://www.gnu.org/licenses/old-licenses/lgpl-2.1.en.html)

-- Textures, sounds, and model
-- Copyright (c) 2014 Krupnov Pavel and 2016 TenPlus1
-- Distributed under the MIT license
-- Bunny by ExeterDad

do
  local def = {
    animation = {
      stand = { start = 1, stop = 15 },
      punch = { start = 16, stop = 24 },
      run = { start = 16, stop = 24 },
      walk = { start = 16, stop = 24 },
    },
    armor_class = 7,
    collisionbox = { -0.268, -0.35, -0.268, 0.268, 0.167, 0.268 },
    damage = 0.5,
    drops = {
      { name = "nmobs:meat_raw" }
    },
    environment = { 'default:dirt_with_grass' },
    hit_dice = 0,
    mesh = 'mobs_bunny.b3d',
    name = 'bunny',
    scared = true,
    run_speed = 2,
    textures = {
      { "mobs_bunny_grey.png" },
      { "mobs_bunny_brown.png" },
      { "mobs_bunny_white.png" }
    },
    vision = 8,
    walk_speed = 1,
  }

  nmobs.register_mob(def)
end
