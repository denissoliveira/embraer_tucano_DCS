local A27T            = 'AT-27'

local armamentos_IN   = {}
local armamentos_OUT  = {}

local armamentosClean = { { CLSID = "<CLEAN>", arg_value = 1 } }
local armamentosTank  = { { CLSID = "{AT-27_TANK}" }, }

-- Loadouts: apenas CLSIDs do DCS base (sem dependencia de outros mods).
-- CLSIDs proprietarios do A29MEFM (MK-81SE, LAU-33A, BDU-33, M260_HYDRA, LAU68_FFAR_*)
-- foram removidos porque causavam db_scan assertion failed quando A29MEFM nao estava instalado.
local bombs_Rockts    = {
	{ CLSID = "{90321C8E-7ED1-47D4-A160-E074D5ABD902}" }, -- MK-81  (DCS base)
	{ CLSID = "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}" }, -- MK-82  (DCS base)
	{ CLSID = "{ADD3FAE1-EBF6-4EF9-8EFC-B36B5DDF1E6B}" }, -- Mk-20 Rockeye (DCS base)
	{ CLSID = "{A021F29D-18AB-4d3e-985C-FC9C60E35E9E}" }, -- LAU-68 Hydra M151 HE  (DCS base)
	{ CLSID = "{4F977A2A-CD25-44df-90EF-164BFA2AE72F}" }, -- LAU-68 Hydra M156 WP  (DCS base)
	{ CLSID = "{174C6E6D-0C3D-42ff-BCB3-0853CB371F5C}" }, -- LAU-68 Hydra Mk5 HEAT (DCS base)
}

for _, v in ipairs(bombs_Rockts) do
	table.insert(armamentos_IN, v); table.insert(armamentos_OUT, v)
end
for _, v in ipairs(armamentosTank) do
	table.insert(armamentos_IN, v)
end
for _, v in ipairs(armamentosClean) do
	table.insert(armamentos_IN, v); table.insert(armamentos_OUT, v)
end

