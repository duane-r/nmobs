-- Nmobs goat.lua
-- Copyright Duane Robertson (duane@duanerobertson.com), 2017, 2019
-- Distributed under the LGPLv2.1 (https://www.gnu.org/licenses/old-licenses/lgpl-2.1.en.html)

-- The nodebox and textures are copied from Cute Cubic Mobs
-- https://github.com/Napiophelios/ccmobs
-- and are distributed as Public Domain (WTFPL).


do
	local goat_nodebox = {
		{ -0.203072, -0.3125, -0.453246, 0.200683, 0, 0.0131549 },
		{ -0.0286689, -0.125, -0.5, 0.0334471, -0.0625, -0.4375 },
		{ -0.1875, -0.5, -0.4375, -0.0625, -0.3125, -0.3125 },
		{ 0.0625, -0.5, -0.4375, 0.1875, -0.3125, -0.3125 },
		{ -0.1875, -0.5, -0.125, -0.0625, -0.3125, 0 },
		{ 0.0625, -0.5, -0.125, 0.1875, -0.3125, 0 },
		{ -0.0831274, -0.167758, 0, 0.0812382, 0.0316038, 0.0466401 },
		{ -0.0750626, -0.122365, 0.0275057, 0.0734655, 0.0592087, 0.0657745 },
		{ -0.090785, 0, 0.0625, 0.090785, 0.0897541, 0.1875 },
		{ -0.109898, -0.125, 0.0625, 0.107509, 0.0633559, 0.211426 },
		{ 0.0625, 0.0625, 0.07412, 0.113356, 0.138105, 0.116882 },
		{ -0.115245, 0.0625, 0.0712692, -0.0625, 0.139529, 0.116882 },
		{ -0.1875, 0.0131991, 0.0625, 0.1875, 0.0422372, 0.125 },
		{ -0.0812287, -0.113513, 0.206681, 0.0764505, -0.00142377, 0.25 },
		{ -0.0334471, -0.161029, 0.1875, 0.0382253, -0.108233, 0.219355 },
		{ -0.109577, 0.125, 0.0783961, -0.0717919, 0.190599, 0.108329 },
		{ 0.0736812, 0.125, 0.0812469, 0.107688, 0.190784, 0.105478 },
		{ -0.0573379, -0.114049, 0.25, 0.0549488, -0.0137408, 0.3125 },
	}

	nmobs.register_mob({
		diurnal = true,
		drops = {
			{ name = 'mobs:meat_raw', },
			{ name = 'mobs:leather', chance = 6 },
		},
		environment = { 'default:dirt_with_grass' },
		hit_dice = 1,
		media_prefix = 'ccmobs',
		name = 'goat',
		nodebox = goat_nodebox,
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
		tames = { 'farming:wheat' },
	})
end
