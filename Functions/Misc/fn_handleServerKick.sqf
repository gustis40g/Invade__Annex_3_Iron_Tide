/*
 * Author: Whigital
 * Description:
 * Wrapper for client kick calls
 *
 */

params ["_unit"];

if (!isServer) exitWith {};

if (!isRemoteExecuted) exitWith {};

if (remoteExecutedOwner != (owner _unit)) exitWith {
    private _caller = ((allPlayers select {(owner _x) == remoteExecutedOwner}) # 0);
    private _msg = (format ["Player %1 (%2) tried to call '%3' for player %4 (%5)!", (name _caller), (getPlayerUID _caller), _fnc_scriptName, (name _unit), (getPlayerUID _unit)]);
    [_msg, "KICK", true] call AW_fnc_log;
};

if (isNull _unit) exitWith {};

private _uid = (getPlayerUID _unit);

["kick", _uid] call AW_fnc_ServerCommand;
