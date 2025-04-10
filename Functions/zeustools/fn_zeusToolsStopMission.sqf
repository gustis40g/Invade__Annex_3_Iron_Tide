/*
 * Author: Whigital
 * Description:
 * Handles stopping of Main/Side/Prio missions
 *
 */

params ["_missionType"];

if (!isServer) exitWith {};

if (isRemoteExecuted && {!([remoteExecutedOwner] call AW_fnc_isStaff)}) exitWith {
    private _caller = objNull;
    private _players = allPlayers;

    private _playerIdx = (_players findIf {(owner _x) == remoteExecutedOwner});

    if (_playerIdx != -1) then {
        _caller = (_players # _playerIdx);
    };

    private _msg = (format ["%1 :: Non Staff player %2 (%3) tried to stop '%4' missions!", _fnc_scriptName, (name _caller), (getPlayerUID _caller), _missionType]);
    [_msg, "VIOLATION", true] call AW_fnc_log;
};


private _stopSide = {
    if (isNull InA_Server_sideScriptHandle) exitWith {
        ["Sidemission thread not running", "SIDE", true] call AW_fnc_log;
    };

    ["Shutting down Sidemission thread ....", "SIDE", true] call AW_fnc_log;

    InA_Server_SideMissionUp = false;
    terminate InA_Server_sideScriptHandle;

    waitUntil {
        sleep 1;
        (isNull InA_Server_sideScriptHandle)
    };

    ["Sidemission thread terminated ....", "SIDE", true] call AW_fnc_log;
};

private _stopPrio = {
    if (isNull InA_Server_prioScriptHandle) exitWith {
        ["Priomission thread not running ....", "PRIO", true] call AW_fnc_log;
    };

    ["Shutting down Priomission thread ....", "PRIO", true] call AW_fnc_log;

    InA_Server_PrioMissionUp = false;
    terminate InA_Server_prioScriptHandle;

    waitUntil {
        sleep 1;
        (isNull InA_Server_prioScriptHandle)
    };

    ["Priomission thread terminated ....", "PRIO", true] call AW_fnc_log;
};

private _stopMain = {
    if (isNull InA_Server_mainScriptHandle) exitWith {
        ["MainAO thread not running ....", "AO", true] call AW_fnc_log;
    };

    ["Shutting down MainAO thread ....", "AO", true] call AW_fnc_log;

    if (!InA_Server_MainAO_SubObjComplete && InA_Server_MainAoSubObjSpawn_Complete) then {
        InA_Server_MainAOControl_EndSubObj = true;

        waitUntil {
            sleep 1;
            InA_Server_MainAO_SubObjComplete
        };
    };

    InA_Server_MainAOShutdown = true;

    waitUntil {
        sleep 1;
        InA_Server_MainAO_Completed
    };

    waituntil {
        sleep 1;
        ((InA_Server_mainAOUnits isEqualTo []) && (InA_Server_subObjUnits isEqualTo []))
    };

    terminate InA_Server_mainScriptHandle;

    waitUntil {
        sleep 1;
        (isNull InA_Server_mainScriptHandle)
    };

    ["MainAO thread terminated ....", "AO", true] call AW_fnc_log;
};


switch (_missionType) do {
    case "SIDE": {
        call _stopSide;
    };

    case "PRIO": {
        call _stopPrio;
    };

    case "MAIN": {
        call _stopMain;
    };

    case "ALL": {
        InA_Server_missionActive = false;

        call _stopSide;
        call _stopPrio;
        call _stopMain;
    };
};
