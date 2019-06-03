-- Nmobs lizard.lua
-- Copyright Duane Robertson (duane@duanerobertson.com), 2017, 2019
-- Distributed under the LGPLv2.1 (https://www.gnu.org/licenses/old-licenses/lgpl-2.1.en.html)

-- The nodebox and textures are distributed as Public Domain (WTFPL).


do
	local lizard_nodebox = {
		{ -0.0941656, -0.4375, -0.125, 0.0899805, -0.3125, 0.3125 }, -- NodeBox1
		{ -0.0355737, -0.421591, -0.272235, 0.0355737, -0.355966, -0.125 }, -- NodeBox2
		{ -0.0625, -0.417614, 0.3125, 0.0625, -0.334091, 0.4375 }, -- NodeBox3
		{ -0.0378199, -0.409659, 0.4375, 0.0398104, -0.348011, 0.5 }, -- NodeBox4
		{ -0.0355737, -0.5, -0.5, 0.0355737, -0.4375, -0.325354 }, -- NodeBox5
		{ 0.125, -0.5, 0.1875, 0.1875, -0.375, 0.25 }, -- NodeBox6
		{ 0.125, -0.5, -0.0625, 0.1875, -0.375, 0 }, -- NodeBox7
		{ -0.1875, -0.5, -0.0625, -0.125, -0.375, 0 }, -- NodeBox8
		{ -0.1875, -0.5, 0.1875, -0.125, -0.375, 0.25 }, -- NodeBox9
		{ -0.1875, -0.4375, 0.1875, 0.1875, -0.375, 0.25 }, -- NodeBox10
		{ -0.1875, -0.4375, -0.0625, 0.1875, -0.375, 0 }, -- NodeBox11
		{ -0.1875, -0.5, 0.1875, -0.125, -0.471307, 0.275434 }, -- NodeBox12
		{ 0.125, -0.5, 0.1875, 0.1875, -0.471307, 0.275434 }, -- NodeBox13
		{ 0.125, -0.5, -0.0625, 0.1875, -0.471307, 0.0261819 }, -- NodeBox14
		{ -0.1875, -0.5, -0.0625, -0.125, -0.471307, 0.0261819 }, -- NodeBox15
		{ -0.012555, -0.3125, -0.097397, 0.012555, -0.27642, 0.279623 }, -- NodeBox16
		{ -0.0355737, -0.457386, -0.372781, 0.0355737, -0.395739, -0.22291 }, -- NodeBox17
	}

	nmobs.register_mob({
		armor_class = 10,
		damage = 0.5,
		drops = {
			{ name = 'mobs:meat_raw', },
		},
		environment = { 'default:dirt_with_rainforest_litter', 'default:sand' },
		hit_dice = 1,
		name = 'lizard',
		nodebox = lizard_nodebox,
	})

	nmobs.register_mob({
		armor_class = 6,
		attacks_player = 20,
		damage = 0.5,
		drops = {
			{ name = 'mobs:meat_raw', },
		},
		environment = { 'default:stone', 'default:dirt_with_dry_grass' },
		hit_dice = 4,
		name = 'giant_lizard',
		nodebox = lizard_nodebox,
		size = 4,
	})
end
