-- Nmobs cow.lua
-- Copyright Duane Robertson (duane@duanerobertson.com), 2017
-- Distributed under the LGPLv2.1 (https://www.gnu.org/licenses/old-licenses/lgpl-2.1.en.html)

-- The nodebox and textures are copied from Cute Cubic Mobs
-- https://github.com/Napiophelios/ccmobs
-- and are distributed as Public Domain (WTFPL).


nmobs.register_mob({
	diurnal = true,
	drops = {
		{name = 'mobs:meat_raw',},
		{name = 'mobs:leather',},
	},
	environment = {'default:dirt_with_grass'},
	hit_dice = 3,
	media_prefix = 'ccmobs',
	name = 'cow',
	nodebox = {
		{-0.3125, -0.25, -0.4375, 0.3125, 0.3125, 0.1875},
		{-0.1875, -0.0625, 0.1875, 0.1875, 0.1875, 0.25},
		{-0.1875, -0.125, 0.25, 0.1875, 0.125, 0.5625},
		{-0.3125, 0.125, 0.25, 0.3125, 0.1875, 0.375},
		{-0.1875, -0.1875, 0.25, 0.1875, 0.1875, 0.4375},
		{-0.125, -0.25, 0.1875, 0.125, 0.1875, 0.3125},
		{-0.25, -0.5, -0.0625, -0.0625, -0.1875, 0.125},
		{0.0625, -0.5, -0.0625, 0.25, -0.0625, 0.125},
		{-0.25, -0.5, -0.375, -0.0625, -0.1875, -0.1875},
		{0.0625, -0.5, -0.375, 0.25, -0.25, -0.1875},
		{-0.0276272, -0.1875, -0.478997, 0.0376734, 0.1875, -0.4375},
		{-0.125, 0.1875, 0.1875, 0.125, 0.25, 0.375}
	},
	_right_click = {
		{
			item = 'bucket:bucket_empty',
			trade = true,
			drops = {
				{name = 'mobs:bucket_milk',},
			},
		},
		{
			item = 'wooden_bucket:bucket_wood_empty',
			trade = true,
			drops = {
				{name = 'wooden_bucket:bucket_wood_milk',},
			},
		},
	},
	size = 1.5,
	sound = 'ccmobs_cow',
	tames = {'farming:wheat 5'},
})


minetest.register_craftitem(':mobs:bucket_milk', {
	description = 'Bucket of Milk',
	inventory_image = 'bucket_milk.png',
	groups = {milk=1,},
	stack_max = 1,
	on_use = minetest.item_eat(8, 'bucket:bucket_empty'),
})

if minetest.get_modpath('wooden_bucket') then
	minetest.register_craftitem(':wooden_bucket:bucket_wood_milk', {
		description = 'Wooden Bucket of Milk',
		inventory_image = 'bucket_wood_milk.png',
		groups = {milk=1,},
		stack_max = 1,
		on_use = minetest.item_eat(8, 'wooden_bucket:bucket_wood_empty'),
	})
end

minetest.register_craftitem(':mobs:cheese', {
	description = 'Cheese',
	inventory_image = 'nmobs_cheese.png',
	on_use = minetest.item_eat(4),
})

minetest.register_craft({
	type = 'cooking',
	output = 'mobs:cheese',
	recipe = 'group:milk',
	cooktime = 5,
	replacements = {
		{ 'mobs:bucket_milk', 'bucket:bucket_empty'},
		{ 'wooden_bucket:bucket_wood_milk', 'wooden_bucket:bucket_wood_empty'},
	}
})

minetest.register_node(':mobs:cheeseblock', {
	description = 'Cheese Block',
	tiles = {'nmobs_cheese_block.png'},
	is_ground_content = false,
	groups = {crumbly = 3},
	sounds = default.node_sound_dirt_defaults()
})

minetest.register_craft({
	output = 'mobs:cheeseblock',
	recipe = {
		{'mobs:cheese', 'mobs:cheese', 'mobs:cheese'},
		{'mobs:cheese', 'mobs:cheese', 'mobs:cheese'},
		{'mobs:cheese', 'mobs:cheese', 'mobs:cheese'},
	}
})

minetest.register_craft({
	output = 'mobs:cheese 9',
	recipe = {
		{'mobs:cheeseblock'},
	}
})
