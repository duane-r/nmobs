-- Nmobs init.lua
-- Copyright Duane Robertson (duane@duanerobertson.com), 2017
-- Distributed under the LGPLv2.1 (https://www.gnu.org/licenses/old-licenses/lgpl-2.1.en.html)

-- stun/fear statuses

nmobs = {}
local mod = nmobs
mod.version = "20171028"
mod.path = minetest.get_modpath(minetest.get_current_modname())
mod.world = minetest.get_worldpath()
mod.mobs = {}


local creative_mode = minetest.settings:get_bool('creative_mode')
local damage_mode = minetest.settings:get_bool('enable_damage')


mod.nice_mobs = minetest.settings:get_bool('nmobs_nice_mobs') or creative_mode or not damage_mode
if mod.nice_mobs == nil then
	mod.nice_mobs = true
end


if mod.nice_mobs then
  print('Nmobs: All mobs will play nicely.')
end


function math.limit(n, l, h)
  return math.max(math.min(n, h), l)
end


function vector.horizontal_length(vec)
  if not (vec.x and vec.z) then
    return 0
  end

  return math.sqrt(vec.x ^ 2 + vec.z ^ 2)
end


function vector.horizontal_distance(p1, p2)
  if not (p1.x and p2.x and p1.z and p2.z) then
    return 0
  end
  return math.sqrt((p2.x - p1.x) ^ 2 + (p2.z - p1.z) ^ 2)
end


-- This tables looks up nodes that aren't already stored.
mod.node = setmetatable({}, {
	__index = function(t, k)
		if not (t and k and type(t) == 'table') then
			return
		end

		t[k] = minetest.get_content_id(k)
		return t[k]
	end
})


mod.node_name = setmetatable({}, {
	__index = function(t, k)
		if not (t and k and type(t) == 'table') then
			return
		end

		t[k] = minetest.get_name_from_content_id(k)
		return t[k]
	end
})


function mod.clone_node(name)
	if not (name and type(name) == 'string') then
		return
	end
	if not minetest.registered_nodes[name] then
		return
	end

	local nod = minetest.registered_nodes[name]
	local node2 = table.copy(nod)
	return node2
end


dofile(mod.path .. "/api.lua")

minetest.register_on_item_eat(function(hp_change, replace_with_item, itemstack, user, pointed_thing)
	if mod:in_combat(user) then
		return itemstack
	end
end)


dofile(mod.path .. "/ape.lua")
dofile(mod.path .. "/bear.lua")
dofile(mod.path .. "/bee.lua")
dofile(mod.path .. "/boulder.lua")
--dofile(mod.path .. "/bunny.lua")
dofile(mod.path .. "/chicken.lua")
dofile(mod.path .. "/cow.lua")
dofile(mod.path .. "/demon.lua")
dofile(mod.path .. "/fox.lua")
dofile(mod.path .. "/goat.lua")
dofile(mod.path .. "/goblin.lua")
dofile(mod.path .. "/jackel_guardian.lua")
dofile(mod.path .. "/kangaroo.lua")
dofile(mod.path .. "/lion.lua")
dofile(mod.path .. "/lizard.lua")
dofile(mod.path .. "/nodes.lua")
dofile(mod.path .. "/otik.lua")
dofile(mod.path .. "/pig.lua")
dofile(mod.path .. "/rat.lua")
dofile(mod.path .. "/scorpion.lua")
dofile(mod.path .. "/shark.lua")
dofile(mod.path .. "/sheep.lua")
dofile(mod.path .. "/skeleton.lua")
dofile(mod.path .. "/slime.lua")
dofile(mod.path .. "/snake.lua")
dofile(mod.path .. "/spider.lua")
--dofile(mod.path .. "/zombie.lua")
