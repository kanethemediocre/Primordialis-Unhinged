---@type mod_calllbacks
local M = {}

---@type brain_function
_G["primordialis_unginged.donothing_brain"] = function(body)
	---@type brain
	local brain = {}
	local vel_x = body.values[1] or body.vel_x
	local vel_y = body.values[2] or body.vel_y
	local stuck_count = body.values[3] or 0
	local wiggle_count = body.values[4] or 0
	local stuck_and_wiggle_count = body.values[5] or 0
	local movement_dir = body.values[6]

	-- Update any custom brain values
	brain.values = {}

	brain.values[1] = vel_x
	brain.values[2] = vel_y
	brain.values[3] = stuck_count
	brain.values[4] = wiggle_count
	brain.values[5] = stuck_and_wiggle_count
	brain.values[6] = movement_dir

	return brain
end

function M.pre(api, config)
	local old_register_creature = register_creature

	local overriding = {
		["_3tentacles.bod"] = true,
		["a.bod"] = true,
		["antenna_bug2.bod"] = true,
		["antenna_bug.bod"] = true,
		["antenna_bug - Copy.bod"] = true,
		["assassin.bod"] = true,
		["autosnek1.bod"] = true,
		["bestagon3.bod"] = true,
		["_blastingdude1.bod"] = true,
		["_blastingdude2.bod"] = true,
		["_blastingdude3.bod"] = true,
		["body_plan.bod"] = true,
		["bombermom.bod"] = true,
		["boss_baby.bod"] = true,
		["boss_baby - Copy.bod"] = true,
		["boss_centipede.bod"] = true,
		["boss_donut.bod"] = true,
		["boss_missile.bod"] = true,
		["cannon.bod"] = true,
		["caterpillar_10missile1.bod"] = true,
		["caterpillar_24rocket1.bod"] = true,
		["caterpillar_basic1.bod"] = true,
		["caterpillar_hard1.bod"] = true,
		["caterpillar_light1.bod"] = true,
		["caterpillar_light2.bod"] = true,
		["caterpillar_lightweight1.bod"] = true,
		["caterpillar_poison1.bod"] = true,
		["caterpillar_slippery1.bod"] = true,
		["caterpillar_speedy1.bod"] = true,
		["caterpillar_spike1.bod"] = true,
		["caterpillar_spike2.bod"] = true,
		["caterpillar_venom1.bod"] = true,
		["centipede.bod"] = true,
		["CHAINSAW.bod"] = true,
		["chariot2.bod"] = true,
		["chariot.bod"] = true,
		["chariot - Copy.bod"] = true,
		["chimpy.bod"] = true,
		["chomper2.5.bod"] = true,
		["chomper2.bod"] = true,
		["chomper.bod"] = true,
		["chopmeray.bod"] = true,
		["claw2.bod"] = true,
		["clawpole.bod"] = true,
		["COMPRESSOR.bod"] = true,
		["conduction_test.bod"] = true,
		["coral.bod"] = true,
		["core_spinner.bod"] = true,
		["_darkchompywithlightandwhiptail.bod"] = true,
		["d.bod"] = true,
		["electrical_test.bod"] = true,
		["explody_snowflake.bod"] = true,
		["explody_tentacle_minion.bod"] = true,
		["explody_triangle.bod"] = true,
		["explosive_star.bod"] = true,
		["fidgeter.bod"] = true,
		["fire_chomper.bod"] = true,
		["fish2.bod"] = true,
		["fish2 - Copy.bod"] = true,
		["fish.bod"] = true,
		["FLEER.bod"] = true,
		["flower.bod"] = true,
		["FURNACE.bod"] = true,
		["glow_bug.bod"] = true,
		["glow_bug - Copy.bod"] = true,
		["grass.bod"] = true,
		["grass_boom.bod"] = true,
		["grub2.bod"] = true,
		["grub.bod"] = true,
		["hamis.bod"] = true,
		["hammery.bod"] = true,
		["hugger.bod"] = true,
		["huggy_ray.bod"] = true,
		["jetski.bod"] = true,
		["jet_squid.bod"] = true,
		["jet_squid - Copy.bod"] = true,
		["left_click.bod"] = true,
		["lightning_star.bod"] = true,
		["lightning_test.bod"] = true,
		["_lilguy.bod"] = true,
		["lil_guy.bod"] = true,
		["lilmissilesquid.bod"] = true,
		["medium_spiky.bod"] = true,
		["menu_snek.bod"] = true,
		["mina_cosplay.bod"] = true,
		["mine_layer.bod"] = true,
		["MINER.bod"] = true,
		["mini_jelly.bod"] = true,
		["mini_jelly - Copy.bod"] = true,
		["minion_worm.bod"] = true,
		["minion_worm - Copy.bod"] = true,
		["missile_claw.bod"] = true,
		["missiler2.bod"] = true,
		["missiler.bod"] = true,
		["missiler_thing.bod"] = true,
		["NEURON.bod"] = true,
		["_odd_chariot - Copy (2).bod"] = true,
		["_OLD_POLYCHAETE_TINY.bod"] = true,
		["_openminething.bod"] = true,
		["penis_boss_bity.bod"] = true,
		["penis_boss.bod"] = true,
		["poison_bush.bod"] = true,
		["poison_caterpillar1.bod"] = true,
		["POLYCHAETE_TINY2.bod"] = true,
		["POLYCHAETE_TINY.bod"] = true,
		["pure_chomp.bod"] = true,
		["push_rockets.bod"] = true,
		["_revisedhype2x.bod"] = true,
		["rocket_launcher.bod"] = true,
		["rocketship.bod"] = true,
		["rope_explosion.bod"] = true,
		["SAW_SHARK.bod"] = true,
		["SAW_SHARK - Copy.bod"] = true,
		["s.bod"] = true,
		["SCORPION.bod"] = true,
		["shield_crab2.bod"] = true,
		["shield_crab.bod"] = true,
		["shield_crab - Copy.bod"] = true,
		["shocker.bod"] = true,
		["shocking.bod"] = true,
		["shockjelly.bod"] = true,
		["shockjelly - Copy.bod"] = true,
		["shopkeeper.bod"] = true,
		["SNAIL2.bod"] = true,
		["SNAIL3.bod"] = true,
		["SNAIL4.bod"] = true,
		["SNAIL5.bod"] = true,
		["SNAIL6.bod"] = true,
		["SNAIL.bod"] = true,
		["SNAILBOMB.bod"] = true,
		["SNAIL - Copy.bod"] = true,
		["snek.bod"] = true,
		["solid_spinner.bod"] = true,
		["speed_worm.bod"] = true,
		["speedy.bod"] = true,
		["speedy - Copy.bod"] = true,
		["spike_strip.bod"] = true,
		["spike_strip - Copy.bod"] = true,
		["spikypole.bod"] = true,
		["spin2.bod"] = true,
		["spinner.bod"] = true,
		["spinyspiky.bod"] = true,
		["starfoxboss1.bod"] = true,
		["_starter0.bod"] = true,
		["_starter1.bod"] = true,
		["start_player.bod"] = true,
		["start_player - Copy.bod"] = true,
		["swordfish.bod"] = true,
		["tadpoly.bod"] = true,
		["target_dummy.bod"] = true,
		["target_dummy - Copy.bod"] = true,
		["tentacle_exploder.bod"] = true,
		["tentapole.bod"] = true,
		["test save.bod"] = true,
		["tethered cannon.bod"] = true,
		["_tonedownthehypex3.bod"] = true,
		["TONGUE.bod"] = true,
		["trailer_electric_thing.bod"] = true,
		["trailer_explody_poison_thing.bod"] = true,
		["trailer_poison_thing_2.bod"] = true,
		["trailer_poison_thing.bod"] = true,
		["trailer_spinny_thing.bod"] = true,
		["trailer_victim_thing.bod"] = true,
		["transmitter_test.bod"] = true,
		["tumorsnek.bod"] = true,
		["turtle.bod"] = true,
		["vampire_ray.bod"] = true,
		["_verysplodey.bod"] = true,
		["w.bod"] = true,
		["w - Copy.bod"] = true,
		["wut.bod"] = true,
	}
	-- i can't be bothered fixing the list, you can do it yourself
	register_creature = function(...)
		local args = { ... }
		local path = args[2]
		if overriding[path:sub(("body plans/"):len() + 1)] then
			path = "data/scripts/lua_mods/mods/Primordialis-Unhinged/" .. path
		end
		args[2] = path
		return old_register_creature(unpack(args))
	end
