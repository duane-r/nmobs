-- Nmobs slime.lua
-- Copyright Duane Robertson (duane@duanerobertson.com), 2017, 2019
-- Distributed under the LGPLv2.1 (https://www.gnu.org/licenses/old-licenses/lgpl-2.1.en.html)

-- The nodebox and textures are distributed as Public Domain (WTFPL).


do
	local slime_nodebox = {
		{ -0.5, -0.5, -0.5, 0.5, -0.45, 0.5 },
	}

	nmobs.register_mob({
		attacks_player = true,
		damage = 0.2,
		environment = { 'group:natural_stone', },
		glow = 2,
		hit_dice = 2,
		name = 'green_slime',
		nodebox = slime_nodebox,
		reach = 0,
		replaces = {
			{
				replace = { 'group:stone', },
				under_air = true,
				when = 75,
				with = { 'nmobs:slimy_stone', },
			}
		},
		run_speed = 0.5,
		spawn = {
			{
				nodes = { 'group:natural_stone' },
			},
			{
				nodes = { 'nmobs:slimy_stone' },
				rarity = 50,
			},
		},
		walk_speed = 0.2,

		-- can't be hurt by weapons
		_take_punch = function()
			return true
		end
	})
end
