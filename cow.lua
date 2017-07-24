-- Nmobs cow.lua
-- Copyright Duane Robertson (duane@duanerobertson.com), 2017
-- Distributed under the LGPLv2.1 (https://www.gnu.org/licenses/old-licenses/lgpl-2.1.en.html)

-- The nodebox and textures are copied from Cute Cubic Mobs
-- https://github.com/Napiophelios/ccmobs
-- and are distributed as Public Domain (WTFPL).


nmobs.register_mob({
  diurnal = true,
  drops = {
    {name = 'mobs:meat_raw',},
    {name = 'mobs:leather',},
  },
  hit_dice = 3,
  looks_for = {'default:dirt_with_grass'},
  media_prefix = 'ccmobs',
  name = 'cow',
  nodebox = {
    {-0.3125, -0.25, -0.4375, 0.3125, 0.3125, 0.1875},
    {-0.1875, -0.0625, 0.1875, 0.1875, 0.1875, 0.25},
    {-0.1875, -0.125, 0.25, 0.1875, 0.125, 0.5625},
    {-0.3125, 0.125, 0.25, 0.3125, 0.1875, 0.375},
    {-0.1875, -0.1875, 0.25, 0.1875, 0.1875, 0.4375},
    {-0.125, -0.25, 0.1875, 0.125, 0.1875, 0.3125},
    {-0.25, -0.5, -0.0625, -0.0625, -0.1875, 0.125},
    {0.0625, -0.5, -0.0625, 0.25, -0.0625, 0.125},
    {-0.25, -0.5, -0.375, -0.0625, -0.1875, -0.1875},
    {0.0625, -0.5, -0.375, 0.25, -0.25, -0.1875},
    {-0.0276272, -0.1875, -0.478997, 0.0376734, 0.1875, -0.4375},
    {-0.125, 0.1875, 0.1875, 0.125, 0.25, 0.375}
  },
  size = 1.5,
  sound = 'ccmobs_cow',
  tames = {'farming:wheat'},
})
