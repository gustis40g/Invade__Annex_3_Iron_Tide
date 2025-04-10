/*
 * Author: Whigital
 * Description:
 * Handles starting of Main/Side/Prio missions
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

    private _msg = (format ["%1 :: Non Staff player %2 (%3) tried to start '%4' missions!", _fnc_scriptName, (name _caller), (getPlayerUID _caller), _missionType]);
    [_msg, "VIOLATION", true] call AW_fnc_log;
};


private _startSide = {
    if (!isNull InA_Server_sideScriptHandle) exitWith {
        ["Sidemission thread already running", "SIDE", true] call AW_fnc_log;
    };

    if (!InA_Server_missionActive) then {
        InA_Server_missionActive = true;
    };

    ["Starting Sidemission thread ....", "SIDE", true] call AW_fnc_log;

    InA_Server_sideScriptHandle = execVM "Missions\Side\MissionControl.sqf";

    waitUntil {
        sleep 1;
        (!isNull InA_Server_sideScriptHandle)
    };

    ["Sidemission thread started ....", "SIDE", true] call AW_fnc_log;
};

private _startPrio = {
    if (!isNull InA_Server_prioScriptHandle) exitWith {
        ["Priomission thread already running ....", "PRIO", true] call AW_fnc_log;
    };

    if (!InA_Server_missionActive) then {
        InA_Server_missionActive = true;
    };

    ["Starting Priomission thread ....", "PRIO", true] call AW_fnc_log;

    InA_Server_prioScriptHandle = execVM "Missions\Priority\MissionControl.sqf";

    waitUntil {
        sleep 1;
        (!isNull InA_Server_prioScriptHandle)
    };

    ["Priomission thread started ....", "PRIO", true] call AW_fnc_log;
};

private _startMain = {
    if (!isNull InA_Server_mainScriptHandle) exitWith {
        ["MainAO thread already running ....", "AO", true] call AW_fnc_log;
    };

    if (!InA_Server_missionActive) then {
        InA_Server_missionActive = true;
    };

    ["Starting MainAO thread ....", "AO", true] call AW_fnc_log;

    InA_Server_MainAOShutdown = false;

    private _currentAOIndex = ((count InA_Server_controlledZones) - 1);

    if (InA_Server_controlledZones isEqualTo InA_Server_StaticBases) then {
        _currentAOIndex = 0;
    };

    InA_Server_currentAO = (InA_Server_controlledZones # _currentAOIndex);

    InA_Server_mainScriptHandle = execVM "Missions\Main\Main_Machine.sqf";

    waitUntil {
        sleep 1;
        (!isNull InA_Server_mainScriptHandle)
    };

    ["MainAO thread started ....", "AO", true] call AW_fnc_log;
};


switch (_missionType) do {
    case "SIDE": {
        call _startSide;
    };

    case "PRIO": {
        call _startPrio;
    };

    case "MAIN": {
        call _startMain;
    };

    case "ALL": {
        InA_Server_missionActive = true;

        call _startMain;
        call _startSide;
        call _startPrio;
    };
};
