-- Nmobs chicken.lua
-- Copyright Duane Robertson (duane@duanerobertson.com), 2017
-- Distributed under the LGPLv2.1 (https://www.gnu.org/licenses/old-licenses/lgpl-2.1.en.html)

-- Textures, sounds, and model
-- Copyright (c) 2014 Krupnov Pavel and 2016 TenPlus1
-- Distributed under the MIT license
-- Chicken by JK Murray

do
  local def = {
    animation = {
      stand = { start = 0, stop = 1 },
      walk = { start = 20, stop = 40 },
    },
    armor_class = 7,
    collisionbox = { -0.2, -0.5, -0.2, 0.2, 0, 0.2 },
    damage = 0.5,
    drops = { { name = "mobs:meat_raw" }, },
    environment = { 'default:dirt_with_grass', 'default:dirt_with_dry_grass', },
    hit_dice = 1,
    mesh = "mobs_chicken.x",
    name = 'chicken',
    run_speed = 3,
    scared = true,
    sound = "mobs_chicken",
    textures = {
      {
        "mobs_chicken.png",
        "mobs_chicken.png",
        "mobs_chicken.png",
        "mobs_chicken.png",
        "mobs_chicken.png",
        "mobs_chicken.png",
        "mobs_chicken.png",
        "mobs_chicken.png",
        "mobs_chicken.png"
      },
      {
        "mobs_chicken_black.png",
        "mobs_chicken_black.png",
        "mobs_chicken_black.png",
        "mobs_chicken_black.png",
        "mobs_chicken_black.png",
        "mobs_chicken_black.png",
        "mobs_chicken_black.png",
        "mobs_chicken_black.png",
        "mobs_chicken_black.png"
      }
    },
    vision = 6,
    walk_speed = 1,
  }

  nmobs.register_mob(def)

  def = {
    animation = {
      stand = { start = 0, stop = 1 },
      walk = {
        start = 20,
        stop = 40
      }
    },
    armor_class = 8,
    attacks_player = true,
    collisionbox = { -0.2, -0.5, -0.2, 0.2, 0, 0.2 },
    damage = 3,
    drops = { },
    environment = { 'default:stone', 'squaresville_c:stone_with_algae', 'squaresville_c:stone_with_moss', 'squaresville_c:stone_with_lichen', 'default:dirt_with_rainforest_litter' },
    hit_dice = 5,
    mesh = 'mobs_chicken.x',
    name = 'cockatrice',
    run_speed = 3,
    size = 2,
    sound = 'mobs_chicken',
    textures = {
      {
        "nmobs_cockatrice.png",
        "nmobs_cockatrice.png",
        "nmobs_cockatrice.png",
        "nmobs_cockatrice.png",
        "nmobs_cockatrice.png",
        "nmobs_cockatrice.png",
        "nmobs_cockatrice.png",
        "nmobs_cockatrice.png",
        "nmobs_cockatrice.png"
      }
    },
    walk_speed = 1,
  }

  nmobs.register_mob(def)
end
