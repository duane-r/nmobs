-- Nmobs chicken.lua
-- Copyright Duane Robertson (duane@duanerobertson.com), 2017, 2019
-- Distributed under the LGPLv2.1 (https://www.gnu.org/licenses/old-licenses/lgpl-2.1.en.html)

-- The nodebox and textures are distributed as Public Domain (WTFPL).

do
	local chicken_nodebox = {
		{ -0.1875, -0.5, -0.4375, 0.1875, 0.0625, 0.25 }, -- NodeBox1
		{ -0.25, -0.375, -0.375, 0.25, 0, 0.1875 }, -- NodeBox3
		{ -0.125, 0, 0.125, 0.125, 0.3125, 0.375 }, -- NodeBox4
		{ -0.04, 0.125, 0.375, 0.04, 0.1875, 0.48 }, -- NodeBox5
		{ -0.01, 0.3125, 0.15, 0.01, 0.375, 0.35 }, -- NodeBox6
		{ -0.125, -0.1875, -0.5, 0.125, 0.125, -0.4375 }, -- NodeBox7
	}

	nmobs.register_mob({
		armor_class = 7,
		damage = 0.5,
		diurnal = true,
		drops = { { name = 'mobs:meat_raw' }, },
		environment = {
			'default:dirt_with_grass',
			'default:dirt_with_dry_grass',
		},
		hit_dice = 1,
		name = 'chicken',
		nodebox = chicken_nodebox,
		run_speed = 3,
		scared = true,
		size = 0.5,
		sound = 'mobs_chicken',
		tames = { 'farming:seed_wheat' },
		vision = 6,
		walk_speed = 1,
	})

	nmobs.register_mob({
		armor_class = 8,
		attacks_player = true,
		damage = 3,
		--drops = { { name = 'mobs:meat_raw' }, },
		environment = {
			'group:natural_stone',
			'default:dirt_with_rainforest_litter',
		},
		hit_dice = 5,
		name = 'cockatrice',
		nodebox = chicken_nodebox,
		run_speed = 3,
		size = 1,
		sound = 'mobs_chicken',
		tames = { 'farming:seed_wheat' },
		vision = 6,
		walk_speed = 1,
	})
end
