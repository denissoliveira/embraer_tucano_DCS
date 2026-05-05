--dofile(LockOn_Options.script_path.."Systems/electric_system_api.lua")
dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."definitions.lua")

local dev = GetSelf()

local update_time_step = 0.05
make_default_activity(update_time_step)

local sensor_data = get_base_data()


--dev:
--devices for direct weapon-usage
dev:listen_command(Keys.pickle_on)
dev:listen_command(Keys.pickle_off)
dev:listen_command(Keys.trigger_on)
dev:listen_command(Keys.trigger_off)
------------------------------------
dev:listen_command(Keys.SetTargetRange_up)
dev:listen_command(Keys.SetTargetRange_down)
------------------------------------
dev:listen_command(Keys.station_one)
dev:listen_command(Keys.station_two)
dev:listen_command(Keys.station_three)
dev:listen_command(Keys.station_four)
dev:listen_command(Keys.station_five)
dev:listen_command(Keys.station_six)
dev:listen_command(Keys.change_station)
dev:listen_command(Keys.inboard_stations)
dev:listen_command(Keys.tip_stations)
dev:listen_command(Keys.outboard_stations)
----------------------------------------
dev:listen_command(Keys.iCommandPlaneModeNAV)
dev:listen_command(Keys.iCommandPlaneModeBore)
dev:listen_command(Keys.iCommandPlaneModeGround)
dev:listen_command(Keys.iCommandPlaneModeCannon)
-------------------------------------------------


--WeaponSystem-Params
local ir_missile_lock_param 					= get_param_handle("WS_IR_MISSILE_LOCK")
local ir_missile_az_param 						= get_param_handle("WS_IR_MISSILE_TARGET_AZIMUTH")
local ir_missile_el_param 						= get_param_handle("WS_IR_MISSILE_TARGET_ELEVATION")
local ir_missile_des_az_param 					= get_param_handle("WS_IR_MISSILE_SEEKER_DESIRED_AZIMUTH")
local ir_missile_des_el_param 					= get_param_handle("WS_IR_MISSILE_SEEKER_DESIRED_ELEVATION")
local stt_azimuth_h 							= get_param_handle("RADAR_STT_AZIMUTH")
local stt_elevation_h 							= get_param_handle("RADAR_STT_ELEVATION")
--local gunpipper_sideways_automatic_param = get_param_handle("WS_GUN_PIPER_AZIMUTH")
--local gunpipper_updown_automatic_param = get_param_handle("WS_GUN_PIPER_ELEVATION")
--local target_range_param = get_param_handle("WS_TARGET_RANGE")
---------------Station Switches---------------------------------------------------------------
local station_one_selector_param				= get_param_handle("STATION_ONE")
local station_two_selector_param				= get_param_handle("STATION_TWO")
local station_three_selector_param				= get_param_handle("STATION_THREE")
local station_four_selector_param				= get_param_handle("STATION_FOUR")
local station_five_selector_param				= get_param_handle("STATION_FIVE")
local station_six_selector_param				= get_param_handle("STATION_SIX")
----------------------------------------------------------------------------------------------
local Gunpipper_Manual_Range_param				= get_param_handle("MAN_GP_TARGET_RANGE")
local Missile_Lock_param						= get_param_handle("MISSILE_LOCK")





local current_station = 0
-----------active stations---
local station_0 = 0
local station_1 = 0
local station_2 = 0
local station_3 = 0
local station_4 = 0
local station_5 = 0
local station_6 = 0
-------check if weapons and switches align---
local usableWeapon = 0
local masterMode = 0
-------check if weapons switches and pylons align----
local Pylon1InUse = 0
local Pylon2InUse = 0
local Pylon3InUse = 0
local Pylon4InUse = 0
local Pylon5InUse = 0
local Pylon6InUse = 0
---------CLSIDs and Categories for loaded weapons----
local Pylon_ONE_Weapon 		= 0
local Pylon_TWO_Weapon 		= 0
local Pylon_THREE_Weapon 	= 0
local Pylon_FOUR_Weapon 	= 0
local Pylon_FIVE_Weapon		= 0
local Pylon_SIX_Weapon		= 0

local LeftTipWeapon			= 0	
local weaponAtStation1L2	= 0
local weaponAtStation1L3	= 0
local LeftTipFull			= 0

local LeftOutboardWeapon 	= 0
local weaponAtStation2L2	= 0
local weaponAtStation2L3	= 0
local LeftOutboardFull		= 0

local LeftInboardWeapon		= 0
local weaponAtStation3L2	= 0
local weaponAtStation3L3	= 0
local LeftInboardFull		= 0

local RightInboardWeapon	= 0
local weaponAtStation4L2	= 0
local weaponAtStation4L3	= 0
local RightInboardFull		= 0

local RightOutboardWeapon	= 0	
local weaponAtStation5L2	= 0
local weaponAtStation5L3	= 0
local RightOutboardFull		= 0

local RightTipWeapon		= 0
local weaponAtStation6L2	= 0
local weaponAtStation6L3	= 0
local RightTipFull			= 0

---------Setting Ranges-------------------------------
local rangeIsSetAt			= 600
-----------------------------------------------------
local rocket_counter 		= 0
local Aim9_fired			= 0
local Shrike_fired 			= 0
-----------------------------------------------------





function keys_trigger_on(value)
    
        dispatch_action(nil, Keys.iCommandPlaneFire)
    
end



function keys_trigger_off(value)

    dispatch_action(nil, Keys.iCommandPlaneFireOff)
	
