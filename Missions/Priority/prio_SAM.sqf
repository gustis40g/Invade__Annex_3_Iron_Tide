/*
 * Author: chicken_no6
 *
 * Description: CSAT SAM site prio mission
 * Last modified:
 *
 *  2022-04-22: Include chicken_no6's fixes - Whigital
 *  2022-02-17: Integrate into I&A 3 - Whigital
 *
 */

private _samSiteObj = [
    ["CamoNet_OPFOR_big_F",[-15.6758,-14.911,-4.8754],244.032],
    ["Land_PowerGenerator_F",[3.625,-6.875,-4.8754],269.305],
    ["Land_Cargo_House_V2_F",[-17.5,13.75,-4.3754],325],
    ["CamoNet_OPFOR_big_F",[-16.8081,15.049,-4.8754],331.468],
    ["Land_PaperBox_open_full_F",[-14.25,17.5,-4.8754],0],
    ["Land_PaperBox_open_full_F",[-11.75,15.5,-4.8754],150]
];


private _trenches = [
    ["Land_Trench_01_forest_F",[-23.4375,-15.3845,-2.89951],76.6422],
    ["Land_Trench_01_forest_F",[-22.6426,-12.2376,-2.89951],122.88],
    ["Land_Trench_01_forest_F",[-32.3276,-5.27051,-2.8754],89.758],
    ["Land_Trench_01_forest_F",[-21.7603,-18.6947,-2.89951],43.5322],
    ["Land_Trench_01_forest_F",[-32.2651,-1.34766,-2.8754],89.758],
    ["Land_Trench_01_forest_F",[-20.6143,-9.06146,-2.84626],122.88],
    ["Land_Trench_01_forest_F",[-32.25,2.625,-2.8754],89.758],
    ["Land_Trench_01_forest_F",[-23.7256,12.4404,-2.92865],51.8417],
    ["Land_Trench_01_forest_F",[-24.6479,15.1705,-2.92865],88.9464],
    ["Land_Trench_01_forest_F",[-20.8599,20.9576,-2.92865],130.968],
    ["Land_Trench_01_forest_F",[-21.3687,9.37616,-2.92865],51.8417],
    ["Land_Trench_01_forest_F",[-23.4043,18.1079,-2.92865],129.654],
    ["Land_Trench_01_forest_F",[-32.1895,6.44727,-2.8754],90],
    ["Land_Trench_01_forest_F",[6.73975,-28.9677,-2.84626],359.758],
    ["Land_Trench_01_forest_F",[-1.15576,-28.8901,-2.84626],359.758],
    ["Land_Trench_01_forest_F",[2.81689,-28.9055,-2.84626],359.758],
    ["Land_Trench_01_forest_F",[-4.97803,-28.8298,-2.84626],359.758],
    ["Land_Trench_01_forest_F",[-19.0269,-21.364,-2.89951],42.2176],
    ["Land_Trench_01_forest_F",[-6.94824,-17.554,-2.8994],325.499],
    ["Land_Trench_01_forest_F",[-18.5181,-5.90497,-2.84626],122.88],
    ["Land_Trench_01_forest_F",[9.61816,-16.175,-2.8464],33.516],
    ["Land_Trench_01_forest_F",[-10.2129,-19.721,-2.89951],324.405],
    ["Land_Trench_01_forest_F",[-13.3799,-21.9385,-2.89951],324.405],
    ["Land_Trench_01_forest_F",[-16.1484,-22.7378,-2.89951],1.5101],
    ["Land_Trench_01_forest_F",[-17.6279,22.7813,-2.92865],164.079],
    ["Land_Trench_01_forest_F",[-19.0581,6.21143,-2.92865],52.9352],
    ["Land_Trench_01_forest_F",[-14.4487,22.1284,-2.92865],210.317],
    ["Land_Trench_01_forest_F",[-1.16064,30.5563,-2.8754],179.758],
    ["Land_Trench_01_forest_F",[-7.93799,18.291,-2.8754],210.317],
    ["Land_Trench_01_forest_F",[-11.1851,20.2439,-2.8754],210.317],
    ["Land_Trench_01_forest_F",[9.59521,17.7748,-2.89951],145.119],
    ["Land_Trench_01_forest_F",[2.81201,30.541,-2.8754],179.758],
    ["Land_Trench_01_forest_F",[6.63428,30.4807,-2.8754],179.758],
    ["Land_Trench_01_forest_F",[-5.0835,30.6186,-2.8754],179.758],
    ["Land_Trench_01_forest_F",[21.3438,-20.2913,-2.89951],314.168],
    ["Land_Trench_01_forest_F",[24.0435,-17.5881,-2.89951],312.854],
    ["Land_Trench_01_forest_F",[18.7529,-21.2917,-2.89951],353.613],
    ["Land_Trench_01_forest_F",[16.1357,-20.6155,-2.89951],33.5162],
    ["Land_Trench_01_forest_F",[12.8672,-18.3662,-2.84626],33.5162],
    ["Land_Trench_01_forest_F",[25.0513,-15.0634,-2.89951],272.95],
    ["Land_Trench_01_forest_F",[22.2456,-9.22156,-2.89951],235.041],
    ["Land_Trench_01_forest_F",[24.3955,-12.3525,-2.89951],235.041],
    ["Land_Trench_01_forest_F",[20.0352,-5.89355,-2.89951],235.041],
    ["Land_Trench_01_forest_F",[33.769,2.59729,-2.8754],269.812],
    ["Land_Trench_01_forest_F",[33.75,-1.375,-2.8754],269.812],
    ["Land_Trench_01_forest_F",[33.686,-5.19727,-2.8754],269.812],  
    ["Land_Trench_01_forest_F",[18.7607,23.0195,-2.89951],181.13],
    ["Land_Trench_01_forest_F",[23.9893,19.291,-2.89951],223.152],
    ["Land_Trench_01_forest_F",[21.2383,21.9423,-2.89951],221.838],
    ["Land_Trench_01_forest_F",[22.2144,10.7819,-2.84626],302.5],
    ["Land_Trench_01_forest_F",[15.9976,22.2013,-2.89951],144.025],
    ["Land_Trench_01_forest_F",[25.2129,16.7775,-2.89951],262.597],
    ["Land_Trench_01_forest_F",[12.8457,19.9628,-2.89951],144.025],
    ["Land_Trench_01_forest_F",[24.4063,14.0894,-2.89951],302.5],
    ["Land_Trench_01_forest_F",[20.082,7.49329,-2.84626],302.5],
    ["Land_Trench_01_forest_F",[33.835,6.52063,-2.8754],269.812]
];


