-- Nmobs skeleton.lua
-- Copyright Duane Robertson (duane@duanerobertson.com), 2017, 2019
-- Distributed under the LGPLv2.1 (https://www.gnu.org/licenses/old-licenses/lgpl-2.1.en.html)

-- The nodebox and textures are distributed as Public Domain (WTFPL).


local mod_name = 'nmobs'


do
	local skeleton_nodebox = {
		{ -0.0625, 0.34375, -0.0625, 0.0625, 0.48, 0.125 }, -- cranium
		{ -0.045, 0.28125, 0, 0.045, 0.34375, 0.125 }, -- mandible
		{ -0.09375, 0.035, -0.0625, 0.09375, 0.25, 0.125 }, -- ribcage
		{ -0.09375, -0.125, -0.0625, 0.09375, 0, 0.08 }, -- pelvis
		{ 0.05, -0.5, -0.02, 0.09, -0.125, 0.02 }, -- rightleg
		{ -0.02, 0, -0.0625, 0.02, 0.4, -0.02 }, -- spine
		{ -0.09, -0.5, -0.02, -0.05, -0.125, 0.02 }, -- leftleg
		{ 0.09375, 0.2, 0, 0.3, 0.25, 0.04 }, -- righthumerus
		{ 0.25, 0.2, 0, 0.3, 0.24, 0.24 }, -- rightulna
		{ -0.3, 0.2, 0, -0.09375, 0.25, 0.04 }, -- lefthumerus
		{ -0.3, 0.2, 0, -0.25, 0.24, 0.24 }, -- leftulna
		{ -0.09, -0.5, -0.02, -0.05, -0.48, 0.12 }, -- leftfoot
		{ 0.05, -0.5, -0.02, 0.09, -0.48, 0.12 }, -- rightfoot
		{ -0.31, 0.21, 0.24, -0.24, 0.23, 0.32 }, -- lefthand
		{ 0.31, 0.21, 0.24, 0.24, 0.23, 0.32 }, -- righthand
	}

	nmobs.register_mob({
		attacks_player = true,
		armor_class = 8,
		drops = { { name = 'nmobs:bonedust', max = 3, }, },
		environment = { 'group:soil', 'group:sand' },
		hit_dice = 3,
		name = 'skeleton',
		nodebox = skeleton_nodebox,
		nocturnal = true,
		size = 2,
	})
end

do
	local grow = { }
	local spread = { }
	local replace = {
		['farming:seed_wheat'] = 'farming:wheat_8',
		['farming:seed_cotton'] = 'farming:cotton_8',
		['dpies:onion'] = 'dpies:onion_3',
	}

	minetest.register_craftitem(mod_name..':bonedust', {
		description = 'Bone Dust',
		inventory_image = 'nmobs_bonedust.png',
		on_use = function(itemstack, user, pointed_thing)
			if not (itemstack and user and pointed_thing and pointed_thing.under) then
				return
			end

			local pos = pointed_thing.under

			if #grow < 1 then
				for k, v in pairs(minetest.registered_items) do
					if k:find('sapling') then
						grow[k] = true
					end
					if k:find('flowers') then
						spread[k] = true
					end
				end

				for n = 1, 8 do
					replace['farming:cotton_'..n] = 'farming:cotton_8'
					replace['farming:wheat_'..n] = 'farming:wheat_8'
				end
			end

			local n = minetest.get_node_or_nil(pos)
			if not n then
				return
			end

			local dn = minetest.registered_items[n.name]
			if not dn or not dn.groups then
				return
			end

			if grow[n.name] then
				local timer = minetest.get_node_timer(pos)
				if timer then
					local timeout = timer:get_timeout()
					timer:set(timeout, timeout - 1)
				end
			elseif replace[n.name] then
				local timer = minetest.get_node_timer(pos)
				if not timer or not timer:is_started() then
					return
				end
				timer:stop()
				minetest.set_node(pos, { name = replace[n.name] })
			elseif spread[n.name] then
				local p1 = vector.add(pos, -3)
				local p2 = vector.add(pos, 3)
				local ns = minetest.find_nodes_in_area_under_air(p1, p2, { 'group:soil' })
				if ns and #ns > 0 then
					for _ = 1, math.min(3, #ns) do
						local p = table.copy(ns[math.random(#ns)])
						p.y = p.y + 1
						minetest.set_node(p, n)
					end
				end
			else
				--print(n.name)
				return
			end

			itemstack:take_item()
			if itemstack:is_empty() then
				-- This avoids digging saplings.
				minetest.after(0.5, function(user)
					user:set_wielded_item(nil)
				end, user)
				return
			else
				return itemstack
			end
		end,

        after_use = function(itemstack, user, node, digparams)
			print('after_use')
			itemstack:take_item()
			return itemstack
		end,
	})
end