end

function keys_pickle_on(value)

	PylonInfo()
	UsablePylons()
	
	if(station_1 == 1)then
		if((Pylon1InUse == 1) and (weaponAtStation1L2 == 5))then
			dev:launch_station(PYLON.TIP_L)
			--print_message_to_user("Launching Station 1.")
		elseif((Pylon1InUse == 1) and (weaponAtStation1L3 == 33))then
			rocket_launch(PYLON.TIP_L)
			--print_message_to_user("Launching Station 1.")
		elseif((Pylon1InUse == 1) and ((weaponAtStation1L2 == 4) 
			and (weaponAtStation1L3 ~= 7))) then
			single_launch_AtoG_missile(PYLON.TIP_L)
		elseif((Pylon1InUse == 1) and (weaponAtStation1L3 == 7))then
			Aim9_launch(PYLON.TIP_L)
			--print_message_to_user("Launching Station 1.")
		end
	end

	if(station_2 == 1)then
		if((Pylon2InUse == 1) and (weaponAtStation2L2 == 5))then
			dev:launch_station(PYLON.OUT_L)
			--print_message_to_user("Launching Station 2.")
		elseif((Pylon2InUse == 1) and (weaponAtStation2L3 == 33))then
			rocket_launch(PYLON.OUT_L)
			--print_message_to_user("Launching Station 2.")
		elseif((Pylon2InUse == 1) and ((weaponAtStation2L2 == 4) 
			and (weaponAtStation2L3 ~= 7))) then
			single_launch_AtoG_missile(PYLON.OUT_L)
		elseif((Pylon2InUse == 1) and (weaponAtStation2L3 == 7))then
			Aim9_launch(PYLON.OUT_L)
			--print_message_to_user("Launching Station 2.")
		end
	end
	
	
	if(station_3 == 1)then
		if((Pylon3InUse == 1) and (weaponAtStation3L2 == 5))then
			dev:launch_station(PYLON.IN_L)
			--print_message_to_user("Launching Station 3.")
		elseif((Pylon3InUse == 1) and (weaponAtStation3L3 == 33))then
			rocket_launch(PYLON.IN_L)
			--print_message_to_user("Launching Station 3.")
		elseif((Pylon3InUse == 1) and ((weaponAtStation3L2 == 4) 
			and (weaponAtStation3L3 ~= 7))) then
			single_launch_AtoG_missile(PYLON.IN_L)
		elseif((Pylon3InUse == 1) and (weaponAtStation3L3 == 7))then
			Aim9_launch(PYLON.IN_L)
			--print_message_to_user("Launching Station 3.")
		end
	end

	if(station_4 == 1)then
		if((Pylon4InUse == 1) and (weaponAtStation4L2 == 5))then
			dev:launch_station(PYLON.IN_R)
			--print_message_to_user("Launching Station 4.")
		elseif((Pylon4InUse == 1) and (weaponAtStation4L3 == 33))then
			rocket_launch(PYLON.IN_R)
			--print_message_to_user("Launching Station 4.")
		elseif((Pylon4InUse == 1) and ((weaponAtStation4L2 == 4) 
			and (weaponAtStation4L3 ~= 7))) then
			single_launch_AtoG_missile(PYLON.IN_R)
		elseif((Pylon4InUse == 1) and (weaponAtStation4L3 == 7))then
			Aim9_launch(PYLON.IN_R)
			--print_message_to_user("Launching Station 4.")
		end
	end

	if(station_5 == 1)then
		if((Pylon5InUse == 1) and (weaponAtStation5L2 == 5))then
			dev:launch_station(PYLON.OUT_R)
			--print_message_to_user("Launching Station 5.")
		elseif((Pylon5InUse == 1) and (weaponAtStation5L3 == 33))then
			rocket_launch(PYLON.OUT_R)
			--print_message_to_user("Launching Station 5.")
		elseif((Pylon5InUse == 1) and ((weaponAtStation5L2 == 4) 
			and (weaponAtStation5L3 ~= 7))) then
			single_launch_AtoG_missile(PYLON.OUT_R)
		elseif((Pylon5InUse == 1) and (weaponAtStation5L3 == 7))then
			Aim9_launch(PYLON.OUT_R)
			--print_message_to_user("Launching Station 5.")
		end
	end
	
	if(station_6 == 1)then
		if((Pylon6InUse == 1) and (weaponAtStation6L2 == 5))then
			dev:launch_station(PYLON.TIP_R)
			--print_message_to_user("Launching Station 6.")
		elseif((Pylon6InUse == 1) and (weaponAtStation6L3 == 33))then
			rocket_launch(PYLON.TIP_R)
			--print_message_to_user("Launching Station 6.")
		elseif((Pylon6InUse == 1) and ((weaponAtStation6L2 == 4) 
			and (weaponAtStation6L3 ~= 7))) then
			single_launch_AtoG_missile(PYLON.TIP_R)
		elseif((Pylon6InUse == 1) and (weaponAtStation6L3 == 7))then
			Aim9_launch(PYLON.TIP_R)
			--print_message_to_user("Launching Station 6.")
		end
	end
	
	--[[
	
	if(station_1 == 1) then
	dev:select_station(PYLON.TIP_L)
	dev:launch_station(PYLON.TIP_L)
	print_message_to_user("Launching Station 1.")
	end
	
	if(station_2 == 1) then
	dev:select_station(PYLON.OUT_L)
	dev:launch_station(PYLON.OUT_L)
	print_message_to_user("Launching Station 2.")
	end
	
	if(station_3 == 1) then
	dev:select_station(PYLON.IN_L)
	dev:launch_station(PYLON.IN_L)
	print_message_to_user("Launching Station 3.")
	end
	
	if(station_4 == 1) then
	dev:select_station(PYLON.IN_R)
	dev:launch_station(PYLON.IN_R)
	print_message_to_user("Launching Station 4.")
	end
	
	if(station_5 == 1) then
	dev:select_station(PYLON.OUT_R)
	dev:launch_station(PYLON.OUT_R)
	print_message_to_user("Launching Station 5.")
	end
	
	if(station_6 == 1) then
	dev:select_station(PYLON.TIP_R)
	dev:launch_station(PYLON.TIP_R)
	print_message_to_user("Launching Station 6.")
	end
	]]
