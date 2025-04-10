/*
Author:
	Quiksilver
	Rarek [AW]
	Stanhope

Description:    Arty prio mission
*/

private _spawnedUnits = [];

private _artilleryTargetTickTimeMin = "ArtilleryTargetTickTimeMin" call BIS_fnc_getParamValue;
private _artilleryTargetTickTimeMax = "ArtilleryTargetTickTimeMax" call BIS_fnc_getParamValue;
if (_artilleryTargetTickTimeMax == _artilleryTargetTickTimeMin) then {
    _artilleryTargetTickTimeMax = _artilleryTargetTickTimeMax + 60;
};

//-------------------- 1. FIND POSITION
private _flatPos = [(getMarkerPos InA_Server_currentAO), 8000, 25, 0.2] call AW_fnc_findSafePos;

// Clear the area
private _terrainObjs = (nearestTerrainObjects [_flatPos, [], 30, false, true]);

{
    _x hideObjectGlobal true;
} forEach _terrainObjs;

//-------------------- 2. SPAWN OBJECTIVES
private _dir = random 360;

priorityObj1 = AW_OPFOR_mission_arty_artyVeh createVehicle (_flatpos getPos [7.5, 0]);
priorityObj2 = AW_OPFOR_mission_arty_artyVeh createVehicle (_flatpos getPos [7.5, 180]);
ammoTruck = AW_OPFOR_mission_arty_ammoVeh createVehicle (_flatpos getPos [25, random 360]);

waitUntil {!isNull priorityObj1 && !isNull priorityObj2 && !isNull ammoTruck};

{
    _x lock 3;
    _x allowCrewInImmobile true;
    _spawnedUnits pushBack _x;
    _x setDir _dir;
    _x setFuel 0;
    _x call AW_fnc_vehicleCustomizationOpfor;

    if (_x isKindOf "rhs_2s3_tv") then {
        _x removeMagazinesTurret ["rhs_mag_LASER_2a33", [0]];
        _x removeMagazinesTurret ["rhs_mag_SMOKE_2a33", [0]];
        _x removeMagazinesTurret ["rhs_mag_WP_2a33", [0]];
        _x removeMagazinesTurret ["rhs_mag_ILLUM_2a33", [0]];


        _x addMagazineTurret ["rhs_mag_HE_2a33", [0]];
        _x addMagazineTurret ["rhs_mag_HE_2a33", [0]];
        _x addMagazineTurret ["rhs_mag_HE_2a33", [0]];
        _x addMagazineTurret ["rhs_mag_HE_2a33", [0]];
        _x addMagazineTurret ["rhs_mag_HE_2a33", [0]];

        _x addMagazineTurret ["rhs_mag_762x54mm_250", [0,0]];
        _x addMagazineTurret ["rhs_mag_762x54mm_250", [0,0]];

    };

    if (_x isKindOf "vn_o_nva_65_static_d44_01") then {
        _x removeMagazinesTurret ["vn_cannon_d44_mag_wp_x12", [0]];
        _x removeMagazinesTurret ["vn_cannon_d44_mag_lume_x12", [0]];
    };
} forEach [priorityObj1,priorityObj2,ammoTruck];

//-------------------- 3. SPAWN CREW - Same method as in priorityaa
sleep 0.1;

private _priorityGroup = createGroup InA_EnemyFactionSide;

{
    private _tmpGrp =createVehicleCrew _x;
    (units _tmpGrp) joinSilent _priorityGroup;
    sleep 0.1;
    _x doWatch getMarkerPos InA_Server_currentAO;

    _x addEventHandler ["Reloaded", {
        params ["_unit", "_weapon", "_muzzle", "_newMagazine", "_oldMagazine"];

        if (alive ammoTruck) then {
            _unit setVehicleAmmo 1;
        };
    }];
} forEach [priorityObj1, priorityObj2];

_priorityGroup setGroupIdGlobal [format ["PRIO-Artillery"]];

_spawnedUnits append ((units _priorityGroup) + [ammoTruck]);

_priorityGroup setBehaviour "COMBAT";
_priorityGroup setCombatMode "RED";

[_spawnedUnits] call derp_fnc_AISkill;
[_spawnedUnits] call AW_fnc_addToAllCurators;

