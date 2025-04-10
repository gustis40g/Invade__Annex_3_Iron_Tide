/*
 * Author: Whigital
 * Description:
 * Applies vehicle skin/textures and components
 *
 */

params [
    "_veh",
    ["_side", "BLUFOR"]
];

if (!isServer) exitWith {};

if (isNull _veh) exitWith {};

private _isTex = false;
private _data = [(typeOf _veh), _side] call AW_fnc_vehicleApperanceLookup;
private _tex = [];

if (isNil "_data") exitWith {};

_data params ["_skin", "_components"];

if (isNil "_skin") exitWith {
    if (isNil "_components") then {
        diag_log text format ["%1 :: No apperance data found for vehicle %2", _fnc_scriptName, (typeOf _veh)];
    } else {
        [
            _veh,
            false,
            _components
        ] call BIS_fnc_initVehicle;
    };
};

if ((typeName _skin) == "ARRAY") then {
    _isTex = true;
    _tex = _skin;
};

if (!_isTex && {(_skin select [0, 6]) == "#TEX#_"}) then {
    _tex = (([(typeOf _veh), _side, _skin, true] call AW_fnc_vehicleApperanceLookup) # 0);
    _isTex = true;
};

if (_isTex && {(isNil "_tex") || (_tex isEqualTo [])}) exitWith {
    diag_log text format ["%1 :: Unable to find texture data for vehicle %2 (%3)", _fnc_scriptName, (typeOf _veh), [_components, _side, _skin]];
};

switch (true) do {
    case (!_isTex && (_components isEqualTo [])): {
        [
            _veh,
            _skin
        ] call BIS_fnc_initVehicle;
    };

    case (!_isTex && (_components isNotEqualTo [])): {
        [
            _veh,
            _skin,
            _components
        ] call BIS_fnc_initVehicle;
    };

    case (_isTex): {
        if (_components isNotEqualTo []) then {
            [_veh, _components] call {
                params ["_vehicle", "_components"];

                private _customization = [
                    _vehicle,
                    false,
                    _components
                ] spawn BIS_fnc_initVehicle;

                waitUntil {sleep 0.1; scriptDone _customization};
            };
        };

        {
            _veh setObjectTextureGlobal [_forEachIndex, _x];
        } forEach _tex;
    };
};
