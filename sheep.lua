-- Nmobs sheep.lua
-- Copyright Duane Robertson (duane@duanerobertson.com), 2017, 2019
-- Distributed under the LGPLv2.1 (https://www.gnu.org/licenses/old-licenses/lgpl-2.1.en.html)

-- The nodebox and textures are copied from Cute Cubic Mobs
-- https://github.com/Napiophelios/ccmobs
-- and are distributed as Public Domain (WTFPL).


do
	local sheep_nodebox = {
		{ -0.3125, -0.375, -0.4375, 0.3125, 0.1875, 0.1875 },
		{ -0.1875, -0.25, 0.125, 0.1875, 0.0625, 0.375 },
		{ -0.25, -0.0625, 0.1875, 0.25, 0.06, 0.3125 },
		{ -0.125, -0.3125, 0.3125, 0.125, 0.08995, 0.5 },
		{ 0.0625, -0.5, -0.0625, 0.25, -0.375, 0.125 },
		{ -0.25, -0.5, -0.0625, -0.0625, -0.3125, 0.125 },
		{ 0.0625, -0.5, -0.375, 0.25, -0.3125, -0.1875 },
		{ -0.25, -0.5, -0.375, -0.0625, -0.3125, -0.1875 },
		{ -0.0625, -0.1875, -0.5, 0.0625, 0.0625, -0.4375 },
	}

	nmobs.register_mob({
		diurnal = true,
		drops = {
			{ name = 'mobs:meat_raw', },
			{ name = 'wool:white', chance = 2, },
			{ name = 'mobs:leather', chance = 8 },
		},
		environment = { 'default:dirt_with_grass' },
		hit_dice = 1,
		media_prefix = 'ccmobs',
		name = 'sheep',
		nodebox = sheep_nodebox,
		_right_click = { {
			drops = {
				{ name = 'wool:white', },
			},
		}, },
		sound = 'ccmobs_sheep',
		tames = { 'farming:wheat' },
	})
end
