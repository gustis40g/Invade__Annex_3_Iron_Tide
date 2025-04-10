/*
 * Author: Whigital
 *
 * Vehicle fuel status event handler
 *
 */

params ["_oper", "_args"];

switch (_oper) do {
    case "ADD": {
        _args params ["_vehicle"];

        if (isNil {_vehicle getHitPointDamage "HitFuel"}) exitWith {};

        _vehicle setVariable ["InA_FuelEhIdx", (_vehicle addEventHandler ["Fuel", {["HANDLE", _this] call AW_fnc_vehicleFuelEh}])];
    };

    case "DELETE": {
        _args params ["_vehicle"];

        private _ehIdx = (_vehicle getVariable ["InA_FuelEhIdx", -1]);

        if (_ehIdx != -1) then {
            _vehicle removeEventHandler ["Fuel", _ehIdx];
        };
    };

    case "HANDLE": {
        _args params ["_vehicle", "_hasFuel"];

        if (!_hasFuel) then {
            private _fuelDamage = (_vehicle getHitPointDamage "HitFuel");

            if (_fuelDamage < 1) then {
                [_vehicle, (1 - _fuelDamage)] remoteExecCall ["setFuel", _vehicle];
            } else {
                ["DELETE", _vehicle] call AW_fnc_vehicleFuelEh;
            };
        };
    };
};
