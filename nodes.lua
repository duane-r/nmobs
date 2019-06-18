-- Nmobs nodes.lua
-- Copyright Duane Robertson (duane@duanerobertson.com), 2017
-- Distributed under the LGPLv2.1 (https://www.gnu.org/licenses/old-licenses/lgpl-2.1.en.html)


do
	minetest.after(0.1, function()
		for k, v in pairs(minetest.registered_nodes) do
			local g = v.groups
			if v.name:find('default:stone_with') then
				g.ore = 1
				minetest.override_item(v.name, { groups = g })
			end
			if (g.stone or v.name:find('default:.*sandstone') or g.ore) and not (v.name:find('brick') or v.name:find('block') or v.name:find('stair') or v.name:find('slab') or v.name:find('default:.*cobble') or v.name:find('walls:.*cobble')) then
				g.natural_stone = 1
				minetest.override_item(v.name, { groups = g })
			end
		end
	end)
end


do
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

	minetest.register_craftitem(":mobs:rat_dead", {
		description = "Dead Rat",
		inventory_image = "nmobs_rat_inventory.png",
	})

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

	-- cobweb
	minetest.register_node(":mobs:cobweb", {
		description = "Cobweb",
		drawtype = "plantlike",
		visual_scale = 1.1,
		tiles = {"mobs_cobweb.png"},
		inventory_image = "mobs_cobweb.png",
		paramtype = "light",
		sunlight_propagates = true,
		liquid_viscosity = 11,
		liquidtype = "source",
		liquid_alternative_flowing = "mobs:cobweb",
		liquid_alternative_source = "mobs:cobweb",
		liquid_renewable = false,
		liquid_range = 0,
		walkable = false,
		groups = { snappy = 1 },
		drop = "farming:cotton",
		sounds = default.node_sound_leaves_defaults(),
	})

	minetest.register_craft({
		output = "mobs:cobweb",
		recipe = {
			{"farming:string", "", "farming:string"},
			{"", "farming:string", ""},
			{"farming:string", "", "farming:string"},
		}
	})
end


do
	minetest.register_craftitem(":mobs:fur", {
		description = "Fur",
		inventory_image = "nmobs_fur.png",
	})

	local cnode = nmobs.clone_node('default:stone')
	cnode.tiles = { 'default_stone.png^nmobs_slimy.png' }
	cnode.description = 'Slimy stone'
	cnode.light_source = 4
	cnode.drop = nil
	minetest.register_node('nmobs:slimy_stone', cnode)

	minetest.register_craftitem('nmobs:slime_ball', {
		image = 'nmobs_slime_ball.png',
		description='Slime Ball',
	})

	minetest.register_craft({
		output = 'nmobs:slime_ball',
        type = 'shapeless',
		replacements = {
			{ 'nmobs:slimy_stone', 'default:cobble' },
		},
		recipe = {
			'nmobs:slimy_stone',
		}
	})

	if minetest.get_modpath('wooden_bucket') then
		minetest.register_craftitem(':wooden_bucket:bucket_wood_milk', {
			description = 'Wooden Bucket of Milk',
			inventory_image = 'bucket_wood_milk.png',
			groups = { milk=1, },
			stack_max = 1,
			on_use = minetest.item_eat(8, 'wooden_bucket:bucket_wood_empty'),
		})
	end
end
