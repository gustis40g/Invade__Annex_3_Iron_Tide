// Main -> Invade & Annex
MENU(InA) = [
    ["Invade &amp; Annex", true],
    ["Main AO",         [0], USERMENU(InA_MainAO),  -5, [["expression", ""]], "1", "1"],
    ["Side mission",    [0], USERMENU(InA_Side),    -5, [["expression", ""]], "1", "1"],
    ["Prio mission",    [0], USERMENU(InA_Prio),    -5, [["expression", ""]], "1", "1"],
    ["Spawn FOBs",      [0], USERMENU(InA_FOBs),    -5, [["expression", ""]], "1", "1"],
    ["Other",           [0], USERMENU(InA_Other),   -5, [["expression", ""]], "1", "1"]
];

//diag_log text format ["%1 :: %2", QMENU(InA), MENU(InA)];

// Main -> Invade & Annex -> Main AO
MENU(InA_MainAO) = [
    ["Main AO", true],
    ["End SubObj",      [0], "", -5, [["expression", "['InA_Event_MainAO_EndSubObj'] remoteExec ['AW_fnc_eventTrigger', 2]"]], "1", "1"],
    ["Stop Main AO",   [0], "", -5, [["expression", "['MAIN'] remoteExec ['AW_fnc_zeusToolsStopMission', 2]"]], "1", "1"],
    ["Start Main AO",  [0], "", -5, [["expression", "['MAIN'] remoteExec ['AW_fnc_zeusToolsStartMission', 2]"]], "1", "1"],
    ["Select next AO",  [0], "", -5, [["expression", "['NextAO_Dialog'] spawn AW_fnc_zeusTools_DlgOpen"]], "1", "1"]
];


// Main -> Invade & Annex -> Side mission
MENU(InA_Side) = [
    ["Side mission", true],
    ["End current Side",    [0], "", -5, [["expression", "['InA_Event_Sidemission_End'] remoteExec ['AW_fnc_eventTrigger', 2]"]], "", ""],
    ["Stop Side thread",    [0], "", -5, [["expression", "['SIDE'] remoteExec ['AW_fnc_zeusToolsStopMission', 2]"]], "1", ""],
    ["Start Side thread",   [0], "", -5, [["expression", "['SIDE'] remoteExec ['AW_fnc_zeusToolsStartMission', 2]"]], "1", ""]
];


// Main -> Invade & Annex -> Prio mission
MENU(InA_Prio) = [
    ["Prio mission", true],
    ["End current Prio",    [0], "", -5, [["expression", "['InA_Event_Priomission_End'] remoteExec ['AW_fnc_eventTrigger', 2]"]], "1", "1"],
    ["Stop Prio thread",    [0], "", -5, [["expression", "['PRIO'] remoteExec ['AW_fnc_zeusToolsStopMission', 2]"]], "1", ""],
    ["Start Prio thread",   [0], "", -5, [["expression", "['PRIO'] remoteExec ['AW_fnc_zeusToolsStartMission', 2]"]], "1", ""]
];


// Main -> Invade & Annex -> <worldName> FOBs
MENU(InA_FOBs) = [
    [(format ["%1 FOBs", worldName]), true]
];

private _fobList = [];
private _fobs = ("isClass (_x >> 'Base')" configClasses (missionConfigFile >> worldName >> "AOs"));

{
    private _fobName = (getTextRaw (_x >> "nameAlt"));
    private _aoNome = (configName _x);

    _fobList pushBack [_fobName, _aoNome];
} forEach _fobs;

{
    _x params ["_fob", "_zone"];

    if !(_zone in InA_Client_controlledZones) then {
        MENU(InA_FOBs) pushBack [_fob, [0], "", -5, [["expression", (format ["['%1'] remoteExec ['AW_fnc_BaseManager', 2]", _zone])]], "1", "1"];
    };
} forEach _fobList;

if ((count MENU(InA_FOBs)) == 1) then {
    MENU(InA_FOBs) pushBack ["No more FOBs to spawn", [0], "", -2, [["expression", ""]], "1", "0"];
};


// Main -> Invade & Annex -> Other
MENU(InA_Other) = [
    ["I&amp;A Other", true],
    ["Stop all missions",                   [0], "", -5, [["expression", "['ALL'] remoteExec ['AW_fnc_zeusToolsStopMission', 2]"]], "1", "1"],
    ["Stop all missions",                   [0], "", -5, [["expression", "['ALL'] remoteExec ['AW_fnc_zeusToolsStartMission', 2]"]], "1", "1"]
];
