/*
 * Author: Whigital
 *
 * Description: Spawns an HQ building which calls in paradrop every
 * so often. Enter the HQ and cut the power to stop the paradrops.
 *
 */

params [["_factionHash", InA_EnemyFactionHash]];

private _flatPos = [(getMarkerPos InA_Server_currentAO), 10, InA_Server_MainAOSize, 10, 0, 0.1, 0, [], [0,0,0]] call BIS_fnc_findSafePos;

private _roughPos =[((_flatPos select 0) - 200) + (random 400),((_flatPos select 1) - 200) + (random 400),0];

private _guardTypes = [
    "#riflemen", "#machinegunners", "#marksmen",
    "#teamleaders", "#heavygunners"
];

private _objArray = [];

private _hqObjs = [
    ["OmniDirectionalAntenna_01_sand_F",[-0.89502,0.109863,2.22799],270],
    ["SatelliteAntenna_01_Sand_F",[1.06152,-0.0917969,2.22795],45],

    ["Land_PortableDesk_01_black_F",[0.572998,0.220703,-0.981861],270],
    ["Land_PortableDesk_01_black_F",[-0.50293,0.149902,-0.981861],90],

    ["Land_IPPhone_01_black_F",[0.586426,0.954102,-0.0949264],280.057],
    ["Land_MultiScreenComputer_01_black_F",[0.566162,-0.339355,-0.0949264],259.944],
    ["Land_PortableCabinet_01_4drawers_black_F",[-0.445068,0.884277,-0.0950704],85.171],
    ["Land_PortableCabinet_01_bookcase_black_F",[-0.322998,-0.577148,-0.0949264],97.979]
];

private _barriers = [
    ["Land_HBarrier_Big_F",[-6.52637,1.00635,-1.11201],90],
    ["Land_HBarrier_Big_F",[-3.40332,6.52588,-1.11201],0],
    ["Land_HBarrier_Big_F",[3.68774,-6.32227,-1.11201],0],
    ["Land_HBarrier_Big_F",[6.60986,-0.75,-1.11201],90],
    ["Land_HBarrier_3_F",[-1.84399,-7.59766,-1.11201],180],
    ["Land_HBarrier_3_F",[-5.89429,-6.31982,-1.11201],90],
    ["Land_HBarrier_3_F",[6.01733,6.35742,-1.11201],90],
    ["Land_HBarrier_3_F",[1.89185,7.68213,-1.11201],180]
];

private _guards = [
    ["C_scientist_F",[-1.33887,0.146484,-0.980422],87.5757],
    ["C_scientist_F",[1.44775,-0.203125,-0.980422],250.135],
    ["O_Survivor_F",[-3.69336,-3.7583,-0.980422],115.222],
    ["O_Survivor_F",[-4.65967,-0.675293,-0.980422],51.2808],
    ["O_Survivor_F",[-1.65137,-1.98779,-0.980422],346.055],
    ["O_Survivor_F",[-1.92969,-5.875,-1.11057],226.479],
    ["O_Survivor_F",[-1.71484,1.93066,-0.980422],145.018],
    ["O_Survivor_F",[1.854,5.91699,-1.11057],51.9503],
    ["O_Survivor_F",[-1.20508,4.47412,-0.980422],171.079],
    ["O_Survivor_F",[2.33081,2.30371,-0.980422],218.026],
    ["O_Survivor_F",[4.35669,-4.22266,-0.980422],309.188],
    ["O_Survivor_F",[4.85107,-0.337891,-0.980422],252.146],
    ["O_Survivor_F",[2.16553,-1.88574,-0.862772],307.761],
    ["O_Survivor_F",[4.17505,2.04102,-0.980422],177.547],
    ["O_Survivor_F",[3.91431,3.97949,-0.980422],272.027]
];

private _subObjs = [];
private _subUnits = [];

private _rndDir = (random 360);


