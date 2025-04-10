/*
Author: Stanhope
Based on mission by Quiksilver and Rarek [AW]

Description:    Shore bombardment relay station
                A relay station that calls in naval fire support.
*/

private _spawnedUnits = [];
private _prioThings = [];

private _artilleryTargetTickTimeMin = "ArtilleryTargetTickTimeMin" call BIS_fnc_getParamValue;
private _artilleryTargetTickTimeMax = "ArtilleryTargetTickTimeMax" call BIS_fnc_getParamValue;
if (_artilleryTargetTickTimeMax == _artilleryTargetTickTimeMin) then {
    _artilleryTargetTickTimeMax = _artilleryTargetTickTimeMax + 60;
};

//-------------------- 1. FIND POSITION
private _flatPos = [(getMarkerPos InA_Server_currentAO), 8000, 25, 0.2] call AW_fnc_findSafePos;

//-------------------- 2. SPAWN OBJECTIVES

//Simulate CSAT ship
private _supportPlatform = createVehicle ["Land_Pier_Box_F", [0, 200]];
_supportPlatform setPosASL [0,200,10];
_supportPlatform enableSimulation false;
private _artillery = createVehicle ["B_Ship_Gun_01_F" , [0, 100]];
_artillery setPosASL [0,200,11];
priorityObj1 = _artillery;

{
    hideObjectGlobal _x;
    _x allowDamage false;
    _prioThings pushBack _x;
} forEach [_supportPlatform, _artillery];

//Spawn actual objective

private _origin = "Land_Cargo_Tower_V2_F";
private _rndDir = random 360;

private _towerProtection = [
    ["Land_DragonsTeeth_01_4x2_old_F",[0.390625,8.93164,-12.8862],0],
    ["Land_DragonsTeeth_01_4x2_old_F",[-8.87988,5.92188,-12.8862],90],
    ["Land_DragonsTeeth_01_4x2_old_F",[0.0644531,-7.92578,-12.8862],0],
    ["Land_DragonsTeeth_01_4x2_old_F",[8.71191,-5.30469,-12.8862],90],
    ["Land_DragonsTeeth_01_4x2_old_F",[8.72852,5.57227,-12.8862],90],
    ["Land_DragonsTeeth_01_4x2_old_F",[-9.06055,-4.87305,-12.8862],90]
];

private _commsStuff = [
    ["Land_SandbagBarricade_01_half_F",[3.12012,-0.765625,2.47843],0],
    ["Land_SandbagBarricade_01_half_F",[1.30957,-0.775391,2.47843],0],
    ["Land_SandbagBarricade_01_F",[3.85449,-0.115234,-0.121563],180],
    ["Land_CampingTable_F",[1.65918,4.71289,2.47484],180],
    ["Land_CampingTable_F",[3.7041,4.71484,2.47484],180],
    ["SatelliteAntenna_01_Small_Black_F",[-0.867188,-1.11133,7.60088],235],
    ["Land_PortableGenerator_01_black_F",[-0.405273,4.76563,2.47744],180],
    ["Land_PortableWeatherStation_01_olive_F",[3.12207,-0.0917969,5.00228],180],
    ["Land_TripodScreen_01_large_black_F",[5.37012,4.21875,2.47748],225],
    ["Land_PortableServer_01_black_F",[4.16992,4.53906,2.47744],0],
    ["OmniDirectionalAntenna_01_black_F",[0.523438,2.04492,7.61111],0],
    ["Land_IPPhone_01_black_F",[1.44922,4.7207,3.28845],0],
    ["Land_Router_01_black_F",[3.26074,4.74414,3.28844],0],
    ["Land_Computer_01_black_F",[1.02637,4.76563,3.28843],0]
];

private _objectiveComputer = ["Land_MultiScreenComputer_01_black_F",[2.17773,4.67578,3.28848],0];

private _officerRelData = ["O_officer_F",[2.22168,2.88672,2.47987],0];

private _guards = [
    ["rhs_vdv_rifleman",[5.30469,2.56055,5.00471],0],
    ["rhs_vdv_rifleman",[-5.08008,2.5918,5.00471],0],
    ["rhs_vdv_rifleman",[4.00488,-1.33398,2.47987],0],
    ["rhs_vdv_rifleman",[3.93359,0.8125,-0.120125],0],
    ["rhs_vdv_rifleman",[-1.02148,4.36523,-0.120125],0],
    ["rhs_vdv_rifleman",[-2.44336,2.00195,-4.2958],0],
    ["rhs_vdv_rifleman",[3.7627,4.19336,-8.24333],0],
    ["rhs_vdv_rifleman",[-4.68359,1.25977,-12.8848],0],
    ["rhs_vdv_rifleman",[-3.41699,1.79492,-12.8848],0],
    ["rhs_vdv_rifleman",[-4.61133,-5.37305,4.90716],0],
    ["rhs_vdv_rifleman",[-1.73047,-5.38086,4.90716],0],
    ["rhs_vdv_rifleman",[5.26367,-0.917969,5.00471],0],
    ["rhs_vdv_rifleman",[-0.415039,1.62109,5.07987],0],
    ["rhs_vdv_rifleman",[-4.73145,-1.66602,-0.120125],0]
];
private _unitTypes = [
    "#riflemen", "#machinegunners", "#marksmen",
    "#engineers", "#medics", "#teamleaders",
    "#heavygunners", "#sharpshooters", "#lats"
];

