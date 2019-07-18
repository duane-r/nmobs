-- Nmobs nodes.lua
-- Copyright Duane Robertson (duane@duanerobertson.com), 2017, 2019

-- Most of this code is adapted from TenPlus1's mobs_redo, and is
-- published under the MIT license:

-- https://forum.minetest.net/viewtopic.php?f=11&t=9917

-- The MIT License (MIT)
-- 
-- Copyright (c) 2016 TenPlus1
-- 
-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
-- 
-- The above copyright notice and this permission notice shall be included in
-- all copies or substantial portions of the Software.
-- 
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
-- THE SOFTWARE.



do
	minetest.register_craftitem(':mobs:leather', {
		description = 'Leather',
		inventory_image = 'mobs_leather.png',
	})

	minetest.register_craftitem(':mobs:meat_raw', {
		description = 'Raw Meat',
		inventory_image = 'mobs_meat_raw.png',
		on_use = minetest.item_eat(3),
	})

	minetest.register_craftitem(':mobs:meat', {
		description = 'Meat',
		inventory_image = 'mobs_meat.png',
		on_use = minetest.item_eat(8),
	})

	minetest.register_craft({
		type = 'cooking',
		output = 'mobs:meat',
		recipe = 'mobs:meat_raw',
		cooktime = 5,
	})

	minetest.register_craftitem(':mobs:bucket_milk', {
		description = 'Bucket of Milk',
		inventory_image = 'bucket_milk.png',
		groups = { milk=1, },
		stack_max = 1,
		on_use = minetest.item_eat(8, 'bucket:bucket_empty'),
	})

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
			{ 'mobs:bucket_milk', 'bucket:bucket_empty' },
			{ 'wooden_bucket:bucket_wood_milk', 'wooden_bucket:bucket_wood_empty' },
		}
	})

	minetest.register_node(':mobs:cheeseblock', {
		description = 'Cheese Block',
		tiles = { 'nmobs_cheese_block.png' },
		is_ground_content = false,
		groups = { crumbly = 3 },
		sounds = default.node_sound_dirt_defaults()
	})

	minetest.register_craft({
		output = 'mobs:cheeseblock',
		recipe = {
			{ 'mobs:cheese', 'mobs:cheese', 'mobs:cheese' },
			{ 'mobs:cheese', 'mobs:cheese', 'mobs:cheese' },
			{ 'mobs:cheese', 'mobs:cheese', 'mobs:cheese' },
		}
	})

	minetest.register_craft({
		output = 'mobs:cheese 9',
		recipe = {
			{ 'mobs:cheeseblock' },
		}
	})

	minetest.register_craftitem(':mobs:rat_dead', {
		description = 'Dead Rat',
		inventory_image = 'nmobs_rat_inventory.png',
	})

	minetest.register_craftitem(':mobs:rat_cooked', {
		description = 'Cooked Rat',
		inventory_image = 'nmobs_rat_cooked.png',
		on_use = minetest.item_eat(2),
	})

	minetest.register_craft({
		type = 'cooking',
		output = 'mobs:rat_cooked',
		recipe = 'mobs:rat_dead',
		cooktime = 5,
	})

	-- cobweb
	minetest.register_node(':mobs:cobweb', {
		description = 'Cobweb',
		drawtype = 'plantlike',
		visual_scale = 1.1,
		tiles = {'mobs_cobweb.png'},
		inventory_image = 'mobs_cobweb.png',
		paramtype = 'light',
		sunlight_propagates = true,
		liquid_viscosity = 11,
		liquidtype = 'source',
		liquid_alternative_flowing = 'mobs:cobweb',
		liquid_alternative_source = 'mobs:cobweb',
		liquid_renewable = false,
		liquid_range = 0,
		walkable = false,
		groups = { snappy = 1 },
		drop = 'farming:cotton',
		sounds = default.node_sound_leaves_defaults(),
	})

	minetest.register_craft({
		output = 'mobs:cobweb',
		recipe = {
			{'farming:string', '', 'farming:string'},
			{'', 'farming:string', ''},
			{'farming:string', '', 'farming:string'},
		}
	})
end
