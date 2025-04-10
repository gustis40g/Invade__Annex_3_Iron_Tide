/*
 * Author: Whigital
 *
 * Description: Spawns a mortar position with 3 mortars, that engages random
 * player within 1200m of the AO with 1 shell from each mortar. Fires roughly
 * every 150 seconds.
 */

params [["_factionHash", InA_EnemyFactionHash]];

private _aoPos = (getMarkerPos InA_Server_currentAO);
private _mortarPos = [_aoPos, 10, (InA_Server_MainAOSize * 0.8), 12, 0, 0.2, 0, [], [0,0,0]] call BIS_fnc_findSafePos;
private _roughPos =[((_mortarPos select 0) - 200) + (random 400),((_mortarPos select 1) - 200) + (random 400),0];

private _boxTypes = [
    "Box_T_East_Ammo_F",
    "Box_East_Ammo_F",
    "Box_T_East_Wps_F",
    "Box_East_Wps_F",
    "Box_T_East_WpsSpecial_F",
    "Box_East_WpsSpecial_F",
    "Box_IED_Exp_F",
    "Box_Syndicate_WpsLaunch_F"
];

private _fortObjs =[
    ["Land_HBarrier_Big_F",[-3.83594,-2.02295,-0.222783],240],
    ["Land_HBarrier_Big_F",[3.79102,-1.87012,-0.222783],120],
    ["Land_HBarrier_Big_F",[-0.0410156,4.35303,-0.222783],0],
    ["Land_Razorwire_F",[-7.31421,4.24585,-0.222783],300],
    ["Land_Razorwire_F",[-0.0126953,-8.1438,-0.222783],180],
    ["Land_Razorwire_F",[7.3186,4.44263,-0.222783],60]
];

private _boxObjs = [
    ["Box_East_Ammo_F", [-3.66479,0.580322,-0.222783], 59.0483],
    ["Box_East_Ammo_F", [-2.30225,2.80786,-0.222783], 180.14],
    ["Box_East_Ammo_F", [1.33203,-3.22607,-0.222783], 299.709],
    ["Box_East_Ammo_F", [2.49219,2.95825,-0.222783], 179.617]
];

private _mortarObjs = [
    ["rhs_2b14_82mm_vdv",[-0.119873,1.18896,-0.222783],0],
    ["rhs_2b14_82mm_vdv",[-0.935547,-0.328125,-0.222783],240],
    ["rhs_2b14_82mm_vdv",[0.925537,-0.265137,-0.222783],120]
];


private _subObjs = [];
private _subUnits = [];
private _mortars = [];

private _rndDir = (random 360);

private _origin = createVehicle ["Land_Balloon_01_air_F", [0,0,0], [], 0, "NONE"];
_origin allowDamage false;
_origin enableSimulation false;
_origin setDir _rndDir;
_origin setPos _mortarPos;
_origin setVectorUp [0,0,1];


