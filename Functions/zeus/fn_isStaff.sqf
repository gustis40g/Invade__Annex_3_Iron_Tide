/*
 * Author: Whigital
 *
 * Description:
 * Check player/owner for Staff access
 *
 */

params ["_input"];

if (!isServer) exitWith {false};

private _caller = objNull;

if (_input isEqualType 0) then {
    private _players = allPlayers;

    private _playerIdx = (_players findIf {(owner _x) == _input});

    if (_playerIdx != -1) then {
        _caller = (_players # _playerIdx);
    };
};

if (isNull _caller) exitWith {false};

private _uid = (getPlayerUID _caller);

(_uid in (InA_Server_coreStaffUIDs + InA_Server_staffUIDs))
