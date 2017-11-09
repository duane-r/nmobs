-- Nmobs skeleton.lua
-- Copyright Duane Robertson (duane@duanerobertson.com), 2017
-- Distributed under the LGPLv2.1 (https://www.gnu.org/licenses/old-licenses/lgpl-2.1.en.html)

-- The nodebox and textures are distributed as Public Domain (WTFPL).


do
  local tex = { }
  for i = 1, 4 do
    tex[#tex+1] = { 'zombie0'..i..'.png' }
  end

  nmobs.register_mob({
    animation = {
      punch = {start = 102, stop = 142, speed = 20},
      run = {start = 41, stop = 101, speed = 20},
      stand = {start = 0, stop = 40, speed = 20},
      walk = {start = 41, stop = 101, speed = 20},
    },
    attacks_player = true,
    armor_class = 8,
    --can_dig = concrete,
    collisionbox = {-0.3, -0.7, -0.3, 0.3, 0.5, 0.3},
    --drops = {
    --  {name = 'bonemeal:bone',},
    --},
    environment = {'default:dirt', 'default:dirt_with_grass', 'default:dirt_with_dry_grass', 'default:dirt_with_snow', 'default:desert_sand'},
    hit_dice = 3,
    mesh = "zombie_normal.b3d",
    name = 'zombie',
    run_speed = 1,
    size = 1.5,
    spawn = {
      {
        nodes = {'default:dirt', 'default:cobble'},
        rarity = 5000,
      },
    },
    textures = tex,
  })
end
