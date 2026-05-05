dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.script_path.."command_defs.lua")

local HUD_System = GetSelf()
local dev = GetSelf()
local sensor_data		= get_base_data()

local update_time_step = 0.01 --1/100
make_default_activity(update_time_step)

dev:listen_command(Keys.iCommandPlaneModeNAV)
dev:listen_command(Keys.iCommandPlaneModeBore)
dev:listen_command(Keys.iCommandPlaneModeGround)

--local Parameter = get_param_handle("HUDBrightnessDown") //Test für später
--Parameter:set(0)

local hud_brightness_counter = 0
local hud_coulor_counter = 0

function keys_1_nav_mode(value)

	dispatch_action(nil, 747)
	dispatch_action(nil, 747)
	dispatch_action(nil, 747)
	dispatch_action(nil, 747)
	dispatch_action(nil, 747)
	dispatch_action(nil, 747)
	dispatch_action(nil, 747)

end

function keys_1_bore_AtoA_mode(value)

	dispatch_action(nil, 747)
	dispatch_action(nil, 747)
	dispatch_action(nil, 747)
	dispatch_action(nil, 747)
	dispatch_action(nil, 747)
	dispatch_action(nil, 747)
	dispatch_action(nil, 747)
	
end

function keys_1_AtoG_mode(value)

	dispatch_action(nil, 747)
	dispatch_action(nil, 747)
	dispatch_action(nil, 747)
	dispatch_action(nil, 747)
	dispatch_action(nil, 747)
	dispatch_action(nil, 747)
	dispatch_action(nil, 747)

end



command_table = {
  
	-----------------------------------------------------
	[Keys.iCommandPlaneModeNAV]		= keys_1_nav_mode,
	[Keys.iCommandPlaneModeBore]	= keys_1_bore_AtoA_mode,
	[Keys.iCommandPlaneModeGround]	= keys_1_AtoG_mode,
	--[Keys.iCommandPlaneModeCannon]	= keys_cannon_mode,
	
}

------------------------------------------------------------------FUNCTION-POST-INIT---------------------------------------------------------------------------------------------------
function post_initialize()
	
	while (hud_brightness_counter <= 100) do
		
		dispatch_action(nil, 747)
		hud_brightness_counter = hud_brightness_counter + 1
		
	end
	
	while (hud_coulor_counter < 5) do
	
		dispatch_action(nil, Keys.iCommandBrightnessILS)
		hud_coulor_counter = hud_coulor_counter +1
		
	end

end
------------------------------------------------------------------FUNCTION-SETCOMMAND---------------------------------------------------------------------------------------------------
function SetCommand(command,value)


end
------------------------------------------------------------------FUNCTION-UPDATE---------------------------------------------------------------------------------------------------
function update()


end

need_to_be_closed = false