end

function rocket_launch(st)
	
	local launched_station = st
	
	if(rocket_counter == 0) then
		dev:launch_station(launched_station)
		rocket_counter = 1
	elseif((rocket_counter > 0) and (rocket_counter < 10))then
		rocket_counter = rocket_counter + 1
	else
		rocket_counter = 0
	end

end

function Aim9_launch(st)

	local fired_station = st
	
	if(Aim9_fired == 0)then
		dev:launch_station(fired_station)
		Aim9_fired = 1
	elseif(Aim9_fired == 1)then
		-- chill
	end
	
end

function single_launch_AtoG_missile(st)

	local released_station = st
	
	if(Shrike_fired == 0)then
		dev:launch_station(released_station)
		Shrike_fired = 1
	elseif(Shrike_fired == 1)then
		-- chill
	end

end


function keys_pickle_off(value)
	
	PylonInfo()
	Aim9_fired = 0
	Shrike_fired = 0
	rocket_counter = 0
	
end





function keys_set_target_range_up(value)

	if(rangeIsSetAt <= 900) then
		rangeIsSetAt = rangeIsSetAt + 100
		dev:set_target_range(rangeIsSetAt)
		--print_message_to_user("Range is set at " ..tostring(rangeIsSetAt))
	else
		rangeIsSetAt = 1000
		dev:set_target_range(rangeIsSetAt)
		--print_message_to_user("Range is set at max range " ..tostring(rangeIsSetAt))
	end
	
	Gunpipper_Manual_Range_param:set(rangeIsSetAt)

end

function keys_set_target_range_down(value)

	if(rangeIsSetAt >= 400) then
		rangeIsSetAt = rangeIsSetAt - 100
		dev:set_target_range(rangeIsSetAt)
		--print_message_to_user("Range is set at " ..tostring(rangeIsSetAt))
	else
		rangeIsSetAt = 300
		dev:set_target_range(rangeIsSetAt)
		--print_message_to_user("Range is set at min range " ..tostring(rangeIsSetAt))
	end

	Gunpipper_Manual_Range_param:set(rangeIsSetAt)
	
end

--[[
function keys_change_station(value)

	if(station_1 == 1)then
		station_1 = 0
		station_2 = 1
	elseif(station_2 == 1)then
		station_2 = 0
		station_3 = 1
	elseif(station_3 == 1)then
		station_3 = 0
		station_4 = 1
	elseif(station_4 == 1)then
		station_4 = 0
		station_5 = 1
	elseif(station_5 == 1)then
		station_5 = 0
		station_6 = 1
	elseif(station_6 == 1)then
		station_6 = 0
		station_0 = 1
	end

end
]]

function keys_nav_mode(value)

	masterMode = 0
	usableWeapon = 0
	
	station_1 = 0
	station_2 = 0
	station_3 = 0
	station_4 = 0
	station_5 = 0
	station_6 = 0
	
	PylonInfo()
	UsablePylons()

end

function keys_bore_AtoA_mode(value)

	masterMode = 2
	usableWeapon = 2
	PylonInfo()
	UsablePylons()

end

function keys_AtoG_mode(value)

	masterMode = 1
	usableWeapon = 1
	PylonInfo()
	UsablePylons()

end

function keys_station_one(value)
	
	if((station_1 == 0) and (masterMode ~= 0)) then
		station_1 = 1
		--print_message_to_user("Station 1 ON.")
	else
		station_1 = 0
		--print_message_to_user("Station 1 OFF.")
	end
	
	PylonInfo()
	UsablePylons()

end

function keys_station_two(value)
	
	if((station_2 == 0) and (masterMode ~= 0)) then
		station_2 = 1
		--print_message_to_user("Station 2 ON.")
	else
		station_2 = 0
		--print_message_to_user("Station 2 OFF.")
	end
	
	PylonInfo()
	UsablePylons()

end

function keys_station_three(value)
	
	if((station_3 == 0) and (masterMode ~= 0)) then
		station_3 = 1
		--print_message_to_user("Station 3 ON.")
	else
		station_3 = 0
		--print_message_to_user("Station 3 OFF.")
	end
	
	PylonInfo()
	UsablePylons()

end

function keys_station_four(value)
	
	if((station_4 == 0) and (masterMode ~= 0)) then
		station_4 = 1
		--print_message_to_user("Station 4 ON.")
	else
		station_4 = 0
		--print_message_to_user("Station 4 OFF.")
	end
	
	PylonInfo()
	UsablePylons()
end

function keys_station_five(value)
	
	if((station_5 == 0) and (masterMode ~= 0)) then
		station_5 = 1
		--print_message_to_user("Station 5 ON.")
	else
		station_5 = 0
		--print_message_to_user("Station 5 OFF.")
	end

	PylonInfo()
	UsablePylons()
