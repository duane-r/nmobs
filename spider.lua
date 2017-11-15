-- Nmobs .lua
-- Copyright Duane Robertson (duane@duanerobertson.com), 2017
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
  local def1 = {
    armor_class = 7,
    attacks_player = true,
    damage = 4,
    drops = {
      { name = "farming:string", max = 2 },
    },
    environment = { 'default:desert_stone', 'default:desert_sand' },
    hit_dice = 4,
    name = 'spider_giant',
    nodebox = {
      {-0.1875, -0.375, -0.4375, 0.1875, 0, -0.0625}, -- NodeBox1
      {-0.125, -0.375, 0, 0.125, -0.0625, 0.375}, -- NodeBox2
      {0.0625, -0.25, 0.375, 0.125, -0.1875, 0.5}, -- NodeBox3
      {-0.125, -0.25, 0.375, -0.0625, -0.1875, 0.5}, -- NodeBox4
      {0.0625, -0.3125, 0.4375, 0.125, -0.25, 0.5}, -- NodeBox5
      {-0.125, -0.3125, 0.4375, -0.0625, -0.25, 0.5}, -- NodeBox6
      {-0.125, -0.3125, -0.0625, 0.125, -0.125, 0}, -- NodeBox7
      {-0.0625, -0.3125, -0.0625, 0.0625, -0.0625, 0}, -- NodeBox7.5
      {0.125, -0.3125, 0.25, 0.1875, -0.25, 0.3125}, -- NodeBox8
      {0.125, -0.3125, 0.1875, 0.375, -0.25, 0.25}, -- NodeBox9
      {0.125, -0.3125, 0.0625, 0.4375, -0.25, 0.125}, -- NodeBox10
      {0.125, -0.3125, 0, 0.1875, -0.25, 0.0625}, -- NodeBox11
      {0.1875, -0.3125, -0.0625, 0.25, -0.25, 0}, -- NodeBox12
      {0.25, -0.3125, -0.125, 0.3125, -0.25, -0.0625}, -- NodeBox13
      {0.3125, -0.5, -0.1875, 0.375, -0.25, -0.125}, -- NodeBox14
      {0.375, -0.5, 0.0625, 0.4375, -0.25, 0.125}, -- NodeBox15
      {0.375, -0.5, 0.1875, 0.4375, -0.25, 0.25}, -- NodeBox16
      {0.1875, -0.3125, 0.3125, 0.25, -0.25, 0.375}, -- NodeBox17
      {0.25, -0.3125, 0.375, 0.3125, -0.25, 0.4375}, -- NodeBox18
      {0.3125, -0.5, 0.4375, 0.375, -0.25, 0.5}, -- NodeBox19
      {-0.375, -0.5, 0.4375, -0.3125, -0.25, 0.5}, -- NodeBox20
      {-0.3125, -0.3125, 0.375, -0.25, -0.25, 0.4375}, -- NodeBox21
      {-0.25, -0.3125, 0.3125, -0.1875, -0.25, 0.375}, -- NodeBox22
      {-0.25, -0.3125, -0.0625, -0.1875, -0.25, 0}, -- NodeBox23
      {-0.3125, -0.3125, -0.125, -0.25, -0.25, -0.0625}, -- NodeBox24
      {-0.375, -0.5, -0.1875, -0.3125, -0.25, -0.125}, -- NodeBox25
      {-0.375, -0.3125, 0.1875, -0.125, -0.25, 0.25}, -- NodeBox26
      {-0.4375, -0.3125, 0.0625, -0.125, -0.25, 0.125}, -- NodeBox27
      {-0.4375, -0.5, 0.1875, -0.375, -0.25, 0.25}, -- NodeBox28
      {-0.4375, -0.5, 0.0625, -0.375, -0.25, 0.125}, -- NodeBox29
      {-0.1875, -0.3125, 0, -0.125, -0.25, 0.0625}, -- NodeBox30
      {-0.1875, -0.3125, 0.25, -0.125, -0.25, 0.3125}, -- NodeBox31
    },
    run_speed = 3,
    size = 2,
    sound = 'mobs_spider',
    sound_angry = 'mobs_spider',
    textures = { 'nmobs_spider_tarantula_top.png', 'nmobs_spider_tarantula_bottom.png', 'nmobs_spider_tarantula_right.png', 'nmobs_spider_tarantula_left.png', 'nmobs_spider_tarantula_front.png', 'nmobs_spider_tarantula_back.png' },
    walk_speed = 1,
  }

  local def2 = table.copy(def1)
  def2.drops = {
		{name = "mobs:meat_raw", max = 3},
		{name = "wool:black", max = 3},
	}
  def2.environment = { 'default:stone', 'squaresville_c:stone_with_algae', 'squaresville_c:stone_with_moss', 'squaresville_c:stone_with_lichen' }
  def2.glow = 2
  def2.name = 'spider_deep'
  def2.textures = { 'nmobs_spider_deep_top.png', 'nmobs_spider_deep_bottom.png', 'nmobs_spider_deep_right.png', 'nmobs_spider_deep_left.png', 'nmobs_spider_deep_front.png', 'nmobs_spider_deep_back.png' }

  local def3 = table.copy(def1)
  def3.drops = {
		{name = "mobs:meat_raw", max = 3},
		{name = "wool:white", max = 3},
	}
  def3.environment = { 'default:ice' }
  def3.name = 'spider_ice'
  def3.textures = { 'nmobs_spider_ice_top.png', 'nmobs_spider_ice_bottom.png', 'nmobs_spider_ice_right.png', 'nmobs_spider_ice_left.png', 'nmobs_spider_ice_front.png', 'nmobs_spider_ice_back.png' }

  local def4 = table.copy(def1)
  def4.attacks_player = nil
  def4.damage = 1
  def4.drops = { {name = "mobs:meat_raw"}, }
  def4.environment = { 'default:desert_stone', 'default:desert_sand' }
  def4.hit_dice = 0
  def4.name = 'tarantula'
  def4.size = 0.5
  def4.step_height = 10
  def4.textures = { 'nmobs_spider_tarantula_top.png', 'nmobs_spider_tarantula_bottom.png', 'nmobs_spider_tarantula_right.png', 'nmobs_spider_tarantula_left.png', 'nmobs_spider_tarantula_front.png', 'nmobs_spider_tarantula_back.png' }

  local def5 = table.copy(def4)
  def5.environment = { 'default:dirt_with_rainforest_litter' }
  def5.name = 'tarantula_jungle'
  def5.textures = { 'nmobs_spider_deep_top.png', 'nmobs_spider_deep_bottom.png', 'nmobs_spider_deep_right.png', 'nmobs_spider_deep_left.png', 'nmobs_spider_deep_front.png', 'nmobs_spider_deep_back.png' }

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

