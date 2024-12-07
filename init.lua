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

-- post hook is for defining creatures
function M.post(api, config)
	local spawn_rate = config.spawn_rates or 0.2
	-- we shadow the creature_list function to call our additional code after it
	local old_creature_list = creature_list
	creature_list = function(...)
		-- call the original
		local r = { old_creature_list(...) }

		-- register our creatures
		register_creature(api.acquire_id("primordialis_unginged.snail_bomb"), "body plans/SNAILBOMB.bod", "snail_brain")
		register_creature(api.acquire_id("primordialis_unginged.snail2"), "body plans/SNAIL2.bod", "snail_brain")
		register_creature(api.acquire_id("primordialis_unginged.snail3"), "body plans/SNAIL3.bod", "snail_brain")
		register_creature(api.acquire_id("primordialis_unginged.snail4"), "body plans/SNAIL4.bod", "snail_brain")
		register_creature(api.acquire_id("primordialis_unginged.snail5"), "body plans/SNAIL5.bod", "snail_brain")
		register_creature(
			api.acquire_id("primordialis_unginged.caterpillar_hard"),
			"body plans/caterpillar_hard1.bod",
			"snail_brain"
		)
		register_creature(
			api.acquire_id("primordialis_unginged.caterpillar_basic"),
			"body plans/caterpillar_basic1.bod",
			"snail_brain"
		)
		register_creature(
			api.acquire_id("primordialis_unginged.caterpillar_spike1"),
			"body plans/caterpillar_spike1.bod",
			"snail_brain"
		)
		register_creature(
			api.acquire_id("primordialis_unginged.caterpillar_spike2"),
			"body plans/caterpillar_spike2.bod",
			"snail_brain"
		)
		register_creature(
			api.acquire_id("primordialis_unginged.caterpillar_poison"),
			"body plans/caterpillar_poison1.bod",
			"snail_brain"
		)
		register_creature(
			api.acquire_id("primordialis_unginged.caterpillar_venom"),
			"body plans/caterpillar_venom1.bod",
			"snail_brain"
		)
		register_creature(
			api.acquire_id("primordialis_unginged.caterpillar_light"),
			"body plans/caterpillar_light1.bod",
			"snail_brain"
		)
		register_creature(
			api.acquire_id("primordialis_unginged.antenna_bug2"),
			"body plans/antenna_bug2.bod",
			"default_brain"
		)
		register_creature(api.acquire_id("primordialis_unginged.grub2"), "body plans/grub2.bod", "default_brain")
		register_creature(
			api.acquire_id("primordialis_unginged.shield_crab2"),
			"body plans/shield_crab2.bod",
			"default_brain"
		)
		register_creature(
			api.acquire_id("primordialis_unginged.starfox_boss"),
			"body plans/starfoxboss1.bod",
			"primordialis_unginged.donothing_brain"
		)
		register_creature(api.acquire_id("primordialis_unginged.chariot2"), "body plans/chariot2.bod", "default_brain")
		register_creature(
			api.acquire_id("primordialis_unginged.autosnek"),
			"body plans/autosnek1.bod",
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
