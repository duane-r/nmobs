-- Nmobs demon.lua
-- Copyright Duane Robertson (duane@duanerobertson.com), 2017
-- Distributed under the LGPLv2.1 (https://www.gnu.org/licenses/old-licenses/lgpl-2.1.en.html)

-- Textures, sounds, and model
-- Copyright (C) 2016 D00Med <heiselong@gmx.com>
-- Distributed under the CC by SA 3.0 license


nmobs.register_mob({
  animation = {
    punch = {start = 21, stop = 38},
    run = {start = 1, stop = 20, speed = 20},
    stand = {start = 39, stop = 50, speed = 5},
    walk = {start = 1, stop = 20, speed = 10},
  },
  attacks_player = true,
  armor_class = 4,
  collisionbox = {-0.2, -0.1, -0.2, 0.2, 0.8, 0.2},
  drops = { {name = 'default:mese_crystal',}, {name = 'default:gold_ingot',}, },
  damage = 5,
  environment = {'squaresville_c:hot_iron', 'squaresville_c:hot_brass'},
  fly = true,
  --glow = 5,
  higher = -10200,
  hit_dice = 4,
  hurts_me = {},
  lower = -9800,
  name = 'demon',
  mesh = 'demon.b3d',
  size = 2,
  spawn = {
    {
      nodes = {'squaresville_c:hot_iron', 'squaresville_c:hot_brass'},
      rarity = 1000,
    },
  },
  textures = {'demon.png'},
  nocturnal = true,
  --size = 2,
})
