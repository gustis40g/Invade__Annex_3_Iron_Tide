/*
 * Author: Whigital
 *
 * Vehicle depot Prio mission that spawns vehicle reinforcements
 *
 */

private _prioUnits = [];
private _prioThings = [];

private _flatPos = [(getMarkerPos InA_Server_currentAO), 4000, 20, 0.2] call AW_fnc_findSafePos;

// Inline functions
private _orientate = {
    params ["_obj", ["_setStraight", true]];

    private _pos = (getPosATL _obj);

    _pos set [2, 0];
    _obj setPosATL _pos;

    private _vectorUp = [0, 0, 1];

    if (!_setStraight) then {
        _vectorUp = (surfaceNormal _pos);
    };

    _obj setVectorUp _vectorUp;
};

private _retask = {
    params ["_groups"];

    {
        if (!isNull _x && {((count (units _x)) > 0)}) then {
            while {(count (waypoints _x)) > 0} do {
                deleteWaypoint ((waypoints _x) # 0);
            };

            [_x, (getMarkerPos InA_Server_currentAO), nil, (800 / 2)] call AW_fnc_taskRndPatrol;

            _x setBehaviour "COMBAT";
            _x setCombatMode "RED";
        };
    } forEach _groups;
};


// Defines
private _infGrps = ["#squads", 2, "#specop_squads", 0.75, "#teams", 1.5, "#specop_teams", 1, "#aa_teams", 1.25, "#at_teams", 1.25];

private _vehHash = (InA_EnemyFactionHash get "#vehicles");

private _vehicles = (
    (_vehHash get "#ifvs") +
    (_vehHash get "#spaas") +
    (_vehHash get "#mbts")
);

private _unitTypes = [
    "#riflemen", "#machinegunners", "#marksmen",
    "#engineers", "#medics", "#teamleaders",
    "#heavygunners", "#sharpshooters", "#lats"
];

private _wallObjs = [
    ["Land_CncWall4_F",[-7.58252,-8.01025,-3.37814],90],
    ["Land_CncWall1_F",[-7.58203,-11.2681,-3.37814],90],
    ["Land_CncWall1_F",[-7.56689,-3.2793,-3.37814],90],
    ["Land_CncWall1_F",[-7.58691,-4.75732,-3.37814],90],
    ["Land_CncWall4_F",[-5.18262,11.6553,-3.37814],180],
    ["Land_CncWall4_F",[-7.56738,-0.0166016,-3.37814],90],
    ["Land_CncWall4_F",[-7.55469,7.98633,-3.37814],90],
    ["Land_CncWall1_F",[-7.57178,3.2417,-3.37814],90],
    ["Land_CncWall1_F",[-7.55908,11.2534,-3.37814],90],
    ["Land_CncWall1_F",[-7.5542,4.72461,-3.37814],90],
    ["Land_CncWall4_F",[7.5918,-7.97998,-3.37814],270],
    ["Land_CncWall1_F",[7.5708,-4.71533,-3.37814],270],
    ["Land_CncWall1_F",[7.61182,-3.21484,-3.37814],270],
    ["Land_CncWall1_F",[7.59326,-11.2388,-3.37814],270],
    ["Land_CncWall4_F",[5.25586,11.689,-3.37814],180],
    ["Land_CncWall4_F",[7.5752,8.01563,-3.37814],270],
    ["Land_CncWall4_F",[7.61035,0.0439453,-3.37814],270],
    ["Land_CncWall4_F",[0.0410156,11.6714,-3.37814],180],
    ["Land_CncWall1_F",[7.57666,4.75684,-3.37814],270],
    ["Land_CncWall1_F",[7.58936,3.30859,-3.37814],270],
    ["Land_CncWall1_F",[7.5542,11.2803,-3.37814],270]
];

private _thingObjs = [
    ["CargoNet_01_barrels_F",[-6.19238,-6.76367,-3.37814],330.987],
    ["Land_TankEngine_01_F",[-5.30664,-4.41504,-3.37814],40.3686],
    ["Land_PowerGenerator_F",[-5.55518,8.75488,-3.37814],93.5612],
    ["Land_PowerGenerator_F",[-5.49121,10.2622,-3.37814],81.9869],
    ["Land_Cargo20_sand_F",[-5.34326,3.97803,-3.37814],260.382],
    ["Land_EngineCrane_01_F",[-3.14209,-3.07227,-3.37814],7.6332],
    ["Land_ScrapHeap_1_F",[5.71045,-4.04199,-3.37814],157.246],
    ["Land_PaperBox_closed_F",[0.779297,9.73438,-3.37814],306.482],
    ["CargoNet_01_box_F",[-2.12354,9.42871,-3.37814],338.131],
    ["Land_WeldingTrolley_01_F",[2.34131,-3.47021,-3.37814],320.449]
];

private _guardData = [
    ["O_Survivor_F",[-5.93408,-0.706055,-3.3767],114.097],
    ["O_Survivor_F",[6.08496,-7.30859,-3.3767],232.349],
    ["O_Survivor_F",[-1.1499,-3.22021,-3.3767],148.263],
    ["O_Survivor_F",[-3.49316,7.75195,-3.3767],147.401],
    ["O_Survivor_F",[-3.69727,4.79639,-3.3767],102.218],
    ["O_Survivor_F",[0.878418,5.54248,-3.3767],267.07],
    ["O_Survivor_F",[-0.568359,8.03613,-3.3767],190.338]
];

private _officeObjs = [
    ["Land_Printer_01_F",[-0.442614,1.36719,0.71841],162.935],
    ["Land_Laptop_Intel_Oldman_F",[-0.427966,0.357422,0.71841],16.9171],
    ["Land_MapBoard_01_Wall_Altis_F",[-2.56908,3.15186,0.992848],0],
    ["Land_CampingTable_F",[-0.422106,0.837891,-0.097188],0],
    ["Land_Shoot_House_Wall_Stand_F",[-0.533923,1.94287,-0.097188],90.213],
    ["Land_Shoot_House_Wall_Stand_F",[0.406018,1.94287,-0.097188],90.213],
    ["Land_Shoot_House_Wall_Stand_F",[0.089124,0.838867,-0.097188],0]
];

private _officeGuards = [
    ["O_Survivor_F",[2.04713,0.717285,-0.0957489],355.276],
    ["O_Survivor_F",[0.940198,1.21094,-0.0957494],249.983],
    ["O_Survivor_F",[-0.106189,2.77588,0.0402865],81.9571],
    ["O_Survivor_F",[1.5818,3.56152,0.0402865],269.21],
    ["O_Survivor_F",[-1.63353,3.51807,0.0402865],207.287]
];

private _depotObj = ["Land_RepairDepot_01_tan_F",[1.66406,0.356934,-3.37814],270];
private _padObj = ["Land_JumpTarget_F",[-0.0864258,-9.7207,-3.37814],0];
private _officeObj = ["Land_Cargo_House_V3_F",[2.59521,7.9458,-3.37814],90];
private _officerObj = ["O_officer_F",[-1.9055,0.962402,-0.0957494],171.811];

private _aoPos = (getMarkerPos InA_Server_currentAO);
private _aoDir = (_flatPos getDir _aoPos);
private _rndDir = (((_aoDir - 45) + (random 90)) + 180);


// Hide nearby terrainobjects
private _mapObjs = (nearestTerrainObjects [_flatPos, [], 50, false, true]);

{
    _x hideObjectGlobal true;
} forEach _mapObjs;


// Spawn origin
private _origin = createVehicle ["Land_Shed_Big_F", [0, 0, 0], [], 100, "NONE"];
_origin allowDamage false;
_origin setDir _rndDir;
_origin setPos _flatPos;
_origin setVectorUp [0,0,1];

_prioThings pushBack _origin;


// Spawn walls
{
    private _obj = [_origin, _x, _rndDir] call AW_fnc_spawnRelative;
    _obj allowDamage false;

    _obj call _orientate;

    _prioThings pushBack _obj;
} forEach _wallObjs;


// Spawn things
{
    private _obj = [_origin, _x, _rndDir] call AW_fnc_spawnRelative;
    _obj allowDamage false;

    [_obj, false] call _orientate;

    _obj enableSimulationGlobal false;
    _prioThings pushBack _obj;
} forEach _thingObjs;


// Spawn guards
private _guardGrp = (createGroup InA_EnemyFactionSide);

{
    private _posData = [_origin, _x, _rndDir, true] call AW_fnc_spawnRelative;
    private _unitType = [(selectRandom _unitTypes)] call AW_fnc_getUnitsFromHash;
    private _unit = _guardGrp createUnit [_unitType, [0, 0, 0], [], 0, "NONE"];

    _posData params ["_pos", "_dir"];

    _unit setDir _dir;
    _unit setPosATL _pos;

    _unit disableAI "PATH";
    _unit setUnitPos "UP";

    _prioUnits pushBack _unit;
} forEach _guardData;

_guardGrp = [_guardGrp] call AW_fnc_changeGroupSide;
_guardGrp setGroupIdGlobal ["Prio-GuardGroup"];

[_guardGrp] spawn AW_fnc_transferGroupHC;


// Spawn Office
private _office = [_origin, _officeObj, _rndDir] call AW_fnc_spawnRelative;
_office allowDamage false;
_office call _orientate;
_prioThings pushBack _office;


// Spawn Office things
{
    private _obj = [_office, _x, _rndDir] call AW_fnc_spawnRelative;
    _obj allowDamage false;
    _obj enableSimulationGlobal false;
    _prioThings pushBack _obj;
} forEach _officeObjs;


// Spawn Officer
private _officeGrp = (createGroup InA_EnemyFactionSide);

private _officer = _officeGrp createUnit [["#officers"] call AW_fnc_getUnitsFromHash, [0, 0, 0], [], 0, "NONE"];
private _officerData = [_office, _officerObj, _rndDir, true] call AW_fnc_spawnRelative;

_officer setDir (_officerData # 1);
_officer setPosATL (_officerData # 0);

_officer addMPEventHandler ["MPKilled", {
    params ["_unit", "_killer", "_instigator", "_useEffects"];

    if (!isServer) exitWith {};

    private _depot = _unit getVariable ["DepotObject", objNull];
    _depot allowDamage true;

    private _name = (name _killer);
    private _msg = "<t align='center'><t size='2.2'>Prio Mission update</t><br/>____________________<br/>Good job, the OPFOR Officer has been killed!<br/><br/>Now destroy that depot !</t>";
    [_msg] remoteExec ["AW_fnc_globalHint", 0];
}];

_officer disableAI "PATH";
_officer setUnitPos "UP";

_prioUnits pushBack _officer;

// Spawn Office guards
{
    private _posData = [_office, _x, _rndDir, true] call AW_fnc_spawnRelative;
    private _unitType = [(selectRandom _unitTypes)] call AW_fnc_getUnitsFromHash;
    private _unit = _officeGrp createUnit [_unitType, [0, 0, 0], [], 0, "NONE"];

    _posData params ["_pos", "_dir"];

    _unit setDir _dir;
    _unit setPosATL _pos;

    _unit disableAI "PATH";
    _unit setUnitPos "UP";

    _prioUnits pushBack _unit;
} forEach _officeGuards;

_officeGrp = [_officeGrp] call AW_fnc_changeGroupSide;
_officeGrp setGroupIdGlobal ["Prio-OfficerGroup"];

[_officeGrp, [[_office, (getPos _office)], {
    params ["_hq", "_pos"];

    waitUntil {
        sleep 1;
        (_hq in (_pos nearObjects [(typeOf _hq), 2]))
    };
}]] spawn AW_fnc_transferGroupHC;


// Spawn Pad
private _pad = [_origin, _padObj, _rndDir] call AW_fnc_spawnRelative;
_prioThings pushBack _pad;


// Spawn Depot
private _depotData = [_origin, _depotObj, _rndDir, true] call AW_fnc_spawnRelative;
private _depot = createVehicle [(_depotObj # 0), [0, 0, 0], [], 100, "NONE"];
_depot allowDamage false;
_depot setDir (_depotData # 1);
_depot setPosATL (_depotData # 0);
[_depot, false] call _orientate;

_depot setRepairCargo 0;

private _depotHdEhIdx = _depot addEventHandler ["HandleDamage", {
    params ["_unit", "_selection", "_damage", "_source", "_projectile", "_hitIndex", "_instigator", "_hitPoint"];

    if ((alive _unit) && {_damage >= 1}) then {
        _unit removeEventHandler ["HandleDamage", _thisEventHandler];

        "Bo_GBU12_LGB" createVehicle (getPosATL _unit);
        deleteVehicle _unit;
    };

    0
}];

_officer setVariable ["DepotObject", _depot, true];


private _spawnPos = (_pad modelToWorld [0, -2, 0]);
_spawnPos set [2, 0];

[_prioUnits] call AW_fnc_addToAllCurators;
[_prioUnits] call derp_fnc_AISkill;

private _patrolBlacklist = [[(getPos _pad), 40]];


private _vehAmount = [
    (selectRandom [0, 1]),  // MBTs
    (1 + (random 1)),       // SPAAs
    (selectRandom [0, 1]),  // IFVs
    (1 + (random 1))        // MRAPs
];

private _infAmount = [
    (3 + (random 2)),       // Squads
    (selectRandom [0, 1]),  // SF Squads
    (1 + (random 1)),       // AA Teams
    (1 + (random 1)),       // AT Teams
    nil,                    // Snipers
    nil,                    // Teams
    nil                     // SF Teams
];

private _enemyArray = [
    _flatPos,
    "PRIO",
    "#rnd",
    _vehAmount,
    _infAmount,
    25,
    400
] call AW_fnc_spawnEnemyUnits;

_prioUnits = (_prioUnits + _enemyArray);


// Task and stuff
private _fuzzyPos = [_flatPos] call AW_fnc_getFuzzyPos;

InA_Server_PrioMarkers = ["PRIO", "Vehicle Depot", _fuzzyPos, 300] call AW_fnc_missionMarkersCreate;
private _prioMarker = (InA_Server_PrioMarkers # 0);

private _taskText = "The enemy has set up a vehicle depot, reinforcing the AO with vehicles until it is taken out!<br/><br/>First kill the officer inside the office, then destroy the depot.<br/><br/>Depot:<br/><img image='Media\Briefing\prioDepot.jpg' width='300' height='150'/>";

[
    west,
    "prioDepotTask",
    [
        _taskText,
        "Priority Target: Vehicle Depot",
        _prioMarker
    ],
    _fuzzyPos,
    "Created",
    0,
    true,
    "repair",
    true
] call BIS_fnc_taskCreate;


// Main loop
InA_Server_PrioMissionSpawned = true;
InA_Server_PrioMissionUp = true;

private _intervalMin = 300;
private _intervalMax = 840;
private _lastSpawn = -_intervalMax;
private _vehiclesMin = 1;
private _vehiclesMax = 6;

private _groupCounter = 1;
private _prioGroups = [];
InA_Server_AOReinforceVehicleCount = 0;
private _currentAO = InA_Server_currentAO;

while {sleep 5; ((alive _depot) && InA_Server_PrioMissionUp)} do {
    // Pause if Main AO is shutdown
    if (InA_Server_MainAOShutdown) then {continue};

    // Check if there is a new AO to reinforce
    if (_currentAO != InA_Server_currentAO) then {
        _currentAO = InA_Server_currentAO;
        [_prioGroups] call _retask;
    };

    // Get wait time based on playercount
    private _interval = (ceil (linearConversion [1, 60, InA_Server_PlayerCount, _intervalMax, _intervalMin, true]));

    // Not enough time has passed or at vehicle limit
    if (
        (time < (_lastSpawn + _interval)) ||
        (InA_Server_AOReinforceVehicleCount >= InA_Server_AOReinforceVehicleLimit)
    ) then {continue};

    // Lets spawn a vehicle
    private _vehType = (selectRandomWeighted _vehicles);
    private _veh = createVehicle [_vehType, [0, 0, 0], [], 50, "NONE"];
    _veh setDir (_rndDir - 180);
    _veh setPosATL _spawnPos;

    waitUntil {sleep 0.1; !isNull _veh};

    _veh call AW_fnc_vehicleCustomizationOpfor;

    private _grp = createVehicleCrew _veh;

    _grp = [_grp] call AW_fnc_changeGroupSide;

    _grp setGroupIdGlobal [format ["AO-Reinforce-Vehicle-%1", _groupCounter]];

    _prioGroups pushBack _grp;

    _veh allowCrewInImmobile [true, true];
    _veh lock 3;

    [(units _grp) + [_veh]] call AW_fnc_addToAllCurators;
    [(units _grp)] call derp_fnc_AISkill;

    _lastSpawn = time;

    0 = [_veh] spawn {
        params ["_veh"];

        InA_Server_AOReinforceVehicleCount = (InA_Server_AOReinforceVehicleCount + 1);

        _veh setVariable ["InA_AOReinforceType", "Vehicle", true];

        [_veh] call AW_fnc_enemyReinforceCounterEH;

        _veh doMove (_veh getPos [25, (getDir _veh)]);

        waitUntil {sleep 1; unitReady _veh};

        private _grp = (group (driver _veh));

        [_grp, (getMarkerPos InA_Server_currentAO), nil, (InA_Server_MainAOSize * 0.75)] call AW_fnc_taskRndPatrol;

        _grp setBehaviour "COMBAT";
        _grp setCombatMode "RED";
    };

    _groupCounter = (_groupCounter + 1);
};


// Success
private _msg = "<t align='center'><t size='2.2'>Prio Mission Complete</t><br/>____________________<br/>Fantastic job, lads! The depot has been destroyed!</t>";
[_msg] remoteExec ["AW_fnc_globalHint", 0];

private _taskStatus = "Succeeded";

if (!InA_Server_PrioMissionUp) then {
    _taskStatus = "Failed";
};

0 = ["prioDepotTask", _taskStatus] spawn AW_fnc_finishTask;

[InA_Server_PrioMarkers] call AW_fnc_missionMarkersRemove;


// Cleanup
0 = [_flatPos, _prioThings, _prioUnits, _prioGroups, _mapObjs] spawn {
    params ["_pos", "_stuff", "_units", "_groups", "_terrainObjs"];

    sleep 120;

    [(_stuff + _units)] spawn AW_fnc_delete;

    {
        if (isObjectHidden _x) then {_x hideObjectGlobal false};
    } forEach _terrainObjs;

    {
        private _veh = (vehicle (leader _x));

        [(units _x)] spawn AW_fnc_delete;

        deleteVehicle _veh;
    } forEach _groups;
};
