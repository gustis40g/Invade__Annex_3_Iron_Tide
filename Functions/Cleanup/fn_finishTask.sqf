/*
 * Author: Whigital
 * Description:
 * Finish a task
 *
 */

params [
    "_task",
    ["_status", "Succeeded"],
    ["_side", west],
    ["_removeFromJIP", true]
];

if !([_task] call BIS_fnc_taskExists) exitWith {};

[_task, _status] call BIS_fnc_taskSetState;

sleep 5;

[_task, _side, _removeFromJIP] call BIS_fnc_deleteTask;