end

function keys_station_six(value)
	
	if((station_6 == 0) and (masterMode ~= 0)) then
		station_6 = 1
		--print_message_to_user("Station 6 ON.")
	else
		station_6 = 0
		--print_message_to_user("Station 6 OFF.")
	end
	
	PylonInfo()
	UsablePylons()
end

function keys_tip_stations(value)

	if((tip_stations == 0) and (masterMode ~= 0)) then
		tip_stations = 1
		station_1 = 1
		station_6 = 1
		--print_message_to_user("Tip-Stations ON.")
	else
		tip_stations = 0
		station_1 = 0
		station_6 = 0
		--print_message_to_user("Tip-Stations OFF.")
	end
		
	PylonInfo()
	UsablePylons()
end

function keys_outboard_stations(value)

	if((outboard_stations == 0) and (masterMode ~= 0))then
		outboard_stations = 1
		
		station_2 = 1
		station_5 = 1
		--print_message_to_user("Outboard-Stations ON.")
	else
		outboard_stations = 0
		station_2 = 0
		station_5 = 0
		--print_message_to_user("Outboard-Stations OFF.")
	end
	
	PylonInfo()
	UsablePylons()
end

function keys_inboard_stations(value)

	if((inboard_stations == 0) and (masterMode ~= 0)) then
		inboard_stations = 1
		
		station_3 = 1
		station_4 = 1
		--print_message_to_user("Inboard-Stations ON.")
		
	else
		inboard_stations = 0
		
		station_3 = 0
		station_4 = 0
		--print_message_to_user("Inboard-Stations OFF.")
	end
	
	PylonInfo()
	UsablePylons()
end





command_table = {
    [Keys.pickle_on] 				= keys_pickle_on,
	[Keys.pickle_off] 				= keys_pickle_off,
    [Keys.trigger_on] 				= keys_trigger_on,
    [Keys.trigger_off] 				= keys_trigger_off,
	----------------------------------------------------
	--[Keys.GunPipper_Automatic]		= keys_gunpipper_automatic,
	[Keys.SetTargetRange_up]		= keys_set_target_range_up,
	[Keys.SetTargetRange_down]		= keys_set_target_range_down,
	-----------------------------------------------------
	[Keys.iCommandPlaneModeNAV]		= keys_nav_mode,
	[Keys.iCommandPlaneModeBore]	= keys_bore_AtoA_mode,
	[Keys.iCommandPlaneModeGround]	= keys_AtoG_mode,
	--[Keys.iCommandPlaneModeCannon]	= keys_cannon_mode,
	----------------------------------------------------
	[Keys.station_one]				= keys_station_one,
	[Keys.station_two]				= keys_station_two,
	[Keys.station_three]			= keys_station_three,
	[Keys.station_four]				= keys_station_four,
	[Keys.station_five]				= keys_station_five,
	[Keys.station_six]				= keys_station_six,
	[Keys.change_station]			= keys_change_station,
	[Keys.inboard_stations]			= keys_inboard_stations,
	[Keys.outboard_stations]		= keys_outboard_stations,
	[Keys.tip_stations]				= keys_tip_stations,
	------------------------------------------------------
	
	
	
}

function PylonInfo()

	--hier werden die Level2 und LEvel3 Infos der jeweiligen Waffe abgerufen
	
	--if(station_1 == 1) then
	LeftTipWeapon			= dev:get_station_info(PYLON.TIP_L)
	weaponAtStation1L2		= LeftTipWeapon.weapon.level2
	weaponAtStation1L3		= LeftTipWeapon.weapon.level3
	LeftTipFull				= LeftTipWeapon.count
	--end
	
	--if(station_2 == 1) then
	LeftOutboardWeapon 		= dev:get_station_info(2)
	weaponAtStation2L2		= LeftOutboardWeapon.weapon.level2
	weaponAtStation2L3		= LeftOutboardWeapon.weapon.level3
	LeftOutboardFull		= LeftOutboardWeapon.count
	--end
	
	--if (station_3 == 1) then
	LeftInboardWeapon 		= dev:get_station_info(4)
	weaponAtStation3L2		= LeftInboardWeapon.weapon.level2
	weaponAtStation3L3		= LeftInboardWeapon.weapon.level3
	LeftInboardFull			= LeftInboardWeapon.count
	--end
	
	--if(station_4 == 1) then
	RightInboardWeapon 		= dev:get_station_info(5)	
	weaponAtStation4L2		= RightInboardWeapon.weapon.level2
	weaponAtStation4L3		= RightInboardWeapon.weapon.level3
	RightInboardFull		= RightInboardWeapon.count
	--end
	
	--if(station_5 == 1) then
	RightOutboardWeapon 	= dev:get_station_info(3)	
	weaponAtStation5L2		= RightOutboardWeapon.weapon.level2
	weaponAtStation5L3		= RightOutboardWeapon.weapon.level3
	RightOutboardFull		= RightOutboardWeapon.count
	--end
	
	--if(station_6 == 1) then
	RightTipWeapon 			= dev:get_station_info(PYLON.TIP_R)	
	weaponAtStation6L2		= RightTipWeapon.weapon.level2
	weaponAtStation6L3		= RightTipWeapon.weapon.level3
	RightTipFull			= RightTipWeapon.count
	--end
	

	--HUD-Station-Indicator-Update
	
	if((LeftTipFull > 0) and (station_1 == 0))then
		station_one_selector_param:set(1)
	elseif((LeftTipFull > 0) and (station_1 == 1))then
		station_one_selector_param:set(2)
	else
		station_one_selector_param:set(0)
	end
	
	if((LeftOutboardFull > 0) and (station_2 == 0))then
		station_two_selector_param:set(1)
	elseif((LeftOutboardFull > 0) and (station_2 == 1))then
		station_two_selector_param:set(2)
	else
		station_two_selector_param:set(0)
	end
	
	if((LeftInboardFull > 0) and (station_3 == 0))then
		station_three_selector_param:set(1)
	elseif((LeftInboardFull > 0) and (station_3 == 1))then
		station_three_selector_param:set(2)
	else
		station_three_selector_param:set(0)
	end
	
	if((RightInboardFull > 0) and (station_4 == 0))then
		station_four_selector_param:set(1)
	elseif((RightInboardFull > 0) and (station_4 == 1))then
		station_four_selector_param:set(2)
	else
		station_four_selector_param:set(0)
	end
	
	if((RightOutboardFull > 0) and (station_5 == 0))then
		station_five_selector_param:set(1)
	elseif((RightOutboardFull > 0) and (station_5 == 1))then
		station_five_selector_param:set(2)
	else
		station_five_selector_param:set(0)
	end
	
	if((RightTipFull > 0) and (station_6 == 0))then
		station_six_selector_param:set(1)
	elseif((RightTipFull > 0) and (station_6 == 1))then
		station_six_selector_param:set(2)
	else
		station_six_selector_param:set(0)
	end
	
	DeSelect_Pylon()
