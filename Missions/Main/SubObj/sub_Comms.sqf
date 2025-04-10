/*
 * Author: Whigital
 *
 * Description: Spawns an Comms station and HQ bunker which calls in CAS
 * helis every so often. Get the access codes from the bunker, then enter
 * the transmission building and end the transmission.
 *
 */

params [["_factionHash", InA_EnemyFactionHash]];

private _commsPos = [(getMarkerPos InA_Server_currentAO), 200, InA_Server_MainAOSize, 6, 0, 0.2, 0, [], [0,0,0]] call BIS_fnc_findSafePos;
private _roughPos = [_commsPos, 200] call AW_fnc_getFuzzyPos;

private _guardTypes = [
    "#riflemen", "#machinegunners", "#marksmen",
    "#teamleaders", "#heavygunners"
];

private _commsObjs = [
    ["SatelliteAntenna_01_Small_Mounted_Sand_F",[-0.74292,-0.518066,1.37319],180],
    ["SatelliteAntenna_01_Mounted_Sand_F",[2.26514,-0.774902,1.048],180],

    ["Land_MapBoard_01_Wall_Altis_F",[-0.573242,4.1582,0.99449],0],

    ["Land_CampingTable_small_F",[-1.28687,0.278809,-0.097188],0],
    ["Land_CampingTable_F",[-2.14478,3.18604,0.0388479],90],

    ["Land_PortableCabinet_01_4drawers_sand_F",[-1.32959,0.311523,0.715818],214.749],
    ["Land_IPPhone_01_olive_F",[-2.04199,2.57178,0.854445],259.21],
    ["Land_PortableLight_single_F",[2.18677,3.83447,0.0388479],50.3083]
];

private _commsTrans = [
    ["Land_TTowerSmall_2_F",[-3.46216,1.47461,-0.69],131.565],
    ["Land_TBox_F",[-3.22705,-3.19385,-0.69],239.874],
    ["Land_TTowerSmall_1_F",[-4.16138,-0.544922,-0.69],148.085]
];

private _commsBarriers = [
    ["Land_HBarrier_3_F",[-5.40576,-4.375,-0.69],60.2341],
    ["Land_HBarrier_3_F",[6.55957,-1.28809,-0.69],77.9973],
    ["Land_HBarrier_3_F",[4.79199,3.81104,-0.69],60.2341],
    ["Land_HBarrier_3_F",[5.38184,-5.04297,-0.69],148.574],
    ["Land_HBarrier_3_F",[-2.70459,-7.0166,-0.69],9.77739],
    ["Land_HBarrier_3_F",[-0.0307617,5.58887,-0.69],358.195],
    ["Land_HBarrier_3_F",[-6.33618,-0.39502,-0.69],97.3006],
    ["Land_HBarrier_3_F",[-4.95288,3.55908,-0.69],305.76],
    ["Land_HBarrier_1_F",[1.56006,-7.06006,-0.69],258.214],

    ["CamoNet_OPFOR_big_F",[-0.206055,-0.229004,-0.69],356.562]
];

private _commsGuards = [
    ["C_scientist_F",[-1.00977,3.32764,0.0402865],266.705],
    ["O_Survivor_F",[4.0791,-1.77197,-0.688561],221.347],
    ["O_Survivor_F",[-0.572998,-5.11328,-0.688561],174.714],
    ["O_Survivor_F",[2.78735,-4.89258,-0.688561],153.321],
    ["O_Survivor_F",[1.81836,0.948242,-0.0957494],266.323],
    ["O_Survivor_F",[0.580566,3.47363,0.0402865],169.034],
    ["O_Survivor_F",[-1.76196,1.57715,-0.0957494],89.4999],
    ["O_Survivor_F",[-1.24243,-2.3042,-0.688561],122.761]
];


private _hqObjs = [
    ["OmniDirectionalAntenna_01_sand_F",[1.28491,0.191895,4.64633],312.425],
    ["SatelliteAntenna_01_Mounted_Sand_F",[-1.50977,4.10156,-1.00285],0],
    ["SatelliteAntenna_01_Small_Mounted_Sand_F",[-3.79834,-0.580566,2.06912],270],

    ["Land_CampingTable_small_F",[-0.724121,-0.0859375,1.45731],81.5501],
    ["Land_IPPhone_01_olive_F",[-0.637939,-0.328613,2.27032],243.769]
];

