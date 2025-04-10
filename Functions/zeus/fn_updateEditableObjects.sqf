/*
 * Author: Whigital
 * Description:
 * Adds objects to curator module
 *
 */

params [
    "_curator",
    ["_objects", []]
];

if (!isServer) exitWith {};

if (_objects isEqualTo []) then {
    _objects append (call AW_fnc_getEditableObjects);
};

private _curatorObjects = (curatorEditableObjects _curator);

private _objsToAdd = (_objects - _curatorObjects);

_curator addCuratorEditableObjects [_objsToAdd, true];