//-------------------- 4. SPAWN FORCE PROTECTION
private _vehAmount = [
    nil,                    // MBTs
    (selectRandom [0, 1]),  // SPAAs
    (selectRandom [0, 1]),  // IFVs
    (selectRandom [0, 1])   // MRAPs
];

private _infAmount = [
    (2 + (random 1)),   // Squads
    (1 + (random 1)),   // SF Squads
    1,                  // AA Teams
    1,                  // AT Teams
    nil,                // Snipers
    nil,                // Teams
    nil                 // SF Teams
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

_spawnedUnits append _enemyAry;

sleep 0.1;


//-------------------- 5. SPAWN H-BARRIER RING
sleep 0.1;

private _distance = 18;
_dir = 0;
for "_c" from 1 to 8 do {
    private _pos = _flatpos getPos [_distance, _dir];
    private _barrier = AW_OPFOR_mission_arty_barrier createVehicle _pos;
    waitUntil {alive _barrier};
    _barrier setDir _dir;
    _dir = _dir + 45;
    _barrier allowDamage false;
    _barrier setVectorUp surfaceNormal position _barrier;
    _spawnedUnits pushBack _barrier;
};
sleep 0.1;

//-------------------- 7. BRIEF
private _fuzzyPos = [((_flatPos select 0) - 300) + (random 600),((_flatPos select 1) - 300) + (random 600),0];

InA_Server_PrioMarkers = ["PRIO", "Artillery", _fuzzyPos, 300] call AW_fnc_missionMarkersCreate;
private _prioMarker = (InA_Server_PrioMarkers # 0);

[
    west,
    "prioArtyTask",
    [
        "OPFOR forces are setting up an artillery battery to hit you guys damned hard! We've picked up their positions with thermal imaging scans and have marked it on your map. This is a priority target, boys! They're just setting up now; they'll be firing in about five minutes!  Previous sites looked like this: <br/><br/><img image='Media\Briefing\prioArty.jpg' width='300' height='150'/>",
        "Priority Target: Artillery",
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
    } else {
        if (alive priorityObj2) then {
             _artyPos = getPos priorityObj1;
        };
    };

    private _goodTargets = [];
    if (count allPlayers < 4) exitWith {
        _goodTargets
    };

    {
        if (!alive _x) then {continue};
        if (captive _x) then {continue};
        if (side _x != west) then {continue};
        if (vehicle _x != _x) then {continue};

        if (((east knowsAbout _x) < 1.9)
            && ((independent knowsAbout _x) < 1.9)
        ) then {continue};

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
    } forEach (allPlayers - (entities "HeadlessClient_F"));

    _goodTargets
};

private _lastFireMission = serverTime;
private _loopTimeout = 30;
private _waitTime = (_artilleryTargetTickTimeMin + (round (random (_artilleryTargetTickTimeMax - _artilleryTargetTickTimeMin))));

while {((canFire priorityObj1) || (canFire priorityObj2)) && InA_Server_PrioMissionUp} do {
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
    private _limitAmmoUsage = (!alive ammoTruck);

    {
        if (alive _x) then {
            [_x, _target, _limitAmmoUsage] call AW_fnc_artyStrike;
        };
    } forEach [priorityObj1, priorityObj2];

    _lastFireMission = serverTime;

    _waitTime = (_artilleryTargetTickTimeMin + (round (random (_artilleryTargetTickTimeMax - _artilleryTargetTickTimeMin))));

	if (_limitAmmoUsage) then {
		_waitTime = (_waitTime + _artilleryTargetTickTimeMin);
	};
};

if (!InA_Server_PrioMissionUp) then {
    {
        _x setDamage 1;
    } forEach [priorityObj1, priorityObj2, ammoTruck];
};

//-------------------- DE-BRIEF

0 = ["prioArtyTask"] spawn AW_fnc_finishTask;

[InA_Server_PrioMarkers] call AW_fnc_missionMarkersRemove;

//-------------------- DELETE
[_spawnedUnits, _terrainObjs] spawn {
    params ["_spawnedUnits", "_terrainObjs"];

    sleep 120;

    {
        if (isObjectHidden _x) then {_x hideObjectGlobal false};
    } forEach _terrainObjs;

    _spawnedUnits = _spawnedUnits - [objNull];
    [_spawnedUnits] call AW_fnc_delete;
};
