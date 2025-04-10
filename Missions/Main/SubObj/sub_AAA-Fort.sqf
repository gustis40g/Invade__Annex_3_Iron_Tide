/*
 * Author: Whigital
 *
 * Description: Spawns a AAA Fortification with 2-3 Tigris AAA's, depending on playercount
 *
 */

params [["_factionHash", InA_EnemyFactionHash]];

private _aoPos = (getMarkerPos InA_Server_currentAO);
private _aaaPos = [_aoPos, 10, (InA_Server_MainAOSize * 0.8), 15, 0, 0.2, 0, [], [0,0,0]] call BIS_fnc_findSafePos;
private _roughPos =[((_aaaPos select 0) - 200) + (random 400), ((_aaaPos select 1) - 200) + (random 400), 0];

private _aaaForts = [
    [
        // 2x
        [
            ["Land_HBarrier_Big_F",[-8.54858,-0.931931,-0.222783],90],
            ["Land_HBarrier_Big_F",[4.68018,-3.85994,-0.222783],180.024],
            ["Land_HBarrier_Big_F",[8.39014,1.561,-0.222783],270.013],
            ["Land_HBarrier_Big_F",[5.27783,8.46729,-0.222783],213.447],
            ["Land_HBarrier_Big_F",[-4.83887,4.48964,-0.222783],0],
            ["Land_HBarrier_Big_F",[-5.31226,-7.45956,-0.222783],213.447],
            ["Land_Razorwire_F",[3.88672,-8.7216,-0.222783],150.921],
            ["Land_Razorwire_F",[-3.64893,9.47678,-0.222783],330.317]
        ],
        [
            ["Box_East_AmmoVeh_F",[-0.39502,-1.28754,-0.222783],103.469],
            ["Box_East_AmmoVeh_F",[-0.137207,1.42448,-0.222783],59.0728]
        ],
        [
            ["PRACS_SLA_2S6M_Tunguska",[4.62231,1.147812,-0.222783],180.024],
            ["PRACS_SLA_2S6M_Tunguska",[-4.78149,-0.517838,-0.222783],0]
        ]
    ],

    // 3x
    [
        [
            ["Land_HBarrier_Big_F",[-5.43774,-7.06808,-0.222783],329.982],
            ["Land_HBarrier_Big_F",[-11.8643,-6.53738,-0.222783],239.982],
            ["Land_HBarrier_Big_F",[0.157715,13.4293,-0.222783],0],
            ["Land_HBarrier_Big_F",[-3.552,8.00775,-0.222783],90],
            ["Land_HBarrier_Big_F",[-9.41113,-0.655151,-0.222783],329.982],
            ["Land_HBarrier_Big_F",[5.04272,-7.44336,-0.222783],210.067],
            ["Land_HBarrier_Big_F",[11.6638,-6.66614,-0.222783],120.042],
            ["Land_HBarrier_Big_F",[4.06372,8.21826,-0.222783],90],
            ["Land_HBarrier_Big_F",[8.79614,-0.473999,-0.222783],210.067],
            ["Land_Razorwire_F",[-0.311768,-10.0301,-0.222783],0],
            ["Land_Razorwire_F",[-8.60864,5.65472,-0.222783],120.028],
            ["Land_Razorwire_F",[9.20313,5.0123,-0.222783],59.9693]
        ],
        [
            ["Box_East_AmmoVeh_F",[0.727539,-1.22055,-0.222783],59.0728],
            ["Box_East_AmmoVeh_F",[-1.37671,0.24649,-0.222783],119.511],
            ["Box_East_AmmoVeh_F",[0.953613,1.29889,-0.222783],81.906]
        ],
        [
            ["PRACS_SLA_2S6M_Tunguska",[-8.15723, -4.0,-0.222783],239.982],
            ["PRACS_SLA_2S6M_Tunguska",[0.215088, 9.17184,-0.222783],0],
            ["PRACS_SLA_2S6M_Tunguska",[7.85083, -5.0,-0.222783],120.042]
        ]
    ]
];

private _playerCount = InA_Server_PlayerCount;

private _aaaFort = (_aaaForts select (_playerCount > 20));

private _subObjs = [];
private _subUnits = [];
private _AAAs = [];

private _rndDir = (random 360);

private _origin = createVehicle ["Land_Balloon_01_air_F", [0,0,0], [], 0, "NONE"];
_origin allowDamage false;
_origin enableSimulation false;
_origin setDir _rndDir;
_origin setPos _aaaPos;
_origin setVectorUp [0,0,1];

