-- Nmobs ape.lua
-- Copyright Duane Robertson (duane@duanerobertson.com), 2017, 2019
-- Distributed under the LGPLv2.1 (https://www.gnu.org/licenses/old-licenses/lgpl-2.1.en.html)

-- The nodebox and textures are distributed as Public Domain (WTFPL).


local node = nmobs.node
local node_name = nmobs.node_name


local last_clear
do
	local ape_nodebox = {
		{ 0.25, -0.3125, -0.125, 0.5, 0.1875, 0.1875 }, -- NodeBox1
		{ -0.5, -0.3125, -0.125, -0.25, 0.25, 0.1875 }, -- NodeBox2
		{ -0.5, -0.4375, -0.125, -0.375, -0.25, 0.1875 }, -- NodeBox3
		{ -0.5, -0.4375, -0.125, -0.25, -0.375, 0.1875 }, -- NodeBox4
		{ 0.25, -0.4375, -0.125, 0.5, -0.375, 0.1875 }, -- NodeBox5
		{ 0.375, -0.4375, -0.125, 0.5, -0.25, 0.1875 }, -- NodeBox6
		{ -0.1875, -0.3125, -0.1875, 0.1875, 0.25, 0.1875 }, -- NodeBox7
		{ -0.5, 0.125, -0.125, 0.5, 0.3125, 0.1875 }, -- NodeBox8
		{ -0.1875, -0.5, -0.125, -0.0625, -0.25, 0.0625 }, -- NodeBox9
		{ 0.0625, -0.5, -0.125, 0.1875, -0.25, 0.0625 }, -- NodeBox10
		{ 0.0625, -0.5, -0.125, 0.1875, -0.4375, 0.125 }, -- NodeBox11
		{ -0.1875, -0.5, -0.125, -0.0625, -0.4375, 0.125 }, -- NodeBox12
		{ -0.1875, -0.3125, -0.25, 0.1875, -0.125, -0.0625 }, -- NodeBox13
		{ -0.1875, -0.125, 0, 0.1875, 0.25, 0.25 }, -- NodeBox14
		{ -0.375, 0.125, -0.125, 0.375, 0.375, 0.1875 }, -- NodeBox15
		{ -0.125, 0.1875, 0, 0.125, 0.5, 0.3125 }, -- NodeBox16
		{ -0.0625, 0.1875, 0.3125, 0.0625, 0.343671, 0.375 }, -- NodeBox17
	}

	local clearable = setmetatable({}, {
		__index = function(t, k)
			if not (t and k and type(t) == 'table') then
				return
			end

			if not minetest.registered_items[node_name[k]] then
				t[k] = false
				return false
			end

			t[k] = (minetest.registered_items[node_name[k]].groups.snappy or minetest.registered_items[node_name[k]].groups.choppy) and true or false
			return t[k]
		end
	})

	local function kong_terrain_effects(self)
		local time = minetest.get_gametime()
		if not last_clear then
			last_clear = time
		end

		if time - last_clear > 3 then
			local pos = self.object:get_pos()
			if not pos then
				return
			end

			local clow = { x=self.collisionbox[1], y=self.collisionbox[2], z=self.collisionbox[3]}
			local chigh = { x=self.collisionbox[4], y=self.collisionbox[5], z=self.collisionbox[6]}
			clow = vector.multiply(clow, 2)
			chigh = vector.multiply(chigh, 2)
			local minp = vector.add(pos, clow)
			minp.y = minp.y - 10
			local maxp = vector.add(pos, chigh)
			maxp.y = maxp.y + 10
			local vm = minetest.get_voxel_manip(minp, maxp)
			if not vm then
				return
			end

			local emin, emax = vm:read_from_map(minp, maxp)
			local area = VoxelArea:new({ MinEdge = emin, MaxEdge = emax })
			local data = vm:get_data()

			for z = minp.z, maxp.z do
				local dz = z - minp.z
				for x = minp.x, maxp.x do
					local dx = x - minp.x
					local ivm = area:index(x, minp.y, z)
					for y = minp.y, maxp.y do
						if data[ivm] ~= node['air'] and data[ivm] ~= node['ignore'] and clearable[data[ivm]] then
							data[ivm] = node['air']
						end
						ivm = ivm + area.ystride
					end
				end
			end

			vm:set_data(data)
			vm:update_liquids()
			vm:write_to_map()
			vm:update_map()

			last_clear = minetest.get_gametime()
		end

		nmobs.terrain_effects(self)
	end

	nmobs.register_mob({
		attacks_player = 10,
		armor_class = 6,
		damage = 2,
		drops = {
			{ name = 'mobs:meat_raw', },
			{ name = 'mobs:fur', },
		},
		environment = { 'default:dirt_with_rainforest_litter' },
		hit_dice = 3,
		name = 'ape',
		nodebox = ape_nodebox,
	})

	nmobs.register_mob({
		attacks_player = 10,
		armor_class = 6,
		damage = 2,
		drops = {
			{ name = 'mobs:meat_raw', },
			{ name = 'mobs:fur', },
		},
		environment = {},
		hit_dice = 3,
		name = 'kong',
		nodebox = ape_nodebox,
		run_speed = 5,
		size = 20,
		_terrain_effects = kong_terrain_effects,
		textures = { 'nmobs_ape_top.png', 'nmobs_ape_bottom.png', 'nmobs_ape_right.png', 'nmobs_ape_left.png', 'nmobs_ape_front.png', 'nmobs_ape_back.png' },
		walk_speed = 5,
	})
end
