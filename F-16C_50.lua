-- F-16C Export

ExportScript.FoundDCSModule = true
ExportScript.Version.F16C = "1.2.1"

ExportScript.ConfigEveryFrameArguments = 
{
	--[[
	every frames arguments
	based of "mainpanel_init.lua"
	Example (http://www.lua.org/manual/5.1/manual.html#pdf-string.format)
	[DeviceID] = "Format"
	  [4] = "%.4f",  <- floating-point number with 4 digits after point
	 [19] = "%0.1f", <- floating-point number with 1 digit after point
	[129] = "%1d",   <- decimal number
	  [5] = "%.f",   <- floating point number rounded to a decimal number
	]]
}
ExportScript.ConfigArguments = 
{
	--[[
	arguments for export in low tick interval
	based on "clickabledata.lua"
	]]
	-- Avionics Power panel
	[715] = "%1d", --MMC Switch, MMC/OFF
	[716] = "%1d", --ST STA Switch, ST STA/OFF
	[717] = "%1d", --MFD Switch, MFD/OFF
	[718] = "%1d", --UFC Switch, UFC/OFF
	[720] = "%1d", --GPS Switch, GPS/OFF
	[721] = "%1d", --DL Switch, DL/OFF
	[722] = "%1d", --MAP Switch, MAP/OFF
	[719] = "%.1f", --INS Knob, OFF/STOR HDG/NORM/NAV/CAL/INFLT ALIGN/ATT
	[723] = "%.1f", --MIDS LVT Knob, ZERO/OFF/ON
	-- Sensor Power Control Panel
	[672] = "%1d", --FCR Switch, FCR/OFF
	[673] = "%1d", --RDR ALT Switch, RDR ALT/STBY/OFF
	[670] = "%1d", --LEFT HDPT Switch, ON/OFF
	[671] = "%1d", --RIGHT HDPT Switch, ON/OFF
	-- IFF Control Panel
	[540] = "%.1f", --IFF MASTER Knob, OFF/STBY/LOW/NORM/EMER
	[542] = "%1d", --C & I Knob, UFC/BACKUP
	[541] = "%.1f", --IFF M-4 CODE Switch, HOLD/ A/B /ZERO
	[543] = "%.1f", --IFF MODE 4 REPLY Switch, OUT/A/B
	[544] = "%1d", --IFF MODE 4 MONITOR Switch, OUT/AUDIO
	[553] = "%.1f", --IFF ENABLE Switch, M1/M3 /OFF/ M3/MS
	-- CMDS
	[375] = "%1d", --RWR 555 Switch, ON/OFF
	[374] = "%1d", --JMR Source Switch, ON/OFF
	[373] = "%1d", --MWS Source Switch, ON/OFF (no function)
	[371] = "%1d", --Jettison Switch, JETT/OFF
	[365] = "%1d", --O1 Expendable Category Switch, ON/OFF
	[366] = "%1d", --O2 Expendable Category Switch, ON/OFF
	[367] = "%1d", --CH Expendable Category Switch, ON/OFF
	[368] = "%1d", --FL Expendable Category Switch, ON/OFF
	[377] = "%.1f", --PROGRAM Knob, BIT/1/2/3/4
	[378] = "%.1f" --MODE Knob, OFF/STBY/MAN/SEMI/AUTO/BYP
	-- RWR
	--[[
	elements["PTR-CMSC-LVR-BRT-140"]	= default_axis_limited(_("RWR Intensity Knob - Rotate to adjust brightness"),	devices.RWR, rwr_commands.IntKnob,		140, 0, 0.1, NOT_UPDATABLE, NOT_RELATIVE, {0, 0.8})
	elements["PTR-CMSC-BTN-HNDOFF-141"]	= short_way_button(_("RWR Indicator Control HANDOFF Button"),					devices.RWR, rwr_commands.Handoff,		141)
	elements["PTR-CMSC-BTN-LNCH-143"]	= short_way_button(_("RWR Indicator Control LAUNCH Button"),					devices.RWR, rwr_commands.Launch,		143)
	elements["PTR-CMSC-BTN-MODE-145"]	= short_way_button(_("RWR Indicator Control MODE Button"),						devices.RWR, rwr_commands.Mode,			145)
	elements["PTR-CMSC-BTN-OBJ-147"]	= short_way_button(_("RWR Indicator Control UNKNOWN SHIP Button"),				devices.RWR, rwr_commands.UnknownShip,	147)
	elements["PTR-CMSC-BTN-STEST-149"]	= short_way_button(_("RWR Indicator Control SYS TEST Button"),					devices.RWR, rwr_commands.SysTest,		149)
	elements["PTR-CMSC-BTN-T-151"]		= short_way_button(_("RWR Indicator Control T Button"),							devices.RWR, rwr_commands.TgtSep,		151)
	elements["PTR-TWAP-LVR-DIM-404"]	= default_axis_limited(_("RWR Indicator Control DIM Knob - Rotate to adjust brightness"),	devices.RWR, rwr_commands.BrtKnob,		404)
	elements["PTR-TWAP-BTN-SRCH-395"]	= short_way_button(_("RWR Indicator Control SEARCH Button"),								devices.RWR, rwr_commands.Search,		395)
	elements["PTR-TWAP-BTN-ACTPWR-397"]	= short_way_button(_("RWR Indicator Control ACT/PWR Button"),								devices.RWR, rwr_commands.ActPwr,		397)
	elements["PTR-TWAP-BTN-ALT-399"]	= short_way_button(_("RWR Indicator Control ALTITUDE Button"),								devices.RWR, rwr_commands.Altitude,		399)
	elements["PTR-TWAP-BTN-PWR-401"]	= default_2_position_tumb(_("RWR Indicator Control POWER Button"),							devices.RWR, rwr_commands.Power,		401)
	elements["PTR-TWAP-BTN-PWR-401"].sound    = {{SOUND_SW4_ON, SOUND_SW4_OFF}}
	elements["PTR-TWAP-BTN-PWR-401"].class_vr = {class_type.BTN_FIX}
	elements["PTR-TWAP-BTN-PWR-401"].side     = {{BOX_SIDE_Y_bottom}}
	]]--
}

-----------------------------
-- HIGH IMPORTANCE EXPORTS --
-- done every export event --
-----------------------------

-- Pointed to by ProcessIkarusDCSHighImportance
function ExportScript.ProcessIkarusDCSConfigHighImportance(mainPanelDevice)
	--[[
	every frame export to Ikarus
	Example from A-10C
	Get Radio Frequencies
	get data from device
	local lUHFRadio = GetDevice(54)
	ExportScript.Tools.SendData("ExportID", "Format")
	ExportScript.Tools.SendData(2000, string.format("%7.3f", lUHFRadio:get_frequency()/1000000)) -- <- special function for get frequency data
	ExportScript.Tools.SendData(2000, ExportScript.Tools.RoundFreqeuncy((UHF_RADIO:get_frequency()/1000000))) -- ExportScript.Tools.RoundFreqeuncy(frequency (MHz|KHz), format ("7.3"), PrefixZeros (false), LeastValue (0.025))
	]]
end

function ExportScript.ProcessDACConfigHighImportance(mainPanelDevice)
	--[[
	every frame export to DAC
	Example from A-10C
	Get Radio Frequencies
	get data from device
	local UHF_RADIO = GetDevice(54)
	ExportScript.Tools.SendDataDAC("ExportID", "Format")
	ExportScript.Tools.SendDataDAC("ExportID", "Format", HardwareConfigID)
	ExportScript.Tools.SendDataDAC("2000", string.format("%7.3f", UHF_RADIO:get_frequency()/1000000))
	ExportScript.Tools.SendDataDAC("2000", ExportScript.Tools.RoundFreqeuncy((UHF_RADIO:get_frequency()/1000000))) -- ExportScript.Tools.RoundFreqeuncy(frequency (MHz|KHz), format ("7.3"), PrefixZeros (false), LeastValue (0.025))
	]]
end

-----------------------------------------------------
-- LOW IMPORTANCE EXPORTS                          --
-- done every gExportLowTickInterval export events --
-----------------------------------------------------

-- Pointed to by ExportScript.ProcessIkarusDCSConfigLowImportance
function ExportScript.ProcessIkarusDCSConfigLowImportance(mainPanelDevice)
	--[[
	export in low tick interval to Ikarus
	Example from A-10C
	Get Radio Frequencies
	get data from device
	local lUHFRadio = GetDevice(54)
	ExportScript.Tools.SendData("ExportID", "Format")
	ExportScript.Tools.SendData(2000, string.format("%7.3f", lUHFRadio:get_frequency()/1000000)) -- <- special function for get frequency data
	ExportScript.Tools.SendData(2000, ExportScript.Tools.RoundFreqeuncy((UHF_RADIO:get_frequency()/1000000))) -- ExportScript.Tools.RoundFreqeuncy(frequency (MHz|KHz), format ("7.3"), PrefixZeros (false), LeastValue (0.025))
	]]
end

function ExportScript.ProcessDACConfigLowImportance(mainPanelDevice)
	--[[
	export in low tick interval to DAC
	Example from A-10C
	Get Radio Frequencies
	get data from device
	local UHF_RADIO = GetDevice(54)
	ExportScript.Tools.SendDataDAC("ExportID", "Format")
	ExportScript.Tools.SendDataDAC("ExportID", "Format", HardwareConfigID)
	ExportScript.Tools.SendDataDAC("2000", string.format("%7.3f", UHF_RADIO:get_frequency()/1000000))
	ExportScript.Tools.SendDataDAC("2000", ExportScript.Tools.RoundFreqeuncy((UHF_RADIO:get_frequency()/1000000))) -- ExportScript.Tools.RoundFreqeuncy(frequency (MHz|KHz), format ("7.3"), PrefixZeros (false), LeastValue (0.025))
	]]

	--=====================================================================================
	--[[
	ExportScript.Tools.WriteToLog('list_cockpit_params(): '..ExportScript.Tools.dump(list_cockpit_params()))
	ExportScript.Tools.WriteToLog('CMSP: '..ExportScript.Tools.dump(list_indication(7)))
	
	-- list_indication get tehe value of cockpit displays
	local ltmp1 = 0
	for ltmp2 = 0, 20, 1 do
		ltmp1 = list_indication(ltmp2)
		ExportScript.Tools.WriteToLog(ltmp2..': '..ExportScript.Tools.dump(ltmp1))
	end
	]]
--[[
	-- getmetatable get function name from devices
	local ltmp1 = 0
	for ltmp2 = 1, 70, 1 do
		ltmp1 = GetDevice(ltmp2)
		ExportScript.Tools.WriteToLog(ltmp2..': '..ExportScript.Tools.dump(ltmp1))
		ExportScript.Tools.WriteToLog(ltmp2..' (metatable): '..ExportScript.Tools.dump(getmetatable(ltmp1)))
	end
]]
end

-----------------------------
--     Custom functions    --
-----------------------------