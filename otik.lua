-- Nmobs otik.lua
-- Copyright Duane Robertson (duane@duanerobertson.com), 2017, 2019
-- Distributed under the LGPLv2.1 (https://www.gnu.org/licenses/old-licenses/lgpl-2.1.en.html)

-- Otik is based on the Otesánek or "Greedy Guts", a Czechoslovakian
--  children's fable in which a child-like stump adopted by a childless
--  couple comes to life and devours them and their neighbors.

-- The nodebox is distributed as Public Domain (WTFPL).

-- Textures are based on minetest textures,
-- Copyright (C) 2010-2012 celeron55, Perttu Ahola <celeron55@gmail.com>
-- Attribution-ShareAlike 3.0 Unported (CC BY-SA 3.0).
-- http://creativecommons.org/licenses/by-sa/3.0/


do
	local otik_nodebox = {
		{ -0.25, -0.5, -0.25, 0.25, 0.5, 0.25 },
		{ -0.125, 0, 0.25, 0.125, 0.0625, 0.3125 },
		{ -0.5, 0.0625, -0.125, -0.25, 0.125, -0.0625 },
		{ -0.375, 0.125, -0.125, -0.3125, 0.375, -0.0625 },
		{ 0.25, 0.125, 0.0625, 0.3125, 0.375, 0.125 },
		{ 0.3125, -0.1875, 0.0625, 0.375, 0.1875, 0.125 },
		{ 0.375, -0.375, 0.0625, 0.4375, -0.125, 0.125 },
		{ -0.125, 0.3125, 0.25, 0.125, 0.375, 0.3125 },
		{ -0.1875, 0, 0.25, -0.125, 0.375, 0.3125 },
		{ 0.125, 0, 0.25, 0.1875, 0.375, 0.3125 },
	}

	nmobs.register_mob({
		attacks_player = true,
		armor_class = 4,
		drops = {
			{ name = 'default:wood', max = 3 },
			{ name = 'default:stick', max = 3 },
			{ name = 'default:apple', max = 3, chance = 3 },
			{ name = 'mapgen:acorns', max = 6, chance = 3 },
			{ name = 'farming:seed_wheat', max = 6, chance = 3 },
			{ name = 'farming:seed_cotton', max = 6, chance = 3 },
		},
		environment = { 'default:dirt_with_grass', 'default:dirt_with_rainforest_litter', 'default:dirt_with_coniferous_litter' },
		hit_dice = 3,
		looks_for = { 'group:snappy', 'group:wood' },
		name = 'otik',
		nocturnal = true,
		nodebox = otik_nodebox,
		replaces = {
			{
				replace = { 'group:snappy', 'group:wood' },
				when = 200,
			}
		},
	})
end