{
    private _obj = [_origin, _x, _rndDir] call AW_fnc_spawnRelative;
    _obj allowDamage false;

    private _objPos = (getPos _obj);
    _objPos set [2, 0];
    _obj setPosATL _objPos;

    _obj setVectorUp (surfaceNormal (getPosATL _obj));
    _subObjs pushBack _obj;
} forEach (_aaaFort # 0);

{
    private _box = [_origin, _x, _rndDir] call AW_fnc_spawnRelative;

    _box allowDamage false;

    _box setVectorUp (surfaceNormal (getPosATL _box));

    clearWeaponCargoGlobal _box;
    clearMagazineCargoGlobal _box;
    clearItemCargoGlobal _box;
    clearBackpackCargoGlobal _box;

    _subObjs pushBack _box;
} forEach (_aaaFort # 1);

{
    _x params ["_type", "_pos", "_dir"];

    private _aaaData = [_origin, _x, _rndDir, true] call AW_fnc_spawnRelative;

    private _aaa = createVehicle [_type, [0,0,0], [], 100, "NONE"];

    private _posAA = (_aaaData # 0);
    _aaa setDir (_aaaData # 1);
    _posAA set [2, 0.1];
    _aaa setPosATL _posAA;

    _aaa addMagazineTurret ["PRACS_2A38_1904rnd_30mm_mixed", [0]];
    _aaa addMagazineTurret ["PRACS_9m311_X1", [0]];

    _aaa addEventHandler ["Reloaded", {
        params ["_unit", "_weapon", "_muzzle", "_newMagazine", "_oldMagazine"];

        _unit setVehicleAmmo 1;
    }];

    _aaa setFuel 0;

    _AAAs pushBack _aaa;

    [_aaa] call AW_fnc_vehicleCustomizationOpfor;
} forEach (_aaaFort # 2);

deleteVehicle _origin;

private _aaaGroup = (createGroup InA_EnemyFactionSide);
private _crew = ["#crews", _factionHash] call AW_fnc_getUnitsFromHash;

{
    private _dir = (getDir _x);

    private _unit = _aaaGroup createUnit [_crew, _aaaPos, [], 10, "NONE"];
    _unit setDir _dir;

    _unit assignAsGunner _x;
    _unit moveInGunner _x;

    _x allowCrewInImmobile true;
    _x lock true;

    _subUnits pushBack _unit;
} forEach _AAAs;

_aaaGroup = [_aaaGroup] call AW_fnc_changeGroupSide;
_aaaGroup setGroupIdGlobal ["AO-SubObj-AAA"];

[(units _aaaGroup)] call derp_fnc_AISkill;
[((units _aaaGroup) + _AAAs)] call AW_fnc_addToAllCurators;


// Patrols
private _patrolDistance = 50;
private _infGrps = ["#squads", 1.5, "#specop_squads", 0.75, "#teams", 1.5, "#specop_teams", 1, "#aa_teams", 1.25, "#at_teams", 1.25];


for [{_i = 0}, {_i < 4}, {_i = (_i + 1)}] do {
    private _randomPos = [_aaaPos, 20 , 125, 5, 0, 0.4, 0, [], _aaaPos] call BIS_fnc_findSafePos;
    private _units = [(selectRandomWeighted _infGrps), _factionHash] call AW_fnc_getUnitsFromHash;
    private _grp = [_units, _randomPos] call AW_fnc_spawnAIGroup;

    [_grp, _aaaPos, nil, _patrolDistance] call AW_fnc_taskCircPatrol;

    _grp setGroupIdGlobal [format ["AO-SubObj-Inf-Group%1", (_i + 1)]];

    _patrolDistance = (_patrolDistance + 25);

    _subUnits = (_subUnits + (units _grp));

    [_grp] spawn derp_fnc_AISkill;
    [(units _grp)] call AW_fnc_addToAllCurators;

    [_grp] spawn AW_fnc_transferGroupHC;

    sleep 0.1;
};

InA_Server_subObjUnits append (_subUnits + _subObjs + _AAAs);


// Decrease Tracked AA in the AO
private _aoAAs = (((entities [["I_LT_01_AA_F", "O_APC_Tracked_02_AA_F"], [], false, true]) - _AAAs) select {((_x distance2D _aoPos) < InA_Server_MainAOSize)});
private _aaLimit = ([1, 2] select (_playerCount > 20));

if ((count _aoAAs) > _aaLimit) then {
    while {(count _aoAAs) > _aaLimit} do {
        private _toDelete = (_aoAAs # 0);

        _aoAAs = (_aoAAs - [_toDelete]);

        {
            moveOut _x;
            deleteVehicle _x;
        } forEach (crew _toDelete);

        deleteVehicle _toDelete;
    };
};


// Objective, task, etc.
InA_Server_SubMarkers = ["SUB", "AAA Fortification", _roughPos, 225] call AW_fnc_missionMarkersCreate;
private _subMarker = (InA_Server_SubMarkers # 0);

private _targetStartText = format ["<t align='center' size='2.2'>Sub-Objective</t><br/><t size='1.5' align='center' color='#FFCF11'>AAA Fortification</t><br/>____________________<br/>OPFOR has set up an Anti-Air Artillery Fortification in the AO. Find and destroy it !<br/><br/>"];
[_targetStartText] remoteExec ["AW_fnc_globalHint", 0];

[
    west,
    [
        "SubAoTask",
        "MainAoTask"
    ],
    [
        "OPFOR is operating an Anti-Air Fortification in the AO.<br/><br/>",
        "AAA Fortification",
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
        } forEach _AAAs;

        true
    };

    sleep 5;

    ((_AAAs findIf {alive _x}) == -1)
};


// Objective, task, etc.
private _aoName = [] call AW_fnc_getCurrentAOName;
_targetStartText = format ["<t align='center' size='2.2'>Sub-Objective</t><br/><t size='1.5' align='center' color='#FFCF11'>Complete</t><br/>____________________<br/>Good job everyone, the AAA Fortification has been destroyed. The airspace around %1 is now a little more secure.", _aoName];
[_targetStartText] remoteExec ["AW_fnc_globalHint", 0];

0 = ["SubAoTask"] spawn AW_fnc_finishTask;

[InA_Server_SubMarkers] call AW_fnc_missionMarkersRemove;

InA_Server_MainAO_SubObjComplete = true;
