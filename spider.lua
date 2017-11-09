-- Nmobs .lua
-- Copyright Duane Robertson (duane@duanerobertson.com), 2017
-- Distributed under the LGPLv2.1 (https://www.gnu.org/licenses/old-licenses/lgpl-2.1.en.html)

-- Textures, sounds, and model
-- Copyright (c) 2014 Krupnov Pavel and 2016 TenPlus1
-- Distributed under the MIT license
-- Spider by AspireMint (fishyWET (CC-BY-SA 3.0 license for texture)


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
  local def1 = {
    animation = {
      stand = { start = 1, stop = 1 },
      punch = { start = 50, stop = 90 },
      run = { start = 20, stop = 40 },
      walk = { start = 20, stop = 40 }
    },
    armor_class = 7,
    attacks_player = true,
    collisionbox = { -0.1, 0, -0.1, 0.1, 0.1, 0.1 },
    damage = 5,
    drops = {
      { name = "farming:string", max = 2 },
    },
    environment = { 'default:desert_stone', 'default:desert_sand' },
    hit_dice = 4,
    mesh = 'mobs_spider.x',
    name = 'spider_giant',
    run_speed = 3,
    size = 7,
    sound = 'mobs_spider',
    sound_angry = 'mobs_spider',
    textures = { {"fun_caves_tarantula.png"}, },
    walk_speed = 1,
  }

  local def2 = table.copy(def1)
  def2.drops = {
		{name = "mobs:meat_raw", max = 3},
		{name = "wool:black", max = 3},
	}
  def2.environment = { 'default:stone', 'squaresville_c:stone_with_algae', 'squaresville_c:stone_with_moss', 'squaresville_c:stone_with_lichen' }
  def2.name = 'spider_deep'
  def2.textures = { { "mobs_spider.png" }, }

  local def3 = table.copy(def1)
  def3.drops = {
		{name = "mobs:meat_raw", max = 3},
		{name = "wool:white", max = 3},
	}
  def3.environment = { 'default:ice' }
  def3.name = 'spider_ice'
	def3.textures = { {"fun_caves_spider_ice.png"}, }

  local def4 = table.copy(def1)
  def4.attacks_player = nil
  def4.damage = 1
  def4.drops = { {name = "mobs:meat_raw"}, }
  def4.environment = { 'default:desert_stone', 'default:desert_sand' }
  def4.hit_dice = 0
  def4.name = 'tarantula'
  def4.size = 1

  local def5 = table.copy(def4)
  def5.environment = { 'default:dirt_with_rainforest_litter' }
  def5.name = 'tarantula_jungle'
  def5.textures = { { "mobs_spider.png" }, }

  nmobs.register_mob(def1)
  nmobs.register_mob(def2)
  nmobs.register_mob(def3)
  nmobs.register_mob(def4)
  nmobs.register_mob(def5)


  -- cobweb
  minetest.register_node(":mobs:cobweb", {
    description = "Cobweb",
    drawtype = "plantlike",
    visual_scale = 1.1,
    tiles = {"mobs_cobweb.png"},
    inventory_image = "mobs_cobweb.png",
    paramtype = "light",
    sunlight_propagates = true,
    liquid_viscosity = 11,
    liquidtype = "source",
    liquid_alternative_flowing = "mobs:cobweb",
    liquid_alternative_source = "mobs:cobweb",
    liquid_renewable = false,
    liquid_range = 0,
    walkable = false,
    groups = {snappy = 1},
    drop = "farming:cotton",
    sounds = default.node_sound_leaves_defaults(),
  })

  minetest.register_craft({
    output = "mobs:cobweb",
    recipe = {
      {"farming:string", "", "farming:string"},
      {"", "farming:string", ""},
      {"farming:string", "", "farming:string"},
    }
  })
end