end

function UsablePylons()
	--hier wird geprüft, ob die ausgewählten Pylons auch die Waffen tragen, 
	--die mit den verschiedenen Selector-Switches ausgewählt wurden.
	
	--Bomben sind Level 2 Nr.5
	--Cluster sind Level 3 Nr.38
	--AtoG Missiles sind Level 2 Nr.4 wenn NICHT Level 3 Nr.7 
	--Rockets sind Level 3 Nr.33 
	--AtoA Missiles sind Level 3 Nr.7
	-- FuelTank sind Level 3 Nr.43
	--Gun ist Level 3 Nr.10
	
	if((station_1 == 1) and ((usableWeapon == 1) and ((weaponAtStation1L2 == 5) or (weaponAtStation1L3 == 33) or 
		((weaponAtStation1L2 == 4) and (weaponAtStation1L3 ~= 7))))or 
		((usableWeapon == 2) and (weaponAtStation1L3 == 7)))then
		Pylon1InUse = 1
		dev:select_station(PYLON.TIP_L)
		--print_message_to_user("Pylon 1 ready and armed with "..tostring(dev:get_station_info(PYLON.TIP_L)))
	end

	if((station_2 == 1) and ((usableWeapon == 1)  and ((weaponAtStation2L2 == 5) or (weaponAtStation2L3 == 33) or 
		((weaponAtStation2L2 == 4) and (weaponAtStation2L3 ~= 7)))) or 
	((usableWeapon == 2) and (weaponAtStation2L3 == 7)))then	
		Pylon2InUse = 1
		--print_message_to_user("Pylon 2 ready and armed with "..tostring(dev:get_station_info(PYLON.OUT_L)))	
		dev:select_station(PYLON.OUT_L)
	end
	
	if((station_3 == 1) and ((usableWeapon == 1) and ((weaponAtStation3L2 == 5) or (weaponAtStation3L3 == 33)or 
		((weaponAtStation3L2 == 4) and (weaponAtStation3L3 ~= 7)))) or 
	((usableWeapon == 2) and (weaponAtStation3L3 == 7)))then
		Pylon3InUse = 1
		--print_message_to_user("Pylon 3 ready and armed with "..tostring(dev:get_station_info(PYLON.IN_L)))
		dev:select_station(PYLON.IN_L)
	end
	
	if((station_4 == 1) and ((usableWeapon == 1) and ((weaponAtStation4L2 == 5) or (weaponAtStation4L3 == 33)or 
		((weaponAtStation4L2 == 4) and (weaponAtStation4L3 ~= 7)))) or 
	((usableWeapon == 2) and (weaponAtStation4L3 == 7)))then	
		Pylon4InUse = 1
		--print_message_to_user("Pylon 4 ready and armed with "..tostring(dev:get_station_info(PYLON.IN_R)))
		dev:select_station(PYLON.IN_R)
	end
	
	if((station_5 == 1) and ((usableWeapon == 1) and ((weaponAtStation5L2 == 5) or (weaponAtStation5L3 == 33)or 
		((weaponAtStation5L2 == 4) and (weaponAtStation5L3 ~= 7)))) or 
	((usableWeapon == 2) and (weaponAtStation5L3 == 7)))then	
		Pylon5InUse = 1
		--print_message_to_user("Pylon 5 ready and armed with "..tostring(dev:get_station_info(PYLON.OUT_R)))
		dev:select_station(PYLON.OUT_R)
	end
	
	if((station_6 == 1) and ((usableWeapon == 1) and ((weaponAtStation6L2 == 5) or (weaponAtStation6L3 == 33)or 
		((weaponAtStation6L2 == 4) and (weaponAtStation6L3 ~= 7)))) or 
	((usableWeapon == 2) and (weaponAtStation6L3 == 7)))then	
		Pylon6InUse = 1
		--print_message_to_user("Pylon 6 ready and armed with "..tostring(dev:get_station_info(PYLON.TIP_R)))
		dev:select_station(PYLON.TIP_R)
	end
	
	
	
