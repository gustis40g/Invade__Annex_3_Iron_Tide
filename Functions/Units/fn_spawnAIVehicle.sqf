/*
    author: stanhope
    description: spawns an AI vehicle with crew
    returns: vehicle
*/

params [
    "_pos",
    "_vehType",
    ["_side", InA_EnemyFactionSide]
];

private _veh = (createVehicle [_vehType, _pos, [], 0, "NONE"]);

_veh call AW_fnc_vehicleCustomizationOpfor;

private _tmpGrp = (createVehicleCrew _veh);

_tmpGrp = [_tmpGrp] call AW_fnc_changeGroupSide;

_veh lock 2;
_veh allowCrewInImmobile [true, true];

_veh
