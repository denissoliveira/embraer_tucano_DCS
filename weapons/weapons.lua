AIM9_RACK_ST = {
		"{AIM9_SINGLE_RACK}",
		"{AIM9E_SINGLE_RACK}",
		"{AIM9L_SINGLE_RACK}",
		"{AIM9P_SINGLE_RACK}",
		"{AIM9M_SINGLE_RACK}",
		"{AIM-9B}",
		"{AIM-9J}",
		"{AIM-9P5}",
		"{AIM-9P3}",
		"{9BFD8C90-F7AE-4e90-833B-BFD0CED0E536}",
		"CATM-9M",
	}

BOMBAS_LEVES_ST = {
		"{MK-81SE}",
		"{Mk82AIR}",
		"{Mk82SNAKEYE}",
		"{ADD3FAE1-EBF6-4EF9-8EFC-B36B5DDF1E6B}", -- Mk-20 Rockeye
		"{90321C8E-7ED1-47D4-A160-E074D5ABD902}", -- Mk-81
		"{BCE4E030-38E9-423E-98ED-24BE3DA87C32}", -- Mk-82
		"{Mk82SNAKEYE}", 						  -- MK82SE
		"{00F5DAC4-0466-4122-998F-B1A298E34113}", -- M-117
		"{DB769D48-67D7-42ED-A2BE-108D566C8B1E}", -- GBU12
		"{5335D97A-35A5-4643-9D9B-026C75961E52}", -- CBU-97
		"{CAE48299-A294-4bad-8EE6-89EFC5DCDF00}", -- ILLUMINATION POD --
	}

ROCKET_LEVES_ST = {

		"{A021F29D-18AB-4d3e-985C-FC9C60E35E9E}", -- LAU-68 Hydra M151 HE
		"{4F977A2A-CD25-44df-90EF-164BFA2AE72F}",-- LAU-68 Hydra M156 WP
		"{174C6E6D-0C3D-42ff-BCB3-0853CB371F5C}",-- LAU-68 Hydra Mk5 HEAT
		"{647C5F26-BDD1-41e6-A371-8DE1E4CC0E94}",-- LAU-68 Hydra PI
		"{0877B74B-5A00-4e61-BA8A-A56450BA9E27}",-- LAU-68 Hydra Practice Smoke
		"{FC85D2ED-501A-48ce-9863-49D468DDD5FC}",-- LAU-68 Hydra Mk1 Practice
		"{65396399-9F5C-4ec3-A7D2-5A8F4C1D90C4}", -- LAU-68 Hydra Mk61 Practice
		"{1F7136CB-8120-4e77-B97B-945FF01FB67C}",  -- LAU-68 Hydra WTU-1/B Practice

		"LAU3_WP61", -- LAU-3 Hydra
		"LAU3_WP1B", -- LAU-3 Hydra
		"LAU3_HE5", -- LAU-3 Hydra
		"LAU3_WP156", -- LAU-3 Hydra
		"LAU3_HE151", -- LAU-3 Hydra

		"{FD90A1DC-9147-49FA-BF56-CB83EF0BD32B}", -- LAU-61 - 19
	}

RACK_LIMPO_ST = {
    { CLSID = "<CLEAN>", arg_value = 1 },
}

TANQUE_LATERAL_ST = {
    "{A-29B TANK}",
	"{A-29B_TANK}",
}

TANQUE_CENTRAL_ST = {
    "{a-29b_tank_c}",
    "{A-29B TANK}",
}

SMOKE_POD_ST = {
    {CLSID = "{SMOKE-WHITE-A29B}",		    arg_value = 0.2}, -- Smoke pod
    {CLSID = "{SMOKE-RED-A29B}",		    arg_value = 0.2}, -- Smoke pod
    {CLSID = "{SMOKE-GREEN-A29B}",		    arg_value = 0.2}, -- Smoke pod
    {CLSID = "{SMOKE-BLACK-A29B}",		    arg_value = 0.2}, -- Smoke pod
    {CLSID = "{SMOKE-ORANGE-A29B}",		    arg_value = 0.2}, -- Smoke pod
    {CLSID = "{SMOKE-YELLOW-A29B}",		    arg_value = 0.2}, -- Smoke pod
}

function montarRackList(...)
    local t = {}
    for _, lista in ipairs({...}) do
    -- se vier algo que não seja tabela, ignora
    if type(lista) == "table" then
        for _, item in ipairs(lista) do
            -- CASO 1: item é string → CLSID simples
            if type(item) == "string" then
                t[#t+1] = { CLSID = item }

            -- CASO 2: item já é tabela → CLSID + args
            elseif type(item) == "table" then
                local entry = {}
                for k, v in pairs(item) do
                    entry[k] = v
                end
                t[#t+1] = entry
                end
            end
        end
    end

    return t
end