end

function DeSelect_Pylon()

	if(LeftTipFull == 0)then
		station_1 = 0
	end
	
	if(LeftOutboardFull == 0)then
		station_2 = 0
	end
	
	if(LeftInboardFull == 0)then
		station_3 = 0
	end
	
	if(RightInboardFull == 0)then
		station_4 = 0
	end
	
	if(RightOutboardFull == 0)then
		station_5 = 0
	end
	
	if(RightTipFull == 0)then
		station_6 = 0
	end

end


function SetCommand(command, value)

    if command_table[command] then
        command_table[command](value)
    end
end


function post_initialize()
    
	--dev:select_station(current_station)
	PylonInfo()
	UsablePylons()
	dev:set_target_range(rangeIsSetAt)
	
	--print_message_to_user("Missile_Seeker_Elevation " ..tostring(ir_missile_des_el_param:get()))
	--print_message_to_user("Missile_Seeker_Azimuth " ..tostring(ir_missile_des_az_param:get()))
	
	-----------------------------------------------------------------------------------
	--Das hier ist GOLD, da es ALLE aktuellen Params anzeigt mit Wert und Veränderung--
	--show_param_handles_list()
	-----------------------------------------------------------------------------------
	

end


function update()

	--WeaponInUse()
	--UsablePylons()
	--PylonInfo()
	if((masterMode == 2) and (ir_missile_lock_param:get() > 0))then
		Missile_Lock_param:set(1)
		print_message_to_user("Missile lock!")
	else
		Missile_Lock_param:set(0)
	end
	--print_message_to_user("Target Elevation from radar: " ..tostring(stt_elevation_h:get()))
	
	
	

	
	--dev:select_station(current_station)
	
--gunpipper_auto_movement_side 		= gunpipper_sideways_automatic_param:get()
--gunpipper_auto_movement_updown		= gunpipper_updown_automatic_param:get()

	--print_message_to_user("IR Missile got lock = " ..tostring(ir_missile_lock_param:get()))
    --if ir_missile_lock_param:get() > 0.0 then --vorher if ir_lock:get() > 0 then 
      --  print_message_to_user("Missile Lock")

	--end
	
	--[[if ir_missile_az_param:get() > 0.0 then
		print_message_to_user("Target_Azimuth " ..tostring(ir_missile_az_param:get()))
	end
	
	
		--if ir_missile_az_param:get() > 0.0 then
		--	print_message_to_user("Target_Azimuth " ..tostring(ir_missile_az_param:get()))
		--end
		--
		--if ir_missile_el_param:get() > 0.0 then
		--	print_message_to_user("Target_Elevation " ..tostring(ir_missile_el_param:get()))
		--end
	else	

		-- radar is providíng target position, but it no lock was achieved yet
	    if ir_missile_des_az_param:get() ~= 0.0 then
			print_message_to_user("Desired Azimuth " ..tostring(ir_missile_des_az_param:get()))
		end
		
		if ir_missile_des_el_param:get() ~= 0.0 then
			print_message_to_user("Desired Elevation " ..tostring(ir_missile_des_el_param:get()))
		end
	end

	
	--print_message_to_user("GunPipper_Automatic_Sideways " ..tostring(gunpipper_auto_movement_side))
	--print_message_to_user("GunPipper_Automatic_UpDown " ..tostring(gunpipper_auto_movement_updown))]]

end

need_to_be_closed = false

