/*
 * Author: Whigital
 * Description:
 * Extracts apperance data from hashtables based on vehicle
 *
 */

params [
    "_vehType",
    "_side",
    ["_key", InA_Server_MapEnvType],
    ["_texOnly", false]
];

if (!isServer) exitWith {};

private _table = (
    switch (_side) do {
        case "BLUFOR": {
            InA_Server_VehicleApperanceHash
        };

        case "OPFOR": {
            InA_Server_VehicleApperanceOPFHash
        };

        default {
            InA_Server_VehicleApperanceHash
        };
    }
);

private _vehHash = (_table get _vehType);
if (isNil "_vehHash") exitWith {};

if (_texOnly) exitWith {
    _vehHash getOrDefault [_key, []]
};

private _components = (_vehHash getOrDefault ["#components", []]);

private _vehSkins = (_vehHash get _key);

if (isNil "_vehSkins") then {
    _vehSkins = (_vehHash get "Default");
};

if (isNil "_vehSkins") exitWith {
    [nil, _components]
};

[(selectRandom _vehSkins), _components]
