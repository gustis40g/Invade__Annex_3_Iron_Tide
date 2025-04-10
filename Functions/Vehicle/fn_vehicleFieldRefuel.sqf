params [
    ["_vehicle", objNull],
    ["_amount", 0.05]
];

if (isNull _vehicle || !alive _vehicle) exitWith {};

if (!local _vehicle) exitWith {
    [_vehicle, _amount] remoteExec ["AW_fnc_vehicleFieldRefuel", _vehicle];
};

_vehicle setFuel ((fuel _vehicle) + _amount);