--------------------------
--------older functions----
--[[
local function WeaponInUse()
	--choice of Weapon
	if(AR_Armament_Selector_Switch:get() == 1) then 
		usableWeapon = 1 --bombs is 1
	end
	
	if(AR_Armament_Selector_Switch:get() == 2) then
		usableWeapon = 1 --bomb is 1
	end
	
	if(AR_Armament_Selector_Switch:get() == 3) then
		usableWeapon = 2 --rocket 2-Inch is 2
	end
	
	if(AR_Armament_Selector_Switch:get() == 4) then
		usableWeapon = 3 --rocket 5-Inch is 3
	end
	
	if(AR_Armament_Selector_Switch:get() == 5) then
		usableWeapon = 4 --jet. everything except tanks
	end
	
	if(AR_Armament_Selector_Switch:get() == 7) then
		usableWeapon = 5 --jet. only tanks
	end
	
	if(AR_Armament_Selector_Switch:get() == 0) then
		usableWeapon = 0 --no usable weapon because SAFE-Mode
	end
	
end


--target_range_param:set(800.0) --Target-Range auf 800m gesetzt

--gunpipper_auto_movement_side 	= 0.0
--gunpipper_auto_movement_updown	= 0.0

function keys_pickle_on(value)
	---only ping when pickle is pressed to safe fps---
	updatePylon()
	WeaponInUse()
	PylonInfo()
	UsablePylons()
	
	
	-------------------------------------------------
	
	print_message_to_user("Weapon on Station 1: "..tostring(weaponAtStation1L2))
	print_message_to_user("Weapon on Station 1: "..tostring(dev:get_station_info(3).weapon.level2))
	print_message_to_user("Weapon on Station 1: "..tostring(dev:get_station_info(3).weapon.level3))
	print_message_to_user("Weapon on Station 2: "..tostring(weaponAtStation2L2))
	print_message_to_user("Weapon on Station 2: "..tostring(dev:get_station_info(4).weapon.level2))
	print_message_to_user("Weapon on Station 2: "..tostring(dev:get_station_info(4).weapon.level3))
	print_message_to_user("Weapon on Station 3: "..tostring(weaponAtStation3L2))
	print_message_to_user("Weapon on Station 3: "..tostring(dev:get_station_info(6).weapon.level2))
	print_message_to_user("Weapon on Station 3: "..tostring(dev:get_station_info(6).weapon.level3))
	print_message_to_user("Weapon on Station 4: "..tostring(weaponAtStation4L2))
	print_message_to_user("Weapon on Station 4: "..tostring(dev:get_station_info(7).weapon.level2))
	print_message_to_user("Weapon on Station 4: "..tostring(dev:get_station_info(7).weapon.level3))
    
	--dev:drop_flare(1, 1)
    local info = dev:get_station_info(current_station)
    --print_message_to_user("Station "..tostring(current_station).." "..tostring(info.count))
    
	
    --dev:launch_station(current_station)
    --current_station = (current_station + 1) % 11
	

	--dev:launch_station(current_station)
    --print_message_to_user(" Launching selected station: ".. tostring(current_station).." "..tostring(info.count))	
	--dev:drop_flare(1, 1)


	-- TODO: Improve station selection to use one station pressed/activated by the pilot
	--next_station = current_station + 1
	while(next_station <= 11)
	do
		info = dev:get_station_info(next_station)
		if info.count == 0 then
			next_station = next_station + 1
		else
			break
		end
	end

	current_station = next_station
	dev:select_station(current_station)
	print_message_to_user("Selected station: ".. current_station)
	
	
	
	
	if (station_1 == 1) and
		(Pylon1InUse == 1) and
		((usableWeapon == 1) or (usableWeapon == 2) or (usableWeapon == 3)) then
		--dev:launch_station(3) --damit schmeißt er immer eine vom Rack
		Salvo(3)
	elseif(station_1 == 1) and
		(Pylon1InUse == 1) and
		((usableWeapon == 4) or (usableWeapon == 5)) then
		dev:emergency_jettison(3)
	end
	
	if (station_2 == 1) and
		(Pylon2InUse == 1)and
		((usableWeapon == 1) or (usableWeapon == 2) or (usableWeapon == 3)) then
		--dev:launch_station(4)
		Salvo(4)
	elseif(station_2 == 1) and
		(Pylon2InUse == 1) and
		((usableWeapon == 4) or (usableWeapon == 5)) then
		dev:emergency_jettison(4)
	end
	
	if (station_3 == 1) and
		(Pylon3InUse == 1)and
		((usableWeapon == 1) or (usableWeapon == 2) or (usableWeapon == 3)) then
		--dev:launch_station(6)
		Salvo(6)
	elseif(station_3 == 1) and
		(Pylon3InUse == 1) and
		((usableWeapon == 4) or (usableWeapon == 5)) then
		dev:emergency_jettison(6)
	end
	
	if (station_4 == 1) and 
		(Pylon4InUse == 1)and
		((usableWeapon == 1) or (usableWeapon == 2) or (usableWeapon == 3)) then
		Salvo(7)
	elseif(station_4 == 1) and
		(Pylon4InUse == 1) and
		((usableWeapon == 4) or (usableWeapon == 5)) then
		dev:emergency_jettison(7)
	end
	
end



function UsablePylons()
	--hier wird geprüft, ob die ausgewählten Pylons auch die Waffen tragen, 
	--die mit den verschiedenen Selector-Switches ausgewählt wurden.
	--Es soll also geprüft werden, ob alle switches (und wie) aktiviert sind. 
	--Z.B. würde Rockets mit Station 2 und 4 nicht zum Abwurf von Bomben auf Station 2 und 4 führen(hoffentlich).
	--Bomben sind Nr.5 Level 2
	--Rockets sind Nr.33 Level 2
	
	if(WP_Station_One_Param:get() == 1)and
	((usableWeapon == 1) and (weaponAtStation1L2 == 5))or 
	(((usableWeapon == 2) or (usableWeapon == 3)) and (weaponAtStation1L3 == 33))or
	((usableWeapon == 4)  and ((dev:get_station_info(3).CLSID ~= VSN_G91YF_PTB) or (dev:get_station_info(3).CLSID ~= VSN_G91YR_PTB))) or
	((usableWeapon == 5) and ((dev:get_station_info(3).CLSID == VSN_G91YF_PTB) or (dev:get_station_info(3).CLSID == VSN_G91YR_PTB))) then
		Pylon1InUse = 1
		print_message_to_user("Pylon 1 ready and armed with "..tostring(dev:get_station_info(3)))
	end

	if(WP_Station_Two_Param:get() == 1)and
	((usableWeapon == 1)  and (weaponAtStation2L2 == 5))or 
	(((usableWeapon == 2) or (usableWeapon == 3)) and (weaponAtStation2L3 == 33))or
	((usableWeapon == 4)  and ((dev:get_station_info(4).CLSID ~= VSN_G91YF_PTB) or (dev:get_station_info(4).CLSID ~= VSN_G91YR_PTB)))or	
	((usableWeapon == 5) and ((dev:get_station_info(3).CLSID == VSN_G91YF_PTB) or (dev:get_station_info(3).CLSID == VSN_G91YR_PTB))) then	
		Pylon2InUse = 1
		print_message_to_user("Pylon 2 ready and armed with "..tostring(dev:get_station_info(4)))	
	end
	
	if(WP_Station_Three_Param:get() == 1)and
	((usableWeapon == 1) and (weaponAtStation3L2 == 5))or 
	(((usableWeapon == 2) or (usableWeapon == 3)) and (weaponAtStation3L3 == 33))or 
	((usableWeapon == 4)  and ((dev:get_station_info(6).CLSID ~= VSN_G91YF_PTB) or (dev:get_station_info(6).CLSID ~= VSN_G91YR_PTB)))or
	((usableWeapon == 5) and ((dev:get_station_info(3).CLSID == VSN_G91YF_PTB) or (dev:get_station_info(3).CLSID == VSN_G91YR_PTB))) then	
		Pylon3InUse = 1
		print_message_to_user("Pylon 3 ready and armed with "..tostring(dev:get_station_info(6)))
	end
	
	if(WP_Station_Four_Param:get() == 1)and
	((usableWeapon == 1) and (weaponAtStation4L2 == 5))or 
	(((usableWeapon == 2) or (usableWeapon == 3)) and (weaponAtStation4L3 == 33))or
	((usableWeapon == 4)  and ((dev:get_station_info(7).CLSID ~= VSN_G91YF_PTB) or (dev:get_station_info(7).CLSID ~= VSN_G91YR_PTB)))or
	((usableWeapon == 5) and ((dev:get_station_info(3).CLSID == VSN_G91YF_PTB) or (dev:get_station_info(3).CLSID == VSN_G91YR_PTB))) then	
		Pylon4InUse = 1
		print_message_to_user("Pylon 3 ready and armed with "..tostring(dev:get_station_info(7)))
	end
	
	if(AR_Rocket_Outboard_Switch:get() == 1) and
	(usableWeapon == 2) and
	(weaponAtStation1L3 == wsType_Rocket) then
		Pylon1InUse = 1
	end
	
	
end


function PylonInfo()

	--hier werden die Level2 und LEvel3 Infos der jeweiligen Waffe abgerufen
	
	if(station_1 == 1) then
	LeftOutboardWeapon		= dev:get_station_info(3)
	weaponAtStation1L2		= LeftOutboardWeapon.weapon.level2
	weaponAtStation1L3		= LeftOutboardWeapon.weapon.level3
	end
	
	if(station_2 == 1) then
	LeftInboardWeapon 		= dev:get_station_info(4)
	weaponAtStation2L2		= LeftInboardWeapon.weapon.level2
	weaponAtStation2L3		= LeftInboardWeapon.weapon.level3
	end
	
	if (station_3 == 1) then
	RightInboardWeapon 		= dev:get_station_info(6)
	weaponAtStation3L2		= RightInboardWeapon.weapon.level2
	weaponAtStation3L3		= RightInboardWeapon.weapon.level3
	end
	
	if(station_4 == 1) then
	RightOutboardWeapon 	= dev:get_station_info(7)	
	weaponAtStation4L2		= RightOutboardWeapon.weapon.level2
	weaponAtStation4L3		= RightOutboardWeapon.weapon.level3
	end
	

end



function Salvo(st)
	
	--Aufbau: st im Konstruktor wird von der pickle_on funktion gesetzt und hier von st in station 
	--umgewandelt, damit immer die fragliche Station gedropped wird.
	--nach den "gezählten" dropps soll mit return die Funktion verlassen werden, wobei "ohne" return so lnge 
	--geworfen wird, bis der button losgelassen wird (hoffentlich)
	
	--ACHTUNG: Die Salvo-Funktion muss eigentlich nicht upgedated werden, weil sie nur durch die keys_pickle_on-Funktion 
	--ausgelöst wird.
	
	local station = st
	
	if((usableWeapon == 2) or (usableWeapon == 3)) and (AR_Rocket_Salvo_Selection:get() == 1) then
		dev:launch_station(station)
		return
	elseif((usableWeapon == 2) or (usableWeapon == 3)) and (AR_Rocket_Salvo_Selection:get() == 2) then
		dev:launch_station(station)
		dev:launch_station(station)
		dev:launch_station(station)
		dev:launch_station(station)
		dev:launch_station(station)
		return
	elseif((usableWeapon == 2) or (usableWeapon == 3)) and (AR_Rocket_Salvo_Selection:get() == 3) then
		dev:launch_station(station)
	end
	
	if(usableWeapon == 1) and (AR_Bomb_RP_Selector:get() == 1) then
		dev:launch_station(station)
		dev:launch_station(station)
		dev:launch_station(station)
		return
	elseif(usableWeapon == 1) and (AR_Bomb_RP_Selector:get() == 0) then
		dev:launch_station(station)
		return
	end
	

end


function updatePylon()

	if(WP_Station_One_Param:get() == 1) then
	--current_station = 1
	station_1 = 1
	dev:select_station(3)
	else
	station_1 = 0
	end
	
	if(WP_Station_Two_Param:get() == 1) then
	--current_station = 2
	station_2 = 1
	dev:select_station(4)
	else
	station_2 = 0
	end
	
	if(WP_Station_Three_Param:get() == 1) then
	--current_station = 3
	station_3 = 1
	dev:select_station(6)	
	else
	station_3 = 0
	end
	
	if(WP_Station_Four_Param:get() == 1) then
	--current_station = 4
	station_4 = 1
	dev:select_station(7)
	else
	station_4 = 0
	end
	

	if station_1 == 0 and 
		station_2 == 0 and 
		station_3 == 0 and 
		station_4 == 0 then
			dev:select_station(1)--1 gibt es nicht bei der G91Y
	end

end
]]