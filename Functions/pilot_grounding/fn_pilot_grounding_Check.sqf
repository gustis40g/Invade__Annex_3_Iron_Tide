/*
 * Author: Whigital
 * 
 * Description:
 * Does initial checks if pilot is grounded, or resets variables after timeout.
 *
 */

params ["_unit"];

if (!isServer) exitWith {};

private _playerUID = (getPlayerUID _unit);
private _owner = (owner _unit);

private _timer = (InA_Server_PilotAirframeTimers getOrDefault [_playerUID, 0]);

// If on timeout, send back to lobby ....
if (_timer > serverTime) then {
    ["GroundedTimer", false, 0, false] remoteExecCall ["BIS_fnc_endMission", _owner];
};
