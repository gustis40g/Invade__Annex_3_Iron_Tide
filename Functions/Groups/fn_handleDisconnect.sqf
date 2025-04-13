/*
	File: fn_handleDisconnect.sqf
	Author: Dom
	Description: Handles a players disconnection
*/
params ["_unit"];

private _oldSelectionPath = [_unit] call AW_fnc_removeFromGroup;

[AW_dynamicGroups,_oldSelectionPath] remoteExecCall ["AW_fnc_updateGroups",-2,"AW_DG_JIP"];