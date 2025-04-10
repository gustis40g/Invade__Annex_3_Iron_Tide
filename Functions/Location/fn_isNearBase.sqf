/*
 * Author: Whigital
 * Description:
 * Checks if a unit/position is within <n> meter of any base/fob
 *
 */

params [
    ["_input", objNull],
    ["_distance", 500]
];

if (!(_input isEqualTypeAny [[], objNull])) exitWith {false};

private _pos = [0, 0, 0];

private _bases = (
    if (isServer) then {
        InA_Server_BaseArray
    } else {
        InA_Client_BaseArray
    }
);

if ((typeName _input) == "OBJECT") then {
    _pos = (getPosATL _input);
} else {
    _pos = _input;
};

if (!(_pos isEqualTypeAll 0)) exitWith {false};

((_bases findIf {(_pos distance2D (getMarkerPos _x)) < _distance}) != -1)
