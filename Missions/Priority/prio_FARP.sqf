/*
 * Author: Whigital
 *
 * FARP Prio mission that spawns heli reinforcements
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

    private _vectorUp = [0,0,1];

    if (!_setStraight) then {
        _vectorUp = (surfaceNormal _pos);
    };

    _obj setVectorUp _vectorUp;
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
    ["Land_HBarrier_Big_F",[-9.88232,-15.689,-0.222779],225],
    ["Land_HBarrier_Big_F",[-10.5811,-5.99707,-0.222779],270],
    ["Land_HBarrier_Big_F",[-12.647,-6.11816,-0.222779],270],
    ["Land_HBarrier_Big_F",[-8.48047,-14.2637,-0.222779],225],
    ["Land_HBarrier_Big_F",[-9.03125,-14.689,1.97898],225],
    ["Land_HBarrier_Big_F",[-11.7476,-6.06445,2.03463],270],
    ["Land_HBarrier_Big_F",[-10.7427,4.36035,-0.222779],270],
    ["Land_HBarrier_Big_F",[-11.2896,19.2134,-0.222779],315],
    ["Land_HBarrier_Big_F",[8.96387,-14.9893,1.97696],135],
    ["Land_HBarrier_Big_F",[-0.0146484,-18.9453,-0.222779],0],
    ["Land_HBarrier_Big_F",[9.8877,-15.7998,-0.222779],135],
    ["Land_HBarrier_Big_F",[10.0532,-6.17676,-0.222779],90],
    ["Land_HBarrier_Big_F",[12.1143,-6.07568,-0.222779],90],
    ["Land_HBarrier_Big_F",[10.9912,-6.07471,1.89922],90],
    ["Land_HBarrier_Big_F",[9.7583,4.40674,-0.222779],90],
    ["Land_HBarrier_Big_F",[8.40625,-14.229,-0.222779],135],
    ["Land_HBarrier_Big_F",[10.5293,19.3604,-0.222779],45],
    ["Land_HBarrier_Big_F",[0.143555,24.5107,-0.222779],0],
    ["Land_Razorwire_F",[-15.4224,1.93604,-0.222779],286.713],
    ["Land_Razorwire_F",[-15.4146,12.0444,-0.222779],252.623],
    ["Land_Razorwire_F",[14.3462,1.59375,-0.222779],70.0496],
    ["Land_Razorwire_F",[14.667,11.5596,-0.222779],116.256]
];

private _platformObjs = [
    ["CargoPlaftorm_01_brown_F",[2.92969,-3.93164,-6.35778],0],
    ["CargoPlaftorm_01_brown_F",[-3.08496,-9.9458,-6.35778],0],
    ["CargoPlaftorm_01_brown_F",[2.92969,-9.9458,-6.35778],0],
    ["CargoPlaftorm_01_brown_F",[-3.08496,-3.93164,-6.35778],0]
];

private _platformThingObjs = [
    ["Land_EngineCrane_01_F",[-4.88184,-2.19238,0.823028],303.525],
    ["Land_Missle_Trolley_02_F",[-5.17383,-6.74854,0.823028],173.507],
    ["Land_MRL_Magazine_01_F",[4.55615,-3.45605,0.823028],172.359],
    ["Land_Bomb_Trolley_01_F",[4.65234,-10.8335,0.823028],196.502]
];

private _thingObjs = [
    ["Box_East_AmmoVeh_F",[-4.10791,1.271,-0.222783],120.054],
    ["Land_Pallet_MilBoxes_F",[4.66602,1.12158,-0.222783],84.4252],
    ["Land_PalletTrolley_01_khaki_F",[2.91113,0.574707,-0.222783],342.088],
    ["Land_PowerGenerator_F",[1.92432,20.0771,-0.222779],265.512],
    ["WaterPump_01_sand_F",[-2.31934,20.3164,-0.222779],56.5432]
];

private _guardObjs = [
    ["rhs_vdv_rifleman",[-1.48047,2.64502,-0.221344],216.103],
    ["rhs_vdv_rifleman",[-9.62256,11.4282,-0.22134],302.064],
    ["rhs_vdv_rifleman",[-13.3374,0.0488281,-0.22134],269.732],
    ["rhs_vdv_rifleman",[-8.46729,3.4209,-0.221344],114.152],
    ["rhs_vdv_rifleman",[-7.24219,-9.72363,-0.22134],139.385],
    ["rhs_vdv_rifleman",[-2.07422,-15.0327,-0.221344],213.223],
    ["rhs_vdv_rifleman",[3.66357,-14.9517,-0.221344],146.245],
    ["rhs_vdv_rifleman",[7.06445,5.73389,-0.22134],165.925],
    ["rhs_vdv_rifleman",[9.21289,17.0991,-0.22134],82.1985],
    ["rhs_vdv_rifleman",[12.1064,1.60645,-0.22134],130.703],
    ["rhs_vdv_rifleman",[10.3179,10.0347,-0.22134],89.9787],
    ["rhs_vdv_rifleman",[2.67773,2.17578,-0.221344],164.571]
];

private _hqWalls = [
    ["Land_Shoot_House_Wall_Crouch_F",[0.541992,-0.388626,-3.27373],0],
    ["Land_Shoot_House_Wall_F",[5.23291,-3.85249,-3.2734],0],
    ["Land_ConcreteWall_03_m_2m_F",[1.7002,-2.47652,-3.2734],90],
    ["Land_ConcreteWall_03_m_2m_F",[6.59375,-2.78804,-3.2734],180],
    ["Land_ConcreteWall_03_m_2m_F",[1.7041,-0.492629,-3.2734],90],
    ["Land_ConcreteWall_03_m_2m_F",[4.61426,-2.78804,-3.2734],180],
    ["Land_ConcreteWall_03_m_2m_F",[1.7002,1.46977,-3.2734],90],
    ["Land_ConcreteWall_03_m_2m_F",[1.7002,3.43169,-3.2734],90],
    ["Land_ConcreteWall_03_m_2m_F",[4.68652,-0.46382,-3.27373],0],
    ["Land_ConcreteWall_03_m_2m_F",[2.71045,-0.463821,-3.27373],0],
    ["Land_ConcreteWall_03_m_2m_F",[-2.37842,-2.50825,-3.27373],90],
    ["Land_ConcreteWall_03_m_2m_F",[-3.32617,-1.48921,-3.27373],0],
    ["Land_Shoot_House_Wall_Long_Crouch_F",[5.63965,1.52983,-3.2734],90],
    ["Land_Shoot_House_Corner_Crouch_F",[-1.04102,0.0478978,-3.2734],180]
];

private _hqStuff = [
    ["Land_MapBoard_01_Wall_Altis_F",[0.123047,4.4268,-2.23802],180],
    ["Land_CampingChair_V2_F",[0.460449,1.65483,-3.27373],287.57],
    ["Land_CampingChair_V2_F",[0.492676,2.80522,-3.27373],259.349],
    ["Land_Tablet_02_sand_F",[5.14795,2.72759,-2.38647],119.744],
    ["Land_Router_01_sand_F",[2.69727,5.34282,-2.45903],307.788],
    ["Land_PortableServer_01_sand_F",[2.66406,5.41216,-2.80617],339.623],
    ["Land_PortableServer_01_sand_F",[5.13037,1.04839,-2.38647],174.137],
    ["Land_PortableServer_01_sand_F",[2.66406,5.41216,-3.15331],342.454],
    ["Land_MultiScreenComputer_01_sand_F",[5.29199,6.00249,-2.26638],189.723],
    ["Land_MultiScreenComputer_01_sand_F",[2.57129,0.085984,-2.38679],13.4048],
    ["Land_MultiScreenComputer_01_sand_F",[4.16113,0.101609,-2.38679],340.034],
    ["Land_IPPhone_01_sand_F",[6.02344,5.98686,-2.25714],209.224],
    ["Land_Laptop_03_sand_F",[6.81836,6.0186,-2.26638],185.761],
    ["Land_PortableGenerator_01_sand_F",[8.14795,3.18071,-3.1534],270],
    ["MapBoard_altis_F",[2.30029,3.66655,-3.27373],100.105],
    ["Land_TripodScreen_01_large_sand_F",[3.521,5.87895,-3.15331],332.639],
    ["Land_PortableDesk_01_sand_F",[5.14063,1.8145,-3.2734],90],
    ["Land_PortableDesk_01_sand_F",[6.0166,6.05278,-3.15331],0],
    ["Land_PortableDesk_01_sand_F",[3.40137,0.0947731,-3.27373],180],
    ["SatelliteAntenna_01_Sand_F",[2.67822,-4.09273,1.8806],320.812],
    ["SatelliteAntenna_01_Mounted_Sand_F",[8.20898,-4.80025,-0.786991],270],
    ["CamoNet_OPFOR_open_F",[2.33936,0.689988,0.2406],348.07],
    ["Land_FieldToilet_F",[3.78076,-4.18696,-3.27373],0],
    ["OmniDirectionalAntenna_01_sand_F",[6.76611,-4.31099,1.8806],91.7],
    ["Land_PortableCabinet_01_4drawers_sand_F",[3.37402,0.0107888,-2.37755],2.95337],
    ["Land_PortableCabinet_01_7drawers_sand_F",[5.10742,2.05278,-2.37723],288.002],
    ["Land_CampingTable_F",[-0.424316,2.17534,-3.27373],270.671],
    ["Land_Tableware_01_cup_F",[-3.4834,-0.397903,-2.46039],0],
    ["Land_Tableware_01_cup_F",[-3.36963,-0.445755,-2.46039],0],
    ["Land_CampingTable_small_F",[-3.66162,-0.732864,-3.2734],90],
    ["Land_LiquidDispenser_01_F",[-3.48779,-0.817337,-2.46039],259.865],
    ["Land_BottlePlastic_V2_F",[-0.377441,2.56401,-2.45813],0],
    ["Land_BottlePlastic_V2_F",[-0.496582,2.43755,-2.45813],0],
    ["Land_TacticalBacon_F",[-0.388184,1.8062,-2.45813],0],
    ["Land_TacticalBacon_F",[-0.489746,1.69927,-2.45813],0],
    ["Land_CampingChair_V2_F",[-1.38965,2.69389,-3.27373],148.759],
    ["Land_WaterCooler_01_new_F",[-4.06641,2.64897,-3.2734],90],
    ["Fridge_01_closed_F",[-3.88867,3.8726,-3.27373],99.1796],
    ["Land_AirConditioner_01_F",[-4.71094,0.855026,-3.1534],177.692]
];

private _hqHMGs = [
    ["rhs_KORD_high_VDV",[6.79541,-2.06099,-0.748883],270],
    ["rhs_KORD_high_VDV",[6.69336,3.11919,-0.748883],225],
    ["rhs_KORD_high_VDV",[-2.7334,-4.57906,-0.748401],45],
    ["rhs_KORD_high_VDV",[-3.06299,3.44048,-0.748883],135]
];

private _hqGuards = [
    ["rhs_vdv_rifleman",[-0.0170898,-4.66402,-0.747444],352.443],
    ["rhs_vdv_rifleman",[6.40918,4.80327,-3.15187],319.97],
    ["rhs_vdv_rifleman",[4.55371,-1.34712,-3.27229],0.64489],
    ["rhs_vdv_rifleman",[4.22266,5.46001,-0.795245],179.671],
    ["rhs_vdv_rifleman",[7.75342,-1.78462,-3.15187],80.3964],
    ["rhs_vdv_rifleman",[6.92529,-4.15816,-3.27229],81.3475],
    ["rhs_vdv_rifleman",[0.612793,-1.92769,-3.27229],68.2317],
    ["rhs_vdv_rifleman",[4.20215,3.45122,-3.27229],256.216],
    ["rhs_vdv_rifleman",[0.436523,0.396531,-3.27229],113.081],
    ["rhs_vdv_rifleman",[6.47461,0.753465,-0.747444],266.53],
    ["rhs_vdv_rifleman",[-1.74902,-4.39497,-3.27229],89.2975],
    ["rhs_vdv_rifleman",[-3.19141,-2.79878,-0.747444],84.8661],
    ["rhs_vdv_rifleman",[-2.62158,2.48637,-3.27229],27.5423],
    ["rhs_vdv_rifleman",[-3.40674,0.447312,-3.27229],359.837],
    ["rhs_vdv_rifleman",[-2.99072,0.729538,-0.747444],84.8661],
    ["rhs_vdv_rifleman",[-0.580078,3.26762,-0.747444],151.292]
];


private _hqOfficer = ["O_officer_F",[3.47803,1.79497,-3.27229],20.2769];

private _padObj = ["RoadCone_F",[-0.118164,-6.91406,0.816441],0];
private _hqObj = ["Land_Cargo_HQ_V3_F",[1.44922,12.4438,-0.222778],180];

private _aoPos = (getMarkerPos InA_Server_currentAO);
private _aoDir = (_flatPos getDir _aoPos);
private _rndDir = (((_aoDir - 45) + (random 90)) + 180);


// Hide nearby terrainobjects
private _mapObjs = (nearestTerrainObjects [_flatPos, [], 50, false, true]);

{
    _x hideObjectGlobal true;
} forEach _mapObjs;


// Spawn origin
private _origin = createVehicle ["Land_Balloon_01_air_F", [0,0,0], [], 100, "NONE"];
_origin allowDamage false;
_origin setDir _rndDir;
_origin setPos _flatPos;
_origin setVectorUp [0,0,1];


private _spawnPosData = [_origin, _padObj, _rndDir, true] call AW_fnc_spawnRelative;
_spawnPosData params ["_heliPos", "_heliDir"];
_heliPos set [2, ((_heliPos # 2) + 0.2)];

private _idlePos = +_heliPos;
_idlePos set [2, ((_idlePos # 2) + 20)];


// Spawn walls
{
    private _obj = [_origin, _x, _rndDir] call AW_fnc_spawnRelative;
    private _height = ((_x # 1) # 2);
    _obj allowDamage false;

    [_obj, false] call _orientate;

    if (_height > 1) then {
        private _pos = (getPosATL _obj);
        _pos set [2, _height];
        _obj setPosATL _pos;
    };

    _prioThings pushBack _obj;
} forEach _wallObjs;


// Spawn platforms
{
    private _obj = [_origin, _x, _rndDir] call AW_fnc_spawnRelative;
    _obj allowDamage false;

    {
        _obj animateSource [(format ["Panel_%1_hide_source", _x]), 1, true];
    } forEach [1, 2, 3, 4];

    _prioThings pushBack _obj;
} forEach _platformObjs;


// Spawn thing on platforms
{
    private _obj = [_origin, _x, _rndDir] call AW_fnc_spawnRelative;
    _obj allowDamage false;
    _prioThings pushBack _obj;
} forEach _platformThingObjs;


// Spawn other things
{
    private _obj = [_origin, _x, _rndDir, nil, true] call AW_fnc_spawnRelative;
    _obj allowDamage false;
    [_obj, false] call _orientate;
    _prioThings pushBack _obj;
} forEach _thingObjs;


// Spawn main guards
private _guardGrp = (createGroup InA_EnemyFactionSide);

{
    private _posData = [_origin, _x, _rndDir, true] call AW_fnc_spawnRelative;
    private _unitType = [(selectRandom _unitTypes)] call AW_fnc_getUnitsFromHash;
    private _unit = _guardGrp createUnit [_unitType, [0,0,0], [], 0, "NONE"];

    _posData params ["_pos", "_dir"];

    _unit setDir _dir;
    _unit setPosATL _pos;

    _unit disableAI "PATH";
    _unit setUnitPos "UP";

    _prioUnits pushBack _unit;
} forEach _guardObjs;

_guardGrp = [_guardGrp] call AW_fnc_changeGroupSide;
_guardGrp setGroupIdGlobal ["PRIO-Guard-Group"];

[_guardGrp] spawn AW_fnc_transferGroupHC;


// Spawn HQ
private _hq = [_origin, _hqObj, _rndDir] call AW_fnc_spawnRelative;
_hq allowDamage false;
_hq call _orientate;
_prioThings pushBack _hq;

_hq animateSource ["Hatch_1_source", 0, true];


private _hqObjs = [];

// Spawn HQ walls
{
    private _obj = [_hq, _x, _rndDir] call AW_fnc_spawnRelative;
    _obj allowDamage false;
    _prioThings pushBack _obj;
    _hqObjs pushBack _obj;
} forEach _hqWalls;


// Spawn HQ stuff
{
    private _obj = [_hq, _x, _rndDir] call AW_fnc_spawnRelative;
    _obj allowDamage false;
    _obj enableSimulationGlobal false;
    _prioThings pushBack _obj;
    _hqObjs pushBack _obj;
} forEach _hqStuff;


_hq setVariable ["onDestroyedToDelete", _hqObjs];

_hq addEventHandler ["Killed", {
    params ["_unit", "_killer", "_instigator", "_useEffects"];

    private _objs = _unit getVariable ["onDestroyedToDelete", []];

    {
        deleteVehicle _x;
    } forEach _objs;
}];


// Spawn HQ officer
private _hqGrp = (createGroup InA_EnemyFactionSide);

private _officer = _hqGrp createUnit [["#officers"] call AW_fnc_getUnitsFromHash, [0,0,0], [], 0, "NONE"];
private _officerData = [_hq, _hqOfficer, _rndDir, true] call AW_fnc_spawnRelative;

_officer setDir (_officerData # 1);
_officer setPosATL (_officerData # 0);

_officer setVariable ["HQBuilding", _hq];

_officer addMPEventHandler ["MPKilled", {
    params ["_unit", "_killer", "_instigator", "_useEffects"];

    if (!isServer) exitWith {};

    private _hq = _unit getVariable ["HQBuilding", objNull];

    _hq allowDamage true;

    private _msg = "<t align='center'><t size='2.2'>Prio Mission update</t><br/>____________________<br/>Good job, the OPFOR Officer has been killed!<br/><br/>Now destroy the HQ building</t>";
    [_msg] remoteExec ["AW_fnc_globalHint", 0];
}];

_officer disableAI "PATH";
_officer setUnitPos "UP";

_prioUnits pushBack _officer;


// Spawn HQ HMGs
{
    private _hmg = [_hq, _x, _rndDir] call AW_fnc_spawnRelative;
    private _dir = (getDir _hmg);

    _hmg addMagazineTurret ["100Rnd_127x99_mag_Tracer_Green", [0]];
    _hmg addMagazineTurret ["100Rnd_127x99_mag_Tracer_Green", [0]];

    _hmg lock true;
    _hmg enableWeaponDisassembly false;

    private _gunner = _hqGrp createUnit [["#engineers"] call AW_fnc_getUnitsFromHash, [0,0,0], [], 0, "NONE"];

    _gunner setDir _dir;
    _gunner moveInGunner _hmg;

    _prioUnits pushBack _gunner;
    _prioThings pushBack _hmg;
} forEach _hqHMGs;


// Spawn HQ guards
{
    private _posData = [_hq, _x, _rndDir, true] call AW_fnc_spawnRelative;
    private _unitType = [(selectRandom _unitTypes)] call AW_fnc_getUnitsFromHash;
    private _unit = _hqGrp createUnit [_unitType, [0,0,0], [], 0, "NONE"];

    _posData params ["_pos", "_dir"];

    _unit setDir _dir;
    _unit setPosATL _pos;

    _unit disableAI "PATH";
    _unit setUnitPos "UP";

    _prioUnits pushBack _unit;
} forEach _hqGuards;

_hqGrp = [_hqGrp] call AW_fnc_changeGroupSide;
_hqGrp setGroupIdGlobal ["PRIO-HQ-Group"];

[_hqGrp, [[_hq, (getPos _hq)], {
    params ["_hq", "_pos"];

    waitUntil {
        sleep 1;
        (_hq in (_pos nearObjects [(typeOf _hq), 2]))
    };
}]] spawn AW_fnc_transferGroupHC;


[_prioUnits] call derp_fnc_AISkill;
[_prioUnits] remoteExec ["AW_fnc_addToAllCurators", 2];


// Spawn complete, delete reference
deleteVehicle _origin;

private _patrolBlacklist = [[_flatPos, 40]];


private _vehAmount = [
    (selectRandom [0, 1]),  // MBTs
    (1 + (random 1)),       // SPAAs
    (1 + (random 1)),       // IFVs
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

// Main protection
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

InA_Server_PrioMarkers = ["PRIO", "Enemy F.A.R.P", _fuzzyPos, 300] call AW_fnc_missionMarkersCreate;
private _prioMarker = (InA_Server_PrioMarkers # 0);

private _taskText = "The enemy is operating a F.A.R.P nearby, resupplying their attack helicopters with weaponry. The AO will be reinforced with CAS helis until the F.A.R.P is neutralized!<br /><br />First kill the officer inside the HQ, then destroy the HQ.";

[
    west,
    "prioFARPTask",
    [
        _taskText,
        "Priority Target: CSAT F.A.R.P",
        _prioMarker
    ],
    _fuzzyPos,
    "Created",
    0,
    true,
    "rearm",
    true
] call BIS_fnc_taskCreate;


// Main loop
InA_Server_PrioMissionSpawned = true;
InA_Server_PrioMissionUp = true;

private _intervalMin = 300;
private _intervalMax = 840;
private _lastSpawn = -_intervalMax;

if (isNil "InA_AOReinforceHeliCounter") then {
    InA_AOReinforceHeliCounter = 0;
};

while {sleep 5; (InA_Server_PrioMissionUp && (alive _hq))} do {
    // Pause if Main AO is shutdown
    if (InA_Server_MainAOShutdown) then {continue};

    // Get wait time based on playercount
    private _interval = (ceil (linearConversion [1, 60, InA_Server_PlayerCount, _intervalMax, _intervalMin, true]));

    // Not enough time has passed or at heli limit
    if (
        (time < (_lastSpawn + _interval)) ||
        (InA_Server_AOReinforceHeliCount >= InA_Server_AOReinforceHeliLimit)
    ) then {continue};

    // Lets spawn a vehicle
    private _heliType = ["#cas_helis"] call AW_fnc_getUnitsFromHash;
    private _heli = createVehicle [_heliType, [0,0,0], [], 50, "NONE"];
    _heli setDir (_heliDir - 180);
    _heli setPosATL _heliPos;

    waitUntil {sleep 0.1; !isNull _heli};

    _heli call AW_fnc_vehicleCustomizationOpfor;

    _heli engineOn true;

    private _grp = createVehicleCrew _heli;

    InA_AOReinforceHeliCounter = (InA_AOReinforceHeliCounter + 1);
    _grp = [_grp] call AW_fnc_changeGroupSide;
    _grp setGroupIdGlobal [format ["AO-Reinforce-Heli-%1", InA_AOReinforceHeliCounter]];

    _heli allowCrewInImmobile true;
    _heli lock 3;

    [(units _grp) + [_heli]] call AW_fnc_addToAllCurators;
    [(units _grp)] call derp_fnc_AISkill;

    _lastSpawn = time;

    0 = [_heli] spawn {
        params ["_heli"];

        InA_Server_AOReinforceHeliCount = (InA_Server_AOReinforceHeliCount + 1);

        _heli setVariable ["InA_AOReinforceType", "Heli", true];

        _heli doMove (_heli getPos [10, (getDir _heli)]);

        waitUntil {sleep 1; (((getPosATL _heli) # 2) > 3) && {unitReady _heli}};

        [_heli, true, nil, (InA_Server_MainAOSize * (0.5 + (random 0.5))), (InA_Server_MainAOSize * 1.5)] spawn AW_fnc_enemyAirEngagement;
    };
};


// Success
private _msg = "<t align='center'><t size='2.2'>Prio Mission Complete</t><br/>____________________<br/>Fantastic job, lads! The F.A.R.P has been disabled!</t>";
[_msg] remoteExec ["AW_fnc_globalHint", 0];

0 = ["prioFARPTask"] spawn AW_fnc_finishTask;

[InA_Server_PrioMarkers] call AW_fnc_missionMarkersRemove;


// Cleanup
0 = [_flatPos, _prioThings, _prioUnits, _mapObjs] spawn {
    params ["_pos", "_things", "_units", "_terrainObjs"];

    sleep 120;

    deleteVehicle (nearestObject [_pos, "Land_Cargo_HQ_V3_ruins_F"]);

    [(_things + _units)] spawn AW_fnc_delete;

    {
        if (isObjectHidden _x) then {_x hideObjectGlobal false};
    } forEach _terrainObjs;
};
