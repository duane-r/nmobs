-- Nmobs bee.lua
-- Copyright Duane Robertson (duane@duanerobertson.com), 2017, 2019
-- Distributed under the LGPLv2.1 (https://www.gnu.org/licenses/old-licenses/lgpl-2.1.en.html)

-- The nodebox and textures are distributed as Public Domain (WTFPL).

-- Sounds and honey images
-- Copyright (c) 2014 Krupnov Pavel and 2016 TenPlus1
-- Distributed under the MIT license


do
	local bee_nodebox = {
		{ -0.0625, -0.344034, 0.3125, 0.0625, -0.220739, 0.407445 }, -- NodeBox1
		{ -0.0929023, -0.375, 0.1875, 0.0929023, -0.1875, 0.3125 }, -- NodeBox2
		{ -0.0929023, -0.375, -0.1875, 0.0929023, -0.1875, 0.125 }, -- NodeBox4
		{ -0.0625, -0.346023, 0.125, 0.0625, -0.220739, 0.1875 }, -- NodeBox5
		--{ -0.0358294, -0.3125, -0.25, 0.0338389, -0.25, -0.1875 }, -- NodeBox6
		{ 0.0625, -0.375, 0.1875, 0.125, -0.3125, 0.3125 }, -- NodeBox7
		{ 0.125, -0.375, 0.125, 0.1875, -0.3125, 0.1875 }, -- NodeBox8
		{ 0.1875, -0.5, 0.0625, 0.25, -0.3125, 0.125 }, -- NodeBox9
		{ 0.1875, -0.5, 0.3125, 0.25, -0.3125, 0.375 }, -- NodeBox10
		{ 0.25, -0.5, 0.1875, 0.3125, -0.3125, 0.25 }, -- NodeBox11
		{ 0.125, -0.375, 0.25, 0.1875, -0.3125, 0.3125 }, -- NodeBox12
		{ 0.1875, -0.375, 0.1875, 0.25, -0.3125, 0.25 }, -- NodeBox13
		{ -0.125, -0.375, 0.1875, -0.0625, -0.3125, 0.3125 }, -- NodeBox14
		{ -0.1875, -0.375, 0.125, -0.125, -0.3125, 0.1875 }, -- NodeBox15
		{ -0.25, -0.5, 0.0625, -0.1875, -0.3125, 0.125 }, -- NodeBox16
		{ -0.25, -0.5, 0.3125, -0.1875, -0.3125, 0.375 }, -- NodeBox17
		{ -0.3125, -0.5, 0.1875, -0.25, -0.3125, 0.25 }, -- NodeBox18
		{ -0.25, -0.375, 0.1875, -0.1875, -0.3125, 0.25 }, -- NodeBox19
		{ -0.1875, -0.375, 0.25, -0.125, -0.3125, 0.3125 }, -- NodeBox20
		{ -0.4375, -0.1875, 0.125, -0.125, -0.125, 0.25 }, -- NodeBox21
		{ 0.125, -0.1875, 0.125, 0.4375, -0.125, 0.25 }, -- NodeBox22
	}

	nmobs.register_mob({
		armor_class = 7,
		damage = 0.5,
		--drops = { { name = 'mobs:honey', chance = 2, max = 2, } },
		environment = { 'group:flower', },
		fly = true,
		hit_dice = 0.5,
		name = 'bee',
		nodebox = bee_nodebox,
		replaces = {
			{
				replace = { 'group:leaves', },
				when = 500,
				with = { 'nmobs:bee_hive', },
			}
		},
		size = 0.5,
		sound = 'mobs_bee',
		spawn = {
			{
				nodes = { 'group:flower' },
				rarity = 250,
			},
		},
		walk_speed = 1,
	})


	minetest.register_node('nmobs:bee_hive', {
		description = 'Bee hive',
		drawtype = "nodebox",
		node_box = {
			type = "fixed",
			fixed = {
				{ -0.3, -0.5, -0.3, 0.3, -0.25, 0.3 },
				{ -0.4, -0.25, -0.4, 0.4, 0.25, 0.4 },
				{ -0.3, 0.25, -0.3, 0.3, 0.5, 0.3 },
			}
		},
        drop = {
            max_items = 6,
            items = { {
                    items = {"mobs:honey 1", "mobs:honey 2", "mobs:honey 4", 'mobs:wax 3' },
			}, },
        },
		tiles = { 'nmobs_bee_hive.png' },
		groups = { snappy = 3, flammable = 2 },
		sounds = default.node_sound_dirt_defaults(),
	})

	minetest.register_craftitem(':mobs:wax', {
		description = 'Wax',
		inventory_image = 'nmobs_wax.png',
	})

	minetest.register_node('nmobs:candle', {
		description = 'Beeswax Candle',
		tiles = { 'nmobs_candle.png' },
		drawtype = 'plantlike',
		use_texture_alpha = true,
		inventory_image = 'nmobs_candle.png',
		light_source = 10,
		groups = { snappy = 3, dig_immediate = 3 },
        selection_box = {
            type = "fixed",
            fixed = {
                {-2 / 16, -0.5, -2 / 16, 2 / 16, 3 / 16, 2 / 16},
            },
        },
	})

	minetest.register_craft({
		output = 'nmobs:candle 10',
		type = 'shapeless',
		recipe = { 'mobs:wax', 'mobs:wax', 'farming:string', },
	})

	minetest.register_craftitem(':mobs:honey', {
		description = 'Honey',
		inventory_image = 'nmobs_honey.png',
		on_use = minetest.item_eat(6),
	})

	minetest.register_node(':mobs:honey_block', {
		description = 'Honey Block',
		tiles = { 'nmobs_honey_block.png' },
		groups = { snappy = 3, flammable = 2 },
		sounds = default.node_sound_dirt_defaults(),
	})

	minetest.register_craft({
		output = 'mobs:honey_block',
		recipe = {
			{ 'mobs:honey', 'mobs:honey', 'mobs:honey' },
			{ 'mobs:honey', 'mobs:honey', 'mobs:honey' },
			{ 'mobs:honey', 'mobs:honey', 'mobs:honey' },
		}
	})

	minetest.register_craft({
		output = 'mobs:honey 9',
		recipe = {
			{ 'mobs:honey_block' },
		}
	})
end