// Hide nearby terrainobjects
private _mapObjs = (nearestTerrainObjects [_flatPos, [], 25, false, true]);

{ _x hideObjectGlobal true; } forEach _mapObjs;

// Spawn origin
private _origin = createVehicle ["Land_Cargo_Tower_V2_F", [0, 0, 0], [], 100];
_origin allowDamage false;
_origin setDir _rndDir;
_origin setPos _flatPos;
_origin setVectorUp [0,0,1];
_prioThings pushBack _origin;

// Spawn things
{
    private _obj = [_origin, _x, _rndDir] call AW_fnc_spawnRelative;
    _obj allowDamage false;
    _obj enableSimulationGlobal false;
    _prioThings pushBack _obj;
} forEach _commsStuff;

{
    private _obj = [_origin, _x, _rndDir] call AW_fnc_spawnRelative;
    _obj allowDamage false;
    _obj enableSimulationGlobal false;
    private _posAtl = getPosATL _obj;
    _posAtl set [2, 0];
    _obj setPosATL _posAtl;
    _obj setVectorUp surfaceNormal position _obj;
    _prioThings pushBack _obj;
} forEach _towerProtection;

//Spawn computer
private _targetComputer = [_origin, _objectiveComputer, _rndDir] call AW_fnc_spawnRelative;
_targetComputer allowDamage false;
_targetComputer enableSimulationGlobal false;
_prioThings pushBack _targetComputer;

["InA_Event_PrioShore_shipLocationFound", {
    (_this select 1) params ["_caller", "_target"];
    deleteVehicle _target;

    InA_Server_PrioMissionUp = false;

    private _completeText = format ["<t align='center'><t size='2.2'>Prio Mission Complete</t><br/>____________________<br/>Fantastic job, lads! %1 has found the location of the enemy ships.  We're sending several tomahawks their way now, their shore bombardment should stop any minute now.</t>", name _caller];
    [_completeText] remoteExec ["AW_fnc_globalHint", 0];
}] call AW_fnc_eventRegister;

[
    _targetComputer,
    "Get ship location",
    "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\interact_ca.paa",
    "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\use_ca.paa",
    "((_target distance _this) <= 2)",
    "((_target distance _this) <= 2)",
    {
        hint "Getting ship location ....";
    },
    {},
    {
        params ["_target", "_caller"];
        ["InA_Event_PrioShore_shipLocationFound", [_caller, _target]] remoteExec ["AW_fnc_eventTrigger", 2];
    },
    {},
    [],
    4,
    0,
    true,
    false
] remoteExec ["BIS_fnc_holdActionAdd", 0, true];

// Spawn guards
private _guardGrp = (createGroup InA_EnemyFactionSide);

//Spawn officer
private _officer = _guardGrp createUnit [["#officers"] call AW_fnc_getUnitsFromHash, [0, 0, 0], [], 0, "NONE"];
private _officerData = [_origin, _officerRelData, _rndDir, true] call AW_fnc_spawnRelative;

