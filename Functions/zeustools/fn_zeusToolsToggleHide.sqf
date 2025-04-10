/*
 * Author: Whigital
 * Description:
 * Hides/Unhides Zeus
 *
 */

params ["_unit"];

if (!isServer) exitWith {};

if (isRemoteExecuted && {!([remoteExecutedOwner] call AW_fnc_isZeus)}) exitWith {
    private _caller = objNull;
    private _players = allPlayers;

    private _playerIdx = (_players findIf {(owner _x) == remoteExecutedOwner});

    if (_playerIdx != -1) then {
        _caller = (_players # _playerIdx);
    };

    private _msg = (format ["%1 :: Non Zeus player %2 (%3) tried to toggle hidden!", _fnc_scriptName, (name _caller), (getPlayerUID _caller)]);
    [_msg, "VIOLATION", true] call AW_fnc_log;
};

private _isHidden = (isObjectHidden _unit);

switch (_isHidden) do {
    case false: {
        private _tempGrp = (createGroup civilian);
        private _tempUnit = (_tempGrp createUnit ["C_Soldier_VR_F", [0, 0, 0], [], 100, "NONE"]);
        _tempGrp setGroupIdGlobal [(format ["Hidden_Zeus-%1", (name _unit)])];

        [_unit] joinSilent _tempGrp;

        _tempUnit call AW_fnc_delete;

        _unit hideObjectGlobal true;

        if (isRemoteExecuted) then {
            [1, ["Hidden - World and Map", "PLAIN"]] remoteExec ["cutText", remoteExecutedOwner];
        };
    };

    case true: {
        private _tempGrp = (createGroup west);
        private _tempUnit = (_tempGrp createUnit ["C_Soldier_VR_F", [0, 0, 0], [], 100, "NONE"]);

        [_unit] joinSilent _tempGrp;

        _tempUnit call AW_fnc_delete;

        _unit hideObjectGlobal false;

        if (isRemoteExecuted) then {
            [1, ["Visible - World and Map", "PLAIN"]] remoteExec ["cutText", remoteExecutedOwner];
        };
    };
};
