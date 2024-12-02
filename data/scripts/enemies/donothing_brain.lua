function donothing_brain(body)
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
