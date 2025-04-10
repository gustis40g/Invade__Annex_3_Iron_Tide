/*
author: unknown

description: 

Last modified: 16/11/2017 by stanhope

Modified: initial release
*/
private _aoLoaction = getMarkerPos InA_Server_currentAO;
private _flatPos = [];
private _spawnedObjects = [];

_flatPos = [getMarkerPos InA_Server_currentAO, 10, InA_Server_MainAOSize, 10, 0, 0.1, 0, [], [0,0,0]] call BIS_fnc_findSafePos;

radioTower = "Land_TTowerBig_2_F" createVehicle _flatPos;
waitUntil {alive radioTower};
radioTower setVectorUp [0,0,1];
radioTower setDir 0;
_flatPos = getPos radioTower;

_barrier1 = createVehicle ["Land_HBarrier_Big_F", [(_flatPos select 0) + 11, (_flatPos select 1) + 4, 0], [], 0, "CAN_COLLIDE"];
_barrier1 setDir 90;
_barrier2 = createVehicle ["Land_HBarrier_Big_F", [(_flatPos select 0) + 11, (_flatPos select 1) - 6, 0], [], 0, "CAN_COLLIDE"];
_barrier2 setDir 90;
_barrier3 = createVehicle ["Land_HBarrier_Big_F", [(_flatPos select 0) - 9, (_flatPos select 1) + 4, 0], [], 0, "CAN_COLLIDE"];
_barrier3 setDir 90;
_barrier4 = createVehicle ["Land_HBarrier_Big_F", [(_flatPos select 0) - 9, (_flatPos select 1) - 6, 0], [], 0, "CAN_COLLIDE"];
_barrier4 setDir 90;
_barrier5 = createVehicle ["Land_HBarrier_Big_F", [(_flatPos select 0) + 6, (_flatPos select 1) + 9, 0], [], 0, "CAN_COLLIDE"];
_barrier6 = createVehicle ["Land_HBarrier_Big_F", [(_flatPos select 0) - 4, (_flatPos select 1) + 9, 0], [], 0, "CAN_COLLIDE"];
_barrier7 = createVehicle ["Land_HBarrier_Big_F", [(_flatPos select 0) + 6, (_flatPos select 1) - 11, 0], [], 0, "CAN_COLLIDE"];
_barrier8 = createVehicle ["Land_HBarrier_Big_F", [(_flatPos select 0) - 4, (_flatPos select 1) - 11, 0], [], 0, "CAN_COLLIDE"];
_spawnedObjects append [_barrier1,_barrier2,_barrier3,_barrier4,_barrier5,_barrier6,_barrier7,_barrier8];

{_x setVectorUp surfaceNormal position _x;} forEach _spawnedObjects;

//Spawn mines, 10 for each 90° around the RT
{
    for "_i" from 1 to 10 do {
        _minePos = radioTower getPos [random [3, 6, 10], _x + random(90)];
        private _mineType = selectRandom ["APERSMine", "APERSMine", "APERSMine"];
        _mine = createMine [_mineType, _minePos, [],0];
        _spawnedObjects pushBack _mine;
        InA_EnemyFactionSide revealMine _mine;
        civilian revealMine _mine;
    };
} forEach [0,90,180,270];

radioTower addEventHandler ["Killed", {
    params ["_unit","","_killer"];

    private _rtPos = (getPos _unit);

    _name = name _killer;
    if (_name == "Error: No vehicle") then{
		_name = "someone";
    };

    [_rtPos] spawn {
        params ["_pos"];

        sleep 1;
        private _rtRuins = (nearestObject [_pos, "Land_TTowerBig_2_ruins_F"]);

        InA_Server_subObjUnits pushBack _rtRuins;
    };

	_aoName = [] call AW_fnc_getCurrentAOName;
    _targetStartText = format["<t align='center' size='2.2'>Sub-Objective</t><br/><t size='1.5' align='center' color='#FFCF11'>Complete</t><br/>____________________<br/>Good job with that radio tower, %2 destroyed it. OPFOR should have a tougher time organizing their air efforts in %1.",_aoName,_name];
    [_targetStartText] remoteExec ["AW_fnc_globalHint",0];
}];

private _roughPos =[((_flatPos select 0) - 200) + (random 400), ((_flatPos select 1) - 200) + (random 400), 0];

InA_Server_SubMarkers = ["SUB", "Radio Tower", _roughPos, 225] call AW_fnc_missionMarkersCreate;
private _subMarker = (InA_Server_SubMarkers # 0);

private _targetStartText = format["<t align='center' size='2.2'>Sub-Objective</t><br/><t size='1.5' align='center' color='#FFCF11'>Radio Tower</t><br/>____________________
<br/>OPFOR have setup a radio communications tower in the AO. Take it out quickly or else they will use it to call in air strikes.<br/><br/>"];
[_targetStartText] remoteExec ["AW_fnc_globalHint",0];
[
    west,
    [
        "SubAoTask",
        "MainAoTask"
    ],
    [
        "OPFOR have setup a radio communications tower in the AO. Take it out quickly or else they will use it to call in air strikes.  Here is a picture someone managed to take of one of those radiotowers: <br/><br/><img image='Media\Briefing\radioTower.jpg' width='300' height='150'/>",
        "Radio Tower",
        _subMarker
    ],
    _roughPos,
    "Created",
    0,
    true,
    "destroy",
    true
] call BIS_fnc_taskCreate;

0 = [] spawn {
    private _intervalMin = 300;
    private _intervalMax = 840;
    private _lastSpawn = -_intervalMax;

    while {sleep 5; (alive radioTower)} do {
        private _interval = (ceil (linearConversion [1, 60, InA_Server_PlayerCount, _intervalMax, _intervalMin, true]));

        if (
            (time < (_lastSpawn + _interval)) ||
            (InA_Server_AOReinforceJetCount >= InA_Server_AOReinforceJetLimit)
        ) then {continue};

        _lastSpawn = time;

        [] spawn AW_fnc_enemyJetSpawn;
    };
};

InA_Server_subObjUnits append _spawnedObjects;

InA_Server_MainAoSubObjSpawn_Complete = true;

waitUntil {
    if (InA_Server_MainAOControl_EndSubObj) exitWith {
        radioTower setDamage 1;

        true
    };

    sleep 5;

    (!alive radioTower)
};

0 = ["SubAoTask"] spawn AW_fnc_finishTask;

[InA_Server_SubMarkers] call AW_fnc_missionMarkersRemove;

InA_Server_MainAO_SubObjComplete = true;
