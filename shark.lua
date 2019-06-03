-- Nmobs shark.lua
-- Copyright Duane Robertson (duane@duanerobertson.com), 2017, 2019
-- Distributed under the LGPLv2.1 (https://www.gnu.org/licenses/old-licenses/lgpl-2.1.en.html)

-- The nodebox and textures are distributed as Public Domain (WTFPL).


do
	local shark_nodebox = {
		{ -0.125, -0.5, -0.1875, 0.125, -0.25, 0.375 },
		{ -0.0625, -0.4375, -0.375, 0.0625, -0.3125, 0.5 },
		{ -0.0325, -0.5, -0.5, 0.0325, -0.25, -0.4375 },
		{ -0.0325, -0.3125, 0.0625, 0.0325, -0.1875, 0.25 },
		{ -0.105, -0.47, 0.375, 0.105, -0.28, 0.4375 },
		{ -0.105, -0.47, -0.25, 0.105, -0.28, -0.1875 },
		{ -0.0325, -0.48, -0.4375, 0.0325, -0.27, -0.375 },
		{ -0.0325, -0.3125, 0.0625, 0.0325, -0.125, 0.125 },
		{ -0.0325, -0.3125, 0.125, 0.0325, -0.155, 0.1875 },
	}

	nmobs.register_mob({
		aquatic = true,
		attacks_player = true,
		armor_class = 6,
		damage = 2,
		drops = {
			{ name = 'mobs:meat_raw', },
		},
		environment = { 'default:water_source' },
		hit_dice = 2,
		name = 'shark_1',
		nodebox = shark_nodebox,
		--rarity = 5000,
		size = 2,
		--vision = 6,
	})
end

