-- Nmobs goblin.lua
-- Copyright Duane Robertson (duane@duanerobertson.com), 2017
-- Distributed under the LGPLv2.1 (https://www.gnu.org/licenses/old-licenses/lgpl-2.1.en.html)

-- The nodebox and textures are distributed as Public Domain (WTFPL).


local drops = {
  {name = "default:mossycobble", chance = 2, max = 3},
  {name = "default:pick_stone", chance = 3, max = 3},
  {name = "default:sword_stone", chance = 5},
  {name = "default:torch", chance = 3, max = 10},
  {name = "nmobs:glowing_fungus", chance = 3, min = 2, max = 5},
  {name = "fun_caves:mushroom_steak", chance = 2, max = 2},
}

nmobs.register_mob({
  attacks_player = true,
  can_dig = {'group:cracky', 'group:crumbly'},
  drops = drops,
  hit_dice = 2,
  looks_for = {'default:mossycobble', 'default:dirt', 'default:stone_with_algae', 'default:stone_with_lichen', 'default:stone_with_coal', 'default:stone_with_iron', 'default:stone_with_copper', 'default:stone_with_gold', 'default:stone_with_mese', 'default:stone_with_diamond', 'fun_caves:giant_mushroom_stem'},
  name = 'goblin',
  nocturnal = true,
  nodebox = {
    {-0.25, -0.3125, -0.25, 0.25, 0.1875, 0.25}, -- body1
    {-0.25, -0.5, -0.125, -0.0625, -0.3125, 0.0625}, -- leftleg
    {0.0625, -0.5, -0.125, 0.25, -0.3125, 0.0625}, -- rightleg
    {0.0625, -0.5, -0.125, 0.3125, -0.4375, 0.1875}, -- rightfoot
    {-0.3125, -0.5, -0.125, -0.0625, -0.4375, 0.1875}, -- leftfoot
    {0.25, -0.25, -0.25, 0.3125, 0.1875, 0.25}, -- body2
    {-0.3125, -0.25, -0.25, -0.25, 0.1875, 0.25}, -- body3
    {-0.25, -0.25, 0.25, 0.25, 0.1875, 0.3125}, -- body4
    {-0.25, -0.25, -0.3125, 0.25, 0.1875, -0.25}, -- body5
    {-0.25, 0.25, -0.25, 0.25, 0.3125, 0.1875}, -- body6
    {-0.1875, 0.3125, -0.1875, 0.1875, 0.375, 0.1875}, -- body7
    {-0.1875, 0.375, 0.0625, -0.0625, 0.4375, 0.1875}, -- lefteye
    {0.0625, 0.375, 0.0625, 0.1875, 0.4375, 0.1875}, -- righteye
    {-0.4375, 0.0625, 0.0625, -0.3125, 0.125, 0.125}, -- leftarm1
    {0.3125, 0.0625, 0.0625, 0.4375, 0.125, 0.125}, -- rightarm1
    {0.375, -0.375, 0.0625, 0.5, -0.1875, 0.125}, -- righthand
    {-0.5, -0.375, 0.0625, -0.375, -0.1875, 0.125}, -- lefthand
    {-0.25, 0.1875, -0.25, 0.25, 0.25, 0.1875}, -- body8
    {-0.1875, 0.1875, 0.1875, -0.125, 0.3125, 0.25}, -- lip1
    {0.125, 0.1875, 0.1875, 0.1875, 0.3125, 0.25}, -- lip2
    {-0.1875, 0.25, 0.1875, 0.1875, 0.3125, 0.25}, -- lip3
    {-0.0625, 0.3125, 0.1875, 0.0625, 0.375, 0.25}, -- nose
    {-0.4375, -0.375, 0.0625, -0.375, 0.125, 0.125}, -- leftarm2
    {0.375, -0.375, 0.0625, 0.4375, 0.125, 0.125}, -- rightarm2
  },
  replaces = {
    --{
    --  replace = {'group:cracky', 'group:choppy', 'group:snappy'},
    --  with = {'air'},
    --  when = 10,
    --},
    {
      replace = {'default:stone_with_coal'},
      with = {'nmobs:stone_with_coal_trap',},
      when = 2,
    },
    {
      replace = {'default:stone_with_copper'},
      with = {'nmobs:stone_with_copper_trap',},
      when = 2,
    },
    {
      replace = {'default:stone_with_gold'},
      with = {'nmobs:stone_with_gold_trap',},
      when = 2,
    },
    {
      replace = {'default:stone_with_diamond'},
      with = {'nmobs:stone_with_diamond_trap',},
      when = 2,
    },
    {
      floor = true,
      replace = {'air'},
      with = {'default:dirt'},
      when = 10,
    },
    {
      floor = true,
      replace = {'group:cracky'},
      with = {'nmobs:mossycobble_slimy', 'default:mossycobble', 'fun_caves:glowing_fungal_stone'},
      when = 10,
    },
    {
      replace = {'air'},
      with = {'nmobs:fairy_light'},
      when = 20,
    },
  },
  size = 0.7,
  spawn = {
    {
      nodes = {'default:stone', 'fun_caves:stone_with_algae', 'fun_caves:stone_with_lichen', 'squaresville:concrete', 'squaresville:road', 'squaresville:sidewalk', 'squaresville:floor_ceiling', 'squaresville:concrete_broken', 'squaresville:road_broken', 'squaresville:sidewalk_broken', 'squaresville:floor_ceiling_broken'},
      rarity = 20000,
    },
    {
      nodes = {'default:mossycobble', 'nmobs:mossycobble_slimy'},
      rarity = 1000,
    },
  },
  tames = {'default:diamond'},
})


drops = table.copy(drops)
drops[#drops+1] = {name = "default:coal_lump", chance = 2, max = 2}
drops[#drops+1] = {name = "default:copper_lump", chance = 4, max = 2}
drops[#drops+1] = {name = "default:iron_lump", chance = 6, max = 2}

nmobs.register_mob({
  armor_class = 8,
  attacks_player = true,
  can_dig = {'group:cracky', 'group:crumbly'},
  drops = drops,
  hit_dice = 4,
  looks_for = {'default:mossycobble', 'default:dirt', 'default:stone_with_algae', 'default:stone_with_lichen', 'default:stone_with_coal', 'default:stone_with_iron', 'default:stone_with_copper', 'default:stone_with_gold', 'default:stone_with_mese', 'default:stone_with_diamond', 'fun_caves:giant_mushroom_stem'},
  name = 'goblin basher',
  nocturnal = true,
  nodebox = {
    {-0.25, -0.3125, -0.25, 0.25, 0.1875, 0.25}, -- body1
    {-0.25, -0.5, -0.125, -0.0625, -0.3125, 0.0625}, -- leftleg
    {0.0625, -0.5, -0.125, 0.25, -0.3125, 0.0625}, -- rightleg
    {0.0625, -0.5, -0.125, 0.3125, -0.4375, 0.1875}, -- rightfoot
    {-0.3125, -0.5, -0.125, -0.0625, -0.4375, 0.1875}, -- leftfoot
    {0.25, -0.25, -0.25, 0.3125, 0.1875, 0.25}, -- body2
    {-0.3125, -0.25, -0.25, -0.25, 0.1875, 0.25}, -- body3
    {-0.25, -0.25, 0.25, 0.25, 0.1875, 0.3125}, -- body4
    {-0.25, -0.25, -0.3125, 0.25, 0.1875, -0.25}, -- body5
    {-0.25, 0.25, -0.25, 0.25, 0.3125, 0.1875}, -- body6
    {-0.1875, 0.3125, -0.1875, 0.1875, 0.375, 0.1875}, -- body7
    {-0.1875, 0.375, 0.0625, -0.0625, 0.4375, 0.1875}, -- lefteye
    {0.0625, 0.375, 0.0625, 0.1875, 0.4375, 0.1875}, -- righteye
    {-0.4375, 0.0625, 0.0625, -0.3125, 0.125, 0.125}, -- leftarm1
    {0.3125, 0.0625, 0.0625, 0.4375, 0.125, 0.125}, -- rightarm1
    {0.375, -0.375, 0.0625, 0.5, -0.1875, 0.125}, -- righthand
    {-0.5, -0.375, 0.0625, -0.375, -0.1875, 0.125}, -- lefthand
    {-0.25, 0.1875, -0.25, 0.25, 0.25, 0.1875}, -- body8
    {-0.1875, 0.1875, 0.1875, -0.125, 0.3125, 0.25}, -- lip1
    {0.125, 0.1875, 0.1875, 0.1875, 0.3125, 0.25}, -- lip2
    {-0.1875, 0.25, 0.1875, 0.1875, 0.3125, 0.25}, -- lip3
    {-0.0625, 0.3125, 0.1875, 0.0625, 0.375, 0.25}, -- nose
    {-0.4375, -0.375, 0.0625, -0.375, 0.125, 0.125}, -- leftarm2
    {0.375, -0.375, 0.0625, 0.4375, 0.125, 0.125}, -- rightarm2
  },
  replaces = {
    --{
    --  replace = {'group:cracky', 'group:choppy', 'group:snappy'},
    --  with = {'air'},
    --  when = 10,
    --},
    {
      replace = {'default:stone_with_coal'},
      with = {'nmobs:stone_with_coal_trap',},
      when = 2,
    },
    {
      replace = {'default:stone_with_copper'},
      with = {'nmobs:stone_with_copper_trap',},
      when = 2,
    },
    {
      replace = {'default:stone_with_gold'},
      with = {'nmobs:stone_with_gold_trap',},
      when = 2,
    },
    {
      replace = {'default:stone_with_diamond'},
      with = {'nmobs:stone_with_diamond_trap',},
      when = 2,
    },
    {
      floor = true,
      replace = {'air'},
      with = {'default:dirt'},
      when = 10,
    },
    {
      floor = true,
      replace = {'group:cracky'},
      with = {'nmobs:mossycobble_slimy', 'default:mossycobble', 'nmobs:glowing_fungal_stone'},
      when = 10,
    },
    {
      replace = {'air'},
      with = {'nmobs:fairy_light'},
      when = 20,
    },
  },
  size = 0.8,
  spawn = {
    {
      nodes = {'default:stone', 'fun_caves:stone_with_algae', 'fun_caves:stone_with_lichen', 'squaresville:concrete', 'squaresville:road', 'squaresville:sidewalk', 'squaresville:floor_ceiling', 'squaresville:concrete_broken', 'squaresville:road_broken', 'squaresville:sidewalk_broken', 'squaresville:floor_ceiling_broken'},
      rarity = 50000,
    },
    {
      nodes = {'default:mossycobble', 'nmobs:mossycobble_slimy'},
      rarity = 1000,
    },
  },
  tames = {'default:diamond'},
})


---------------------------------------------------------------
-- Nodes
---------------------------------------------------------------


local mushrooms = {"flowers:mushroom_brown", "flowers:mushroom_red"}
minetest.register_node("nmobs:fairy_light", {
	description = "Fairy Light",
	drawtype = "plantlike",
	visual_scale = 0.75,
	tiles = {"nmobs_fairy_light.png"},
	paramtype = "light",
	sunlight_propagates = true,
	light_source = 4,
	walkable = false,
	diggable = false,
	pointable = false,
	is_ground_content = false,
  on_construct = function(pos)
    local timer = minetest.get_node_timer(pos)
    timer:set(math.random(100, 300), 0)
  end,
  on_timer = function(pos, elapsed)
    local node_down = minetest.get_node_or_nil({x=pos.x, y=pos.y, z=pos.z})
    if node_down and node_down.name == 'default:dirt' then
      minetest.set_node(pos, {name=mushrooms[math.random(#mushrooms)]})
    else
      minetest.remove_node(pos)
    end
	end,
})


---------------------------------------------------------------
-- Traps
---------------------------------------------------------------

minetest.register_node("nmobs:mossycobble_slimy", {
	description = "Messy Gobblestone",
	tiles = {"default_mossycobble.png"},
	is_ground_content = false,
	groups = {cracky = 2, stone = 1, trap = 1, slippery_floor_trap = 1},
	sounds = default.node_sound_stone_defaults(),
	paramtype = "light",
	light_source =  4,
})

minetest.register_craft({
	type = "cooking",
	output = "default:stone",
	recipe = "nmobs:mossycobble_trap",
})

minetest.register_node("nmobs:stone_with_coal_trap", {
	description = "Coal Trap",
	tiles = {"default_cobble.png^default_mineral_coal.png"},
	groups = {cracky = 3, trap = 1, fire_trap = 1},
	drop = 'default:coal_lump',
	is_ground_content = false,
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("nmobs:stone_with_copper_trap", {
	description = "Copper Trap",
	tiles = {"default_cobble.png^default_mineral_copper.png"},
	groups = {cracky = 3, trap = 1, electricity_trap = 1},
	drop = 'default:copper_lump',
	is_ground_content = false,
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("nmobs:stone_with_diamond_trap", {
	description = "Diamond Trap",
	tiles = {"default_cobble.png^default_mineral_diamond.png"},
	groups = {cracky = 3, trap = 1, explosive_trap = 1},
	drop = 'default:diamond_lump',
	is_ground_content = false,
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("nmobs:stone_with_gold_trap", {
	description = "Gold Trap",
	tiles = {"default_cobble.png^default_mineral_gold.png"},
	groups = {cracky = 3, trap = 1, lava_trap = 1},
	drop = 'default:gold_lump',
	is_ground_content = false,
	sounds = default.node_sound_stone_defaults(),
})
