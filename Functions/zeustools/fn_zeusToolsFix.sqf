/*
 * Author: Whigital
 * Description:
 * Vehicle fix function
 *
 */

params ["_vehicle"];

if (!isServer) exitWith {};

if (isRemoteExecuted && {!([remoteExecutedOwner] call AW_fnc_isZeus)}) exitWith {
    private _caller = objNull;
    private _players = allPlayers;

    private _playerIdx = (_players findIf {(owner _x) == remoteExecutedOwner});

    if (_playerIdx != -1) then {
        _caller = (_players # _playerIdx);
    };

    private _msg = (format ["%1 :: Non Zeus player %2 (%3) tried to fix a vehicle!", _fnc_scriptName, (name _caller), (getPlayerUID _caller)]);
    [_msg, "VIOLATION", true] call AW_fnc_log;
};

if (isNull _vehicle) exitWith {};

[_vehicle, 0] remoteExec ["setDamage", _vehicle];
[_vehicle, 1] remoteExec ["setFuel", _vehicle];
[_vehicle, 1] remoteExec ["setVehicleAmmo", _vehicle];
