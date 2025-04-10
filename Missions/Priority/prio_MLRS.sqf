/*
 * Author: chicken_no6
 *
 * Description: MLRS Artillery Position shoots missels at players ;P
 * Last modified:
 *
 *  2022-01-30: Integrate into I&A 3 - Whigital
 *  2021-09-04: Unit defines - chicken_no6
 *
 */

private _mlrsbaseObjs = [
    ["Land_Trench_01_forest_F",[-23.4375,-15.3845,-1.89951],76.6422],
    ["Land_Trench_01_forest_F",[-22.6426,-12.2376,-1.89951],122.88],
    ["Land_Trench_01_forest_F",[-32.3276,-5.27051,-1.8754],89.758],
    ["Land_Trench_01_forest_F",[-21.7603,-18.6947,-1.89951],43.5322],
    ["Land_Trench_01_forest_F",[-32.2651,-1.34766,-1.8754],89.758],
    ["Land_Trench_01_forest_F",[-20.6143,-9.06146,-1.84626],122.88],
    ["Land_Trench_01_forest_F",[-32.25,2.625,-1.8754],89.758],
    ["Land_Trench_01_forest_F",[-23.7256,12.4404,-1.92865],51.8417],
    ["Land_Trench_01_forest_F",[-24.6479,15.1705,-1.92865],88.9464],
    ["Land_Trench_01_forest_F",[-20.8599,20.9576,-1.92865],130.968],
    ["Land_Trench_01_forest_F",[-21.3687,9.37616,-1.92865],51.8417],
    ["Land_Trench_01_forest_F",[-23.4043,18.1079,-1.92865],129.654],
    ["Land_Trench_01_forest_F",[-32.1895,6.44727,-1.8754],89.758],
    ["Land_Trench_01_forest_F",[6.73975,-28.9677,-1.84626],359.758],
    ["Land_Trench_01_forest_F",[-1.15576,-28.8901,-1.84626],359.758],
    ["Land_Trench_01_forest_F",[2.81689,-28.9055,-1.84626],359.758],
    ["Land_Trench_01_forest_F",[-4.97803,-28.8298,-1.84626],359.758],
    ["Land_TTowerSmall_2_F",[1.875,-6.375,-3.8754],0],
    ["Land_Trench_01_forest_F",[-6.94824,-17.554,-1.8994],325.499],
    ["Land_Trench_01_forest_F",[-16.1484,-22.7378,-1.89951],1.5101],
    ["Land_Trench_01_forest_F",[-10.2129,-19.721,-1.89951],324.405],
    ["Land_Trench_01_forest_F",[-19.0269,-21.364,-1.89951],42.2176],
    ["Land_Trench_01_forest_F",[-13.3799,-21.9385,-1.89951],324.405],
    ["Land_Trench_01_forest_F",[-18.5181,-5.90497,-1.84626],122.88],
    ["Land_Trench_01_forest_F",[9.61768,-16.1754,-1.84626],33.5162],
    ["CamoNet_OPFOR_big_F",[-15.6758,-14.911,-3.8754],244.032],
    ["Land_MRL_Magazine_01_F",[-16.938,-11.709,-3.8754],55],
    ["Land_MRL_Magazine_01_F",[-16.313,-12.584,-3.8754],55],
    ["Land_MRL_Magazine_01_F",[-15.688,-13.459,-3.8754],55],
    ["Land_PowerGenerator_F",[3.625,-6.875,-3.8754],269.305],
    ["Land_Cargo_House_V2_F",[-17.5,13.75,-3.8754],325],
    ["Land_Trench_01_forest_F",[-17.6279,22.7813,-1.92865],164.079],
    ["Land_Trench_01_forest_F",[-19.0581,6.21143,-1.92865],52.9352],
    ["Land_Trench_01_forest_F",[-14.4487,22.1284,-1.92865],210.317],
    ["Land_Trench_01_forest_F",[-1.16064,30.5563,-1.8754],179.758],
    ["Land_Trench_01_forest_F",[-7.93799,18.291,-1.8754],210.317],
    ["Land_Trench_01_forest_F",[-11.1851,20.2439,-1.8754],210.317],
    ["Land_Trench_01_forest_F",[9.59521,17.7748,-1.89951],145.119],
    ["Land_Trench_01_forest_F",[2.81201,30.541,-1.8754],179.758],
    ["Land_Trench_01_forest_F",[6.63428,30.4807,-1.8754],179.758],
    ["Land_Trench_01_forest_F",[-5.0835,30.6186,-1.8754],179.758],
    ["CamoNet_OPFOR_big_F",[-16.8081,15.049,-3.8754],331.468],
    ["Land_PaperBox_open_full_F",[-14.25,17.5,-3.8754],0],
    ["Land_PaperBox_open_full_F",[-11.75,15.5,-3.8754],150],
    ["Land_Trench_01_forest_F",[21.3438,-20.2913,-1.89951],314.168],
    ["Land_Trench_01_forest_F",[18.7529,-21.2917,-1.89951],353.613],
    ["Land_Trench_01_forest_F",[24.0435,-17.5881,-1.89951],312.854],
    ["Land_Trench_01_forest_F",[12.8672,-18.3662,-1.84626],33.5162],
    ["Land_Trench_01_forest_F",[25.0513,-15.0634,-1.89951],272.95],
    ["Land_Trench_01_forest_F",[24.3955,-12.3525,-1.89951],235.041],
    ["Land_Trench_01_forest_F",[16.1357,-20.6155,-1.89951],33.5162],
    ["Land_Trench_01_forest_F",[20.0352,-5.89355,-1.89951],235.041],
    ["Land_Trench_01_forest_F",[33.769,2.59729,-1.8754],269.812],
    ["Land_Trench_01_forest_F",[33.75,-1.375,-1.8754],269.812],
    ["Land_Trench_01_forest_F",[33.686,-5.19727,-1.8754],269.812],
    ["Land_Trench_01_forest_F",[22.2456,-9.22156,-1.89951],235.041],
    ["Land_Trench_01_forest_F",[23.9893,19.291,-1.89951],223.152],
    ["Land_Trench_01_forest_F",[21.2383,21.9423,-1.89951],221.838],
    ["Land_Trench_01_forest_F",[24.4063,14.0894,-1.89951],302.5],
    ["Land_Trench_01_forest_F",[15.9976,22.2013,-1.89951],144.025],
    ["Land_Trench_01_forest_F",[18.7607,23.0195,-1.89951],181.13],
    ["Land_Trench_01_forest_F",[22.2144,10.7819,-1.84626],302.5],
    ["Land_Trench_01_forest_F",[12.8457,19.9628,-1.89951],144.025],
    ["Land_Trench_01_forest_F",[20.082,7.49329,-1.84626],302.5],
    ["Land_Trench_01_forest_F",[33.835,6.52063,-1.8754],269.812],
    ["Land_Trench_01_forest_F",[25.2129,16.7775,-1.89951],262.597]
];

