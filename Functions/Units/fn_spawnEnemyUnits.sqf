/*
    fn_spawnEnemyUnits.sqf
    Author: stanhope, Whigital
    Description: Spawn units for missions
*/

params [
    "_missionPos",
    ["_missionType", "AO"],
    ["_patrolType", "#circ"],
    ["_vehCountArray", []],
    ["_infCountArray", []],
    ["_patrolMin", 25],
    ["_patrolMax", 300],
    ["_factionHash", InA_EnemyFactionHash]
];


private _taskPatrol = {
    params ["_grp", "_pos", "_patrolType", "_patrolMin", "_patrolMax"];

    private _forms = [
        "COLUMN",
        "WEDGE",
        "ECH LEFT",
        "ECH RIGHT",
        "STAG COLUMN"
    ];

    switch (_patrolType) do {
        case "#rnd": {
            private _randomPos = [_pos, _patrolMin, (_patrolMin * 2), 4, 0, 0.4, 0, [], [_pos, [0,0]]] call BIS_fnc_findSafePos;

            [_grp, _randomPos, _patrolMin, (_patrolMax / 2)] call AW_fnc_taskRndPatrol;
        };

        case "#circ": {
            private _rad = (((_patrolMin * 2) + (random _patrolMax)) min _patrolMax);

            [_grp, _pos, _patrolMin, _rad] call AW_fnc_taskCircPatrol;
        };
    };


    // Only set formation on infantry
    if (isNull (objectParent (leader _grp))) then {
        private _form = (selectRandom _forms);
        _grp setFormation _form;

        {
            _x setWaypointFormation _form;
        } forEach (waypoints _grp);
    };
};

// Make sure position is Position3D/ATL
if ((count _missionPos) < 3) then {
    _missionPos pushBack (getTerrainHeightASL _missionPos);
    _missionPos = (ASLToATL _missionPos);
};

private _spawnedUnits = [];

///////////////////
///  VEHICLES   ///
///////////////////
_vehCountArray params [
    ["_mbtCount",   0],
    ["_aaCount",    0],
    ["_ifvCount",   0],
    ["_carCount",   0]
];

{
    _x params ["_count", "_type", "_grpName"];

    if (_count == 0) then {continue};

    for "_i" from 1 to _count do {
        private _randomPos = [_missionPos, _patrolMin, _patrolMax, 8, 0, 0.4, 0, [], [_missionPos, [0,0]]] call BIS_fnc_findSafePos;

        private _vehType = [_type, _factionHash] call AW_fnc_getUnitsFromHash;
        private _veh = [_randomPos, _vehType] call AW_fnc_spawnAIVehicle;

        private _vehGrp = (group (driver _veh));

        [_vehGrp, _missionPos, _patrolType, _patrolMin, _patrolMax] call _taskPatrol;

        _vehGrp setGroupIdGlobal [format ["%1-Veh-%2%3", _missionType, _grpName, _i]];

        {
            _spawnedUnits pushBack _x;
        } forEach (units _vehGrp);

        [_vehGrp] spawn derp_fnc_AISkill;

        [_vehGrp] spawn AW_fnc_transferGroupHC;

        _spawnedUnits pushBack _veh;
    };

    sleep 0.1;
} forEach [
    [_mbtCount, "#mbts",    "MBT"],
    [_aaCount,  "#spaas",   "SPAA"],
    [_ifvCount, "#ifvs",    "IFV"],
    [_carCount, "#mraps",   "MRAP"]
];


///////////////////
///  INFANTRY   ///
///////////////////
_infCountArray params [
    ["_infSquadsCount",     0],
    ["_sfSquadsCount",      0],
    ["_aaTeamsCount",       0],
    ["_atTeamsCount",       0],
    ["_sniperTeamsCount",   0],
    ["_infTeamsCount",      0],
    ["_sfTeamsCount",       0]
];

{
    _x params ["_count", "_type", "_squadName"];

    if (_count == 0) then {continue};

    for "_i" from 1 to _count do {
        private _rng = (_patrolMin + (random _patrolMax));
        private _randomPos = [_missionPos, _patrolMin, (_patrolMax / 2), 4, 0, 1, 0, [], [_missionPos, [0,0]]] call BIS_fnc_findSafePos;
        private _squadType = [_type, _factionHash] call AW_fnc_getUnitsFromHash;
        private _infGrp = [_squadType, _randomPos] call AW_fnc_spawnAIGroup;

        [_infGrp, _missionPos, _patrolType, _patrolMin, _patrolMax] call _taskPatrol;

        _infGrp setGroupIdGlobal [format ["%1-Inf-%2%3", _missionType, _squadName, _i]];

        {
            _spawnedUnits pushBack _x;
        } forEach (units _infGrp);

        [_infGrp] spawn derp_fnc_AISkill;

        [_infGrp] spawn AW_fnc_transferGroupHC;
    };
} forEach [
    [_infSquadsCount,   "#squads",          "Squad"],
    [_sfSquadsCount,    "#specop_squads",   "ReconSquad"],
    [_aaTeamsCount,     "#aa_teams",        "AA-Team"],
    [_atTeamsCount,     "#at_teams",        "AT-Team"],
    [_infTeamsCount,    "#teams",           "Team"],
    [_sfTeamsCount,     "#specop_teams",    "ReconTeam"]
];


//////////////////
///  SNIPERS   ///
//////////////////
for "_i" from 1 to _sniperTeamsCount do {
    private _min = (50 max (_patrolMax / 4));
    private _max = (500 min (_patrolMax * 1.5));

    private _randomPos = [_missionPos, _max, _min, 5] call BIS_fnc_findOverwatch;

    if ((_randomPos distance2D _missionPos) > (_patrolMax * 1.5)) then {
        _randomPos = [_missionPos, _min, _max, 4, 0, 1, 0, [], [_missionPos, [0,0]]] call BIS_fnc_findSafePos;
    };

    private _sniperTeamType = ["#sniper_teams", _factionHash] call AW_fnc_getUnitsFromHash;
    private _sniperTeam = [_sniperTeamType, _randomPos] call AW_fnc_spawnAIGroup;

    _sniperTeam setGroupIdGlobal [format ["%1-SniperTeam%2", _missionType, _i]];
    _sniperTeam setBehaviour "COMBAT";
    _sniperTeam setCombatBehaviour "COMBAT";
    _sniperTeam setCombatMode "RED";

    {
        _x setUnitPos "DOWN";
        _spawnedUnits pushBack _x;
    } forEach (units _sniperTeam);

    [_sniperTeam, 50] spawn derp_fnc_AISkill;

    [_sniperTeam] spawn AW_fnc_transferGroupHC;
};

[_spawnedUnits] call AW_fnc_addToAllCurators;

_spawnedUnits
