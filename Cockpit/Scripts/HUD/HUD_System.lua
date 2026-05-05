dofile(LockOn_Options.script_path.. "command_defs.lua")
dofile(LockOn_Options.script_path .. "devices.lua")
dofile(LockOn_Options.script_path .. "Systems/weapon_system.lua")



dev = GetSelf()
local update_time_step = 0.001 --update will be called 1000 times per second
make_default_activity(update_time_step)
local sensor_data = get_base_data()


--Hier kommen spätere funktionen für die Übertragung oder Generierung der Werte für den Gunpipper rein

dev:listen_command(Keys.GunPipper_Up)
dev:listen_command(Keys.GunPipper_Down)
dev:listen_command(Keys.GunPipper_Right)
dev:listen_command(Keys.GunPipper_Left)
dev:listen_command(Keys.GunPipper_Center)
dev:listen_command(Keys.GunPipper_Automatic) 
dev:listen_command(Keys.iCommandPlaneModeNAV)
dev:listen_command(Keys.iCommandPlaneModeBore)
dev:listen_command(Keys.iCommandPlaneModeGround)
--dev:listen_command(Keys.iCommandPlaneModeCannon)
dev:listen_command(Keys.SysHudBrightnessUP)
dev:listen_command(Keys.SysHudBrightnessDOWN)
dev:listen_command(Keys.iCommandPowerOnOff)

local gunpipper_horizontal_movement_param 	= get_param_handle("GUNPIPPER_SIDE")
local gunpipper_vertical_movement_param 	= get_param_handle("GUNPIPPER_UPDOWN")
local gunpipper_center_param 				= get_param_handle("GUNPIPPER_CENTER")
local gunpipper_sideways_automatic_param 	= get_param_handle("WS_GUN_PIPER_AZIMUTH")
local gunpipper_updown_automatic_param 		= get_param_handle("WS_GUN_PIPER_ELEVATION")
local target_range_param 					= get_param_handle("WS_TARGET_RANGE")
local NAV_mode_param						= get_param_handle("NAV_MODE")
local AtoG_mode_param						= get_param_handle("AG_MODE")
local AtoA_mode_param						= get_param_handle("AA_MODE")
local HUD_Sys_Brightness_param				= get_param_handle("SYS_HUD_BRIGHTNESS")
local GUNPIPPER_deflection_param 			= get_param_handle("GUNPIPPER_DEFLECTION")
local Gunpipper_Def_to_Range_param			= get_param_handle("GUNP_DEF_TO_RANGE")



gunpipper_center_param:set(0.0)
--target_range_param:set(800.0) --Target-Range auf 800m gesetzt

local gunpipper_mode = 0
local sys_hud_brightness = 0
local gunpipper_vertical = 0
local gp_def_to_range = 0
local electricity_on		= 0

function keys_gunpipper_vertical_up(value)

	if (gunpipper_mode ==  0)
	then
		gunpipper_vertical = gunpipper_vertical + 0.001
		--gunpipper_vertical_movement_param:set(gunpipper_vertical_movement_param:get() +0.01) --war 0.05
		gunpipper_vertical_movement_param:set(gunpipper_vertical)
		--print_message_to_user("Gunpipper depression is at " ..tostring(gunpipper_vertical_movement_param:get()))
		GUNPIPPER_deflection_param:set(gunpipper_vertical)
	end

end

function keys_gunpipper_vertical_down(value)

	if (gunpipper_mode ==  0)
	then
		gunpipper_vertical = gunpipper_vertical - 0.001
		--gunpipper_vertical_movement_param:set(gunpipper_vertical_movement_param:get() -0.01)
		gunpipper_vertical_movement_param:set(gunpipper_vertical)
		--print_message_to_user("Gunpipper depression is at " ..tostring(gunpipper_vertical_movement_param:get()))
		GUNPIPPER_deflection_param:set(gunpipper_vertical)
	end

end

--[[
function keys_gunpipper_horizontal_right(value)

	if (gunpipper_mode ==  0)
	then
		gunpipper_horizontal_movement_param:set(gunpipper_horizontal_movement_param:get() +0.01)
	end
	
end

function keys_gunpipper_horizontal_left(value)
-- 										das ist der vorherige Wert - den neuen Wert, also ein Schritt.
	if (gunpipper_mode ==  0)
	then
		gunpipper_horizontal_movement_param:set(gunpipper_horizontal_movement_param:get() -0.01)
	end

end
]]

function keys_gunpipper_center(value)
	if (gunpipper_mode ==  0) or (gunpipper_mode == 2)
	then
	gunpipper_vertical = 0.0
	gunpipper_horizontal_movement_param:set(0.0)
	gunpipper_vertical_movement_param:set(0.0)
	end

end

function keys_gunpipper_automatic(value)

	if (gunpipper_mode ==  0) --and  (gunpipper_horizontal_movement_param == 0.0) and (gunpipper_vertical_movement_param == 0.0)) 
	then 
		gunpipper_mode = 1
		--print_message_to_user("Gunpipper automatic")
		--print_message_to_user("Wert"..tostring(ir_missile_az_param))
	elseif (gunpipper_mode ==  1)
	then
		gunpipper_mode = 0
	--print_message_to_user("Gunpipper manual.")
	end

end

function keys_nav_mode(value)

	gunpipper_mode = 2
	keys_gunpipper_center()
	GUNPIPPER_deflection_param:set(gunpipper_vertical)
	NAV_mode_param:set(1)
	AtoA_mode_param:set(0)
	AtoG_mode_param:set(0)
	Gunpipper_Def_to_Range_param:set(gunpipper_mode) -- 2 -> aus; 1-> Range; 0 -> Deflection
	