private _hqGuardsArray = [
    ["O_soldierU_TL_F",[4.74121,3.22882,-3.27229],0],
    ["O_soldierU_medic_F",[2.92383,-4.11041,-3.27229],0],
    ["O_soldierU_AR_F",[6.05908,-1.76385,-0.747444],0],
    ["O_soldierU_M_F",[-2.8335,-4.05585,-0.747444],0],
    ["O_soldierU_LAT_F",[5.95264,3.24298,-0.747444],0],
    ["O_soldierU_F",[-3.39746,-4.79694,-3.27229],0],
    ["O_SoldierU_SL_F",[-1.44434,1.45154,-3.27229],0],
    ["O_soldierU_A_F",[-2.80811,3.13812,-0.747444],0]
];


private _samSystemObj = [
    ["O_SAM_System_04_F",[16.8496,-13.0015,-4.8754],135],
    ["O_SAM_System_04_F",[17.0132,14.732,-4.8754],45]
];


private _trencheClasses = [
    "Land_Trench_01_forest_F",
    "Land_Trench_01_grass_F"
];


private _orientate = {
    params ["_obj", ["_setStraight", false]];

    private _pos = (getPosATL _obj);

    _pos set [2, 0];
    _obj setPosATL _pos;

    private _vectorUp = [0, 0, 1];

    if (!_setStraight) then {
        _vectorUp = (surfaceNormal _pos);
    };

    _obj setVectorUp _vectorUp;
};


