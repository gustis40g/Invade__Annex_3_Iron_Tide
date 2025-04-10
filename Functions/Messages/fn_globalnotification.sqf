/*
    Author: BACONMOP
    For creating a global notification
*/
params ["_type", "_args"];

if (!hasInterface) exitWith {};

private _argsArray = [];

if ((typeName _args) != (typeName [])) then {
    _argsArray pushBack _args;
} else {
    _argsArray = _args;
};

[_type, _argsArray] call BIS_fnc_showNotification;