private _hqBarriers = [
    ["Land_HBarrier_5_F",[-4.25391,0.591797,-3.52196],89.5623],
    ["Land_HBarrier_3_F",[-1.25928,-5.19141,-3.52196],204.417],
    ["Land_HBarrier_3_F",[-3.56689,-3.28271,-3.52196],53.1941],
    ["Land_HBarrier_3_F",[4.29297,-0.65625,-3.52196],272.753],
    ["Land_HBarrier_3_F",[1.14331,-5.23438,-3.52196],156.563],
    ["Land_HBarrier_3_F",[3.51636,-3.52588,-3.52196],129.238],
    ["Land_HBarrier_3_F",[-2.42529,3.37158,-3.52196],359.366],
    ["Land_HBarrier_3_F",[4.23413,2.67236,-3.52196],267.121],
    ["Land_HBarrier_3_F",[1.47241,6.38916,-3.52196],357.147],
    ["Land_HBarrier_3_F",[0.0180664,4.37939,-3.52196],271.512]
];

private _hqGuards = [
    ["C_scientist_F",[0.323975,0.0537109,1.45875],199.572],
    ["O_Survivor_F",[2.35156,0.328125,1.45875],70.7494],
    ["O_Survivor_F",[-1.86084,-1.86035,1.46997],198.624],
    ["O_Survivor_F",[-2.42236,0.343262,1.45938],273.327],
    ["O_Survivor_F",[1.42261,-2.19727,-2.35505],294.069],
    ["O_Survivor_F",[1.97241,-1.96436,1.45875],137.965],
    ["O_Survivor_F",[-0.520508,1.48779,-3.43456],85.0303],
    ["O_Survivor_F",[1.60132,1.84766,-0.739902],202.458],
    ["O_Survivor_F",[-2.35815,2.02783,1.45946],115.942],
    ["O_Survivor_F",[1.5813,4.74658,-3.52052],82.671],
    ["O_Survivor_F",[2.72168,3.43555,-3.52052],350.453]
];


private _subObjs = [];
private _subUnits = [];

private _rndDir = (random 360);

// Comms: Spawn base object ....
private _commsOrg = createVehicle ["Land_Cargo_House_V3_F", [0, 0, 0], [], 0, "NONE"];
_commsOrg setDir _rndDir;
_commsOrg setPos _commsPos;
_commsOrg setVectorUp [0, 0, 1];
_commsOrg allowDamage false;

_subObjs pushBack _commsOrg;


// Comms: Spawn all other objects
{
    private _obj = [_commsOrg, _x, _rndDir] call AW_fnc_spawnRelative;
    _obj allowDamage false;
    _obj enableSimulationGlobal false;
    _subObjs pushBack _obj;
} forEach (_commsObjs + _commsTrans);


