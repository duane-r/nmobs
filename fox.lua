-- Nmobs fox.lua
-- Copyright Duane Robertson (duane@duanerobertson.com), 2017, 2019
-- Distributed under the LGPLv2.1 (https://www.gnu.org/licenses/old-licenses/lgpl-2.1.en.html)

-- The nodebox and textures are distributed as Public Domain (WTFPL).

do
	local fox_nodebox = {
		{ -0.125, -0.3125, -0.3125, 0.125, -0.0625, 0.25 }, -- NodeBox1
		{ -0.125, -0.5, 0.125, -0.0625, -0.3125, 0.1875 }, -- NodeBox2
		{ 0.0625, -0.5, 0.125, 0.125, -0.3125, 0.1875 }, -- NodeBox3
		{ 0.0625, -0.5, -0.25, 0.125, -0.3125, -0.1875 }, -- NodeBox4
		{ -0.125, -0.5, -0.25, -0.0625, -0.3125, -0.1875 }, -- NodeBox5
		{ -0.125, -0.5, 0.125, -0.0625, -0.48, 0.21 }, -- NodeBox6
		{ 0.0625, -0.5, 0.125, 0.125, -0.48, 0.21 }, -- NodeBox7
		{ 0.0625, -0.5, -0.25, 0.125, -0.48, -0.165 }, -- NodeBox8
		{ -0.125, -0.5, -0.25, -0.0625, -0.48, -0.165 }, -- NodeBox9
		{ -0.0979393, -0.1875, 0.1875, 0.100953, 0.0466653, 0.375 }, -- NodeBox10
		{ -0.0625, -0.1875, 0.375, 0.0625, -0.0625, 0.4375 }, -- NodeBox11
		{ -0.0301352, -0.161071, 0.4375, 0.0301352, -0.0993519, 0.5 }, -- NodeBox12
		{ -0.0625, -0.25, -0.375, 0.0625, -0.125, -0.3125 }, -- NodeBox15
		{ -0.0625, -0.3125, -0.4375, 0.0625, -0.1875, -0.375 }, -- NodeBox16
		{ -0.0625, -0.375, -0.5, 0.0625, -0.25, -0.4375 }, -- NodeBox17
		{ -0.0979393, 0.0331173, 0.220752, -0.0257945, 0.0858039, 0.254317 }, -- NodeBox18
		{ 0.0309534, 0.0331173, 0.220752, 0.100599, 0.0858039, 0.254317 }, -- NodeBox19
		{ 0.0482163, 0.0526866, 0.220752, 0.0843785, 0.106879, 0.254317 }, -- NodeBox20
		{ -0.081365, 0.0526866, 0.220752, -0.043696, 0.106879, 0.254317 }, -- NodeBox21
	}

	nmobs.register_mob({
		drops = { { name = 'mobs:fur', }, },
		environment = { 'default:dirt_with_grass' },
		hit_dice = 1,
		name = 'fox',
		nodebox = fox_nodebox,
	})

	nmobs.register_mob({
		drops = { { name = 'mobs:fur', }, },
		environment = { 'default:snow', 'default:dirt_with_snow' },
		hit_dice = 1,
		name = 'arctic_fox',
		nodebox = fox_nodebox,
	})
end
