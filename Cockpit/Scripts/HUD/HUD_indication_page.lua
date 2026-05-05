dofile(LockOn_Options.script_path.."HUD/HUD_definitions.lua")
dofile(LockOn_Options.common_script_path .."elements_defs.lua")




--[[
-- alignment options:
--"RightBottom"
--"LeftTop"
--"RightTop"
--"LeftCenter"
--"RightCenter"
--"CenterBottom"
--"CenterTop"
--"CenterCenter"
--"LeftBottom"

========================================================================================================================================

--GUN_PIPPER.element_params 	= {"param_nr0","param_nr1","param_nr2"}

-- {"change_color_when_parameter_equal_to_number", param_nr, number, red, green, blue}
-- {"text_using_parameter", param_nr, format_nr}
-- {"move_left_right_using_parameter", param_nr, gain}
-- {"move_up_down_using_parameter", param_nr, gain}
-- {"opacity_using_parameter", param_nr}
-- {"rotate_using_parameter", param_nr, gain}
-- {"compare_parameters", param1_nr, param2_nr} -- if param1 == param2 then visible
-- {"parameter_in_range", param_nr, greaterthanvalue, lessthanvalue} -- if greaterthanvalue < param < lessthanvalue then visible
-- {"parameter_compare_with_number", param_nr, number} -- if param == number then visible
-- {"draw_argument_in_range", arg_nr, greaterthanvalue, lessthanvalue} -- if greaterthanvalue < arg < lessthanvalue then visible
-- {"line_object_set_point_using_parameters", point_nr, param_x, param_y, gain_x, gain_y} -- applies to ceSimpleLineObject at least


--]]

--local sensor_data 				= get_base_data() ---it is always a good idea to get_base_data :-)
-- this might not work since get_base_data() has to be updated every frame in a function update(). see hud device
 

----------Creation of parent-Element to "slave" the Gunpipper to-----------------------------------
local HUD_BASE 					= CreateElement "ceSimple"
HUD_BASE.name  					= create_guid_string()
HUD_BASE.init_pos				= {0.0, -0.0, 0.0}									--{0, -1.345,0}
--HUD_BASE.element_params     = {"MAINPOWER"}             
--HUD_BASE.controllers        = {{"parameter_in_range" ,0,0.9,1.1} }
AddHudElement(HUD_BASE)

-----------Finally, the Gunpipper built through the function/s in HUD_definitions.lua-----------------------------------------------------------
GUN_PIPPER 								= create_HUD_texture(HUD_GUNPIPPER_TEXT, 0,0,1024,1024, 40.0) -- Alte Werte für SetScale(Meters): create_HUD_texture(HUD_GUNPIPPER_TEXT, 0,0,1024,1024, 0.022)
GUN_PIPPER.name							= create_guid_string()
GUN_PIPPER.init_pos						= {0.0, 4, 0.0} -- "{0.0, -0.005, 0.0}" passt gut :-) war zuvor {0.0, 0.0, 0.0} sollte aber {-links/+rechts, -runter/+hoch, +vor/-zurück}
GUN_PIPPER.parent_element				= HUD_BASE.name --mal auskommentiert
--											Param #0,        Param #1
GUN_PIPPER.element_params 				= {"GUNPIPPER_SIDE","GUNPIPPER_UPDOWN", "SYS_HUD_BRIGHTNESS"}
--									  								Param #, Gain							Param #, Gain // Gain von 0,1 zu 1 wegen auto Gunpipper Test
GUN_PIPPER.controllers    				= {{"move_left_right_using_parameter", 0, 1.0}, {"move_up_down_using_parameter", 1, 1.0}, {"parameter_in_range", 2, 0, 2}}
AddHudElement(GUN_PIPPER)
---------------------------