A27TFM = {
	Name                      = A27T,
	DisplayName               = _('EMB-312 Tucano (AT-27)'),
	HumanCockpit              = true,
	HumanCockpitPath          = current_mod_path .. '/Cockpit/',
	Picture                   = current_mod_path .. '/ImagesGui/AT-27.png',
	Rate                      = 40,
	Shape                     = A27T,
	WorldID                   = WSTYPE_PLACEHOLDER,
	livery_entry              = A27T,

	propellorShapeType        = "3ARG_PROC_BLUR",
	propellorShapeName        = "EMB312_blade.FBX",
	propellorShapeBlurX       = 0.6,

	shape_table_data          =
	{
		{
			file        = A27T,
			life        = 18,
			vis         = 3,
			desrt       = 'su-25-oblomok',
			fire        = { 300, 2 },
			username    = A27T,
			index       = WSTYPE_PLACEHOLDER,
			classname   = "lLandPlane",
			positioning = "BYNORMAL",
			drawonmap   = true,
		},
		{
			name  = "su-25-oblomok";
			file  = "su-25-oblomok";
			fire  = { 240, 2};
		},
	},

	net_animation             = { 551, 552, 553, 554, 200, 201, 202, 203, 204, 205, 206, 207, 208, 209, 140, 141, 142, 900, 901, 99, 400, 401, 402, 38, },
	mapclasskey               = "P0091000025",
	attribute                 = { wsType_Air, wsType_Airplane, wsType_Fighter, WSTYPE_PLACEHOLDER, "Planes", },
	-- Categoria realista: treinador armado leve. Removido "Bomber" (Tucano nao e bombardeiro).
	-- wsType_Fighter e a constante valida do DCS (wsType_Tactical_bomber nao existe e quebrava o db_scan).
	Categories 			= {"{78EFB7A2-FD52-4b57-A6A6-3BF0E1D6555F}", "Attack", "Trainer", "Reconnaissance", },	

	-- Dados Físicos AT-27 (PT-6A)
	M_empty                   = 1810,  -- kg
	M_nominal                 = 2550,  -- kg
	M_max                     = 3175,  -- kg
	M_fuel_max                = 555,   -- kg (combustivel real do EMB-312: ~694 L uteis x 0.8 kg/L)

	H_max                     = 9144,  -- m (teto de servico real ~30.000 ft)

	average_fuel_consumption  = 0.031, -- kg/s (=> ~5 h de autonomia, como o real)

	CAS_min                   = 45,
	V_opt                     = 114,  -- m/s (cruzeiro real ~411 km/h)
	V_take_off                = 38,   -- m/s
	V_land                    = 34,   -- m/s
	V_max_sea_level           = 124,  -- m/s (vel. max real ~448 km/h)
	V_max_h                   = 124,  -- m/s
	Vy_max                    = 11.3, -- m/s
	Mach_max                  = 0.45,
	Ny_min                    = -3.0,
	Ny_max                    = 6.0,
	Ny_max_e                  = 6.0,
	AOA_take_off              = 0.14,
	bank_angle_max            = 60,

	has_afteburner            = false,
	has_speedbrake            = false,

	nose_gear_pos             = { 2.976, -1.55, 0.0 },
	main_gear_pos             = { -0.122, -1.61, 1.816 },
	tand_gear_max             = 1,
	nose_gear_wheel_diameter  = 0.359,
	main_gear_wheel_diameter  = 0.579,

	wing_area                 = 19.4,  -- m2
	wing_span                 = 11.14, -- m
	wing_type                 = 0,
	height                    = 3.40,  -- m
	length                    = 9.86,  -- m

	wing_tip_pos              = { 0.038, -0.032, 5.393 },
	range                     = 1916, -- km
	flaps_maneuver            = 0.5,

	RCS                       = 2.5,
	IR_emission_coeff         = 0.08,
	IR_emission_coeff_ab      = 0.0,

	brakeshute_name           = 0,
	is_tanker                 = false,
	air_refuel_receptacle_pos = { 0.0, 0.0, 0.0 },

	engines_count             = 1,
	engines_nozzles           =
	{
		[1] =
		{
			pos                 = { 2.636, -0.072, 0.5 }, -- nozzle coords
			elevation           = 0,
			diameter            = 1.023,
			exhaust_length_ab   = 3.794,
			exhaust_length_ab_K = 0.3,
			smokiness_level     = 0.001,
			--elevation   =  0, -- AFB cone elevation
			--diameter	 = 0*0.1, -- AFB cone diameter
			--exhaust_length_ab   = -3.0, -- lenght in m
			--exhaust_length_ab_K = 0.3, -- AB animation
			--engine_number  = 1, --both to first engine
		}, -- end of [1]
		[2] =
		{
			pos                 = { 2.636, -0.072, -0.5 }, -- nozzle coords
			elevation           = 0,
			diameter            = 1.023,
			exhaust_length_ab   = 3.794,
			exhaust_length_ab_K = 0.3,
			smokiness_level     = 0.001,
		}, -- end of [1]
	}, -- end of engines_nozzles

	crew_size                 = 2,
	crew_members              =
	{
		[1] =
		{
			ejection_through_canopy = true,
			ejection_seat_name      = "pilot_f15_00_seat",
			pilot_name              = "pilot_f15_00",
			drop_canopy_name        = 0,
			drop_parachute_name     = "pilot_f15_parachute",
			pos                     = { 0.5, 0.1, 0.1 },
			canopy_pos              = { 2, 0.5, 0 },
			ejection_play_arg       = 50,
			pilot_body_arg          = 50,
			can_be_playable         = true,
			canopy_args             = { 38, 0.8 },
			ejection_added_speed    = { -4.5, 15, 0.4 },
			ejection_order          = 2,
			role                    = "pilot",
			role_display_name       = _("Pilot"),
			g_suit                  = 1,
			bailout_arg             = -1,
		},
		[2] =
		{
			ejection_through_canopy = true,
			ejection_seat_name      = "pilot_f15_00_seat",
			pilot_name              = "pilot_f15_00",
			drop_canopy_name        = 0,
			drop_parachute_name     = "pilot_f15_parachute",
			pos                     = { -0.8, 0.3, 0.1 },
			canopy_pos              = { 2, 0.5, 0 },
			ejection_added_speed    = { -4, 14.5, -0.4 },
			ejection_play_arg       = 472,
			can_be_playable         = false,
			canopy_args             = { 38, 0.8 },
			pilot_body_arg          = 472,
			ejection_order          = 1,
			role                    = "instructor",
			role_display_name       = _("Instructor pilot"),
			g_suit                  = 1,
			bailout_arg             = -1,
		},
	},

	-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	Pylons                    =
	{
		pylon(1, 0, 0, 0, 0,
			{
				arg = 308,
				arg_value = 0.2,
				DisplayName = "1",
				use_full_connector_position = true,
				connector = "Pylon1",
			},
			armamentos_OUT
		),
		pylon(2, 0, 0, 0, 0,
			{
				arg = 309,
				arg_value = 0.2,
				DisplayName = "2",
				use_full_connector_position = true,
				connector = "Pylon2",
			},
			armamentos_IN
		),
		pylon(3, 0, 0, 0, 0,
			{
				arg = 310,
				arg_value = 0.2,
				DisplayName = "3",
				use_full_connector_position = true,
				connector = "Pylon3",
			},
			armamentos_IN
		),
		pylon(4, 0, 0, 0, 0,
			{
				arg = 311,
				arg_value = 0.2,
				DisplayName = "4",
				use_full_connector_position = true,
				connector = "Pylon4",
			},
			armamentos_OUT
		),
	},
	-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	Tasks                     =
	{
		aircraft_task(GroundAttack), 
		aircraft_task(CAS), 
		aircraft_task(AFAC), 
		aircraft_task(Escort), 
		aircraft_task(Reconnaissance),
        aircraft_task(RunwayAttack),
    },
	DefaultTask               = aircraft_task(CAS),

	-- Centro de massa e momentos de inercia (padrao A-29B)
	-- center_of_mass: 0.30m a frente da origem do modelo (CG nose-heavy estavel)
	-- moment_of_inertia: escalonado do A-29B pela razao de massa (1810/3200 = 0.566)
	center_of_mass            = { 0.30, -0.10, 0.0 },
	moment_of_inertia         = { 7960.0, 17260.0, 15150.0 },

	SFM_Data                  =
	{
		aerodynamics =
		{
			Cy0        = 0.10,
			Mzalfa     = 3.0,
			Mzalfadt   = 0.6,
			kjx        = 5.0,    -- damping de rolagem (aumentado de 2.0 p/ ajudar estabilidade no solo)
			kjz        = 3.0,    -- damping de yaw/pitch (REVERTIDO: 0.00125 deixou o aviao girar de novo. 3.0 funciona)
			Czbe       = -0.012,
			cx_gear    = 0.050,
			cx_flap    = 0.12,
			cy_flap    = 0.50,
			cx_brk     = 0.08,

			table_data =
			{
				[1] = { 0.0, 0.055, 0.080, 0.050, 0.020, 0.20, 17.0, 1.60 },
				[2] = { 0.2, 0.055, 0.080, 0.050, 0.020, 0.60, 17.0, 1.40 },
				[3] = { 0.3, 0.060, 0.082, 0.055, 0.025, 0.80, 16.0, 1.35 },
				[4] = { 0.4, 0.070, 0.080, 0.060, 0.030, 0.90, 15.0, 1.30 },
				[5] = { 0.5, 0.085, 0.078, 0.070, 0.040, 0.85, 14.0, 1.20 },
				[6] = { 0.6, 0.110, 0.075, 0.085, 0.060, 0.75, 13.0, 1.10 },
				[7] = { 0.7, 0.150, 0.070, 0.100, 0.080, 0.60, 11.0, 1.00 },
			},
		},
		engine =
		{
			typeng                = 3, -- turboprop
			Nmg                   = 64,
			MinRUD                = 0,
			MaxRUD                = 1,
			MaksRUD               = 1,
			ForsRUD               = 1,
			hMaxEng               = 8.7,
			dcx_eng               = 0.015,
			cemax                 = 0.70,
			cefor                 = 0.70,
			dpdh_m                = 3800,
			dpdh_f                = 3800,

			D_prop                = 2.36,

			Startup_Ignition_Time = 32.0,
			Shutdown_Duration     = 15.0,
			prop_locations        = { { 3.131, -0.082, 0.0 }, },
			prop_blades_count     = 3,
			prop_pitch_min        = 15.0,
			prop_pitch_max        = 87.0,
			prop_pitch_feather    = 87.0,
			Nominal_RPM           = 2200,

			table_data =
            {
                -- [Index] = {Mach, Dry Thrust (N), Afterburner Thrust (N)}
                [1] =   {0.0,   15000.0,   15000.0}, -- Tração estática gerada pelo torque
                [2] =   {0.1,   13970.0,   13970.0},
                [3] =   {0.2,   6985.0,    6985.0},
                [4] =   {0.3,   4656.7,    4656.7},
                [5] =   {0.4,   3492.5,    3492.5},
                [6] =   {0.5,   2794.0,    2794.0},
                [7] =   {0.6,   2328.3,    2328.3},
                [8] =   {0.7,   1995.7,    1995.7},
                [9] =   {0.8,   1746.2,    1746.2},
                -- Valores acima de Mach 0.6/0.7 não são reais para o voo nivelado do EMB-312, 
                -- mas são exigidos pela engine para cálculo em mergulhos em VNE.
            }, -- end of table_data
		},
	},
	sounderName               = "Aircraft/Planes/AT-27",
}
add_aircraft(A27TFM)