// Spawn base object ....
private _origin = createVehicle ["Land_Bunker_01_HQ_F", [0, 0, 0], [], 0, "NONE"];
_origin setDir _rndDir;
_origin setPos _flatPos;
_origin setVectorUp [0, 0, 1];

_subObjs pushBack _origin;


// Spawn all other objects
{
    private _obj = [_origin, _x, _rndDir] call AW_fnc_spawnRelative;
    _obj allowDamage false;
    _obj enableSimulationGlobal false;
    _subObjs pushBack _obj;
} forEach _hqObjs;


// Spawn H-Barriers
{
    private _obj = [_origin, _x, _rndDir] call AW_fnc_spawnRelative;
    _obj allowDamage false;

    private _pos = (getPosATL _obj);
    _obj setPosATL [(_pos # 0), (_pos # 1), 0];

    _obj setVectorUp (surfaceNormal (getPosATL _obj));
    _subObjs pushBack _obj;
} forEach _barriers;


// Spawn Guards ....
private _guardGroup = (createGroup InA_EnemyFactionSide);

{
    private _data = [_origin, _x, _rndDir, true] call AW_fnc_spawnRelative;
    private _pos = (_data # 0);
    private _dir = (_data # 1);

    private _unitType = [(selectRandom _guardTypes), _factionHash] call AW_fnc_getUnitsFromHash;

    if ((_x # 0) == "C_scientist_F") then {
        _unitType = ["#officers", _factionHash] call AW_fnc_getUnitsFromHash;
    };

    private _unit = _guardGroup createUnit [_unitType, _pos, [], 0, "NONE"];

    _unit setDir _dir;
    _unit setPosATL _pos;

    _unit disableAI "PATH";
    _unit setUnitPos "UP";

    [[_unit]] call AW_fnc_addToAllCurators;

    _subUnits pushBack _unit;
} forEach _guards;

_guardGroup = [_guardGroup] call AW_fnc_changeGroupSide;
_guardGroup setGroupIdGlobal ["AO-SubObj-Guards"];

[(units _guardGroup)] call derp_fnc_AISkill;

[_guardGroup, [[_origin, _flatPos], {
    params ["_hq", "_pos"];

    waitUntil {
        sleep 1;
        (_hq in (_pos nearObjects [(typeOf _hq), 2]))
    };
}]] spawn AW_fnc_transferGroupHC;


// Create transferswitch and add action
private _switch = [_origin, ["Land_TransferSwitch_01_F",[-2.75806,1.23877,-0.00300503],270], _rndDir] call AW_fnc_spawnRelative;

_switch allowDamage false;
_switch animateSource ["SwitchPosition", 1, true];
_switch animateSource ["SwitchLight", 1, true];
_switch animateSource ["Power_1", 0.4, true];
_switch animateSource ["Power_2", 0.6, true];
_switch setVariable ["switchedOn", true, true];

_subObjs pushBack _switch;

["InA_Event_BunkerPoweredOff", {
    params ["_event", "_switch"];

    _switch setVariable ["switchedOn", false, true];

    _switch animateSource ["SwitchPosition", 0];
    _switch animateSource ["SwitchLight", 0];
    _switch animateSource ["Power_1", 0];
    _switch animateSource ["Power_2", 0];

    InA_MainAO_CCBunkerPowered = false;
}] call AW_fnc_eventRegister;

[
    _switch,
    "Cut Power",
    "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\interact_ca.paa",
    "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\use_ca.paa",
    "((_target distance _this) <= 2) && {_target getVariable ['switchedOn', false]}",
    "((_target distance _this) <= 2) && {_target getVariable ['switchedOn', false]}",
    {
        hint "Switching power off ....";
    },
    {},
    {
        params ["_target", "_caller", "_actionId", "_arguments"];

        ["InA_Event_BunkerPoweredOff", _target] remoteExec ["AW_fnc_eventTrigger", 2];
    },
    {},
    [],
    4,
    0,
    true,
    false
] remoteExec ["BIS_fnc_holdActionAdd", 0, true];

InA_Server_subObjUnits append (_subUnits + _subObjs);

InA_Server_SubMarkers = ["SUB", "Command and Control", _roughPos, 225] call AW_fnc_missionMarkersCreate;
private _subMarker = (InA_Server_SubMarkers # 0);

private _targetStartText = format ["<t align='center' size='2.2'>Sub-Objective</t><br/><t size='1.5' align='center' color='#FFCF11'>Command and Control</t><br/>____________________<br/>OPFOR have set up an Command and Control Bunker inside the AO. Infiltrate the building and cut the power.<br/><br/>"];
[_targetStartText] remoteExec ["AW_fnc_globalHint", 0];

[
    west,
    [
        "SubAoTask",
        "MainAoTask"
    ],
    [
        "OPFOR have set up an Command and Control bunker inside the AO. Infiltrate the building and cut the power.<br/><br/>Until you cut the power, CSAT will keep calling in paratroopers!<br/><br/>Bunker:<br/><img image='Media\Briefing\sub_command.jpg' width='300' height='170' />",
        "Command and Control",
        _subMarker
    ],
    _roughPos,
    "Created",
    0,
    true,
    "interact",
    true
] call BIS_fnc_taskCreate;

InA_MainAO_CCBunkerPowered = true;

InA_Server_MainAoSubObjSpawn_Complete = true;

private _intervalMin = 240;
private _intervalMax = 720;
private _lastSpawn = -_intervalMax;

InA_AOParaReinforceGroups = [];

while {sleep 2; InA_MainAO_CCBunkerPowered} do {
    if (InA_Server_MainAOControl_EndSubObj) then {
        _switch setVariable ["switchedOn", false, true];

        _switch animateSource ["SwitchPosition", 0];
        _switch animateSource ["SwitchLight", 0];
        _switch animateSource ["Power_1", 0];
        _switch animateSource ["Power_2", 0];

        InA_MainAO_CCBunkerPowered = false;

        break
    };

    private _paraLimit = 8;

    if (InA_Server_PlayerCount > 15) then {_paraLimit = 16;};
    if (InA_Server_PlayerCount > 30) then {_paraLimit = 24;};

    private _interval = (ceil (linearConversion [1, 60, InA_Server_PlayerCount, _intervalMax, _intervalMin, true]));
    private _parasAlive = 0;

    {
        _parasAlive = (_parasAlive + ({alive _x} count (units _x)));
    } forEach InA_AOParaReinforceGroups;

    if ((serverTime < (_lastSpawn + _interval)) || {((_parasAlive >= _paraLimit))}) then {continue};

    private _return = [(getMarkerPos "airCavSpawnMarker"), (getMarkerPos InA_Server_currentAO), _factionHash] call AW_fnc_paraReinforce;
    private _paraGrp = (_return # 0);
    private _heli = (_return # 1);
    private _heliGrp = (group (driver _heli));

    InA_AOParaReinforceGroups pushBack _paraGrp;

    InA_Server_subObjUnits append ((units _paraGrp) + [_heli] + (units _heliGrp));

    _lastSpawn = serverTime;
};

["InA_Event_BunkerPoweredOff"] call AW_fnc_eventUnregister;

private _aoName = [] call AW_fnc_getCurrentAOName;
_targetStartText = format ["<t align='center' size='2.2'>Sub-Objective</t><br/><t size='1.5' align='center' color='#FFCF11'>Complete</t><br/>____________________<br/>Good job everyone, the Command and Control Bunker has been disabled. OPFOR is now unable to call for any more paratroopers in %1.", _aoName];
[_targetStartText] remoteExec ["AW_fnc_globalHint", 0];

0 = ["SubAoTask"] spawn AW_fnc_finishTask;

[InA_Server_SubMarkers] call AW_fnc_missionMarkersRemove;

InA_Server_MainAO_SubObjComplete = true;
