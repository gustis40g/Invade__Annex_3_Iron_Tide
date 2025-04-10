/*
author: stanhope
Description: Function that pushes a given vehicle into the InA_Server_RespawnVehiclesArray (scripts/vehicle/vehiclerespawn.sqf) array
*/

if (!isServer) exitWith {}; // GO AWAY PLAYER

params ["_vehicle", "_delay", ["_base", "BASE"], "_vehType", "_vehPos"];

if (!canSuspend) exitWith {
    _this spawn AW_fnc_vBasemonitor;
};

if (isNil "InA_Server_VehicleApperanceDefined") then {
    waitUntil {
        sleep 0.1;
        ((!isNil "InA_Server_VehicleApperanceDefined") && {InA_Server_VehicleApperanceDefined})
    };
};

_vehicle lock 2;

if (isNil "_vehType") then {
    _vehType = (typeOf _vehicle);
};

[_vehicle, _vehType] call AW_fnc_vehicleCustomization;
[_vehicle] call AW_fnc_generalVehicleSettings;

_vehicle lock 0;

if (isNil "_vehPos") then {
    _vehPos = (getPosWorld _vehicle);
};

private _uniqueId = (hashValue [_vehType, _vehPos, _delay, _base]);

sleep 2;

private _toPushBack = [_vehicle, _vehType, _vehPos, (getDir _vehicle), _delay, nil, _base, _uniqueId];

waitUntil {sleep 1; !isNil "InA_Server_RespawnVehiclesArray"};

InA_Server_RespawnVehiclesArray pushBack _toPushBack;
