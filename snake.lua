-- Nmobs snake.lua
-- Copyright Duane Robertson (duane@duanerobertson.com), 2017, 2019
-- Distributed under the LGPLv2.1 (https://www.gnu.org/licenses/old-licenses/lgpl-2.1.en.html)


do
	if minetest.global_exists('status_mod') then
		status_mod.register_status({
			name = 'poisoned',
			during = function(player)
				if not player then
					return
				end
				local player_name = player:get_player_name()
				if not player_name or player_name == '' then
					return
				end

				local damage = 1
				local status = status_mod.get_status(player_name, 'poisoned')
				if status and status.damage then
					damage = tonumber(status.damage)
				end

				local hp = player:get_hp()
				if hp and type(hp) == 'number' then
					hp = hp - damage
					player:set_hp(hp)
				end
			end,
			terminate = function(player)
				if not player then
					return
				end

				local player_name = player:get_player_name()
				minetest.chat_send_player(player_name, 'Your sickness ebbs away.')
			end,
		})
	end

	local snake_nodebox = {
		{ -0.0625, -0.5, -0.4375, 0, -0.4375, -0.3125 },
		{ 0, -0.5, -0.375, 0.0625, -0.4375, -0.1875 },
		{ 0.0625, -0.5, -0.25, 0.125, -0.4375, -0.0625 },
		{ 0, -0.5, -0.125, 0.0625, -0.4375, 0.0625 },
		{ -0.0625, -0.5, 0, 0, -0.4375, 0.125 },
		{ -0.125, -0.5, 0.0625, -0.0625, -0.4375, 0.25 },
		{ -0.0625, -0.5, 0.1875, 0, -0.4375, 0.3125 },
		{ 0, -0.5, 0.25, 0.0625, -0.4375, 0.4375 },
	}

	local function poison_bite(self, target, delay, capabilities)
		if minetest.global_exists('status_mod')
		and status_mod.registered_status['poisoned']
		and target and target.get_player_name then
			local player_name = target:get_player_name()
			local armor = target:get_armor_groups()
			if not (player_name and armor) then
				return
			end

			if armor['fleshy'] and math.random(100) > armor['fleshy'] then
				return
			end

			minetest.chat_send_player(player_name, minetest.colorize('#FF0000', 'You\'ve been poisoned!'))
			status_mod.set_status(player_name, 'poisoned', 2 ^ math.random(8), { damage = 1 })
		else
			nmobs.punch(self, target, delay, capabilities)
		end
	end

	nmobs.register_mob({
		attacks_player = true,
		armor_class = 6,
		drops = {
			{ name = 'mobs:meat_raw', },
		},
		environment = { 'default:dirt_with_rainforest_litter' },
		hit_dice = 1,
		name = 'jungle_snake',
		nodebox = snake_nodebox,
		_punch = poison_bite,
		textures = { 'default_rainforest_litter.png' },
		vision = 6,
	})

	nmobs.register_mob({
		attacks_player = true,
		armor_class = 6,
		drops = {
			{ name = 'mobs:meat_raw', },
		},
		environment = { 'group:sand', 'default:dirt_with_dry_grass' },
		hit_dice = 1,
		name = 'snake',
		nodebox = snake_nodebox,
		_punch = poison_bite,
		textures = { 'default_desert_sand.png' },
		vision = 6,
	})
end