private _hqHMGs = [
    ["rhs_KORD_high_VDV",[6.79541,-2.06099,-0.748883],270],
    ["rhs_KORD_high_VDV",[6.69336,3.11919,-0.748883],225],
    ["rhs_KORD_high_VDV",[-2.7334,-4.57906,-0.748401],45],
    ["rhs_KORD_high_VDV",[-3.06299,3.44048,-0.748883],135]
];

private _mlrsObj = [
    ["RHS_BM21_VDV_01",[17.1416,-13.5228,-3.8754],134.986],
    ["RHS_BM21_VDV_01",[17.2964,14.9695,-3.8754],43.9696]
];

private _orientate = {
    params ["_obj", ["_setStraight", true]];

    private _pos = (getPosATL _obj);

    _pos set [2, 0];
    _obj setPosATL _pos;

    private _vectorUp = [0,0,0];

    if (!_setStraight) then {
        _vectorUp = (surfaceNormal _pos);
    };

    _obj setVectorUp _vectorUp;
};

private _mlrsLaunchers = [];
private _spawnedObjects = [];
private _prioUnits = [];
private _activeAO = InA_Server_currentAO;

private _rndDir = random 360;
private _flatPos = [(getMarkerPos _activeAO), 8000, 15, 0.2] call AW_fnc_findSafePos;
private _objPos = [_flatPos, 15, 5, 10, 0, 0.2, 0] call BIS_fnc_findSafePos;
private _origin = createVehicle ["Land_Cargo_HQ_V2_F", [0, 0, 0], [], 0, "NONE"];
_origin setDir _rndDir;
_origin setPos _objPos;
_spawnedObjects pushBack _origin;