end

function keys_bore_AtoA_mode(value)

	gunpipper_mode = 1
	NAV_mode_param:set(0)
	AtoA_mode_param:set(1)
	AtoG_mode_param:set(0)
	Gunpipper_Def_to_Range_param:set(gunpipper_mode) -- 2 -> aus; 1-> Range; 0 -> Deflection

end

function keys_AtoG_mode(value)

	gunpipper_mode = 0
	NAV_mode_param:set(0)
	AtoA_mode_param:set(0)
	AtoG_mode_param:set(1)
	Gunpipper_Def_to_Range_param:set(gunpipper_mode) -- 2 -> aus; 1-> Range; 0 -> Deflection
	
end

function keys_hud_brightness_up(value)

	if(sys_hud_brightness <= 0.9)then
		sys_hud_brightness = sys_hud_brightness + 0.1
	end
	HUD_Sys_Brightness_param:set(sys_hud_brightness)

end

function keys_hud_brightness_down(value)

	if(sys_hud_brightness >= 0.1)then
		sys_hud_brightness = sys_hud_brightness - 0.1
	end
	HUD_Sys_Brightness_param:set(sys_hud_brightness)
end


function keys_electricity_on_off(value)

	if(electricity_on == 0) then
		electricity_on = 1
	else
		electricity_on = 0
	end
	sys_hud_brightness = electricity_on
	HUD_Sys_Brightness_param:set(sys_hud_brightness)

end


command_table = {
    [Keys.GunPipper_Up] 		= keys_gunpipper_vertical_up,
    [Keys.GunPipper_Down] 		= keys_gunpipper_vertical_down,
    --[Keys.GunPipper_Right] 		= keys_gunpipper_horizontal_right,
    --[Keys.GunPipper_Left] 		= keys_gunpipper_horizontal_left,
    [Keys.GunPipper_Center] 	= keys_gunpipper_center,
    [Keys.GunPipper_Automatic]	= keys_gunpipper_automatic,
	
	[Keys.iCommandPlaneModeNAV]		= keys_nav_mode,
	[Keys.iCommandPlaneModeBore]	= keys_bore_AtoA_mode,
	[Keys.iCommandPlaneModeGround]	= keys_AtoG_mode,
	--[Keys.iCommandPlaneModeCannon]	= keys_cannon_mode,
	[Keys.SysHudBrightnessUP]		= keys_hud_brightness_up,
	[Keys.SysHudBrightnessDOWN]		= keys_hud_brightness_down,
	[Keys.iCommandPowerOnOff]		= keys_electricity_on_off,
}

-------------Hier geht es los mit den laufenden Funktionen. Alles dadrüber ist local-kram und functionen----------------
function post_initialize()

	local dev=GetSelf()
	keys_nav_mode()
	--gunpipper_horizontal_movement_param:set(0.0)
	--gunpipper_vertical_movement_param:set(0.0)
	
	
	
	local birth = LockOn_Options.init_conditions.birth_place
    if birth == "GROUND_COLD" then
		electricity_on = 0
		sys_hud_brightness = electricity_on
	else
		electricity_on = 1
		sys_hud_brightness = electricity_on
	end
		
	HUD_Sys_Brightness_param:set(sys_hud_brightness)
	
end


function SetCommand(command, value)

    if command_table[command] then
        command_table[command](value)
    end
	
end

function update()

	
	
	if (gunpipper_mode == 1) then
		gunpipper_horizontal_movement_param:set(gunpipper_sideways_automatic_param:get())
		gunpipper_vertical_movement_param:set(gunpipper_updown_automatic_param:get())
		end
	
	--if target_range_param:get() > 0.0 then
		--print_message_to_user("Target aquired")
		--print_message_to_user("Target Range  " tostring (target_range_param:get()))
	--else
		--target_range_param:set(800.0)
		--print_message_to_user("Range set to 800m")
end
	
	
	
	
	


need_to_be_closed = false


--possible sensor_data 
--called through e.g.: sensor_data.getEngineRPM()
--and cast to a variable like this: GET_ENGINE_RPM = sensor_data.getEngineRPM()
--[[
getAngleOfAttack()
getAngleOfSlide()
getBarometricAltitude()
getCanopyPos()
getCanopyState()
getEngineLeftFuelConsumption()
getEngineLeftRPM()
getEngineLeftTemperatureBeforeTurbine()
getEngineRightFuelConsumption()
getEngineRightRPM()
getEngineRightTemperatureBeforeTurbine()
getFlapsPos()
getFlapsRetracted()
getHeading()
getHorizontalAcceleration()
getIndicatedAirSpeed()
getLandingGearHandlePos()
getLateralAcceleration()
getLeftMainLandingGearDown()
getLeftMainLandingGearUp()
getMachNumber()
getMagneticHeading()
getNoseLandingGearDown()
getNoseLandingGearUp()
getPitch()
getRadarAltitude()
getRateOfPitch()
getRateOfRoll()
getRateOfYaw()
getRightMainLandingGearDown()
getRightMainLandingGearUp()
getRoll()
getRudderPosition()
getSpeedBrakePos()
getSelfAirspeed()
getSelfCoordinates()
getSelfVelocity()
getStickPitchPosition()
getStickRollPosition()
getThrottleLeftPosition()
getThrottleRightPosition()
getTotalFuelWeight()
getTrueAirSpeed()
getVerticalAcceleration()
getVerticalVelocity()
getWOW_LeftMainLandingGear()
getWOW_NoseLandingGear()
getWOW_RightMainLandingGear()
--]]