-- Nmobs .lua
-- Copyright Duane Robertson (duane@duanerobertson.com), 2017, 2019
-- Distributed under the LGPLv2.1 (https://www.gnu.org/licenses/old-licenses/lgpl-2.1.en.html)

-- The nodebox and textures are distributed as Public Domain (WTFPL).


--[[
local function climb(self)
	if not self then
		return
	end

	if self._state == "standing" and math.random() < 0.2 then
		if self.fall_speed == 2 then
			self.fall_speed = -2
		else
			self.fall_speed = 2
		end
	elseif self._state == "fighting" and self.fall_speed ~= -2 then
		self.fall_speed = -2
	end
end
--]]


do
	local spider_nodebox = {
		{ -0.1875, -0.375, -0.4375, 0.1875, 0, -0.0625 }, -- NodeBox1
		{ -0.125, -0.375, 0, 0.125, -0.0625, 0.375 }, -- NodeBox2
		{ 0.0625, -0.25, 0.375, 0.125, -0.1875, 0.5 }, -- NodeBox3
		{ -0.125, -0.25, 0.375, -0.0625, -0.1875, 0.5 }, -- NodeBox4
		{ 0.0625, -0.3125, 0.4375, 0.125, -0.25, 0.5 }, -- NodeBox5
		{ -0.125, -0.3125, 0.4375, -0.0625, -0.25, 0.5 }, -- NodeBox6
		{ -0.125, -0.3125, -0.0625, 0.125, -0.125, 0 }, -- NodeBox7
		{ -0.0625, -0.3125, -0.0625, 0.0625, -0.0625, 0 }, -- NodeBox7.5
		{ 0.125, -0.3125, 0.25, 0.1875, -0.25, 0.3125 }, -- NodeBox8
		{ 0.125, -0.3125, 0.1875, 0.375, -0.25, 0.25 }, -- NodeBox9
		{ 0.125, -0.3125, 0.0625, 0.4375, -0.25, 0.125 }, -- NodeBox10
		{ 0.125, -0.3125, 0, 0.1875, -0.25, 0.0625 }, -- NodeBox11
		{ 0.1875, -0.3125, -0.0625, 0.25, -0.25, 0 }, -- NodeBox12
		{ 0.25, -0.3125, -0.125, 0.3125, -0.25, -0.0625 }, -- NodeBox13
		{ 0.3125, -0.5, -0.1875, 0.375, -0.25, -0.125 }, -- NodeBox14
		{ 0.375, -0.5, 0.0625, 0.4375, -0.25, 0.125 }, -- NodeBox15
		{ 0.375, -0.5, 0.1875, 0.4375, -0.25, 0.25 }, -- NodeBox16
		{ 0.1875, -0.3125, 0.3125, 0.25, -0.25, 0.375 }, -- NodeBox17
		{ 0.25, -0.3125, 0.375, 0.3125, -0.25, 0.4375 }, -- NodeBox18
		{ 0.3125, -0.5, 0.4375, 0.375, -0.25, 0.5 }, -- NodeBox19
		{ -0.375, -0.5, 0.4375, -0.3125, -0.25, 0.5 }, -- NodeBox20
		{ -0.3125, -0.3125, 0.375, -0.25, -0.25, 0.4375 }, -- NodeBox21
		{ -0.25, -0.3125, 0.3125, -0.1875, -0.25, 0.375 }, -- NodeBox22
		{ -0.25, -0.3125, -0.0625, -0.1875, -0.25, 0 }, -- NodeBox23
		{ -0.3125, -0.3125, -0.125, -0.25, -0.25, -0.0625 }, -- NodeBox24
		{ -0.375, -0.5, -0.1875, -0.3125, -0.25, -0.125 }, -- NodeBox25
		{ -0.375, -0.3125, 0.1875, -0.125, -0.25, 0.25 }, -- NodeBox26
		{ -0.4375, -0.3125, 0.0625, -0.125, -0.25, 0.125 }, -- NodeBox27
		{ -0.4375, -0.5, 0.1875, -0.375, -0.25, 0.25 }, -- NodeBox28
		{ -0.4375, -0.5, 0.0625, -0.375, -0.25, 0.125 }, -- NodeBox29
		{ -0.1875, -0.3125, 0, -0.125, -0.25, 0.0625 }, -- NodeBox30
		{ -0.1875, -0.3125, 0.25, -0.125, -0.25, 0.3125 }, -- NodeBox31
	}

	nmobs.register_mob({
		armor_class = 7,
		attacks_player = true,
		damage = 4,
		drops = {
			{ name = "mobs:meat_raw", max = 3 },
			{ name = "farming:string", max = 4 },
			{ name = "wool:yellow", max = 2 },
		},
		environment = { 'default:desert_stone', 'group:sand' },
		hit_dice = 4,
		name = 'giant_tarantula',
		nocturnal = true,
		run_speed = 3,
		size = 2,
		sound = 'mobs_spider',
		sound_angry = 'mobs_spider',
		textures = { 'nmobs_desert_tarantula_top.png', 'nmobs_desert_tarantula_bottom.png', 'nmobs_desert_tarantula_right.png', 'nmobs_desert_tarantula_left.png', 'nmobs_desert_tarantula_front.png', 'nmobs_desert_tarantula_back.png' },
		walk_speed = 1,
	})

	nmobs.register_mob({
		armor_class = 7,
		attacks_player = true,
		damage = 4,
		drops = {
			{ name = "mobs:meat_raw", max = 3 },
			{ name = "wool:black", max = 3 },
			{ name = "farming:string", max = 4 },
		},
		environment = { 'group:natural_stone', },
		glow = 2,
		hit_dice = 4,
		lower_than = -10,
		name = 'deep_spider',
		run_speed = 3,
		size = 2,
		sound = 'mobs_spider',
		sound_angry = 'mobs_spider',
		walk_speed = 1,
	})

	nmobs.register_mob({
		armor_class = 7,
		attacks_player = true,
		damage = 4,
		drops = {
			{ name = "mobs:meat_raw", max = 3 },
			{ name = "wool:white", max = 3 },
			{ name = "farming:string", max = 4 },
		},
		environment = { 'default:ice' },
		hit_dice = 4,
		name = 'ice_spider',
		run_speed = 3,
		size = 2,
		sound = 'mobs_spider',
		sound_angry = 'mobs_spider',
		walk_speed = 1,
	})

	nmobs.register_mob({
		armor_class = 7,
		attacks_player = nil,
		damage = 1,
		drops = { { name = "mobs:meat_raw"}, },
		environment = { 'default:desert_stone', 'group:sand' },
		hit_dice = 0,
		name = 'desert_tarantula',
		run_speed = 3,
		size = 0.5,
		sound = 'mobs_spider',
		sound_angry = 'mobs_spider',
		step_height = 10,
		walk_speed = 1,
	})

	nmobs.register_mob({
		armor_class = 7,
		attacks_player = nil,
		damage = 1,
		drops = { { name = "mobs:meat_raw"}, },
		environment = { 'default:dirt_with_rainforest_litter' },
		hit_dice = 0,
		name = 'jungle_tarantula',
		run_speed = 3,
		size = 0.5,
		sound = 'mobs_spider',
		sound_angry = 'mobs_spider',
		step_height = 10,
		textures = { 'nmobs_deep_spider_top.png', 'nmobs_deep_spider_bottom.png', 'nmobs_deep_spider_right.png', 'nmobs_deep_spider_left.png', 'nmobs_deep_spider_front.png', 'nmobs_deep_spider_back.png' },
		walk_speed = 1,
	})
end