private _terrainObjs = (nearestTerrainObjects [_objPos, [], 40, false, true]);
{
    _x hideObjectGlobal true;
} forEach _terrainObjs;

{
    private _obj = [_origin, _x, _rndDir] call AW_fnc_spawnRelative;
    [_obj, false] call _orientate;

    if ((typeOf _obj) == "CamoNet_OPFOR_big_F") then {
        _obj allowDamage false;
    };

    if ((typeOf _obj) == "Land_Trench_01_forest_F") then {
        _obj setPos [getPos _obj select 0, getPos _obj select 1, (getPos _obj select 2) +1.9];
    };

    _spawnedObjects pushBack _obj;
} forEach _mlrsbaseObjs;

//Spawn Ammotruck
private _ammoTruck = [_origin, ["O_Truck_02_Ammo_F", [-13.375,-15.875,-3.8754],233.382], _rndDir] call AW_fnc_spawnRelative;
_ammoTruck allowDamage false;
_ammoTruck enableSimulationGlobal false;
_ammoTruck lock true;
_ammoTruck setFuel 0;

_ammoTruck call AW_fnc_vehicleCustomizationOpfor;

private _pos = (getPosATL _ammoTruck);

_ammoTruck setPosATL [(_pos # 0), (_pos # 1), 0];
_ammoTruck setVectorUp (surfaceNormal (getPosATL _ammoTruck));
_ammoTruck allowDamage true;
_ammoTruck enableSimulationGlobal true;

InA_PrioAmmoTruck = _ammoTruck;

_spawnedObjects pushBack _ammoTruck;

// Spawn MLRSs
private _mlrsGroup = (createGroup InA_EnemyFactionSide);

{
    private _mlrs = [_origin, _x, _rndDir] call AW_fnc_spawnRelative;

    _mlrs allowDamage false;
    _mlrs enableSimulationGlobal false;

    private _pos = (getPosATL _mlrs);
    _mlrs setPosATL [(_pos # 0), (_pos # 1), 0];

    _mlrs setVectorUp (surfaceNormal (getPosATL _mlrs));

    _mlrs allowDamage true;
    _mlrs enableSimulationGlobal true;

    _mlrs lock true;
    _mlrs setFuel 0;

    _mlrs addMagazineTurret ["12Rnd_230mm_rockets", [0]];
    _mlrs addMagazineTurret ["12Rnd_230mm_rockets", [0]];
    _mlrs addMagazineTurret ["12Rnd_230mm_rockets", [0]];

    _mlrs call AW_fnc_vehicleCustomizationOpfor;

    _mlrs addEventHandler ["Reloaded", {
        params ["_unit", "_weapon", "_muzzle", "_newMagazine", "_oldMagazine"];

        if (alive InA_PrioAmmoTruck) then {
            _unit setVehicleAmmo 1;
        };
    }];

    _mlrsGroup addVehicle _mlrs;

    private _gunner = _mlrsGroup createUnit [["#engineers"] call AW_fnc_getUnitsFromHash, [0,0,0], [], 0, "NONE"];
    _gunner assignAsGunner _mlrs;
    _gunner moveInGunner _mlrs;

    _mlrs doWatch (getMarkerPos _activeAO);

    _prioUnits pushBack _gunner;
    _mlrsLaunchers pushBack _mlrs;
    _spawnedObjects pushBack _mlrs;
} forEach _mlrsObj;

_mlrsGroup = [_mlrsGroup] call AW_fnc_changeGroupSide;
_mlrsGroup setGroupIdGlobal ["PRIO-MLRS"];
_mlrsGroup setCombatMode "BLUE";
_mlrsGroup setBehaviourStrong "CARELESS";

//Spawn HQ HMGs
private _hqGrp = (createGroup InA_EnemyFactionSide);

{
    private _hmg = [_origin, _x, (_rndDir + 180)] call AW_fnc_spawnRelative;
    private _dir = (getDir _hmg);

    _hmg addMagazineTurret ["100Rnd_127x99_mag_Tracer_Green", [0]];
    _hmg addMagazineTurret ["100Rnd_127x99_mag_Tracer_Green", [0]];

    _hmg lock true;
    _hmg enableWeaponDisassembly false;

    private _gunner = _hqGrp createUnit [["#engineers"] call AW_fnc_getUnitsFromHash, [0,0,0], [], 0, "NONE"];

    _gunner setDir _dir;
    _gunner moveInGunner _hmg;

    _prioUnits pushBack _gunner;
    _spawnedObjects pushBack _hmg;
} forEach _hqHMGs;

_hqGrp = [_hqGrp] call AW_fnc_changeGroupSide;
_hqGrp setGroupIdGlobal ["PRIO-HQ-HMGs"];

[_hqGrp, [[_origin, _objPos], {
    params ["_hq", "_pos"];

    waitUntil {
        sleep 1;
        (_hq in (_pos nearObjects [(typeOf _hq), 2]))
    };
}]] spawn AW_fnc_transferGroupHC;


[((units _mlrsGroup) + (units _hqGrp))] call derp_fnc_AISkill;
[((units _mlrsGroup) + (units _hqGrp))]  call AW_fnc_addToAllCurators;


// Spawn guard units
private _vehAmount = [
    0,  // MBTs
    (selectRandom [0, 1]),  // SPAAs
    (selectRandom [1, 2]),  // IFVs
    (selectRandom [1, 2])   // MRAPs
];

private _infAmount = [
    (selectRandom [3, 4]),  // Squads
    (selectRandom [1, 2]),  // SF Squads
    (selectRandom [1, 2]),  // AA Teams
    (selectRandom [1, 2]),  // AT Teams
    nil,                    // Snipers
    (selectRandom [2, 3]),  // Teams
    (selectRandom [1, 2])   // SF Teams
];

private _enemyArray = [
    _flatPos,
    "PRIO",
    "#rnd",
    _vehAmount,
    _infAmount,
    25,
    500
] call AW_fnc_spawnEnemyUnits;

_prioUnits append _enemyArray;


// Setup markers and task
private _fuzzyPos = [_flatPos] call AW_fnc_getFuzzyPos;

InA_Server_PrioMarkers = ["PRIO", "Rocket Artillery", _fuzzyPos, 300] call AW_fnc_missionMarkersCreate;
private _prioMarker = (InA_Server_PrioMarkers # 0);

private _taskText = "OPFOR are setting up Rocket Artillery to hit you guys damned hard!<br/><br/>This is a priority target soldiers!";

[
    west,
    "prioMLRSTask",
    [
        _taskText,
        "Priority Target: Rocket Artillery",
        _prioMarker
    ],
    _fuzzyPos,
    "Created",
    0,
    true,
    "destroy",
    true
] call BIS_fnc_taskCreate;

InA_Server_PrioMissionSpawned = true;
InA_Server_PrioMissionUp = true;


// Main loop
private _intervalMin = ["ArtilleryTargetTickTimeMin", 180] call BIS_fnc_getParamValue;
private _intervalMax = ["ArtilleryTargetTickTimeMax", 360] call BIS_fnc_getParamValue;
private _knowledgeThreshold = 1.2;
private _lastFired = -_intervalMax;
private _mlrsMag = "12Rnd_230mm_rockets";

private _minShells = 2;
private _maxShells = 4;
private _amount = 2;
private _precision = 30;

while {sleep 5; (InA_Server_PrioMissionUp && ((_mlrsLaunchers findIf {alive _x}) != -1))} do {
    // Pause if Main AO is shutdown
    if (InA_Server_MainAOShutdown) then {continue};

    if (_activeAO != InA_Server_currentAO) then {
        _activeAO = InA_Server_currentAO;

        {
            _x doWatch (getMarkerPos _activeAO);
        } forEach _mlrsLaunchers;
    };

    private _players = (
        (allPlayers - (entities "HeadlessClient_F")) select {
            (alive _x) && {
                (!captive _x) && {
                    !([_x, 1500] call AW_fnc_isNearBase) && {
                        ((_x distance2D _flatPos) > 2500)
                    } && ((speed _x) < 2)
                }
            }
        }
    );

    private _waitTime = (parseNumber ((linearConversion [1, 30, (count _players), _intervalMax, _intervalMin, true]) toFixed 1));

    if (time < (_lastFired + _waitTime)) then {continue};

    private _activeLaunchers = (_mlrsLaunchers select {canFire _x});
    if ((count _activeLaunchers) == 0) then {continue};

    private _targets = (_players select {
        (((getPos _x) distance2D (getMarkerPos _activeAO)) < (InA_Server_MainAOSize * 2)) && {
            (alive _x) && {
                (((getPosATL _x) # 2) < 10) && {
                    ((getPos _x) inRangeOfArtillery [_mlrsLaunchers, "12Rnd_230mm_rockets"]) &&
                    (((east knowsAbout _x) > _knowledgeThreshold) || ((independent knowsAbout _x) > _knowledgeThreshold))
                }
            }
        }
    });

    if (_targets isEqualTo []) then {continue};

    private _target = (selectRandom _targets);

    private _targetPos = (getPos _target);
    private _spotPos = [(_targetPos # 0), (_targetPos # 1), ((_targetPos # 2) + 25)];
    private _spotObj = createVehicle ["SmokeShellRed", _spotPos, [], 8, "NONE"];
    private _limitAmmoUsage = (!alive _ammoTruck);

    _lastFired = serverTime;

    sleep (8 + (random 4));

    _mlrsGroup setCombatMode "YELLOW";

    private _timeout = (diag_tickTime + 0.5);

    waitUntil {sleep 0.1; ((combatMode _mlrsGroup) == "YELLOW") || (diag_tickTime > _timeout)};

    if ((combatMode _mlrsGroup) != "YELLOW") then {
        ["Failed to set MLRS groups CombatMode, skipping firing sequence", "PRIO", true] call AW_fnc_log;
        continue;
    };

    {
        if ((!alive _x) || (!canFire _x)) then {continue};

        if (_limitAmmoUsage) then {
            _amount = (selectRandom [1, 2, 3]);
        } else {
            _amount = (_minShells + (round (random (_maxShells - _minShells))));
        };

        private _theta = random 360;
        private _deviation = ([(sin _theta), (cos _theta), 0] vectorMultiply (random _precision));

        _x doArtilleryFire [(_targetPos vectorAdd _deviation), _mlrsMag, _amount];

        waitUntil {
            sleep 1;
            unitReady _x;
        };
    } forEach _mlrsLaunchers;

    _mlrsGroup setCombatMode "BLUE";
};


// Success
private _msg = "<t align='center'><t size='2.2'>Prio Mission Complete</t><br/>____________________<br/>Fantastic job, lads! The OPFOR Rocket Artillery has been neutralized!</t>";
[_msg] remoteExec ["AW_fnc_globalHint", 0];


0 = ["prioMLRSTask"] spawn AW_fnc_finishTask;

[InA_Server_PrioMarkers] call AW_fnc_missionMarkersRemove;


// Cleanup
0 = [_objPos, _spawnedObjects, _prioUnits, _terrainObjs] spawn {
    params ["_pos", "_spawnedObjects", "_enemiesArray", "_terrainObjs"];

    InA_PrioAmmoTruck = nil;

    sleep 120;

    deleteVehicle (nearestObject [_pos, "Land_Cargo_HQ_V2_ruins_F"]);
    deleteVehicle (nearestObject [_pos, "Land_Cargo_House_V2_ruins_F"]);

    [_spawnedObjects + _enemiesArray] spawn AW_fnc_delete;

    {
        if (isObjectHidden _x) then {
            _x hideObjectGlobal false;
        };
    } forEach _terrainObjs;
};