end

-- post hook is for defining creatures
function M.post(api, config)
	-- we shadow the creature_list function to call our additional code after it
	local old_creature_list = creature_list
	creature_list = function(...)
		-- call the original
		local r = { old_creature_list(...) }

		-- register our creatures
		register_creature(
			api.acquire_id("primordialis_unginged.snail_bomb"),
			"data/scripts/lua_mods/mod/Primordialis-Unhinged/body plans/SNAILBOMB.bod",
			"snail_brain"
		)
		register_creature(
			api.acquire_id("primordialis_unginged.snail2"),
			"data/scripts/lua_mods/mod/Primordialis-Unhinged/body plans/SNAIL2.bod",
			"snail_brain"
		)
		register_creature(
			api.acquire_id("primordialis_unginged.snail3"),
			"data/scripts/lua_mods/mod/Primordialis-Unhinged/body plans/SNAIL3.bod",
			"snail_brain"
		)
		register_creature(
			api.acquire_id("primordialis_unginged.snail4"),
			"data/scripts/lua_mods/mod/Primordialis-Unhinged/body plans/SNAIL4.bod",
			"snail_brain"
		)
		register_creature(
			api.acquire_id("primordialis_unginged.snail5"),
			"data/scripts/lua_mods/mod/Primordialis-Unhinged/body plans/SNAIL5.bod",
			"snail_brain"
		)
		register_creature(
			api.acquire_id("primordialis_unginged.caterpillar_hard"),
			"data/scripts/lua_mods/mod/Primordialis-Unhinged/body plans/caterpillar_hard1.bod",
			"snail_brain"
		)
		register_creature(
			api.acquire_id("primordialis_unginged.caterpillar_basic"),
			"data/scripts/lua_mods/mod/Primordialis-Unhinged/body plans/caterpillar_basic1.bod",
			"snail_brain"
		)
		register_creature(
			api.acquire_id("primordialis_unginged.caterpillar_spike1"),
			"data/scripts/lua_mods/mod/Primordialis-Unhinged/body plans/caterpillar_spike1.bod",
			"snail_brain"
		)
		register_creature(
			api.acquire_id("primordialis_unginged.caterpillar_spike2"),
			"data/scripts/lua_mods/mod/Primordialis-Unhinged/body plans/caterpillar_spike2.bod",
			"snail_brain"
		)
		register_creature(
			api.acquire_id("primordialis_unginged.caterpillar_poison"),
			"data/scripts/lua_mods/mod/Primordialis-Unhinged/body plans/caterpillar_poison1.bod",
			"snail_brain"
		)
		register_creature(
			api.acquire_id("primordialis_unginged.caterpillar_venom"),
			"data/scripts/lua_mods/mod/Primordialis-Unhinged/body plans/caterpillar_venom1.bod",
			"snail_brain"
		)
		register_creature(
			api.acquire_id("primordialis_unginged.caterpillar_light"),
			"data/scripts/lua_mods/mod/Primordialis-Unhinged/body plans/caterpillar_light1.bod",
			"snail_brain"
		)
		register_creature(
			api.acquire_id("primordialis_unginged.antenna_bug2"),
			"data/scripts/lua_mods/mod/Primordialis-Unhinged/body plans/antenna_bug2.bod",
			"default_brain"
		)
		register_creature(
			api.acquire_id("primordialis_unginged.grub2"),
			"data/scripts/lua_mods/mod/Primordialis-Unhinged/body plans/grub2.bod",
			"default_brain"
		)
		register_creature(
			api.acquire_id("primordialis_unginged.shield_crab2"),
			"data/scripts/lua_mods/mod/Primordialis-Unhinged/body plans/shield_crab2.bod",
			"default_brain"
		)
		register_creature(
			api.acquire_id("primordialis_unginged.starfox_boss"),
			"data/scripts/lua_mods/mod/Primordialis-Unhinged/body plans/starfoxboss1.bod",
			"primordialis_unginged.donothing_brain"
		)
		register_creature(
			api.acquire_id("primordialis_unginged.chariot2"),
			"data/scripts/lua_mods/mod/Primordialis-Unhinged/body plans/chariot2.bod",
			"default_brain"
		)
		register_creature(
			api.acquire_id("primordialis_unginged.autosnek"),
			"data/scripts/lua_mods/mod/Primordialis-Unhinged/body plans/autosnek1.bod",
			"primordialis_unginged.donothing_brain"
		)
		-- return the result of the original, not strictly neccesary here but useful in some situations
		return unpack(r)
	end

	-- shadow init_biomes function to call our stuff afterwards
	local old_init_biomes = init_biomes
	init_biomes = function(...)
		local r = { old_init_biomes(...) }
		-- add our creatures to the starting biome, if spawn_rates are too high you will start to see issues where only some creatures can spawn
		-- to fix this make sure the sum isn't too high, i will perhaps add a prehook for compat with this in future
		add_creature_spawn_chance("SAFE", api.acquire_id("primordialis_unginged.caterpillar_hard"), 0.02, 2)

		add_creature_spawn_chance("STRT", api.acquire_id("primordialis_unginged.chariot2"), 0.01, 6)
		add_creature_spawn_chance("STRT", api.acquire_id("primordialis_unginged.grub2"), 0.02, 1)
		add_creature_spawn_chance("STRT", api.acquire_id("primordialis_unginged.antenna_bug2"), 0.03, 4)
		add_creature_spawn_chance("STRT", api.acquire_id("primordialis_unginged.snail2"), 0.02, 5)
		add_creature_spawn_chance("STRT", api.acquire_id("primordialis_unginged.snail3"), 0.02, 7)
		add_creature_spawn_chance("STRT", api.acquire_id("primordialis_unginged.snail4"), 0.03, 4)

		add_creature_spawn_chance("STRT", api.acquire_id("primordialis_unginged.caterpillar_hard"), 0.01, 3)
		add_creature_spawn_chance("STRT", api.acquire_id("primordialis_unginged.caterpillar_basic"), 0.02, 1)
		add_creature_spawn_chance("STRT", api.acquire_id("primordialis_unginged.caterpillar_spike1"), 0.01, 2)
		add_creature_spawn_chance("STRT", api.acquire_id("primordialis_unginged.caterpillar_poison"), 0.01, 1)

		add_creature_spawn_chance("ICEE", api.acquire_id("primordialis_unginged.shield_crab2"), 0.01, 3)
		add_creature_spawn_chance("ICEE", api.acquire_id("primordialis_unginged.starfox_boss"), 0.004, 100)

		add_creature_spawn_chance("ICEE", "SNYL", 0.02, 3)
		add_creature_spawn_chance("ICEE", api.acquire_id("primordialis_unginged.snail_bomb"), 0.001, 3)
		add_creature_spawn_chance("ICEE", api.acquire_id("primordialis_unginged.snail2"), 0.02, 5)
		add_creature_spawn_chance("ICEE", api.acquire_id("primordialis_unginged.snail5"), 0.04, 8)
		add_creature_spawn_chance("ICEE", api.acquire_id("primordialis_unginged.caterpillar_hard"), 0.02, 3)
		add_creature_spawn_chance("ICEE", api.acquire_id("primordialis_unginged.caterpillar_spike2"), 0.04, 3)
		add_creature_spawn_chance("ICEE", api.acquire_id("primordialis_unginged.caterpillar_venom"), 0.01, 3)
		add_creature_spawn_chance("ICEE", api.acquire_id("primordialis_unginged.autosnek"), 0.01, 12)

		add_creature_spawn_chance("DARK", api.acquire_id("primordialis_unginged.caterpillar_light"), 0.08, 3)
		add_creature_spawn_chance("DARK", api.acquire_id("primordialis_unginged.caterpillar_hard"), 0.02, 3)
		return unpack(r)
	end
end

return M
