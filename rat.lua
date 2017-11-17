-- Nmobs rat.lua
-- Copyright Duane Robertson (duane@duanerobertson.com), 2017
-- Distributed under the LGPLv2.1 (https://www.gnu.org/licenses/old-licenses/lgpl-2.1.en.html)

-- The nodebox and textures are distributed as Public Domain (WTFPL).

do
  local def = {
    armor_class = 7,
    damage = 0.5,
    drops = {
      { name = 'mobs:rat_dead' },
    },
    environment = { 'default:stone', 'default:dirt_with_grass', 'default:dirt_with_dry_grass' },
    hit_dice = 0,
    name = 'rat',
    nodebox = {
      {-0.125, -0.5, -0.125, 0.125, -0.25, 0.25}, -- NodeBox1
      {-0.0902808, -0.5, 0.3125, 0.0902807, -0.3125, 0.375}, -- NodeBox2
      {-0.0625, -0.46733, 0.375, 0.0625, -0.342045, 0.4375}, -- NodeBox3
      {-0.0159242, -0.435511, -0.5, 0.0179147, -0.405682, -0.1875}, -- NodeBox4
      {-0.103507, -0.5, 0.25, 0.107488, -0.284375, 0.3125}, -- NodeBox5
      {-0.091564, -0.471307, -0.1875, 0.0935545, -0.282386, -0.125}, -- NodeBox6
      {0.055, -0.316779, 0.262046, 0.13, -0.202387, 0.2925}, -- NodeBox7
      {-0.13, -0.316779, 0.262046, -0.055, -0.202387, 0.2925}, -- NodeBox8
    },
    run_speed = 2,
    scared = true,
    size = 0.5,
    sound = 'mobs_rat',
    walk_speed = 1,
  }

  nmobs.register_mob(def)


  minetest.register_craftitem(":mobs:rat_dead", {
    description = "Dead Rat",
    inventory_image = "nmobs_rat_inventory.png",
  })

  -- cooked rat, yummy!
  minetest.register_craftitem(":mobs:rat_cooked", {
    description = "Cooked Rat",
    inventory_image = "nmobs_rat_cooked.png",
    on_use = minetest.item_eat(2),
  })

  minetest.register_craft({
    type = "cooking",
    output = "mobs:rat_cooked",
    recipe = "mobs:rat_dead",
    cooktime = 5,
  })
end
