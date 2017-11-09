-- Nmobs bee.lua
-- Copyright Duane Robertson (duane@duanerobertson.com), 2017
-- Distributed under the LGPLv2.1 (https://www.gnu.org/licenses/old-licenses/lgpl-2.1.en.html)

-- Textures, sounds, and model
-- Copyright (c) 2014 Krupnov Pavel and 2016 TenPlus1
-- Distributed under the MIT license


do
  local def = {
    animation = {
      stand = { start = 0, stop = 30 },
      walk = { start = 35, stop = 65 }
    },
    armor_class = 7,
    collisionbox = { -0.2, -0.01, -0.2, 0.2, 0.2, 0.2 },
    damage = 0.5,
    drops = { { name = "mobs:honey", chance = 2, max = 2, } },
    environment = { 'group:flower', },
    hit_dice = 0.5,
    mesh = 'mobs_bee.x',
    name = 'bee',
    sound = 'mobs_bee',
    spawn = {
      {
        nodes = {'group:flower'},
        rarity = 250,
      },
    },
    textures = {
      { "mobs_bee.png" }
    },
    walk_speed = 1,
  }

  nmobs.register_mob(def)


  -- honey
  minetest.register_craftitem(":mobs:honey", {
    description = "Honey",
    inventory_image = "mobs_honey_inv.png",
    on_use = minetest.item_eat(6),
  })

  -- honey block
  minetest.register_node(":mobs:honey_block", {
    description = "Honey Block",
    tiles = {"mobs_honey_block.png"},
    groups = {snappy = 3, flammable = 2},
    sounds = default.node_sound_dirt_defaults(),
  })

  minetest.register_craft({
    output = "mobs:honey_block",
    recipe = {
      {"mobs:honey", "mobs:honey", "mobs:honey"},
      {"mobs:honey", "mobs:honey", "mobs:honey"},
      {"mobs:honey", "mobs:honey", "mobs:honey"},
    }
  })

  minetest.register_craft({
    output = "mobs:honey 9",
    recipe = {
      {"mobs:honey_block"},
    }
  })
end