GUN_PIPPER_LOCK 						= create_HUD_texture(HUD_GUNPIPPER_T_LOCK, 0,0,1024,1024, 40.0) -- Alte Werte für SetScale(Meters): create_HUD_texture(HUD_GUNPIPPER_TEXT, 0,0,1024,1024, 0.022)
GUN_PIPPER_LOCK.name					= create_guid_string()
GUN_PIPPER_LOCK.init_pos				= {0.0, 4, 0.0} -- "{0.0, -0.005, 0.0}" passt gut :-) war zuvor {0.0, 0.0, 0.0} sollte aber {-links/+rechts, -runter/+hoch, +vor/-zurück}
GUN_PIPPER_LOCK.parent_element			= HUD_BASE.name --mal auskommentiert
--											Param #0,        Param #1
GUN_PIPPER_LOCK.element_params 			= {"GUNPIPPER_SIDE","GUNPIPPER_UPDOWN", "MISSILE_LOCK"}
--									  								Param #, Gain							Param #, Gain // Gain von 0,1 zu 1 wegen auto Gunpipper Test
GUN_PIPPER_LOCK.controllers   	 		= {{"move_left_right_using_parameter", 0, 1.0}, {"move_up_down_using_parameter", 1, 1.0}, {"parameter_in_range", 2, 0, 2}}
AddHudElement(GUN_PIPPER_LOCK)
----------------Now to some Fonts----------------------------------------------------------------------------------------------------------------
--local Station_One_HUD_Indicator					= CreateElement "ceStringPoly"
--Station_One_HUD_Indicator.name 					= create_guid_string()
--Station_One_HUD_Indicator.parent_element		= HUD_BASE.name
--Station_One_HUD_Indicator.material				= fonts["PeeJottFont_Green"]
--Station_One_HUD_Indicator.init_pos 				= {-90.0, -200.0, -0.0}
--Station_One_HUD_Indicator.alignment 			= "CenterCenter"
--Station_One_HUD_Indicator.stringdefs 			= HUD_strdefs_digit
--Station_One_HUD_Indicator.formats 				= {"%0.0f"}--{"%0.2f","%s"}
--Station_One_HUD_Indicator.element_params 		= {"WEP_ON_PYLON_ONE","SYS_HUD_BRIGHTNESS"}
--Station_One_HUD_Indicator.controllers 			= {{"text_using_parameter",0,0},{"parameter_in_range" ,0, 0, 3},{"opacity_using_parameter", 1}}
--AddHudElement(Station_One_HUD_Indicator)

local NAV_Indicator 		  		= add_text_hud("NAV MODE", -60.0, -220.0, HUD_BASE, "PeeJottFont_Green", HUD_strdefs_text, "CenterCenter")
NAV_Indicator.element_params  		= {"NAV_MODE"}
NAV_Indicator.controllers     		= {{"parameter_in_range", 0, 0, 2} }

local AtoG_Indicator 		  		= add_text_hud("AG MODE", -60.0, -220.0, HUD_BASE, "PeeJottFont_Green", HUD_strdefs_text, "CenterCenter")
AtoG_Indicator.element_params  		= {"AG_MODE"}
AtoG_Indicator.controllers     		= {{"parameter_in_range", 0, 0, 2} }

local AtoG_Indicator 		  		= add_text_hud("AA MODE", -60.0, -220.0, HUD_BASE, "PeeJottFont_Green", HUD_strdefs_text, "CenterCenter")
AtoG_Indicator.element_params  		= {"AA_MODE"}
AtoG_Indicator.controllers     		= {{"parameter_in_range", 0, 0, 2} }

local Gunpipper_deflection_def					= add_text_hud("DEF", 30.0, -220.0, HUD_BASE, "PeeJottFont_Green", HUD_strdefs_text, "CenterCenter")
Gunpipper_deflection_def.element_params  		= {"GUNP_DEF_TO_RANGE"}
Gunpipper_deflection_def.controllers     		= {{"parameter_in_range", 0, -1, 1},  }

local Gunpipper_deflection_nr			= CreateElement "ceStringPoly"
Gunpipper_deflection_nr.name			= create_guid_string()
Gunpipper_deflection_nr.parent_element	= HUD_BASE.name
Gunpipper_deflection_nr.material		= fonts["PeeJottFont_Green"]
Gunpipper_deflection_nr.init_pos 		= {85.0, -220.0, -0.0}
Gunpipper_deflection_nr.alignment 		= "CenterCenter"
Gunpipper_deflection_nr.stringdefs 		= HUD_strdefs_text
Gunpipper_deflection_nr.formats 		= {"%0.3f"}--{"%0.2f","%s"}
Gunpipper_deflection_nr.element_params 	= {"GUNPIPPER_DEFLECTION", "GUNP_DEF_TO_RANGE", "SYS_HUD_BRIGHTNESS"}
Gunpipper_deflection_nr.controllers 	= {{"text_using_parameter",0, 0},{"parameter_in_range" ,1, -1, 1}, {"parameter_in_range", 2, 0, 2}}
AddHudElement(Gunpipper_deflection_nr)

local Gunpipper_range_def				= add_text_hud("RANGE", 30.0, -220.0, HUD_BASE, "PeeJottFont_Green", HUD_strdefs_text, "CenterCenter")
Gunpipper_range_def.element_params	  	= {"GUNP_DEF_TO_RANGE"}
Gunpipper_range_def.controllers   	  	= {{"parameter_in_range", 0, 0, 2},  }

