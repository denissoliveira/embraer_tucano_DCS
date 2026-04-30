livery = {
	{"AT27BANO2",	DIFFUSE			,	"bano_lights", true};
	{"AT27BANO",	DIFFUSE			,	"at-27_bano", true};

	{"MascM",	DIFFUSE			,	"capmasks", true};
	{"MascM",	NORMAL_MAP			,	"capmasks_nm", true};

	{"Helmet_glass",	DIFFUSE			,	"cap_viseira", true};

	{"AT27",	DIFFUSE			,	"at-27_fuselage", true};
	{"AT27",	NORMAL_MAP			,	"at-27_fuselage_nm", true};
	
	{"CAP01",	DIFFUSE			,	"cappilot01", true};
	{"CAP01",	NORMAL_MAP			,	"cappilot01_nm", true};

	{"AT27_GLASS",	DIFFUSE			,	"at-27_glass", true};
	{"AT27_GLASS",	NORMAL_MAP			,	"AT-27_Glass_Nrm", true};

	{"Wing Right",	DIFFUSE			,	"at-27_parts", true};

	{"GALLET",	DIFFUSE			,	"gallet", true};
	{"GALLET",	NORMAL_MAP			,	"gallet_nm", true};

	{"CAP02",	DIFFUSE			,	"cappilot02", true};
	{"CAP02",	NORMAL_MAP			,	"cappilot02_nm", true};

	{"AT27SEAT",	DIFFUSE			,	"at-27_seat", true};
	{"AT27SEAT",	NORMAL_MAP			,	"at-27_seat_nm", true};

	{"GUENAU",	DIFFUSE			,	"gue_map", true};
	{"GUENAU",	NORMAL_MAP			,	"gue_map_nm", true};

	{"AT27_PILOT",	DIFFUSE			,	"pilot_al", true};
	{"AT27_PILOT",	NORMAL_MAP			,	"pilot_al_nm", true};

	{"AT27_PARTS",	DIFFUSE			,	"at-27_parts", true};
	{"AT27_PARTS",	NORMAL_MAP			,	"at-27_parts_nm", true};
}

name = "AT-27"
countries = {}
custom_args =
{
	[810] = 0, -- Pilot helmet
	[811] = 0, -- Helmet visor 0-close, 1-open
	[812] = 0, -- Front helmet visor 0-close, 1-open

	[820] = 0, -- Antennas
	[821] = 1, -- Down antenna
	[822] = 0, -- Down antenna
	[823] = 0, -- Top canopy antenna
	[824] = 1, -- Small antenna
	[825] = 0, -- Internal canopy support
	[826] = 0, -- 0: Tucano, 1: Tucano shorts
	[827] = 0, -- Air brake
}
