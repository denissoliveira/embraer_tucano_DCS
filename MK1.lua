local SHORTST = 'Shorts-Tucano-T1'

mount_vfs_model_path(current_mod_path .. "/Shapes")
mount_vfs_texture_path(current_mod_path .. "/Textures")
mount_vfs_liveries_path (current_mod_path .. "/Liveries")
mount_vfs_sound_path(current_mod_path .. "/Sounds")

SHORTSTFM =  {
    Name                =   SHORTST,
    DisplayName         = _('Shorts Tucano T.Mk1'),
    HumanCockpit        = true,
    HumanCockpitPath    = current_mod_path..'/Cockpit/',
    Picture             = current_mod_path..'/ImagesGui/ShortsT1.png',
    Rate                = 40,
    Shape               = SHORTST,
    WorldID             =  WSTYPE_PLACEHOLDER, 
    livery_entry        = SHORTST,

    propellorShapeType  = "3ARG_PROC_BLUR",
    propellorShapeName  = "EMB312_blade.FBX",
    propellorShapeBlurX = 0.6,

    shape_table_data    = 
    {
        {
            file     = SHORTST;
            life     = 18;
            vis      = 3;
            desrt    = 'Fighter-2-crush';
            fire     = { 300, 2};
            username = SHORTST;
            index    =  WSTYPE_PLACEHOLDER;
            classname       = "lLandPlane";
            positioning     = "BYNORMAL";
            drawonmap       = true;
        },
    },

    net_animation = { 551,552,553,554,200,201,202,203,204,205,206,207,208,209,140,141,142,900,901,99,400,401,402,38, },
    mapclasskey         = "P0091000025",
    attribute           = {wsType_Air, wsType_Airplane, wsType_Fighter, WSTYPE_PLACEHOLDER ,"Battleplanes",},
    Categories          = {"{78EFB7A2-FD52-4b57-A6A6-3BF0E1D6555F}", "Interceptor",},   

    -- Dados Físicos Shorts Tucano (Garrett TPE331)
    M_empty                     = 2017, -- kg (Mais pesado que o AT-27)
    M_nominal                   = 2700, -- kg 
    M_max                       = 3275, -- kg (MTOW RAF)
    M_fuel_max                  = 415,  -- kg 

    H_max                       = 10515, -- m (Teto maior: 34,500 ft)

    average_fuel_consumption    = 0.075, -- kg/s (O Garrett queima mais combustível)

    CAS_min                     = 45, 
    V_opt                       = 113, -- m/s (~407km/h)
    V_take_off                  = 40,  -- m/s (Pesado, precisa de mais velocidade)
    V_land                      = 36,  -- m/s 
    V_max_sea_level             = 141, -- m/s (~507km/h, bem mais rápido)
    V_max_h                     = 135, -- m/s
    Vy_max                      = 17.8,-- m/s (Taxa de subida absurda comparado ao AT-27: 3510 ft/min)
    Mach_max                    = 0.50, 
    Ny_min                      = -3.0, 
    Ny_max                      = 7.0, -- Estrutura ligeiramente reforçada 
    Ny_max_e                    = 7.0,  
    AOA_take_off                = 0.14, 
    bank_angle_max              = 60, 

    has_afteburner              = false, 
    has_speedbrake              = true, -- O Shorts T1 possui aerofreio ventral.

    nose_gear_pos               = {2.976, -1.5, 0.0},
    main_gear_pos               = {-0.122, -1.61, 1.816},
    tand_gear_max               = 1,
    nose_gear_wheel_diameter    = 0.359,
    main_gear_wheel_diameter    = 0.579,

    wing_area                   = 19.4,  -- m2
    wing_span                   = 11.28, -- m (Asa ligeiramente diferente nas pontas)
    wing_type                   = 0,
    height                      = 3.40,  -- m 
    length                      = 9.86,  -- m 

    wing_tip_pos                = { 0.038, -0.032, 5.45 },

    range                       = 1665, -- km (Alcance menor por causa do motor mais gastão)

    flaps_maneuver              = 0.5, 
    RCS                         = 2.5, 
    IR_emission_coeff           = 0.09, 
    IR_emission_coeff_ab        = 0.0, 

    brakeshute_name             = 0, 
    is_tanker                   = false, 
    air_refuel_receptacle_pos   = {0.0, 0.0, 0.0},

    engines_count               = 1, 
    engines_nozzles = 
    {
        [1] = 
        {
            pos         =  {2.6,-0.2,0.6}, 
            elevation = 0,
            diameter = 0.3, 
            exhaust_length_ab = 0,
            exhaust_length_ab_K = 0,
            smokiness_level = 0.005,
        },
    },

    crew_size    = 2,
    crew_members = 
    {
        [1] = 
        {
            ejection_through_canopy = true,
            ejection_seat_name = "pilot_f15_00_seat",
            pilot_name  = "pilot_f15_00",
            drop_canopy_name = 0,
            drop_parachute_name =  "pilot_f15_parachute",           
            pos =  {0.5, 0.1, 0.1},
            canopy_pos = {2,0.5,0},
            ejection_play_arg = 50,
            pilot_body_arg = 50,
            can_be_playable = true,
            canopy_args = {38,0.8},
            ejection_added_speed = {-4.5,15,0.4},
            ejection_order       = 2,           
            role                 = "pilot",
            role_display_name    = _("Pilot"),  
            g_suit             =  1,
            bailout_arg = -1,
        },
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
            ejection_play_arg = 50,         
            can_be_playable = false,
            canopy_args = {38,0.8},
            pilot_body_arg      = 472,
            ejection_order      = 1,            
            role                 = "instructor",
            role_display_name    = _("Instructor pilot"),
            g_suit             =  1,
            bailout_arg = -1,
        },
    },

    Tasks = 
    {
        aircraft_task(GroundAttack), aircraft_task(CAS), aircraft_task(AFAC), aircraft_task(Escort),
    },  
    DefaultTask = aircraft_task(CAS),
    
    SFM_Data = 
    {
        aerodynamics = -- Mesma base, mas ajustada para o peso maior
        {
            Cy0        = 0.10,
            Mzalfa     = 3.0,
            Mzalfadt   = 0.6,
            kjx        = 2.2, -- Inércia rolagem maior (peso)
            kjz        = 0.001,
            Czbe       = -0.012,
            cx_gear    = 0.050,
            cx_flap    = 0.12,
            cy_flap    = 0.50,
            cx_brk     = 0.08,

            table_data  = 
            {   
                [1] ={ 0.0,  0.055, 0.080, 0.050, 0.020, 0.20, 17.0, 1.60 },
                [2] ={ 0.2,  0.055, 0.080, 0.050, 0.020, 0.60, 17.0, 1.40 },
                [3] ={ 0.3,  0.060, 0.082, 0.055, 0.025, 0.80, 16.0, 1.35 },
                [4] ={ 0.4,  0.070, 0.080, 0.060, 0.030, 0.90, 15.0, 1.30 },
                [5] ={ 0.5,  0.085, 0.078, 0.070, 0.040, 0.85, 14.0, 1.20 },
                [6] ={ 0.6,  0.110, 0.075, 0.085, 0.060, 0.75, 13.0, 1.10 },
                [7] ={ 0.7,  0.150, 0.070, 0.100, 0.080, 0.60, 11.0, 1.00 },
            },
        },
        engine = 
        {
            typeng                  = 3, -- turboprop
            Nmg                     = 64, 
            MinRUD                  = 0, 
            MaxRUD                  = 1, 
            MaksRUD                 = 1, 
            ForsRUD                 = 1, 
            hMaxEng                 = 10.5, -- Limite do Garrett
            dcx_eng                 = 0.015, 
            cemax                   = 0.70, 
            cefor                   = 0.70, 
            dpdh_m                  = 3800, 
            dpdh_f                  = 3800, 

            D_prop                  = 2.39, -- Hélice de 4 pás

            Startup_Ignition_Time   = 8.0,
            Shutdown_Duration       = 9.8,
            prop_locations          = {{3.131, -0.082, 0.0},},
            prop_blades_count       = 4, -- Hélice de quatro pás
            prop_pitch_min          = 15.0,
            prop_pitch_max          = 87.0,
            prop_pitch_feather      = 87.0,
            Nominal_RPM             = 2000, -- Garrett trabalha com RPM constante

            table_data =
            { 
                -- Shorts T1: 1100 SHP max = 820.000 Watts
                { 0.00, 820000 },
                { 0.10, 810000 },
                { 0.15, 800000 },
                { 0.20, 785000 },
                { 0.25, 750000 },
                { 0.30, 710000 },
                { 0.35, 680000 },
                { 0.40, 600000 },
                { 0.45, 480000 },
                { 0.50, 300000 },
            },
        },
    },
    sounderName = "Aircraft/Planes/AT-27",
}
add_aircraft(SHORTSTFM)