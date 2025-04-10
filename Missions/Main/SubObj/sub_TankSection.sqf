/*author: stanhope, AW community member.*/

params [["_factionHash", InA_EnemyFactionHash]];

private _flatPos = [getMarkerPos InA_Server_currentAO, 25, InA_Server_MainAOSize, 8, 0, 0.5] call BIS_fnc_findSafePos;

private _tanks = [];

private _tank1 = createVehicle [(["#mbts", _factionHash] call AW_fnc_getUnitsFromHash), _flatPos, [], 0, "NONE"];
_tanks pushBack _tank1;

private _tankPos = [_flatPos, 15, 65, 8, 0, 0.5, 0, []] call BIS_fnc_findSafePos;
private _tank2 = createVehicle [(["#mbts", _factionHash] call AW_fnc_getUnitsFromHash), _tankPos, [], 0, "NONE"];
_tanks pushBack _tank2;

_tankPos = [_flatPos, 15, 65, 8, 0, 0.5, 0, [[_tankPos, 15]]] call BIS_fnc_findSafePos;
private _tank3 = createVehicle [(["#mbts", _factionHash] call AW_fnc_getUnitsFromHash), _tankPos, [], 0, "NONE"];
_tanks pushBack _tank3;

private _aoTankGroup = createGroup InA_EnemyFactionSide;

{
    _x call AW_fnc_vehicleCustomizationOpfor;
    private _tmpGrp = createVehicleCrew _x;
    (units _tmpGrp) joinSilent _aoTankGroup;
    sleep 0.1;
    _x lock 3;
    _x allowCrewInImmobile [true, true];

    _x addEventHandler ["Killed", {
        params ["_unit","","_killer"];
        private _name = name _killer;

        if (_name == "Error: No vehicle") then {
            _name = "Someone";
        };

        private _vehicleName = getText (configFile >> "CfgVehicles" >> typeOf _unit >> "displayName");
        private _aoName = [] call AW_fnc_getCurrentAOName;
        private _targetStartText = format["<t align='center' size='2.2'>Sub-Objective</t><br/><t size='1.5' align='center' color='#FFCF11'>Update</t><br/>____________________<br/>%2 destroyed one of a %3. Good job! Make sure to also find and eliminate the other tanks at %1.",_aoName,_name, _vehicleName];
        [_targetStartText] remoteExec ["AW_fnc_globalHint",0];
    }];
} forEach _tanks;

_aoTankGroup setGroupIdGlobal ["AO-SubObj-TankSection"];

[(units _aoTankGroup)] call derp_fnc_AISkill;

[_aoTankGroup, _flatPos, nil, 175] call AW_fnc_taskRndPatrol;
_aoTankGroup setFormation "WEDGE";
_aoTankGroup setSpeedMode "LIMITED";

[(units _aoTankGroup) + [_tank1, _tank2, _tank3]] call AW_fnc_addToAllCurators;

_aoTankGroup setBehaviour "AWARE";
_aoTankGroup setCombatMode "YELLOW";

InA_Server_subObjUnits = ((units _aoTankGroup) + [_tank1,_tank2,_tank3]);

InA_Server_SubMarkers = ["SUB", "Tank Section", _flatPos, 225] call AW_fnc_missionMarkersCreate;
private _subMarker = (InA_Server_SubMarkers # 0);

_targetStartText = format["<t align='center' size='2.2'>Sub-Objective</t><br/><t size='1.5' align='center' color='#FFCF11'>Tank Section</t><br/>____________________<br/>OPFOR have called in a Tank Section. Find and destroy these MBTs, they must not survive this AO.<br/><br/>"];
[_targetStartText] remoteExec ["AW_fnc_globalHint",0];

[
    west,
    [
        "SubAoTask",
        "MainAoTask"
    ],
    [
        "OPFOR have called in a Tank Section. Find and destroy these MBTs, they must not survive this AO.",
        "Tank Section",
        _subMarker
    ],
    _flatPos,
    "Created",
    0,
    true,
    "destroy",
    true
] call BIS_fnc_taskCreate;

InA_Server_MainAoSubObjSpawn_Complete = true;

while {sleep 5; ((_tanks findIf {alive _x}) != -1)} do {
    if (InA_Server_MainAOControl_EndSubObj) then {
        {
            if (alive _x) then {_x setDamage 1};
        } forEach _tanks;

        break
    };

    {
        if (((getPosASL _x) # 2) < 0) then {_x setDamage 1};
    } forEach _tanks;
};

0 = ["SubAoTask"] spawn AW_fnc_finishTask;

[InA_Server_SubMarkers] call AW_fnc_missionMarkersRemove;

InA_Server_MainAO_SubObjComplete = true;
