/*
 * Author: Whigital
 * Description:
 * Checks if there are any players within <n> meters of unit/position
 *
 */

params [
    ["_input", objNull],
    ["_distance", 500]
];

if (!(_input isEqualTypeAny [[], objNull])) exitWith {false};

private _pos = [0, 0, 0];

if ((typeName _input) == "OBJECT") then {
    _pos = (getPosATL _input);
} else {
    _pos = _input;
};

if (!(_pos isEqualTypeAll 0)) exitWith {false};

((((allPlayers - (entities "HeadlessClient_F")) select {alive _x}) findIf {(_pos distance2D _x) < _distance}) != -1)
