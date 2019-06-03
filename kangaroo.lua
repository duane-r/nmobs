-- Nmobs hape.lua
-- Copyright Duane Robertson (duane@duanerobertson.com), 2017, 2019
-- Distributed under the LGPLv2.1 (https://www.gnu.org/licenses/old-licenses/lgpl-2.1.en.html)

-- The nodebox and textures are distributed as Public Domain (WTFPL).


do
	local kangaroo_nodebox = {
			{ -0.125, -0.3125, -0.1875, 0.125, 0.125, 0.125 }, -- NodeBox1
			{ -0.125, -0.0625, 0.0625, 0.125, 0.1875, 0.3125 }, -- NodeBox2
			{ -0.0352311, -0.5, -0.4375, 0.037433, -0.4375, -0.1875 }, -- NodeBox3
			{ -0.0352311, -0.5, -0.1875, 0.037433, -0.25, -0.125 }, -- NodeBox4
			{ -0.0924815, 0.1875, 0.1875, 0.0902796, 0.375, 0.4375 }, -- NodeBox5
			{ -0.0638563, 0.1875, 0.375, 0.0616543, 0.3125, 0.5 }, -- NodeBox6
			{ -0.125, -0.5, 0.0625, -0.0625, -0.4375, 0.375 }, -- NodeBox7
			{ 0.0625, -0.5, 0.0625, 0.125, -0.4375, 0.375 }, -- NodeBox8
			{ 0.0625, -0.5, 0.0625, 0.125, -0.1875, 0.125 }, -- NodeBox9
			{ -0.125, -0.5, 0.0625, -0.0625, -0.1875, 0.125 }, -- NodeBox10
			{ -0.125, -0.25, 0.25, -0.0625, 0, 0.3125 }, -- NodeBox11
			{ 0.0625, -0.25, 0.25, 0.125, 0, 0.3125 }, -- NodeBox12
			{ -0.0924815, 0.375, 0.1875, -0.0625, 0.5, 0.25 }, -- NodeBox13
			{ 0.0625, 0.375, 0.1875, 0.0946835, 0.5, 0.25 }, -- NodeBox14
		}

	nmobs.register_mob({
		armor_class = 10,
		damage = 0.5,
		drops = {
			{ name = 'mobs:meat_raw', },
		},
		environment = { 'default:dirt_with_dry_grass' },
		hit_dice = 1,
		hops = true,
		name = 'kangaroo',
		nodebox = kangaroo_nodebox,
	})
end