local Gunpipper_range_nr				= CreateElement "ceStringPoly"
Gunpipper_range_nr.name					= create_guid_string()
Gunpipper_range_nr.parent_element		= HUD_BASE.name
Gunpipper_range_nr.material				= fonts["PeeJottFont_Green"]
Gunpipper_range_nr.init_pos 			= {85.0, -220.0, -0.0}
Gunpipper_range_nr.alignment 			= "CenterCenter"
Gunpipper_range_nr.stringdefs 			= HUD_strdefs_text
Gunpipper_range_nr.formats 				= {"%0.0f"}--{"%04d"}--{"%0.2f","%s"}
Gunpipper_range_nr.element_params 		= {"MAN_GP_TARGET_RANGE", "GUNP_DEF_TO_RANGE", "SYS_HUD_BRIGHTNESS"}
Gunpipper_range_nr.controllers 			= {{"text_using_parameter",0, 0},{"parameter_in_range" ,1, 0, 2}, {"parameter_in_range", 2, 0, 2}}
AddHudElement(Gunpipper_range_nr)



local station_one						= add_text_hud("1", -90.0, -195.0, HUD_BASE, "PeeJottFont_Green", HUD_strdefs_text, "CenterCenter")
station_one.element_params				= {"STATION_ONE"}
station_one.controllers					= {{"parameter_in_range", 0, 0, 3} }

local station_one_sel					= add_text_hud("O", -90, -195.0, HUD_BASE, "PeeJottFont_Green", HUD_strdefs_big, "CenterCenter")
station_one_sel.element_params			= {"STATION_ONE"}
station_one_sel.controllers				= {{"parameter_in_range", 0, 1, 3} }

local station_two						= add_text_hud("2", -70.0, -195.0, HUD_BASE, "PeeJottFont_Green", HUD_strdefs_text, "CenterCenter")
station_two.element_params				= {"STATION_TWO"}
station_two.controllers					= {{"parameter_in_range", 0, 0, 3} }

local station_two_sel					= add_text_hud("O", -70, -195.0, HUD_BASE, "PeeJottFont_Green", HUD_strdefs_big, "CenterCenter")
station_two_sel.element_params			= {"STATION_TWO"}
station_two_sel.controllers				= {{"parameter_in_range", 0, 1, 3} }

local station_three						= add_text_hud("3", -50, -195.0, HUD_BASE, "PeeJottFont_Green", HUD_strdefs_text, "CenterCenter")
station_three.element_params			= {"STATION_THREE"}
station_three.controllers				= {{"parameter_in_range", 0, 0, 3} }

local station_three_sel					= add_text_hud("O", -50, -195.0, HUD_BASE, "PeeJottFont_Green", HUD_strdefs_big, "CenterCenter")
station_three_sel.element_params		= {"STATION_THREE"}
station_three_sel.controllers			= {{"parameter_in_range", 0, 1, 3} }

local station_four						= add_text_hud("4", 50.0, -195.0, HUD_BASE, "PeeJottFont_Green", HUD_strdefs_text, "CenterCenter")
station_four.element_params				= {"STATION_FOUR"}
station_four.controllers				= {{"parameter_in_range", 0, 0, 3} }

local station_four_sel					= add_text_hud("O", 50, -195.0, HUD_BASE, "PeeJottFont_Green", HUD_strdefs_big, "CenterCenter")
station_four_sel.element_params			= {"STATION_FOUR"}
station_four_sel.controllers			= {{"parameter_in_range", 0, 1, 3} }

local station_five						= add_text_hud("5", 70.0, -195.0, HUD_BASE, "PeeJottFont_Green", HUD_strdefs_text, "CenterCenter")
station_five.element_params				= {"STATION_FIVE"}
station_five.controllers				= {{"parameter_in_range", 0, 0, 3} }

local station_five_sel					= add_text_hud("O", 70, -195.0, HUD_BASE, "PeeJottFont_Green", HUD_strdefs_big, "CenterCenter")
station_five_sel.element_params			= {"STATION_FIVE"}
station_five_sel.controllers			= {{"parameter_in_range", 0, 1, 3} }

local station_six						= add_text_hud("6", 90.0, -195.0, HUD_BASE, "PeeJottFont_Green", HUD_strdefs_text, "CenterCenter")
station_six.element_params				= {"STATION_SIX"}
station_six.controllers					= {{"parameter_in_range", 0, 0, 3} }

local station_six_sel					= add_text_hud("O", 90, -195.0, HUD_BASE, "PeeJottFont_Green", HUD_strdefs_big, "CenterCenter")
station_six_sel.element_params			= {"STATION_SIX"}
station_six_sel.controllers				= {{"parameter_in_range", 0, 1, 3} }

local pylon_ind							= add_text_hud("PYLONS", 0, -195.0, HUD_BASE, "PeeJottFont_Green", HUD_strdefs_text, "CenterCenter")
pylon_ind.element_params				= {"SYS_HUD_BRIGHTNESS"}
pylon_ind.controllers					= {{"parameter_in_range", 0, 0, 2} }