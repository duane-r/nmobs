-- Nmobs cow.lua
-- Copyright Duane Robertson (duane@duanerobertson.com), 2017, 2019
-- Distributed under the LGPLv2.1 (https://www.gnu.org/licenses/old-licenses/lgpl-2.1.en.html)

-- The nodebox and textures are copied from Cute Cubic Mobs
-- https://github.com/Napiophelios/ccmobs
-- and are distributed as Public Domain (WTFPL).


do
	local cow_nodebox = {
		{ -0.3125, -0.25, -0.4375, 0.3125, 0.3125, 0.1875 },
		{ -0.1875, -0.0625, 0.1875, 0.1875, 0.1875, 0.25 },
		{ -0.1875, -0.125, 0.25, 0.1875, 0.125, 0.5625 },
		{ -0.3125, 0.125, 0.25, 0.3125, 0.1875, 0.375 },
		{ -0.1875, -0.1875, 0.25, 0.1875, 0.1875, 0.4375 },
		{ -0.125, -0.25, 0.1875, 0.125, 0.1875, 0.3125 },
		{ -0.25, -0.5, -0.0625, -0.0625, -0.1875, 0.125 },
		{ 0.0625, -0.5, -0.0625, 0.25, -0.0625, 0.125 },
		{ -0.25, -0.5, -0.375, -0.0625, -0.1875, -0.1875 },
		{ 0.0625, -0.5, -0.375, 0.25, -0.25, -0.1875 },
		{ -0.0276272, -0.1875, -0.478997, 0.0376734, 0.1875, -0.4375 },
		{ -0.125, 0.1875, 0.1875, 0.125, 0.25, 0.375 }
	}

	nmobs.register_mob({
		diurnal = true,
		drops = {
			{ name = 'mobs:meat_raw', },
			{ name = 'mobs:leather', },
		},
		environment = { 'default:dirt_with_grass' },
		hit_dice = 3,
		media_prefix = 'ccmobs',
		name = 'cow',
		nodebox = cow_nodebox,
		_right_click = {
			{
				item = 'bucket:bucket_empty',
				trade = true,
				drops = {
					{ name = 'mobs:bucket_milk', },
				},
			},
			{
				item = 'wooden_bucket:bucket_wood_empty',
				trade = true,
				drops = {
					{ name = 'wooden_bucket:bucket_wood_milk', },
				},
			},
		},
		size = 1.5,
		sound = 'ccmobs_cow',
		tames = { 'farming:wheat 5' },
	})
end
