local A27T = 'T-27'

local armamentos_IN   = {}

local armamentosClean = { { CLSID = "<CLEAN>", arg_value = 1 } }
local armamentosTank  = { { CLSID = "{AT27_TANK}" }, }

for _, v in ipairs(armamentosTank) do 
	table.insert(armamentos_IN, v) 
end
for _, v in ipairs(armamentosClean) do
	table.insert(armamentos_IN, v); --table.insert(armamentos_OUT, v)
end

mount_vfs_model_path(current_mod_path .. "/Shapes")
mount_vfs_texture_path(current_mod_path .. "/Textures")
mount_vfs_liveries_path (current_mod_path .. "/Liveries")
mount_vfs_sound_path(current_mod_path .. "/Sounds")

--dofile(current_mod_path .. "/weapons/weapons.lua")

-- Declaring aircraft 
-- A27T
A27TFM =  {

	Name 				=   A27T,
	DisplayName			= _('EMB-312 Tucano (T-27)'),

	HumanCockpit 		= true,
	HumanCockpitPath    = current_mod_path..'/Cockpit/',

	Picture 			= current_mod_path..'/ImagesGui/AT-27.png',
	Rate 				= 40, -- RewardPoint in Multiplayer
	Shape 				= A27T,
	WorldID				=  WSTYPE_PLACEHOLDER, 
	livery_entry    	= A27T,

	propellorShapeType  = "3ARG_PROC_BLUR",
	propellorShapeName  = "EMB312_blade.FBX",
	propellorShapeBlurX = 0.6,

	shape_table_data 	= 
	{
		{
			file  	 = A27T;
			life  	 = 18; -- lifebar
			vis   	 = 3; -- visibility gain.
			desrt    = 'Fighter-2-crush'; -- Name of destroyed object file name
			fire  	 = { 300, 2}; -- Fire on the ground after destoyed: 300sec 2m
			username = A27T;
			index    =  WSTYPE_PLACEHOLDER;
			classname 		= "lLandPlane";
			positioning 	= "BYNORMAL";
			drawonmap 		= true;
		},
		--[[{
			name  = "ov10-oblomok";
			file  = "ov10-oblomok";
			fire  = { 240, 2};
		},]]--
	},
------------------------------------------------------------------------
	net_animation = {
						551,552,553,554,200,201,202,203,204,205,206,207,208,209,140,141,142,900,901,99,400,401,402,38,
					},
-----------------------------------------
	mapclasskey 		= "P0091000025",
	attribute  			= {wsType_Air, wsType_Airplane, wsType_Fighter, WSTYPE_PLACEHOLDER ,"Battleplanes",},
	Categories 			= {"{78EFB7A2-FD52-4b57-A6A6-3BF0E1D6555F}", "Interceptor",},	
	-------------------------
	M_empty 					= 2350, -- kg
	M_nominal 					= 2800, -- kg
	M_max 						= 4200, -- kg
	M_fuel_max 					= 650, -- kg --2225

	H_max 					 	= 10670, -- m

	average_fuel_consumption 	= 0.245, -- this is highly relative, but good estimates are 36-40l/min = 28-31kg/min = 0.47-0.52kg/s -- 45l/min = 35kg/min = 0.583kg/s

	CAS_min 					= 45, -- if this is not OVERAL FLIGHT TIME, but jus LOITER TIME, than it sholud be 10-15 minutes.....CAS capability in minute (for AI)
	V_opt 						= 110,-- Cruise speed (for AI)
	V_take_off 					= 42, -- Take off speed in m/s (for AI)
	V_land 						= 38, -- Land speed in m/s (for AI)
	V_max_sea_level 			= 130, -- Max speed at sea level in m/s (for AI)
	V_max_h 					= 115, -- Max speed at max altitude in m/s (for AI)
	Vy_max 						= 12, -- Max climb speed in m/s (for AI)
	Mach_max 					= 0.45, -- Max speed in Mach (for AI)
	Ny_min 						= -3, -- Min G (for AI)
	Ny_max 						= 6.0,  -- Max G (for AI)
	Ny_max_e 					= 6.0,  -- Max G (for AI)
	AOA_take_off 				= 0.14, -- AoA in take off (for AI)
	bank_angle_max 				= 60, -- Max bank angle (for AI)

	has_afteburner 				= false, -- AFB yes/no
	has_speedbrake 				= false, -- Speedbrake yes/no

	nose_gear_pos 				= {2.976, -1.5, -0.002}, --F-16 New Model	{2.954,	-2.0,	0}, --	{2.954,	-1.881,	0},
	main_gear_pos 				= { -0.122, -1.61, 1.816}, --F-16 New Model {-1.041,	-2.0,	1.207}, --	{-1.041,	-1.869,	1.207},
	tand_gear_max 				= 1, --4.6,
	nose_gear_wheel_diameter	= 0.359,
	main_gear_wheel_diameter	= 0.579,

	--tanker_type 				= 1, -- Tanker type if the plane is airrefuel capable
					
	wing_area 					= 19.4, -- wing area in m2
	wing_span 					= 11.14, -- wing spain in m
	wing_type 					= 0,
	height 						= 4.77, -- height in m	
	length 						= 12.13, -- full lenght in m

	--[[ 
	X (0.5): Posição longitudinal (frente/trás). Positivo é para a frente (nariz).
	Y (-0.2): Posição vertical (cima/baixo). Geralmente negativo se a asa tiver diedro negativo ou estiver abaixo do centro de massa.
	Z (5.4): Envergadura (lateral). É a distância do centro da fuselagem até a ponta da asa. 
	]]--
	wing_tip_pos 				= { 0.038, -0.032, 5.393 },--{1.004,	0.707,	1.249}, 

	--thrust_sum_max 				= 600, -- thrust in kg (44kN)
	--thrust_sum_ab 				= 600, -- thrust inkg (71kN)

	range 						= 1900, -- Max range in km (for AI)

	flaps_maneuver 				= 0.5, -- Max flaps in take-off and maneuver (0.5 = 1st stage; 1.0 = 2nd stage) (for AI)

	RCS 						= 2.5, -- Radar Cross Section m2
	IR_emission_coeff 			= 0.1, -- Normal engine -- IR_emission_coeff = 1 is Su-27 without afterburner. It is reference.
	IR_emission_coeff_ab 		= 0.0, -- With afterburner

	brakeshute_name 			= 0, -- Landing - brake chute visual shape after separation
	is_tanker 					= false, -- Tanker yes/no
	air_refuel_receptacle_pos 	= {0.0,	0.0, 0.0},

	engines_count				= 1, -- Engines count
	engines_nozzles = 
	{
		[1] = 
		{
			pos 		=  {2.57,-0.13,0.58}, -- nozzle coords
			elevation = 0,
			diameter = 1.023,
			exhaust_length_ab = 3.794,
			exhaust_length_ab_K = 0.3,
			smokiness_level = 0.001,
			--elevation   =  0, -- AFB cone elevation
			--diameter	 = 0*0.1, -- AFB cone diameter
			--exhaust_length_ab   = -3.0, -- lenght in m
			--exhaust_length_ab_K = 0.3, -- AB animation
			--engine_number  = 1, --both to first engine
		}, -- end of [1]
		[2] = 
		{
			pos 		=  {2.578,-0.05,-0.56}, -- nozzle coords
			elevation = 0,
			diameter = 1.023,
			exhaust_length_ab = 3.794,
			exhaust_length_ab_K = 0.3,
			smokiness_level = 0.001,
		}, -- end of [1]
	}, -- end of engines_nozzles

	crew_size	 = 2,
	crew_members = 
	{
-- FRONT SEAT
		[1] = 
		{
			ejection_through_canopy = true, --no openbeta usare mechanimations
			ejection_seat_name = "pilot_f15_00_seat", --arg0: frame 0~10 seat+pilota, 10~100 solo seat
			pilot_name  = "pilot_f15_00", --modello richiamato dopo separazione seggiolino 
			drop_canopy_name = 0, --nessun tettuccio da espellere
			drop_parachute_name =  "pilot_f15_parachute",			
			pos =  {0.5, 0.1, 0.1}, --posizionamento seggiolino (centro assi)
			canopy_pos = {2,0.5,0},
			ejection_play_arg = 50, --50+1000, --rottura vetro
			pilot_body_arg = 50, -- frame 0~50:pilota+seggiolino, 50~99:solo seggiolino, 100: asta espulsione
			can_be_playable = true,
			canopy_args = {38,0.8}, --da disabilitare con ejection_through_canopy
			ejection_added_speed = {-4.5,15,0.4}, --X,Y,Z metri: direzione espulsione(determina punto di caduta)
			ejection_order 		 = 2,			
			role 				 = "pilot",
			role_display_name    = _("Pilot"),	
			g_suit 			   =  1,
			bailout_arg = -1, --abilitare su openbeta con mechanimations
			
		}, -- end of [1]

-- BACK SEAT		
	[2] = 
		{
			ejection_through_canopy = true,
			ejection_seat_name = "pilot_f15_00_seat",
			pilot_name = "pilot_f15_00",			
			drop_canopy_name = 0,
			drop_parachute_name =  "pilot_f15_parachute",			
			pos =  {-0.8, 0.3, 0.1},
			canopy_pos = {2,0.5,0},
			ejection_added_speed = {-4,14.5,-0.4},
			ejection_play_arg = 50,--50+1000,			
			can_be_playable = false,
			canopy_args = {38,0.8},
			pilot_body_arg		= 472,
			ejection_order 		= 1,			
			role 				 = "instructor",
			role_display_name    = _("Instructor pilot"),
			g_suit 			   =  1,
			bailout_arg = -1,

		}, -- end of crew_members
	},

	LandRWCategories = 
        {
        [1] = 
        {
            Name = "AircraftCarrier",
        },
        [2] = 
        {
            Name = "AircraftCarrier With Catapult",
        }, 
        [3] = 
        {
            Name = "AircraftCarrier With Tramplin",
        }, 
    }, -- end of LandRWCategories
        TakeOffRWCategories = 
        {
        [1] = 
        {
            Name = "AircraftCarrier",
        },
        [2] = 
        {
            Name = "AircraftCarrier With Catapult",
        }, 
        [3] = 
        {
            Name = "AircraftCarrier With Tramplin",
        }, 
    }, -- end of TakeOffRWCategories
	
	-- Countermeasures
        SingleChargeTotal = 180,
        CMDS_Incrementation = 30,
        ChaffDefault = 90, -- RR-170
        ChaffChargeSize = 1,
        FlareDefault = 45, -- MJU-7
        FlareChargeSize = 2,
        CMDS_Edit = true,
		
	chaff_flare_dispenser 	= 
	{
		[1] = 
		{
			dir =  {0, -1, -1},
			pos =  {-3, -1, 2},
		}, -- end of [1]
		[2] = 
		{
			dir =  {0, -1, 1},
			pos =  {-3, -1, -2},
		}, -- end of [2]
	}, -- end of chaff_flare_dispenser

	--sensors
	
	detection_range_max		 = 160,
	radar_can_see_ground 	 = true, -- this should be examined (what is this exactly?)
	CanopyGeometry = 
	{
        azimuth = {-160.0, 160.0},
        elevation = {-60.0, 80.0}
	},
	
	Sensors = 
	{
        --RADAR = "AN/APG-68",
        --RWR = "Abstract RWR"
    },

	HumanRadio = 
	{
		frequency = 127.5,  -- Radio Freq
		editable = true,
		minFrequency = 100.000,
		maxFrequency = 156.000,
		modulation = MODULATION_AM
	},

	panelRadio = 
	{		
		[1] = {
				name = _("FM Radio"),		   
				range = {{min = 30, max = 87.975}},
				channels = {
							[1] = { name = _("Channel 1"),		default = 30.0, modulation = _("FM")},
							[2] = { name = _("Channel 2"),		default = 31.0, modulation = _("FM")},
							[3] = { name = _("Channel 3"),		default = 32.0, modulation = _("FM")},
							[4] = { name = _("Channel 4"),		default = 33.0, modulation = _("FM")},
							[5] = { name = _("Channel 5"),		default = 40.0, modulation = _("FM")},
							[6] = { name = _("Channel 6"),		default = 41.0, modulation = _("FM")},
							[7] = { name = _("Channel 0"),		default = 42.0, modulation = _("FM")},
							[8] = { name = _("Channel RG"),		default = 50.0, modulation = _("FM")},
							}
				},
	},
	
	EPLRS = true,
	
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	Pylons =  
	{  
        pylon(1, 0, 0, 0, 0,
			{
				arg = 309,
				arg_value = 0.2,
				DisplayName = "2",
				use_full_connector_position = true,
				connector = "Pylon2",
			},
			armamentos_IN
		),
        pylon(2, 0, 0, 0, 0,
			{
				arg = 310,
				arg_value = 0.2,
				DisplayName = "3",
				use_full_connector_position = true,
				connector = "Pylon3",
			},
			armamentos_IN
		),
	},
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	Tasks = 
	{
        aircraft_task(GroundAttack),
        aircraft_task(RunwayAttack),
        aircraft_task(PinpointStrike),
        aircraft_task(CAS),
        aircraft_task(AFAC),
		aircraft_task(CAP),
        aircraft_task(Escort),
        aircraft_task(FighterSweep),
        aircraft_task(Intercept),
    },	
	DefaultTask = aircraft_task(CAS),
	
	SFM_Data = 
	{
		aerodynamics = -- Cx = Cx_0 + Cy^2*B2 +Cy^4*B4
		{
			Cy0        = 0.10,     -- sustentação em alpha zero
			Mzalfa     = 3.0,      -- momento de arfagem por alpha
			Mzalfadt   = 0.6,      -- amortecimento em arfagem
			kjx        = 2.0,      -- inércia longitudinal (ajuste fino depois)
			kjz        = 0.001,    -- inércia em guinada
			Czbe       = -0.012,   -- efeito do profundor
			cx_gear    = 0.050,    -- arrasto do trem de pouso
			cx_flap    = 0.12,     -- arrasto de flap
			cy_flap    = 0.50,     -- ganho de sustentação com flap
			cx_brk     = 0.08,     -- freio aerodinâmico / wheel brake drag

			table_data  = 
			{	
				--  M     Cx0     Cya     B       B4      Omxmax  Aldop  Cymax
				[1] ={ 0.0,  0.055, 0.080, 0.050, 0.020, 0.20, 17.0, 1.60 },
				[2] ={ 0.2,  0.055, 0.080, 0.050, 0.020, 0.60, 17.0, 1.40 },
				[3] ={ 0.3,  0.060, 0.082, 0.055, 0.025, 0.80, 16.0, 1.35 },
				[4] ={ 0.4,  0.070, 0.080, 0.060, 0.030, 0.90, 15.0, 1.30 },
				[5] ={ 0.5,  0.085, 0.078, 0.070, 0.040, 0.85, 14.0, 1.20 },
				[6] ={ 0.6,  0.110, 0.075, 0.085, 0.060, 0.75, 13.0, 1.10 },
				[7] ={ 0.7,  0.150, 0.070, 0.100, 0.080, 0.60, 11.0, 1.00 },
			}, -- end of table_data
		}, -- end of aerodynamics
		engine = 
		{
			typeng					= 3, --3 turboprop
			Nmg						= 64, -- RPM at idle
			MinRUD					= 0, -- Min state of the throttle
			MaxRUD					= 1, -- Max state of the throttle
			MaksRUD					= 1, -- Military power state of the throttle
			ForsRUD					= 1, -- Afterburner state of the throttle
			hMaxEng					= 9.0, -- Max altitude for safe engine operation in km
			dcx_eng					= 0.015, -- Affects drag of engine when shutdown
			cemax					= 0.70, -- not used for fuel calulation , only for AI routines to check flight time ( fuel calculation algorithm is built in )
			cefor					= 0.70, -- not used for fuel calulation , only for AI routines to check flight time ( fuel calculation algorithm is built in )
			dpdh_m					= 3800, --  altitude coefficient for max thrust
			dpdh_f					= 3800,  --  altitude coefficient for AB thrust

			D_prop					= 3.45,

            Startup_Ignition_Time 	= 8.0,
            Shutdown_Duration 		= 9.8,
			prop_locations 			= {{3.131, -0.082, 0.002}, {0.0, 0.0, math.rad(-1.87)},},
			prop_blades_count 		= 3,
			prop_pitch_min      	= 23.0,    -- prop pitch min, degrees
			prop_pitch_max      	= 65.0,    -- prop pitch max, degrees
			prop_pitch_feather  	= 80.0,    -- prop pitch feather position, degrees if feather < prop_pitch_max no feathering available
			Nominal_RPM 			= 3000,

			table_data =
			{ -- Mach      Potência disponível equivalente no eixo (W)
				{ 0.00, 560000 }, -- Potência máxima estática (750 shp)
				{ 0.10, 555000 }, -- Leve perda por avanço
				{ 0.15, 548000 },
				{ 0.20, 535000 },
				{ 0.25, 520000 }, -- Região ideal de subida
				{ 0.30, 500000 },
				{ 0.35, 470000 }, -- Próximo da velocidade de cruzeiro
				{ 0.40, 400000 },
				{ 0.45, 300000 },
				{ 0.50, 200000 },
				{ 0.55, 120000 },
				{ 0.60,  60000 },
			}, -- end of engine
		}, -- end of engine
	},

	sounderName         = "Aircraft/Planes/AT-27",


	fires_pos = 
	{
		[1] = 	{-0.184,  	 2.166,		0.4731},
		[2] = 	{-0.184,  	-2.166,		0.4731},
	}, -- end of fires_pos

	--damage , index meaning see in  Scripts\Aircrafts\_Common\Damage.lua
	Damage = verbose_to_dmg_properties(
	{	
		["COCKPIT"]            	= {critical_damage = 30.0	, args = {853},},	--3
		["MAIN"]            	= {critical_damage = 20.0	, args = {852},},	--10

		["ENGINE_R"]            = {critical_damage = 1.0	, args = {-1},},	--12
		["ENGINE_L"]            = {critical_damage = 1.0	, args = {-1},},	--11

		["WING_R_OUT"]          = {critical_damage = 10.0	, args = {850},},	--24
		["WING_L_OUT"]          = {critical_damage = 10.0	, args = {851},},	--23

		["STABILIZER_L_OUT"]    = {critical_damage = 10.0	, args = {858},},	--45

		["RUDDER_R"]    		= {critical_damage = 20.0	, args = {856},},	--54
		["RUDDER_L"]    		= {critical_damage = 20.0	, args = {857},},	--53

		["TAIL_RIGHT_SIDE"]    	= {critical_damage = 20.0	, args = {854},},	--57
		["TAIL_LEFT_SIDE"]    	= {critical_damage = 20.0	, args = {855},},	--56
	}),


	lights_data = {
        typename = "collection",
        lights = {
            [WOLALIGHT_LANDING_LIGHTS]	= {
				typename	= 	"collection",
				lights		= {
					{ typename  = "argumentlight",	argument  = 209, },
				},
			},--must be collection
			[WOLALIGHT_TAXI_LIGHTS]	= {
				typename	= 	"collection",
				lights		= {
					{ typename  = "argumentlight",	argument  = 208, },
				},
			},--must be collection
			[WOLALIGHT_NAVLIGHTS]	= {
				typename 	= "collection",
				lights 		= {
					{ typename  = "argumentlight", argument  = 190, },				-- red
					{ typename  = "argumentlight", argument  = 191, },				-- green
					{ typename  = "argumentlight", argument  = 192, },				-- white
				},
			},--must be collection
			[WOLALIGHT_FORMATION_LIGHTS] = {
				typename	= "collection",
				lights		= {
					{ typename  = "argumentlight",	argument  = 200, },
				},		-- green bars
			},--must be collection
        }
    },

    --ViewSettings = ViewSettings,
    --SnapViews    = SnapViews,

}

add_aircraft(A27TFM)