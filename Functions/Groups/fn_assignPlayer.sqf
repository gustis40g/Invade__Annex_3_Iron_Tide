/*
    File: fn_assignPlayer.sqf
    Author: Dom
    Description: Assigns the player in the desired group
*/
params [
    ["_unit",objNull,[objNull]],
    ["_selectionPath",[],[[]]],
    ["_desiredRole","",[""]],
    ["_isRespawn",false,[true]]
];

_selectionPath params ["_groupIndex","_unitIndex"];
private _groupToUpdate = AW_dynamicGroups select _groupIndex;
private _unitsInGroup = _groupToUpdate select 4;
private _desiredUnit = _unitsInGroup select _unitIndex;

if (!isNull _desiredUnit && {!_isRespawn}) exitWith {
    ["Role already taken."] remoteExecCall ["hint",_unit];
};

private _oldSelectionPath = if (_isRespawn) then {[]} else {[_unit] call AW_fnc_removeFromGroup};

_unitsInGroup set [_unitIndex,_unit];
[_desiredRole,_isRespawn] remoteExecCall ["AW_fnc_setupPlayer",_unit];


private _fnc_getRankNumber = {
    params ["_rankString"];

    switch (toUpper _rankString) do {
        case "CORPORAL": {1};
        case "SERGEANT": {2};
        case "LIEUTENANT": {3};
        case "CAPTAIN": {4};
        case "MAJOR": {5};
        case "COLONEL": {6};
        default {0};
    };
};

[AW_dynamicGroups,_oldSelectionPath,_selectionPath,_unit] remoteExecCall ["AW_fnc_updateGroups",-2,"AW_DG_JIP"];