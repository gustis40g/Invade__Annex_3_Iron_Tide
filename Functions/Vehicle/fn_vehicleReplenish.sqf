/*
 * Author: Whigital
 *
 * Repair/Rearm/Refuel vehicle
 *
 */

params [
    ["_vehicle", objNull]
];

if (!isServer) exitWith {};

private _isServiceCall = (_fnc_scriptNameParent == "AW_fnc_repairServiceVehicle");

if (isRemoteExecuted && {!_isServiceCall && {!([remoteExecutedOwner] call AW_fnc_isZeus)}}) exitWith {
    private _caller = objNull;
    private _players = allPlayers;

    private _playerIdx = (_players findIf {(owner _x) == remoteExecutedOwner});

    if (_playerIdx != -1) then {
        _caller = (_players # _playerIdx);
    };

    private _msg = (format ["%1 :: Non Zeus player %1 (%2) tried to replenish a vehicle (%3)!", _fnc_scriptName, (name _caller), (getPlayerUID _caller), (typeOf _vehicle)]);
    [_msg, "VIOLATION", true] call AW_fnc_log;
};

[_vehicle, {
    params ["_veh"];

    _veh setVehicleAmmo 1;
    _veh setDamage 0;
    _veh setFuel 1;

    _veh setRepairCargo 1;
    _veh setAmmoCargo 1;
    _veh setFuelCargo 1;
}] remoteExec ["call", _vehicle];

if ((attachedObjects _vehicle) isNotEqualTo []) then {
    {
        private _attached = _x;

        if (!(_attached isKindOf "StaticWeapon")) then {continue};

        private _turrets = (allTurrets _attached);

        if (_turrets isEqualTo []) then {
            [_attached, 1] remoteExecCall ["setVehicleAmmo", _attached];

            continue
        };

        {
            private _turret = _x;
            [_attached, 1] remoteExecCall ["setVehicleAmmo", (_attached turretOwner _turret)];
        } forEach (allTurrets _attached);

        _x setDamage 0;
        _x setFuel 1;
    } forEach (attachedObjects _vehicle);
};
