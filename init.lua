-- Nmobs init.lua
-- Copyright Duane Robertson (duane@duanerobertson.com), 2017
-- Distributed under the LGPLv2.1 (https://www.gnu.org/licenses/old-licenses/lgpl-2.1.en.html)


nmobs = {}
nmobs = nmobs
nmobs.version = "1.0"
nmobs.path = minetest.get_modpath(minetest.get_current_modname())
nmobs.world = minetest.get_worldpath()
nmobs.mobs = {}


local creative_mode = minetest.setting_getbool('creative_mode')
local damage_mode = minetest.setting_getbool('enable_damage')


nmobs.nice_mobs = minetest.setting_getbool('nmobs_nice_mobs') or creative_mode or not damage_mode
if nmobs.nice_mobs == nil then
	nmobs.nice_mobs = true
end


if nmobs.nice_mobs then
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


dofile(nmobs.path .. "/api.lua")
dofile(nmobs.path .. "/bee.lua")
dofile(nmobs.path .. "/bear.lua")
dofile(nmobs.path .. "/bunny.lua")
dofile(nmobs.path .. "/boulder.lua")
dofile(nmobs.path .. "/chicken.lua")
dofile(nmobs.path .. "/cow.lua")
--dofile(nmobs.path .. "/crystaloid1.lua")
dofile(nmobs.path .. "/elephant.lua")
dofile(nmobs.path .. "/fox.lua")
dofile(nmobs.path .. "/goat.lua")
dofile(nmobs.path .. "/goblin.lua")
dofile(nmobs.path .. "/jackel_guardian.lua")
dofile(nmobs.path .. "/nodes.lua")
dofile(nmobs.path .. "/otik.lua")
dofile(nmobs.path .. "/pig.lua")
dofile(nmobs.path .. "/rat.lua")
dofile(nmobs.path .. "/scorpion.lua")
dofile(nmobs.path .. "/sheep.lua")
dofile(nmobs.path .. "/skeleton.lua")
dofile(nmobs.path .. "/spider.lua")
dofile(nmobs.path .. "/zombie.lua")
