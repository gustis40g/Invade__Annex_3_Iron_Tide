/*
 * Author: Whigital
 *
 * Description: Spawns a AA Fortification with 2-3 Nyx AA's, depending on playercount
 *
 */

params [["_factionHash", InA_EnemyFactionHash]];

private _aoPos = (getMarkerPos InA_Server_currentAO);
private _aaPos = [_aoPos, 10, (InA_Server_MainAOSize * 0.8), 15, 0, 0.2, 0, [], [0,0,0]] call BIS_fnc_findSafePos;
private _roughPos = [((_aaPos select 0) - 200) + (random 400), ((_aaPos select 1) - 200) + (random 400), 0];

private _aaForts = [
    [
        // 2x
        [
            ["Land_Trench_01_forest_F",[-3.26367,3.81567,1.43222],180],
            ["Land_Trench_01_forest_F",[-7.04956,-0.570526,1.43222],90],
            ["Land_Trench_01_forest_F",[-6.12744,2.54102,1.43222],135],
            ["Land_Trench_01_forest_F",[-7.12183,-4.65123,1.43222],90],
            ["Land_Trench_01_forest_F",[7.49341,0.713348,1.43222],270.043],
            ["Land_Trench_01_forest_F",[3.70532,-3.67093,1.43222],0.0419729],
            ["Land_Trench_01_forest_F",[6.56982,-2.39897,1.43222],315.043],
            ["Land_Trench_01_forest_F",[7.56201,4.68712,1.43222],270.043],
            ["Land_Razorwire_F",[0.081543,-7.88249,-0.222783],180],
            ["Land_Razorwire_F",[0.450439,8.18419,-0.222783],0]
        ],
        [
            ["Box_IND_AmmoVeh_F",[0.190674,0.0863647,-0.222783],75.5189]
        ],
        [
            ["PRACS_SLA_SA9",[2.9563,1.97,-0.222787],180.066],
            ["PRACS_SLA_SA9",[-2.81567,-1.60468,-0.222787],0]
        ]
    ],

    // 3x
    [
        [
            ["Land_Trench_01_forest_F",[-3.64209,-6.71909,1.43222],330.039],
            ["Land_Trench_01_forest_F",[-7.56567,0.420258,1.43222],150.046],
            ["Land_Trench_01_forest_F",[-9.93921,-2.03424,1.43222],105.039],
            ["Land_Trench_01_forest_F",[-6.92065,-7.25864,1.43222],15.0374],
            ["Land_Trench_01_forest_F",[3.54712,-6.8403,1.43222],30.0676],
            ["Land_Trench_01_forest_F",[-9.45654,-5.41443,1.43222],60.0373],
            ["Land_Trench_01_forest_F",[3.26929,9.62662,1.43222],225],
            ["Land_Trench_01_forest_F",[-3.6875,6.50803,1.43222],90],
            ["Land_Trench_01_forest_F",[4.20654,6.34366,1.43222],270],
            ["Land_Trench_01_forest_F",[0.0983887,10.8942,1.43222],180],
            ["Land_Trench_01_forest_F",[-2.76538,9.61957,1.43222],135],
            ["Land_Trench_01_forest_F",[9.87207,-2.45248,1.43222],255.062],
            ["Land_Trench_01_forest_F",[6.85547,-7.67834,1.43222],345.063],
            ["Land_Trench_01_forest_F",[9.54004,-5.57281,1.43222],300.061],
            ["Land_Trench_01_forest_F",[7.76978,0.125824,1.43222],210.094],
            ["Land_Razorwire_F",[-0.162109,-11.8116,-0.222783],179.669],
            ["Land_Razorwire_F",[-10.1418,6.07336,-0.222783],304.022],
            ["Land_Razorwire_F",[10.4683,5.77417,-0.222783],242.859]
        ],
        [
            ["Box_IND_AmmoVeh_F",[1.06323,0.230042,-0.222783],248.664],
            ["Box_IND_AmmoVeh_F",[-0.215576,-1.30215,-0.222783],224.15],
            ["Box_IND_AmmoVeh_F",[-0.824707,0.945313,-0.222783],209.744]
        ],
        [
            ["PRACS_SLA_SA9",[0.535889,5.36664,-0.222787],0],
            ["PRACS_SLA_SA9",[-4.86646,-2.48727,-0.222787],240.042],
            ["PRACS_SLA_SA9",[4.7583,-3.17719,-0.222787],120.065]
        ]
    ]
];

private _playerCount = InA_Server_PlayerCount;

private _aaFort = (_aaForts select (_playerCount > 20));

private _subObjs = [];
private _subUnits = [];
private _AAs = [];

private _rndDir = (random 360);

private _origin = createVehicle ["Land_Balloon_01_air_F", [0,0,0], [], 0, "NONE"];
_origin allowDamage false;
_origin enableSimulation false;
_origin setDir _rndDir;
_origin setPos _aaPos;
_origin setVectorUp [0,0,1];


