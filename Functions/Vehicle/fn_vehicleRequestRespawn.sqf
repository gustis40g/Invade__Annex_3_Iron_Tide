/*
 * Author: Whigital
 * Description:
 * Resets the respawn timer of a specific vehicle
 *
 */

params ["_id"];

if (!isServer) exitWith {};

if (isRemoteExecuted && {!([remoteExecutedOwner] call AW_fnc_isStaff)}) exitWith {
    private _caller = objNull;
    private _players = allPlayers;

    private _playerIdx = (_players findIf {(owner _x) == remoteExecutedOwner});

    if (_playerIdx != -1) then {
        _caller = (_players # _playerIdx);
    };

    private _msg = (format ["%1 :: Non Staff %2 (%3) tried to respawn a vehicle!", _fnc_scriptName, (name _caller), (getPlayerUID _caller)]);
    [_msg, "VIOLATION", true] call AW_fnc_log;
};

private _vehIdx = (InA_Server_RespawnVehiclesArray findIf {(_x # 7) == _id});

if (_vehIdx == -1) exitWith {
    if (isRemoteExecuted) then {
        ["Vehicle not found in respawn list on server!"] remoteExec ["systemChat", remoteExecutedOwner];
    };
};

private _vehData = (InA_Server_RespawnVehiclesArray # _vehIdx);

_vehData params ["_veh", "_vehType", "_spawnPos", "_spawnDir", "_spawnDelay", "_timeDestroyed", "_base", "_uid"];

_vehData set [5, (serverTime - _spawnDelay)];

InA_Server_RespawnVehiclesArray set [_vehIdx, _vehData];

if (isRemoteExecuted) then {
    private _msg = (format ["Vehicle '%1' at '%2' set to respawn in the next respawn loop ....", ([_vehType] call AW_fnc_getRespawnVehicleDisplayName), ([_base] call AW_fnc_getFOBDisplayName)]);
    [_msg] remoteExec ["systemChat", remoteExecutedOwner];
};