{
    private _obj = [_origin, _x, _rndDir] call AW_fnc_spawnRelative;
    _obj allowDamage false;

    private _pos = (getPosATL _obj);
    _obj setPosATL [(_pos # 0), (_pos # 1), 0];

    _obj setVectorUp (surfaceNormal (getPosATL _obj));
    _subObjs pushBack _obj;
} forEach _fortObjs;


{
    _x params ["_type", "_pos", "_dir"];

    private _boxType = (selectRandom _boxTypes);
    private _box = [_origin, [_boxType, _pos, _dir], _rndDir] call AW_fnc_spawnRelative;

    _pos = (getPosATL _box);
    _box setPosATL [(_pos # 0), (_pos # 1), 0];

    _box setVectorUp (surfaceNormal (getPosATL _box));

    clearWeaponCargoGlobal _box;
    clearMagazineCargoGlobal _box;
    clearItemCargoGlobal _box;
    clearBackpackCargoGlobal _box;

    _box addBackpackCargoGlobal ["O_Mortar_01_weapon_F", (selectRandom [2,3,4,5,6])];

    if ((selectRandom [1, 2, 3]) == 1) then {
        _box addMagazineCargoGlobal ["DemoCharge_Remote_Mag", 1];
    };

    _subObjs pushBack _box;
} forEach _boxObjs;


{
    private _mortar = [_origin, _x, _rndDir] call AW_fnc_spawnRelative;

    _mortar allowDamage false;
    _mortar enableSimulationGlobal false;

    private _pos = (getPosATL _mortar);
    _mortar setPosATL [(_pos # 0), (_pos # 1), 0];

    _mortar setVectorUp (surfaceNormal (getPosATL _mortar));

    _mortar allowDamage true;
    _mortar enableSimulationGlobal true;

    _mortar enableWeaponDisassembly false;
    _mortars pushBack _mortar;

    _mortar removeMagazinesTurret ["rhs_mag_3vs25m_10", [0]];
    _mortar removeMagazinesTurret ["rhs_mag_d832du_10", [0]];

    _mortar addEventHandler ["Fired", {
        params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];

        private _magsRemaining = ({_x == "rhs_mag_3vo18_10"} count (_unit magazinesTurret [[0], false]));
        private _ammoLeft = (_gunner ammo (currentMuzzle _gunner));

        if (_magsRemaining < 4) then {
            _unit addMagazineTurret ["rhs_mag_3vo18_10", [0]];
        };
    }];
} forEach _mortarObjs;

deleteVehicle _origin;


private _mortarGroup = (createGroup InA_EnemyFactionSide);
private _mortarGunner = ["#engineers", _factionHash] call AW_fnc_getUnitsFromHash;

{
    private _dir = (getDir _x);

    private _unit = _mortarGroup createUnit [_mortarGunner, _mortarPos, [], 0, "NONE"];
    _unit setDir _dir;

    _unit assignAsGunner _x;
    _unit moveInGunner _x;

    _x allowCrewInImmobile true;
    _x lock true;

    _subUnits pushBack _unit;
} forEach _mortars;

_mortarGroup = [_mortarGroup] call AW_fnc_changeGroupSide;
_mortarGroup setGroupIdGlobal ["AO-SubObj-Mortars"];

_mortarGroup setCombatMode "BLUE";
_mortarGroup setBehaviourStrong "CARELESS";

[(units _mortarGroup)] call derp_fnc_AISkill;
[((units _mortarGroup) + _mortars)] call AW_fnc_addToAllCurators;

// Patrols
private _patrolDistance = 50;
private _infGrps = ["#squads", 1.5, "#specop_squads", 0.75, "#teams", 1.5, "#specop_teams", 1, "#aa_teams", 1.25, "#at_teams", 1.25];


for [{_i = 0}, {_i < 4}, {_i = (_i + 1)}] do {
    private _randomPos = [_mortarPos, 25 , 200, 5, 0, 0.5, 0, [], _mortarPos] call BIS_fnc_findSafePos;
    private _units = [(selectRandomWeighted _infGrps), _factionHash] call AW_fnc_getUnitsFromHash;
    private _grp = [_units, _randomPos] call AW_fnc_spawnAIGroup;

    [_grp, _mortarPos, nil, _patrolDistance] call AW_fnc_taskCircPatrol;

    _grp setGroupIdGlobal [format ["AO-SubObj-Inf-Group%1", (_i + 1)]];

    _patrolDistance = (_patrolDistance + 50);

    _subUnits = (_subUnits + (units _grp));

    [_grp] spawn derp_fnc_AISkill;
    [(units _grp)] call AW_fnc_addToAllCurators;

    [_grp] spawn AW_fnc_transferGroupHC;

    sleep 0.1;
};

InA_Server_subObjUnits append (_subUnits + _subObjs + _mortars);


// Objective, task, etc.
InA_Server_SubMarkers = ["SUB", "Mortar Team", _roughPos, 225] call AW_fnc_missionMarkersCreate;
private _subMarker = (InA_Server_SubMarkers # 0);

private _targetStartText = format ["<t align='center' size='2.2'>Sub-Objective</t><br/><t size='1.5' align='center' color='#FFCF11'>Mortar Team</t><br/>____________________<br/>OPFOR has a Mortar Team operating in the AO. Find and eliminate them !<br/><br/>"];
[_targetStartText] remoteExec ["AW_fnc_globalHint", 0];

[
    west,
    [
        "SubAoTask",
        "MainAoTask"
    ],
    [
        "OPFOR have a mortar position inside the AO. Watch for purple smoke or red flares, as they are know to use it for spotting.<br/><br/>",
        "Mortar Team",
        _subMarker
    ],
    _roughPos,
    "Created",
    0,
    true,
    "destroy",
    true
] call BIS_fnc_taskCreate;

InA_Server_MainAoSubObjSpawn_Complete = true;

// Main firing loop
private _intervalMin = 60;
private _intervalMax = 300;
private _spotTime = 8;
private _knowledgeThreshold = 1.2;
private _lastFired = -_intervalMax;
private _mortarMag = "8Rnd_82mm_Mo_shells";

private _getKnowledge = {
    params ["_vehicle", "_threshold"];

    (((east knowsAbout _vehicle) max (independent knowsAbout _vehicle)) > _threshold)
};

while {sleep 5; ((_mortars findIf {alive _x}) != -1)} do {
    if (InA_Server_MainAOControl_EndSubObj) then {
        {
            if (alive _x) then {_x setDamage 1};
        } forEach _mortars;

        break
    };

    // Scale time between firemission with playercount
    private _players = (allPlayers - (entities "HeadlessClient_F"));
    private _waitTime = (parseNumber ((linearConversion [1, 45, (count _players), _intervalMax, _intervalMin, true]) toFixed 1));

    // Not enough time elapsed since last firemission
    if (serverTime < (_lastFired + _waitTime)) then {continue};

    // None of the mortars can fire
    private _activeMortars = (_mortars select {canFire _x});
    if ((count _activeMortars) == 0) then {continue};

    private _targets = (_players select {
        (((getPos _x) distance2D _aoPos) < (InA_Server_MainAOSize * 1.75)) && {
            (alive _x)
        }
    });

    private _targetsFiltered = [];

    {
        private _unit = _x;

        if (!((getPos _unit) inRangeOfArtillery [_mortars, _mortarMag])) then {continue};

        if ([_unit] call AW_fnc_isNearBase) then {continue};

        private _pushBack = false;
        private _playerVehicle = (vehicle _unit);
        private _knowsEnough =  ([_playerVehicle, _knowledgeThreshold] call _getKnowledge);

        if (!_knowsEnough) then {continue};

        if (_playerVehicle == _unit) then {
            _pushBack = true;
        } else {
            if ((_playerVehicle isKindOf "Land") && {(speed _playerVehicle) < 2}) then {
                _pushBack = true;
            };

            if ((_playerVehicle isKindOf "Air") && {(((getPos _playerVehicle) # 2) < 1) && ((speed _playerVehicle) < 1)}) then {
                _pushBack = true;
            };
        };

        if (_pushBack) then {
            _targetsFiltered pushBack _unit;
        };
    } forEach _targets;

    // No suitable targets found
    if (_targetsFiltered isEqualTo []) then {continue};

    private _selectedTarget = (selectRandom _targetsFiltered);
    private _targetPos = (getPos _selectedTarget);

    private _spotType = (["SmokeShellPurple", "F_40mm_Red"] select (sunOrMoon < 0.5));
    private _spotPos = [(_targetPos # 0), (_targetPos # 1), ((_targetPos # 2) + 25)];

    private _knowledge = ((east knowsAbout _selectedTarget) max (independent knowsAbout _selectedTarget));
    private _accuracy = (parseNumber ((linearConversion [4, _knowledgeThreshold, _knowledge, 2, 25, true]) toFixed 1));
    private _fireMissionPos = ([[[_targetPos, (_accuracy + (_accuracy / 2))]], [[_targetPos, (_accuracy / 2)]]] call BIS_fnc_randomPos);

    private _spotObj = createVehicle [_spotType, _fireMissionPos, [], 0, "NONE"];
    private _shellETA = (((_activeMortars # 0) getArtilleryETA [_fireMissionPos, _mortarMag]) max 15);

    _lastFired = serverTime;

    sleep (_shellETA + _spotTime);

    _mortarGroup setCombatMode "YELLOW";

    {
        if ((!alive _x) || (!canFire _x)) then {continue};

        _x doArtilleryFire [_fireMissionPos, _mortarMag, 1];

        waitUntil {
            sleep 0.1;
            unitReady _x;
        };

        sleep 2;
    } forEach _mortars;

    _mortarGroup setCombatMode "BLUE";
};


// Objective, task, etc.
private _aoName = [] call AW_fnc_getCurrentAOName;
_targetStartText = format ["<t align='center' size='2.2'>Sub-Objective</t><br/><t size='1.5' align='center' color='#FFCF11'>Complete</t><br/>____________________<br/>Good job everyone, the Mortar Team has been eliminated. OPFOR can no longer call in fire support near %1.", _aoName];
[_targetStartText] remoteExec ["AW_fnc_globalHint", 0];

0 = ["SubAoTask"] spawn AW_fnc_finishTask;

[InA_Server_SubMarkers] call AW_fnc_missionMarkersRemove;

InA_Server_MainAO_SubObjComplete = true;
