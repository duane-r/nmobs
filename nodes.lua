-- Nmobs nodes.lua
-- Copyright Duane Robertson (duane@duanerobertson.com), 2017, 2019
-- Distributed under the LGPLv2.1 (https://www.gnu.org/licenses/old-licenses/lgpl-2.1.en.html)


local mod = nmobs


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


dofile(mod.path..'/mobs_redo.lua')


do
	minetest.register_craftitem(':mobs:fur', {
		description = 'Fur',
		inventory_image = 'nmobs_fur.png',
	})

	minetest.register_craft({
		output = 'mobs:leather',
        type = 'shapeless',
		recipe = {
			'mobs:fur',
			'mobs:fur',
		}
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