_officer setDir (_officerData # 1);
_officer setPosATL (_officerData # 0);
_officer disableAI "PATH";
_officer setUnitPos "UP";

_spawnedUnits pushBack _officer;

{
    private _posData = [_origin, _x, _rndDir, true] call AW_fnc_spawnRelative;
    private _unitType = [(selectRandom _unitTypes)] call AW_fnc_getUnitsFromHash;
    private _unit = _guardGrp createUnit [_unitType, [0, 0, 0], [], 0, "NONE"];

    _posData params ["_pos", "_dir"];

    _unit setDir _dir;
    _unit setPosATL _pos;

    _unit disableAI "PATH";
    _unit setUnitPos "UP";

    _spawnedUnits pushBack _unit;
} forEach _guards;

_guardGrp = [_guardGrp] call AW_fnc_changeGroupSide;
_guardGrp setGroupIdGlobal ["PRIO-GuardGroup"];

[_guardGrp, [[_origin, _flatPos], {
    params ["_hq", "_pos"];

    waitUntil {
        sleep 1;
        (_hq in (_pos nearObjects [(typeOf _hq), 2]))
    };
}]] spawn AW_fnc_transferGroupHC;

//-------------------- 3. SPAWN CREW - Same method as in priorityaa
sleep 0.1;

private _priorityGroup = createGroup InA_EnemyFactionSide;

{
    private _tmpGrp = createVehicleCrew _x;
    (units _tmpGrp) joinSilent _priorityGroup;
    sleep 0.1;
    _x doWatch getMarkerPos InA_Server_currentAO;
} forEach [_artillery];

_priorityGroup setGroupIdGlobal [format ["PRIO-Artillery"]];
_priorityGroup setBehaviour "COMBAT";
_priorityGroup setCombatMode "RED";

_spawnedUnits = (_spawnedUnits + (units _priorityGroup));

[_spawnedUnits] call derp_fnc_AISkill;
[_spawnedUnits] remoteExec ["AW_fnc_addToAllCurators", 2];

//-------------------- 4. SPAWN FORCE PROTECTION
private _vehAmount = [
    0,                      // MBTs
    (selectRandom [0, 1]),  // SPAAs
    (selectRandom [0, 1]),  // IFVs
    (selectRandom [1, 2])   // MRAPs
];

private _infAmount = [
    (selectRandom [2, 3]),  // Squads
    (selectRandom [1, 2]),  // SF Squads
    1,                      // AA Teams
    1,                      // AT Teams
    nil,                    // Snipers
    nil,                    // Teams
    (selectRandom [0, 1])   // SF Teams
];

private _enemyAry = [
    _flatPos,
    "PRIO",
    "#rnd",
    _vehAmount,
    _infAmount,
    25,
    400
] call AW_fnc_spawnEnemyUnits;

_spawnedUnits = (_spawnedUnits + _enemyAry);
sleep 0.1;

//-------------------- 7. BRIEF
private _fuzzyPos = [((_flatPos select 0) - 300) + (random 600),((_flatPos select 1) - 300) + (random 600),0];

InA_Server_PrioMarkers = ["PRIO", "Shore bombardment Relay station", _fuzzyPos, 300] call AW_fnc_missionMarkersCreate;
private _prioMarker = (InA_Server_PrioMarkers # 0);

[
    west,
    "prioShoreBombardmentTask",
    [
        "CSAT have set up a communications relay to coordinate their shore bombardment efforts.  We can't get find their ships that are providing this naval support.  Go to the relay station and find the location of their ships.",
        "Priority Target: Shore bombardment Relay station",
        _prioMarker
    ],
    _fuzzyPos,
    "Created",
    0,
    true,
    "target",
    true
] call BIS_fnc_taskCreate;

InA_Server_PrioMissionSpawned = true;
InA_Server_PrioMissionUp = true;

//-------------------- FIRING SEQUENCE LOOP
private _getTargets = {
    private _artyPos = [0,0];
    if (alive priorityObj1) then {
        _artyPos = getPos priorityObj1;
    };

    private _goodTargets = [];
    if (count allPlayers < 4) exitWith {
        _goodTargets
    };

    {
        if (!alive _x) then {continue;};
        if (side _x != west) then {continue;};
        if (vehicle _x != _x) then {continue;};
        if (((east knowsAbout _x) < 1.9)
            && ((independent knowsAbout _x) < 1.9)
        ) then {continue;};
        if ((_artyPos distance2D (getPos _x)) < 1000) then {continue;};

        private _tooClose = false;
        private _potentialTarget = _x;
        {
            _distance = 0;
            if (_x isEqualType []) then {
                _distance = _potentialTarget distance _x;
            };
            if (_x isEqualType "") then {
                _distance = _potentialTarget distance (getMarkerPos _x);
            };
            if (_distance < 1000) then {
                _tooClose = true;
                break;
            };
        } forEach (InA_Server_BaseArray + InA_Server_blacklistPositions);

        if (_tooClose) then {continue;};
        _goodTargets pushBack _x;
    } forEach allPlayers;

    _goodTargets
};

private _lastFireMission = serverTime;
private _loopTimeout = 30;
private _waitTime = (_artilleryTargetTickTimeMin + (round (random (_artilleryTargetTickTimeMax - _artilleryTargetTickTimeMin))));

while {(canFire priorityObj1) && InA_Server_PrioMissionUp} do {
    sleep _loopTimeout;

    if ((time - _lastFireMission) < _waitTime) then {
        _loopTimeout = 30;
        continue;
    };

    // Pause if Main AO is shutdown
    if (InA_Server_MainAOShutdown) then {
        sleep 5;
        continue;
    };

    private _targets = [] call _getTargets;
    if (count _targets == 0) then {
        _loopTimeout = 15;
        continue;
    };

    private _target = getPos (selectRandom _targets);

    {
        if (alive _x) then {
            [_x, _target] call AW_fnc_artyStrike;
            _x setVehicleAmmo 1;
        };
    } forEach [priorityObj1];

    _lastFireMission = serverTime;

    _waitTime = (_artilleryTargetTickTimeMin + (round (random (_artilleryTargetTickTimeMax - _artilleryTargetTickTimeMin))));
};

//-------------------- DE-BRIEF
0 = ["prioShoreBombardmentTask"] spawn AW_fnc_finishTask;

[InA_Server_PrioMarkers] call AW_fnc_missionMarkersRemove;

//-------------------- DELETE
[_spawnedUnits + _prioThings] spawn {
    params ["_spawnedUnits"];
    sleep 120;
    _spawnedUnits = _spawnedUnits - [objNull];
    [_spawnedUnits] call AW_fnc_delete;
};

[_mapObjs] spawn {
    params ["_mapObjs"];
    sleep 120;
    { _x hideObjectGlobal false; } forEach _mapObjs;
};
