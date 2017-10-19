-- Nmobs rat.lua
-- Copyright Duane Robertson (duane@duanerobertson.com), 2017
-- Distributed under the LGPLv2.1 (https://www.gnu.org/licenses/old-licenses/lgpl-2.1.en.html)

-- Textures, sounds, and model
-- Copyright (c) 2014 Krupnov Pavel and 2016 TenPlus1
-- Distributed under the MIT license
-- Rat by PilzAdam


do
  local def = {
    armor_class = 7,
    collisionbox = { -0.2, -0.7, -0.2, 0.2, -0.5, 0.2 },
    drops = {
      { name = 'mobs:rat_dead' },
    },
    environment = { 'default:stone', 'default:dirt_with_grass', 'default:dirt_with_dry_grass' },
    hit_dice = 0,
    mesh = 'mobs_rat.b3d',
    name = 'rat',
    run_speed = 2,
    scared = true,
    sound = 'mobs_rat',
    textures = {
      { "mobs_rat.png" },
      { "mobs_rat2.png" },
    },
    walk_speed = 1,
  }

  nmobs.register_mob(def)


  minetest.register_craftitem(":mobs:rat_dead", {
    description = "Dead Rat",
    inventory_image = "mobs_rat_inventory.png",
  })

  -- cooked rat, yummy!
  minetest.register_craftitem(":mobs:rat_cooked", {
    description = "Cooked Rat",
    inventory_image = "mobs_rat_inventory.png",
    on_use = minetest.item_eat(2),
  })

  minetest.register_craft({
    type = "cooking",
    output = "mobs:rat_cooked",
    recipe = "mobs:rat_dead",
    cooktime = 5,
  })
end
