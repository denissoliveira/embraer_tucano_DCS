start_custom_command   = 10000

local __count_custom = start_custom_command-1

local function __custom_counter()
	__count_custom = __count_custom + 1
	return __count_custom
end

Keys =
{
	--iCommandPlaneFonar						= 71, --Canopy open/close
	--iCommandPlaneWingtipSmokeOnOff 					= 78,
	iCommandPlaneJettisonWeapons 				= 82,
 	iCommandPlaneFire 							= 84,
	iCommandPlaneFireOff 						= 85,
	
	--Master-Modes FC3---------------------------------
	iCommandPlaneChangeWeapon 					= 101,
	iCommandPlaneModeNAV						= 105,
	iCommandPlaneModeBVR						= 106,
	iCommandPlaneModeVS							= 107,
	iCommandPlaneModeBore						= 108,
	iCommandPlaneModeFI0						= 110,
	iCommandPlaneModeGround						= 111,
	iCommandPlaneModeCannon						= 113,
	
	iCommandBrightnessILS						= 156,
	--iCommandActiveJamming 					= 136,
	iCommandPlaneJettisonFuelTanks 				= 178,
	iCommandToggleCommandMenu					= 179,
	
	iCommandPowerOnOff							= 315,
	
	iCommandPlanePickleOn	 					= 350,
	iCommandPlanePickleOff 						= 351,
	
	iCommandHUDBrightnessUp						= 746,
	ICommandHUDBrightnessDown	                = 747,
	------------------WEAPON SYSTEM---------------------------------
	-----------------Launch, Fire, Release and Drop-----------------
	pickle_on 					= __custom_counter(),
	pickle_off 					= __custom_counter(),
	trigger_on					= __custom_counter(),
	trigger_off					= __custom_counter(),
	----------------Station Selection--------------------------------
	station_one					= __custom_counter(),
	station_two					= __custom_counter(),
	station_three				= __custom_counter(),
	station_four				= __custom_counter(),
	station_five				= __custom_counter(),
	station_six					= __custom_counter(),
	change_station				= __custom_counter(),
	inboard_stations			= __custom_counter(),
	tip_stations				= __custom_counter(),
	outboard_stations			= __custom_counter(),
	-----------------------------HUD--------------------------------
	GunPipper_Up					= __custom_counter(),
	GunPipper_Down					= __custom_counter(),
	--GunPipper_Right				= __custom_counter(),
	--GunPipper_Left				= __custom_counter(),
	GunPipper_Center				= __custom_counter(),
	GunPipper_Automatic				= __custom_counter(),
	Gunpipper_Manual				= __custom_counter(),
	SetTargetRange_up				= __custom_counter(),
	SetTargetRange_down				= __custom_counter(),
	SysHudBrightnessUP				= __custom_counter(),
	SysHudBrightnessDOWN			= __custom_counter(),
}
start_command   = 3000
local __count = start_command-1
local function __counter()
	__count = __count + 1
	return __count
end

device_commands = {

    
}