// Comms: Spawn H-Barriers
{
    private _obj = [_commsOrg, _x, _rndDir] call AW_fnc_spawnRelative;
    _obj allowDamage false;

    private _pos = (getPosATL _obj);
    _obj setPosATL [(_pos # 0), (_pos # 1), 0];

    _obj setVectorUp (surfaceNormal (getPosATL _obj));
    _subObjs pushBack _obj;
} forEach _commsBarriers;

// Comms: Spawn Guards ....
private _commsGroup = (createGroup InA_EnemyFactionSide);

{
    private _data = [_commsOrg, _x, _rndDir, true] call AW_fnc_spawnRelative;
    private _pos = (_data # 0);
    private _dir = (_data # 1);

    private _unitType = [(selectRandom _guardTypes), _factionHash] call AW_fnc_getUnitsFromHash;

    if ((_x # 0) == "C_scientist_F") then {
        _unitType = ["#officers", _factionHash] call AW_fnc_getUnitsFromHash;
    };

    private _unit = _commsGroup createUnit [_unitType, _pos, [], 0, "NONE"];

    _unit setDir _dir;
    _unit setPosATL _pos;

    _unit disableAI "PATH";
    _unit setUnitPos "UP";

    _subUnits pushBack _unit;
} forEach _commsGuards;

_commsGroup = [_commsGroup] call AW_fnc_changeGroupSide;
_commsGroup setGroupIdGlobal ["AO-SubObj-GuardsComms"];

[(units _commsGroup)] call derp_fnc_AISkill;
[(units _commsGroup)] call AW_fnc_addToAllCurators;

[_commsGroup, [[_commsOrg, _commsPos], {
    params ["_hq", "_pos"];

    waitUntil {
        sleep 1;
        (_hq in (_pos nearObjects [(typeOf _hq), 2]))
    };
}]] spawn AW_fnc_transferGroupHC;


private _commsLaptop = [_commsOrg, ["Land_MultiScreenComputer_01_olive_F",[-2.10303,3.50879,0.854445],285.958], _rndDir] call AW_fnc_spawnRelative;
_commsLaptop allowDamage false;
_commsLaptop setVariable ["codesAcquired", false, true];
_commsLaptop setVariable ["isTransmitting", true, true];

["InA_Event_TransmissionsShutdown", {
    params ["_event", "_transmitter"];

    if (!InA_MainAO_CommsHubTransmitting) exitWith {};

    _transmitter setVariable ["isTransmitting", false, true];
    InA_MainAO_CommsHubTransmitting = false;
}] call AW_fnc_eventRegister;

[
    _commsLaptop,
    "Shutdown transmissions",
    "\a3\ui_f\data\IGUI\Cfg\HoldActions\holdAction_search_ca.paa",
    "\a3\ui_f\data\IGUI\Cfg\HoldActions\holdAction_hack_ca.paa",
    "((_target distance _this) <= 2) && {(_target getVariable ['codesAcquired', false]) && {_target getVariable ['isTransmitting', false]}}",
    "((_target distance _this) <= 2) && {(_target getVariable ['codesAcquired', false]) && {_target getVariable ['isTransmitting', false]}}",
    {
        hint "Shutting down transmissions ....";
    },
    {},
    {
        params ["_target", "_caller", "_actionId", "_arguments"];

        ["InA_Event_TransmissionsShutdown", _target] remoteExec ["AW_fnc_eventTrigger", 2];
    },
    {},
    [],
    6,
    0,
    true,
    false
] remoteExec ["BIS_fnc_holdActionAdd", 0, true];

_subObjs pushBack _commsLaptop;

private _hqPos = [_commsPos, 50, 150, 6, 0, 0.2, 0, [], [0,0,0]] call BIS_fnc_findSafePos;

// HQ: Spawn base object ....
private _hqOrg = createVehicle ["Land_Bunker_01_tall_F", [0, 0, 0], [], 0, "NONE"];
private _relDir = (_hqPos getDir _commsPos);

_hqOrg setDir _relDir;
_hqOrg setPos _hqPos;
_hqOrg setVectorUp [0, 0, 1];
_hqOrg allowDamage false;

// HQ: Spawn all other objects
{
    private _obj = [_hqOrg, _x, _relDir] call AW_fnc_spawnRelative;
    _obj allowDamage false;
    _obj enableSimulationGlobal false;
    _subObjs pushBack _obj;
} forEach _hqObjs;


// HQ: Spawn H-Barriers
{
    private _obj = [_hqOrg, _x, _relDir] call AW_fnc_spawnRelative;
    _obj allowDamage false;

    private _pos = (getPosATL _obj);
    _obj setPosATL [(_pos # 0), (_pos # 1), 0];

    _obj setVectorUp (surfaceNormal (getPosATL _obj));
    _subObjs pushBack _obj;
} forEach _hqBarriers;

// HQ: Spawn Guards ....
private _hqGroup = (createGroup InA_EnemyFactionSide);

{
    private _data = [_hqOrg, _x, _relDir, true] call AW_fnc_spawnRelative;
    private _pos = (_data # 0);
    private _dir = (_data # 1);

    private _unitType = [(selectRandom _guardTypes), _factionHash] call AW_fnc_getUnitsFromHash;

    if ((_x # 0) == "C_scientist_F") then {
        _unitType = ["#officers", _factionHash] call AW_fnc_getUnitsFromHash;
    };

    private _unit = _hqGroup createUnit [_unitType, _pos, [], 0, "NONE"];

    _unit setDir _dir;
    _unit setPosATL _pos;

    _unit disableAI "PATH";
    _unit setUnitPos "UP";

    _subUnits pushBack _unit;
} forEach _hqGuards;

_hqGroup = [_hqGroup] call AW_fnc_changeGroupSide;
_hqGroup setGroupIdGlobal ["AO-SubObj-GuardsHQ"];

[(units _hqGroup)] call derp_fnc_AISkill;
[(units _hqGroup)] call AW_fnc_addToAllCurators;

[_hqGroup, [[_hqOrg, _hqPos], {
    params ["_hq", "_pos"];

    waitUntil {
        sleep 1;
        (_hq in (_pos nearObjects [(typeOf _hq), 2]))
    };
}]] spawn AW_fnc_transferGroupHC;


_hqLaptop = [_hqOrg, ["Land_Laptop_03_olive_F",[-0.72876,0.123047,2.27032],284.861], _relDir] call AW_fnc_spawnRelative;
_hqLaptop allowDamage false;
_hqLaptop setVariable ["codesAcquired", false, true];
_hqLaptop setVariable ["radioTransmitter", _commsLaptop];

["InA_Event_CodesAquired", {
    params ["_event", "_args"];

    _args params ["_laptop", "_unit"];

    _laptop setVariable ["codesAcquired", true, true];
    private _transmitter = _laptop getVariable ["radioTransmitter", objNull];
    _transmitter setVariable ["codesAcquired", true, true];

    private _targetStartText = format ["<t align='center' size='2.2'>Sub-Objective</t><br/><t size='1.5' align='center' color='#FFCF11'>Codes acquired</t><br/>____________________<br/>%1 acquired the access codes. Now find that Communication center and use the codes to shut it down.", (name _unit)];
    [_targetStartText] remoteExec ["AW_fnc_globalHint", 0];
}] call AW_fnc_eventRegister;

[
    _hqLaptop,
    "Acquire Codes",
    "\a3\ui_f\data\IGUI\Cfg\HoldActions\holdAction_search_ca.paa",
    "\a3\ui_f\data\IGUI\Cfg\HoldActions\holdAction_hack_ca.paa",
    "((_target distance _this) <= 2) && {!(_target getVariable ['codesAcquired', false])}",
    "((_target distance _this) <= 2) && {!(_target getVariable ['codesAcquired', false])}",
    {
        hint "Acquiring access codes ....";
    },
    {},
    {
        params ["_laptop", "_player"];

        ["InA_Event_CodesAquired", [_laptop, _player]] remoteExec ["AW_fnc_eventTrigger", 2];
    },
    {},
    [],
    6,
    0,
    true,
    false
] remoteExecCall ["BIS_fnc_holdActionAdd", 0, true];

_subObjs pushBack _hqLaptop;

InA_Server_subObjUnits append (_subUnits + _subObjs);

InA_Server_SubMarkers = ["SUB", "Communications Hub", _roughPos, 225] call AW_fnc_missionMarkersCreate;
private _subMarker = (InA_Server_SubMarkers # 0);

private _targetStartText = format ["<t align='center' size='2.2'>Sub-Objective</t><br/><t size='1.5' align='center' color='#FFCF11'>Communications Hub</t><br/>____________________<br/>OPFOR have set up a Communications Hub inside the AO. Acquire the access codes, then shutdown the transmissions.<br/><br/>"];
[_targetStartText] remoteExec ["AW_fnc_globalHint", 0];

[
    west,
    [
        "SubAoTask",
        "MainAoTask"
    ],
    [
        "OPFOR have set up a Communications Hub inside the AO.<br/><br/>First, acquire the access codes from the HQ. Once you have the codes, proceed to the Communucation center and shutdown the transmissions.<br/><br/>Until the transmissions are shut down, CSAT will keep calling in helicopter airsupport!<br/><br/>HQ:<br/><img image='Media\Briefing\sub_comms_hq.jpg' width='270' height='300' /><br/><br/>Comms center:<br/><img image='Media\Briefing\sub_comms_trans.jpg' width='300' height='200' />",
        "Communications Hub",
        _subMarker
    ],
    _roughPos,
    "Created",
    0,
    true,
    "radio",
    true
] call BIS_fnc_taskCreate;

InA_MainAO_CommsHubTransmitting = true;

InA_Server_MainAoSubObjSpawn_Complete = true;

private _intervalMin = 300;
private _intervalMax = 840;
private _lastSpawn = -_intervalMax;

while {sleep 5; InA_MainAO_CommsHubTransmitting} do {
    if (InA_Server_MainAOControl_EndSubObj) then {
        _hqLaptop setVariable ["codesAcquired", true, true];
        _commsLaptop setVariable ["isTransmitting", false, true];

        InA_MainAO_CommsHubTransmitting = false;

        break
    };

    private _interval = (ceil (linearConversion [1, 60, InA_Server_PlayerCount, _intervalMax, _intervalMin, true]));

    if (
        (time < (_lastSpawn + _interval)) ||
        (InA_Server_AOReinforceHeliCount >= InA_Server_AOReinforceHeliLimit)
    ) then {continue};

    _lastSpawn = time;

    [(getMarkerPos "airCavSpawnMarker")] spawn AW_fnc_heliCombatPatrol;
};

["InA_Event_TransmissionsShutdown"] call AW_fnc_eventUnregister;
["InA_Event_CodesAquired"] call AW_fnc_eventUnregister;

private _aoName = [] call AW_fnc_getCurrentAOName;
_targetStartText = format ["<t align='center' size='2.2'>Sub-Objective</t><br/><t size='1.5' align='center' color='#FFCF11'>Complete</t><br/>____________________<br/>Good job everyone, the Communications Hub has been disabled. OPFOR is now unable to call any more CAS support in %1.", _aoName];
[_targetStartText] remoteExec ["AW_fnc_globalHint", 0];

0 = ["SubAoTask"] spawn AW_fnc_finishTask;

[InA_Server_SubMarkers] call AW_fnc_missionMarkersRemove;

// Don't despawn bunker until player(s) gone
0 = [_hqOrg] spawn {
    params ["_hq"];

    waitUntil {sleep 1; InA_Server_MainAO_Completed};

    waitUntil {sleep 5; !([_hq, 25] call AW_fnc_playersNear)};

    deleteVehicle _hq;
};

InA_Server_MainAO_SubObjComplete = true;
