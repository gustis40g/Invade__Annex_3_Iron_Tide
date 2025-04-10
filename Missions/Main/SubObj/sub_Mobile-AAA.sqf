/*
author: stanhope, AW community member.
description: spawns a AAA truck as subobj
*/

params [["_factionHash", InA_EnemyFactionHash]];

private _skinsArray = [
    ["Hex", "Sand"],
    ["GreenHex", "Green"]
];

private _side = (_factionHash get "#side");

private _flatPos = [getMarkerPos InA_Server_currentAO, 10, InA_Server_MainAOSize, 5, 0, 0.1, 0, [], [0,0,0]] call BIS_fnc_findSafePos;

private _truck = createVehicle ["O_Truck_03_transport_F", _flatPos, [], 0, "NONE"];
private _AAA = createVehicle ["B_AAA_System_01_F", _flatPos, [], 10, "NONE"];

_AAA attachTo [_truck, [0.05, -1.2, 2.08]];

private _skins = (selectRandom _skinsArray);
[_truck, [(_skins # 0), 1]] call BIS_fnc_initVehicle;
[_AAA, [(_skins # 1), 1]] call BIS_fnc_initVehicle;

_truck setVariable ["Praetorian", _AAA];
_AAA setVariable ["Tempest", _truck];

_AAA setVehicleRadar 1;
_AAA setVehicleReceiveRemoteTargets true;
_AAA setVehicleReportOwnPosition true;
_AAA setVehicleReportRemoteTargets true;

private _aoAAAGroup = createGroup InA_EnemyFactionSide;

private _crew = ["#engineers", _factionHash] call AW_fnc_getUnitsFromHash;
private _unit = _aoAAAGroup createUnit [_crew, _truck, [], 10, "NONE"];

_unit assignAsDriver _truck;
_unit moveInDriver _truck;

_truck lock 3;
_truck allowCrewInImmobile [true, true];

private _AAACrew = _aoAAAGroup createUnit ["C_UAV_AI_F", [0,0,0], [], 0, "NONE"];
_AAACrew assignAsGunner _AAA;
_AAACrew moveInGunner _AAA;

_AAA allowCrewInImmobile [true, true];

_aoAAAGroup = [_aoAAAGroup] call AW_fnc_changeGroupSide;
_aoAAAGroup setGroupIdGlobal ["AO-SubObj-AAA"];

[(units _aoAAAGroup)] call derp_fnc_AISkill;

_AAA addEventHandler ["Killed", {
    params ["_AAA","","_killer"];

    private _name = name _killer;

    if (_name == "Error: No vehicle") then {
        _name = "Someone";
    };

    _aoName = [] call AW_fnc_getCurrentAOName;
    _targetStartText = format["<t align='center' size='2.2'>Sub-Objective</t><br/><t size='1.5' align='center' color='#FFCF11'>Update</t><br/>____________________<br/>%2 destroyed the goalkeeper. CSAT will now have a tougher time keeping a hold of %1.",_aoName,_name];
    [_targetStartText] remoteExec ["AW_fnc_globalHint", 0];
    private _truck = _AAA getVariable ["Tempest", objNull];
    _truck setDamage 1;
}];

_AAA addEventHandler ["Reloaded", {
    params ["_unit", "_weapon", "_muzzle", "_newMagazine", "_oldMagazine"];

    _unit setVehicleAmmo 1;
}];

_truck addEventHandler ["Killed", {
    params ["_truck","","_killer"];

    private _name = name _killer;

    if (_name == "Error: No vehicle") then {
        _name = "Someone";
    };

    _aoName = [] call AW_fnc_getCurrentAOName;
    _targetStartText = format["<t align='center' size='2.2'>Sub-Objective</t><br/><t size='1.5' align='center' color='#FFCF11'>Update</t><br/>____________________<br/>%2 destroyed the goalkeeper. CSAT will now have a tougher time keeping a hold of %1.",_aoName,_name];
    [_targetStartText] remoteExec ["AW_fnc_globalHint", 0];
    private _AAA = _truck getVariable ["Praetorian", objNull];
    _AAA setDamage 1;
}];

[_aoAAAGroup, _flatPos, nil, 175] call AW_fnc_taskRndPatrol;

[(units _aoAAAGroup) + [_truck,_AAA]] call AW_fnc_addToAllCurators;

_aoAAAGroup setBehaviour "AWARE";
_aoAAAGroup setCombatMode "YELLOW";

InA_Server_subObjUnits = ((units _aoAAAGroup) + [_truck, _AAA]);

InA_Server_SubMarkers = ["SUB", "Goalkeeper", _flatPos, 225] call AW_fnc_missionMarkersCreate;
private _subMarker = (InA_Server_SubMarkers # 0);

_targetStartText = format["<t align='center' size='2.2'>Sub-Objective</t><br/><t size='1.5' align='center' color='#FFCF11'>Goalkeeper</t><br/>____________________<br/>OPFOR is fieldtesting their latest prototype AAA system.  A goalkeeper strapped to a transport truck.  Take it out before so they don't get any usefull data from the test.<br/><br/>"];
[_targetStartText] remoteExec ["AW_fnc_globalHint", 0];

[
    west,
    [
        "SubAoTask",
        "MainAoTask"
    ],
    [
        "OPFOR is fieldtesting their latest prototype AAA system.  A goalkeeper strapped to a transport truck.  Take it out before so they don't get any usefull data from the test.  Intel suggest it'll look like this:<br/><br/><img image='Media\Briefing\goalKeeper.jpg' width='300' height='150'/>",
        "Goalkeeper",
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

waitUntil {
    if (InA_Server_MainAOControl_EndSubObj) exitWith {
        {
            if (alive _x) then {_x setDamage 1};
        } forEach [_AAA, _truck];

        true
    };

    sleep 5;

    ((!alive _AAA) || (!alive _truck))
};

0 = ["SubAoTask"] spawn AW_fnc_finishTask;

[InA_Server_SubMarkers] call AW_fnc_missionMarkersRemove;

InA_Server_MainAO_SubObjComplete = true;