private _enableSensors = {
    params ["_vehicle"];

    {
        _x params ["_component", "_sensor"];

        private _sensorStatus = ((_vehicle isVehicleSensorEnabled _component) # 0);

        if (!(_sensorStatus # 1)) then {
            _vehicle enableVehicleSensor [_component, true];
        };
    } forEach (listVehicleSensors _vehicle);

    _vehicle setVehicleRadar 1;
    _vehicle setVehicleReceiveRemoteTargets true;
    _vehicle setVehicleReportRemoteTargets true;
    _vehicle setVehicleReportOwnPosition true;
};


private _SAMs = [];
private _enemiesArray = [];
private _spawnedObjects = [];
private _rndDir = (random 360);
private _currentAO = InA_Server_currentAO;

private _flatPos = [(getMarkerPos InA_Server_currentAO), 8000, 10, 0.25] call AW_fnc_findSafePos;

private _terrainObjs = (nearestTerrainObjects [_flatPos, [], 40, false, true]);

{
    _x hideObjectGlobal true;
} forEach _terrainObjs;

private _origin = createVehicle ["Land_Cargo_HQ_V2_F", [0, 0, 0], [], 50, "NONE"];
_origin setDir _rndDir;
_origin setPos _flatPos;
_origin allowDamage false;
[_origin, true] call _orientate;

private _pos = (getPosATL _origin);
_pos set [2, ((_pos # 2) + 1)];
_origin setPosATL _pos;
_spawnedObjects pushBack _origin;

private _TTowerSmall = [_origin, ["Land_TTowerSmall_2_F",[1.875,-6.375,-4.8754],0], _rndDir] call AW_fnc_spawnRelative;
_spawnedObjects pushBack _TTowerSmall;
[_TTowerSmall, true] call _orientate;

private _flagCSAT = [_origin, ["Flag_CSAT_F",[7.6792,-4.89587,1.88012],0], _rndDir] call AW_fnc_spawnRelative;
_spawnedObjects pushBack _flagCSAT;

{
    private _data = +_x;
    _data set [0, (selectRandom _trencheClasses)];
    private _obj = [_origin, _data, _rndDir] call AW_fnc_spawnRelative;
    _spawnedObjects pushBack _obj;
    _obj call _orientate;
    private _objPos = (getPosATL _obj);
    _objPos set [2, ((_objPos # 2) + 2)];
    _obj setPosATL _objPos;
} forEach _trenches;


{
    private _obj = [_origin,_x,_rndDir] call AW_fnc_spawnRelative;
    _spawnedObjects pushBack _obj;
    _obj allowDamage false;
    _obj enableSimulation false;
    _obj call _orientate;
    _obj call AW_fnc_vehicleCustomizationOpfor;
    _spawnedObjects pushBack _obj;
} forEach _samSiteObj;

private _PortableDesk = [_origin, ["Land_PortableDesk_01_sand_F",[4.75439,1.25934,-3.27373],0], _rndDir] call AW_fnc_spawnRelative;
_PortableDesk allowDamage false;
_PortableDesk enableSimulation false;
_spawnedObjects pushBack _PortableDesk;

private _laptop = [_origin, ["Land_Laptop_03_sand_F",[5.53027,1.31451,-2.38679],180], _rndDir] call AW_fnc_spawnRelative;

_laptop allowDamage false;
_laptop enableSimulation false;
_laptop setVariable ["Radar_Disabled", false, true];

[
    _laptop,
    "Shutdown Radar",
    "\a3\ui_f\data\IGUI\Cfg\HoldActions\holdAction_search_ca.paa",
    "\a3\ui_f\data\IGUI\Cfg\HoldActions\holdAction_hack_ca.paa",
    "((_target distance _this) <= 2) && {!(_target getVariable ['Radar_Disabled', false])}",
    "((_target distance _this) <= 2) && {!(_target getVariable ['Radar_Disabled', false])}",
    {
        hint "Disabling SAM protection ....";
    },
    {},
    {
        params ["_target", "_caller", "_actionId", "_arguments"];

        ["InA_Event_PrioSAM_RadarShutdown", [_target, _caller]] remoteExecCall ["AW_fnc_eventTrigger", 2];
    },
    {},
    [],
    6,
    0,
    true,
    false
] remoteExecCall ["BIS_fnc_holdActionAdd", 0, true];

_spawnedObjects pushBack _laptop;

private _skins = (selectRandom _skinsArray);

private _ammoTruck = [_origin, ["O_Truck_03_ammo_F",[-13.375,-15.875,-4.8754],233.382], _rndDir] call AW_fnc_spawnRelative;
_spawnedObjects pushBack _ammoTruck;
_ammoTruck allowDamage false;
_ammoTruck enableSimulationGlobal false;
_ammoTruck lock 3;
_ammoTruck setFuel 0;
private _pos = (getPosATL _ammoTruck);
_ammoTruck setPosATL [(_pos # 0), (_pos # 1), 1];
_ammoTruck setVectorUp (surfaceNormal (getPosATL _ammoTruck));
_ammoTruck allowDamage true;
_ammoTruck enableSimulationGlobal true;

_ammoTruck call AW_fnc_vehicleCustomizationOpfor;

InA_PrioAmmoTruck = _ammoTruck;

private _radarSystem = [_origin, ["O_Radar_System_02_F",[2.29199,0.755432,-0.748371],90], _rndDir] call AW_fnc_spawnRelative;
_spawnedObjects pushBack _radarSystem;
private _samSiteGroup = createVehicleCrew _radarSystem;
(crew _radarSystem) join _samSiteGroup;
[_radarSystem] call _enableSensors;
_radarSystem allowDamage false;

_radarSystem doWatch (getMarkerPos _currentAO);

_radarSystem call AW_fnc_vehicleCustomizationOpfor;


{
    private _obj = [_origin, _x, _rndDir] call AW_fnc_spawnRelative;
    private _pos = (getPosATL _obj);
    _obj setPosATL [(_pos # 0), (_pos # 1), 1];
    _obj setVectorUp (surfaceNormal (getPosATL _obj));
    private _tmpGrp = createVehicleCrew _obj;
    (units _tmpGrp) joinSilent _samSiteGroup;
    _obj lock 3;
    _obj allowDamage false;
    _obj allowCrewInImmobile true;
    _SAMs pushBack _obj;
    _spawnedObjects pushBack _obj;

    [_obj] call _enableSensors;

    _obj addMagazineTurret ["magazine_Missile_s750_x4", [0]];
    _obj addMagazineTurret ["magazine_Missile_s750_x4", [0]];
    _obj addMagazineTurret ["magazine_Missile_s750_x4", [0]];

    _obj  addEventHandler ["Reloaded", {
        params ["_unit", "_weapon", "_muzzle", "_newMagazine", "_oldMagazine"];

        if (alive InA_PrioAmmoTruck) then {
            _unit setVehicleAmmo 1;
        };
    }];

    [
        _obj,
        [(_skins # 1), 1]
    ] call BIS_fnc_initVehicle;
} forEach _samSystemObj;

_samSiteGroup = [_samSiteGroup] call AW_fnc_changeGroupSide;
_samSiteGroup setGroupIdGlobal ["PRIO-SAM-Launchers"];
_samSiteGroup setBehaviourStrong "COMBAT";
_samSiteGroup setCombatMode "RED";

_enemiesArray append (units _samSiteGroup);


private _unitTypes = [
    "#riflemen", "#machinegunners", "#marksmen",
    "#engineers", "#medics", "#teamleaders",
    "#heavygunners", "#sharpshooters", "#lats"
];


private _hqGuardsGroup = (createGroup InA_EnemyFactionSide);

{
    private _posData = [_origin, _x, _rndDir, true] call AW_fnc_spawnRelative;
    private _unitType = [(selectRandom _unitTypes)] call AW_fnc_getUnitsFromHash;
    private _unit = _hqGuardsGroup createUnit [_unitType, [0, 0, 0], [], 0, "NONE"];

    _posData params ["_pos", "_dir"];

    _unit setDir _dir;
    _unit setPosATL _pos;

    _unit disableAI "PATH";
    _unit setUnitPos "UP";
} forEach _hqGuardsArray;

_hqGuardsGroup = [_hqGuardsGroup] call AW_fnc_changeGroupSide;
_hqGuardsGroup setGroupIdGlobal ["PRIO-SAM_HQ-Guards"];

_enemiesArray append (units _hqGuardsGroup);

[_hqGuardsGroup, [[_origin, _flatPos], {
    params ["_hq", "_pos"];

    waitUntil {
        sleep 1;
        (_hq in (_pos nearObjects [(typeOf _hq), 2]))
    };
}]] spawn AW_fnc_transferGroupHC;

private _vehAmount = [
    1,                  // MBTs
    0,                  // SPAAs
    (1 + (random 1)),   // IFVs
    (2 + (random 1))    // MRAPs
];

private _infAmount = [
    (3 + (random 1)),   // Squads
    (1 + (random 1)),   // SF Squads
    (1 + (random 1)),   // AA Teams
    (1 + (random 1)),   // AT Teams
    nil,                // Snipers
    (2 + (random 1)),   // Teams
    (2 + (random 1))    // SF Teams
];

private _enemyArray = [
    _flatPos,
    "PRIO",
    "#rnd",
    _vehAmount,
    _infAmount,
    50,
    500
] call AW_fnc_spawnEnemyUnits;

_enemiesArray append _enemyArray;


[_enemiesArray] remoteExec ["AW_fnc_addToAllCurators", 2];
[_enemiesArray, 50] call derp_fnc_AISkill;

_laptop setVariable ["InA_Prio_HQ", _origin];
_laptop setVariable ["InA_Prio_SAMs", _SAMs];


["InA_Event_PrioSAM_RadarShutdown", {
    params ["_event", "_args"];

    _args params ["_laptop", "_caller"];

    _laptop setVariable ["Radar_Disabled", true, true];

    private _updateText = (format ["<t align='center'><t size='2.2'>Prio Mission Update</t><br/>____________________<br/>The SAM protection been disabled by %1, now destroy it!</t>", (name _caller)]);
    [_updateText] remoteExec ["AW_fnc_globalHint", 0];

    private _hq = (_laptop getVariable ["InA_Prio_HQ", objNull]);
    private _sams = (_laptop getVariable ["InA_Prio_SAMs", []]);

    {
        _x allowDamage true;
    } forEach (_sams + [_hq]);
}] call AW_fnc_eventRegister;


private _fuzzyPos = [_flatPos] call AW_fnc_getFuzzyPos;

InA_Server_PrioMarkers = ["PRIO", "SAM Site", _fuzzyPos, 300] call AW_fnc_missionMarkersCreate;
private _prioMarker = (InA_Server_PrioMarkers # 0);

[
    west,
    "prioSAMTask",
    [
        "OPFOR forces are setting up an SAM Site to hit you guys damned hard! We've picked up their positions with thermal imaging scans and have marked it on your map. This is a priority target, boys! They're just setting up now",
        "Priority Target: SAM Site",
        _prioMarker
    ],
    _fuzzyPos,
    "Created",
    0,
    true,
    "attack",
    true
] call BIS_fnc_taskCreate;

InA_Server_PrioMissionSpawned = true;
InA_Server_PrioMissionUp = true;

while {InA_Server_PrioMissionUp} do {
    if (_currentAO != InA_Server_currentAO) then {
        _currentAO = InA_Server_currentAO;

        _radarSystem doWatch (getMarkerPos _currentAO);
    };

    if ((_SAMs findIf {alive _x}) == -1) then {break};

    sleep 5;
};

["InA_Event_PrioSAM_RadarShutdown"] call AW_fnc_eventUnregister;


// Success
private _completeText = "<t align='center'><t size='2.2'>Prio Mission Complete</t><br/>____________________<br/>Fantastic job, lads! The SAM Site has been neutralized!</t>";
[_completeText] remoteExec ["AW_fnc_globalHint", 0];

if (!InA_Server_PrioMissionUp) then {
    {
        _x setDamage 1;
    } forEach (_SAMs + [_radarSystem]);
};

0 = ["prioSAMTask"] spawn AW_fnc_finishTask;

[InA_Server_PrioMarkers] call AW_fnc_missionMarkersRemove;


// Cleanup
0 = [
    _flatPos,
    _spawnedObjects,
    _enemiesArray,
    _terrainObjs,
    ["Land_Cargo_HQ_V2_ruins_F", "Land_Cargo_House_V2_ruins_F"]
] spawn {
    params ["_pos", "_things", "_units", "_terrainObjs", ["_ruinObjs", nil]];

    sleep 120;

    if (!isNil "_ruinObjs") then {
        private _ruins = (nearestObjects [_pos, _ruinObjs, 25]);

        {
            deleteVehicle _x;
        } forEach _ruins;
    };

    [(_things + _units)] spawn AW_fnc_delete;

    {
        if (isObjectHidden _x) then {_x hideObjectGlobal false};
    } forEach _terrainObjs;
};