{
    private _obj = [_origin, _x, _rndDir] call AW_fnc_spawnRelative;
    _obj allowDamage false;

    private _objPos = (getPos _obj);
    private _zPos = 0;

    if ((typeOf _obj) == "Land_Trench_01_forest_F") then {
        _zPos = 1.4;
    };

    _objPos set [2, _zPos];

    _obj setPosATL _objPos;
    _obj setVectorUp (surfaceNormal (getPosATL _obj));
    _subObjs pushBack _obj;
} forEach (_aaFort # 0);


{
    private _box = [_origin, _x, _rndDir] call AW_fnc_spawnRelative;

    _box allowDamage false;

    _box setVectorUp (surfaceNormal (getPosATL _box));

    clearWeaponCargoGlobal _box;
    clearMagazineCargoGlobal _box;
    clearItemCargoGlobal _box;
    clearBackpackCargoGlobal _box;

    _subObjs pushBack _box;
} forEach (_aaFort # 1);


{
    _x params ["_type", "_pos", "_dir"];

    private _aaData = [_origin, _x, _rndDir, true] call AW_fnc_spawnRelative;

    private _aa = createVehicle [_type, [0,0,0], [], 100, "NONE"];

    private _posAA = (_aaData # 0);
    _aa setDir (_aaData # 1);
    _posAA set [2, 0.1];
    _aa setPosATL _posAA;

    _aa removeMagazinesTurret ["SmokeLauncherMag", [0]];
    _aa removeWeaponTurret ["SmokeLauncher", [0]];

    _aa addEventHandler ["Reloaded", {
        params ["_unit", "_weapon", "_muzzle", "_newMagazine", "_oldMagazine"];

        _unit setVehicleAmmo 1;
    }];

    _aa setFuel 0;

    _AAs pushBack _aa;

    [_aa] call AW_fnc_vehicleCustomizationOpfor;
} forEach (_aaFort # 2);

deleteVehicle _origin;

private _aaGroup = (createGroup InA_EnemyFactionSide);
_aaGroup setGroupIdGlobal ["AO-SubObj-AA"];
private _crew = ["#crews", _factionHash] call AW_fnc_getUnitsFromHash;

{
    private _dir = (getDir _x);

    private _unit = _aaGroup createUnit [_crew, _aaPos, [], 10, "NONE"];
    _unit setDir _dir;

    _unit assignAsGunner _x;
    _unit moveInGunner _x;

    _x allowCrewInImmobile true;
    _x lock true;

    _subUnits pushBack _unit;
} forEach _AAs;

_aaGroup = [_aaGroup] call AW_fnc_changeGroupSide;

[(units _aaGroup)] call derp_fnc_AISkill;
[(units _aaGroup) + _AAs] call AW_fnc_addToAllCurators;

// Patrols
private _patrolDistance = 50;

private _infGrps = ["#squads", 1.5, "#specop_squads", 0.75, "#teams", 1.5, "#specop_teams", 1, "#aa_teams", 1.25, "#at_teams", 1.25];

for [{_i = 0}, {_i < 4}, {_i = (_i + 1)}] do {
    private _randomPos = [_aaPos, 20 , 125, 5, 0, 0.4, 0, [], _aaPos] call BIS_fnc_findSafePos;
    private _units = [(selectRandomWeighted _infGrps), _factionHash] call AW_fnc_getUnitsFromHash;
    private _grp = [_units, _randomPos] call AW_fnc_spawnAIGroup;

    [_grp, _aaPos, nil, _patrolDistance] call AW_fnc_taskCircPatrol;

    _grp setGroupIdGlobal [format ["AO-SubObj-Inf-Group%1", (_i + 1)]];

    _patrolDistance = (_patrolDistance + 25);

    _subUnits = (_subUnits + (units _grp));

    [_grp] spawn derp_fnc_AISkill;
    [(units _grp)] call AW_fnc_addToAllCurators;

    [_grp] spawn AW_fnc_transferGroupHC;

    sleep 0.1;
};

InA_Server_subObjUnits append (_subUnits + _subObjs + _AAs);


// Objective, task, etc.
InA_Server_SubMarkers = ["SUB", "AA Fortification", _roughPos, 225] call AW_fnc_missionMarkersCreate;
private _subMarker = (InA_Server_SubMarkers # 0);

private _targetStartText = format ["<t align='center' size='2.2'>Sub-Objective</t><br/><t size='1.5' align='center' color='#FFCF11'>AA Fortification</t><br/>____________________<br/>OPFOR has set up an Anti-Air Fortification in the AO. Find and destroy it !<br/><br/>"];
[_targetStartText] remoteExec ["AW_fnc_globalHint", 0];

[
    west,
    [
        "SubAoTask",
        "MainAoTask"
    ],
    [
        "OPFOR is operating an Anti-Air Fortification in the AO.<br/><br/>",
        "AA Fortification",
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

// Wait until AAA's are destroyed
waitUntil {
    if (InA_Server_MainAOControl_EndSubObj) exitWith {
        {
            if (alive _x) then {_x setDamage 1};
        } forEach _AAs;

        true
    };

    sleep 5;

    ((_AAs findIf {alive _x}) == -1)
};

// Objective, task, etc.
private _aoName = [] call AW_fnc_getCurrentAOName;
_targetStartText = format ["<t align='center' size='2.2'>Sub-Objective</t><br/><t size='1.5' align='center' color='#FFCF11'>Complete</t><br/>____________________<br/>Good job everyone, the AA Fortification has been destroyed. The airspace around %1 is now a little more secure", _aoName];
[_targetStartText] remoteExec ["AW_fnc_globalHint", 0];

0 = ["SubAoTask"] spawn AW_fnc_finishTask;

[InA_Server_SubMarkers] call AW_fnc_missionMarkersRemove;

InA_Server_MainAO_SubObjComplete = true;
