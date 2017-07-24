-- Nmobs nodes.lua
-- Copyright Duane Robertson (duane@duanerobertson.com), 2017
-- Distributed under the LGPLv2.1 (https://www.gnu.org/licenses/old-licenses/lgpl-2.1.en.html)


if not minetest.registered_items["mobs:leather"] then
  minetest.register_craftitem(":mobs:leather", {
    description = "Leather",
    inventory_image = "mobs_leather.png",
  })

  minetest.register_craftitem(":mobs:meat_raw", {
    description = "Raw Meat",
    inventory_image = "mobs_meat_raw.png",
    on_use = minetest.item_eat(3),
  })

  minetest.register_craftitem(":mobs:meat", {
    description = "Meat",
    inventory_image = "mobs_meat.png",
    on_use = minetest.item_eat(8),
  })

  minetest.register_craft({
    type = "cooking",
    output = "mobs:meat",
    recipe = "mobs:meat_raw",
    cooktime = 5,
  })
end

minetest.register_craftitem(":mobs:fur", {
  description = "Fur",
  inventory_image = "nmobs_fur.png",
})
