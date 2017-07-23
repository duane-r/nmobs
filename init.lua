-- Nmobs init.lua
-- Copyright Duane Robertson (duane@duanerobertson.com), 2017
-- Distributed under the LGPLv2.1 (https://www.gnu.org/licenses/old-licenses/lgpl-2.1.en.html)


nmobs_mod = {}
nmobs = nmobs_mod
nmobs_mod.version = "1.0"
nmobs_mod.path = minetest.get_modpath(minetest.get_current_modname())
nmobs_mod.world = minetest.get_worldpath()
nmobs_mod.mobs = {}


local creative_mode = minetest.setting_getbool('creative_mode')
local damage_mode = minetest.setting_getbool('enable_damage')


nmobs_mod.nice_mobs = minetest.setting_getbool('nmobs_nice_mobs') or creative_mode or not damage_mode
if nmobs_mod.nice_mobs == nil then
	nmobs_mod.nice_mobs = true
end


if nmobs_mod.nice_mobs then
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


dofile(nmobs_mod.path .. "/api.lua")
dofile(nmobs_mod.path .. "/cow.lua")
dofile(nmobs_mod.path .. "/goat.lua")
dofile(nmobs_mod.path .. "/pig.lua")
dofile(nmobs_mod.path .. "/sheep.lua")
dofile(nmobs_mod.path .. "/boulder.lua")
dofile(nmobs_mod.path .. "/goblin.lua")
dofile(nmobs_mod.path .. "/scorpion.lua")
dofile(nmobs_mod.path .. "/skeleton.lua")
dofile(nmobs_mod.path .. "/jackel_guardian.lua")
--dofile(nmobs_mod.path .. "/crystaloid1.lua")
