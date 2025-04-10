#include "event_macros.hpp"
/*
 * Author: Whigital
 * Description:
 * preInit function to register events before JIP queue is handled
 *
 */

if (isNil QGVAR(Initialized)) then {
    GVAR(Initialized) = false;
};

if (GVAR(Initialized)) exitWith {
    diag_log text format ["%1 :: Duplicate init detected, exiting ....", _fnc_scriptName];
};

if (isNil QEVT_HASH) then {
    EVT_HASH = createHashMap;
};

/*
    Clients needs to register it's listeners here before the JIP queue is processed,
    otherwise any JIP triggered events will be lost ....
*/
if (hasInterface) then {
    [QEVENT(UpdateBaseArray), {
        params ["_event", "_base"];

        if (!(_base isEqualType "")) exitWith {
            diag_log text format ["%1 :: Unknown input for event %2: %3....", _fnc_scriptName, _event, _base];
        };

        if (isNil "InA_Client_BaseArray") then {
            InA_Client_BaseArray = [_base];
        } else {
            InA_Client_BaseArray append [_base];
        };
    }] call AW_fnc_eventRegister;

    [QEVENT(UpdateControlledZones), {
        params ["_event", "_zone"];

        if (!(_zone isEqualType "")) exitWith {
            diag_log text format ["%1 :: Unknown input for event %2: %3....", _fnc_scriptName, _event, _zone];
        };

        if (isNil "InA_Client_controlledZones") then {
            InA_Client_controlledZones = [_zone];
        } else {
            InA_Client_controlledZones pushBackUnique _zone;
        };
    }] call AW_fnc_eventRegister;

    [QEVENT(UpdateCurrentAO), {
        params ["_event", "_ao"];

        InA_Client_currentAO = _ao;
    }] call AW_fnc_eventRegister;

    [QEVENT(ArsenalAdded), {
        params ["_event", "_args"];

        0 = _args spawn AW_fnc_arsenalSetup;
    }] call AW_fnc_eventRegister;

    [QEVENT(SideMissionUp), {
        params ["_event", "_status"];

        InA_Client_SideMissionUp = _status;
    }] call AW_fnc_eventRegister;
};


// HC events
if (!hasInterface && !isServer) then {
    [QEVENT(HCTransferWaitUntil), {
        params ["_event", "_input"];

        _input params ["_id", "_args", "_code", "_timeout"];

        private _delayTimeout = false;
        private _timeOut = (time + _timeout);
        private _condHandle = (_args spawn _code);

        waitUntil {
            sleep 1;

            (
                (scriptDone _condHandle) ||
                (time > _timeOut)
            )
        };

        if (!scriptDone _condHandle) then {
            _delayTimeout = true;
        };

        if (!_delayTimeout) then {
            [QEVENT(HCTransferServerCallback), _id] remoteExec ["AW_fnc_eventTrigger", 2];
        };
    }] call AW_fnc_eventRegister;
};


// Server events
if (isServer) then {
    [QEVENT(HeadlessClientConnected), {
        params ["_event", "_unit"];

        InA_Server_HeadlessClients pushBackUnique _unit;
    }] call AW_fnc_eventRegister;

    [QEVENT(SideMissionSuccess), {
        InA_Server_SideMissionSuccess = true;
    }] call AW_fnc_eventRegister;

    [QEVENT(MainAO_EndSubObj), {
        if (isRemoteExecuted && {!([remoteExecutedOwner] call AW_fnc_isStaff)}) exitWith {
            private _caller = objNull;
            private _players = allPlayers;

            private _playerIdx = (_players findIf {(owner _x) == remoteExecutedOwner});

            if (_playerIdx != -1) then {
                _caller = (_players # _playerIdx);
            };

            private _msg = (format ["%1 :: Non Staff player %1 (%2) tried to end MainAO SubObj!", QEVENT(MainAO_EndSubObj), (name _caller), (getPlayerUID _caller)]);
            [_msg, "VIOLATION", true] call AW_fnc_log;
        };

        InA_Server_MainAOControl_EndSubObj = true;
    }] call AW_fnc_eventRegister;

    [QEVENT(Sidemission_End), {
        if (isRemoteExecuted && {!([remoteExecutedOwner] call AW_fnc_isStaff)}) exitWith {
            private _caller = objNull;
            private _players = allPlayers;

            private _playerIdx = (_players findIf {(owner _x) == remoteExecutedOwner});

            if (_playerIdx != -1) then {
                _caller = (_players # _playerIdx);
            };

            private _msg = (format ["%1 :: Non Staff player %1 (%2) tried to end Sidemission!", QEVENT(MainAO_EndSubObj), (name _caller), (getPlayerUID _caller)]);
            [_msg, "VIOLATION", true] call AW_fnc_log;
        };

        InA_Server_SideMissionUp = false;
    }] call AW_fnc_eventRegister;

    [QEVENT(Priomission_End), {
        if (isRemoteExecuted && {!([remoteExecutedOwner] call AW_fnc_isStaff)}) exitWith {
            private _caller = objNull;
            private _players = allPlayers;

            private _playerIdx = (_players findIf {(owner _x) == remoteExecutedOwner});

            if (_playerIdx != -1) then {
                _caller = (_players # _playerIdx);
            };

            private _msg = (format ["%1 :: Non Staff player %1 (%2) tried to end Priomission!", QEVENT(MainAO_EndSubObj), (name _caller), (getPlayerUID _caller)]);
            [_msg, "VIOLATION", true] call AW_fnc_log;
        };

        InA_Server_PrioMissionUp = false;
    }] call AW_fnc_eventRegister;

    [QEVENT(ManualAO), {
        params ["_event", "_nextAO"];

        if (isRemoteExecuted && {!([remoteExecutedOwner] call AW_fnc_isStaff)}) exitWith {
            private _caller = objNull;
            private _players = allPlayers;

            private _playerIdx = (_players findIf {(owner _x) == remoteExecutedOwner});

            if (_playerIdx != -1) then {
                _caller = (_players # _playerIdx);
            };

            private _msg = (format ["%1 :: Non Staff player %1 (%2) tried to setnext AO!", _event, (name _caller), (getPlayerUID _caller)]);
            [_msg, "VIOLATION", true] call AW_fnc_log;
        };

        InA_Server_manualAO = _nextAO;

        private _aoName = (getText ((missionConfigFile >> worldName >> "AOs") >> _nextAO >> "name"));

        [(format ["[AO] Next AO set to '%1' ....", _aoName]), false] spawn AW_fnc_adminChannelMsg;
    }] call AW_fnc_eventRegister;

    [QEVENT(addBlacklistPos), {
        params ["_event", "_pos"];

        if (isRemoteExecuted && {!([remoteExecutedOwner] call AW_fnc_isZeus)}) exitWith {
            private _caller = objNull;
            private _players = allPlayers;

            private _playerIdx = (_players findIf {(owner _x) == remoteExecutedOwner});

            if (_playerIdx != -1) then {
                _caller = (_players # _playerIdx);
            };

            private _msg = (format ["%1 :: Non Zeus player %1 (%2) tried to add a blacklist position!", _event, (name _caller), (getPlayerUID _caller)]);
            [_msg, "VIOLATION", true] call AW_fnc_log;
        };

        InA_Server_blacklistPositions pushBackUnique _pos;

        InA_Server_blacklistPositionTimers insert [[_pos, (serverTime + 3600)]];

        ["[ZEUS] Blacklist position added ....", false] spawn AW_fnc_adminChannelMsg;
    }] call AW_fnc_eventRegister;

    [QEVENT(remBlacklistPos), {
        params ["_event", "_pos"];

        if (isRemoteExecuted && {!([remoteExecutedOwner] call AW_fnc_isZeus)}) exitWith {
            private _caller = objNull;
            private _players = allPlayers;

            private _playerIdx = (_players findIf {(owner _x) == remoteExecutedOwner});

            if (_playerIdx != -1) then {
                _caller = (_players # _playerIdx);
            };

            private _msg = (format ["%1 :: Non Zeus player %1 (%2) tried to remove a blacklist position!", _event, (name _caller), (getPlayerUID _caller)]);
            [_msg, "VIOLATION", true] call AW_fnc_log;
        };

        private _blacklist = (InA_Server_blacklistPositions select {(_x distance2d _pos) < InA_Server_MissionMinDistance});

        if (_blacklist isEqualTo []) exitWith {
            if (isRemoteExecuted) then {
                ["No blacklist positions near you to remove ...."] remoteExecCall ["systemChat", remoteExecutedOwner];
            };
        };

        {
            InA_Server_blacklistPositions deleteAt (InA_Server_blacklistPositions find _x);
            InA_Server_blacklistPositionTimers deleteAt _x;

            ["[ZEUS] Blacklist position removed ...."] spawn AW_fnc_adminChannelMsg;
        } forEach _blacklist;
    }] call AW_fnc_eventRegister;

    [QEVENT(ToggleCodeExec), {
        params ["_event", "_mod"];

        if (isRemoteExecuted && {!([remoteExecutedOwner] call AW_fnc_isStaff)}) exitWith {
            private _caller = objNull;
            private _players = allPlayers;

            private _playerIdx = (_players findIf {(owner _x) == remoteExecutedOwner});

            if (_playerIdx != -1) then {
                _caller = (_players # _playerIdx);
            };

            private _msg = (format ["%1 :: Non Staff player %1 (%2) tried toggle %3 code execution!", _event, (name _caller), (getPlayerUID _caller), _mod]);
            [_msg, "VIOLATION", true] call AW_fnc_log;
        };

        switch (_mod) do {
            case "Ares": {
                private _state = (missionNamespace getVariable ["Ares_Allow_Zeus_To_Execute_Code", true]);

                missionNamespace setVariable ["Ares_Allow_Zeus_To_Execute_Code", !_state, true];

                private _status = (["Disabled", "Enabled"] select !_state);
                [(format ["[ADMIN] Ares Code Execution module %1 ....", _status])] spawn AW_fnc_adminChannelMsg;
            };

            case "ZEN": {
                private _state = (missionNamespace getVariable ["ZEN_disableCodeExecution", false]);

                missionNamespace setVariable ["ZEN_disableCodeExecution", !_state, true];

                private _status = (["Enabled", "Disabled"] select !_state);
                [(format ["[ADMIN] ZEN Code Execution module %1 ....", _status])] spawn AW_fnc_adminChannelMsg;
            };
        };
    }] call AW_fnc_eventRegister;

    [QEVENT(HCTransferServerCallback), {
        params ["_event", "_callbackId"];

        if (isNil "AW_fnc_transferGroupHC_callbackIds") exitWith {};

        if (_callbackId in AW_fnc_transferGroupHC_callbackIds) then {
            AW_fnc_transferGroupHC_callbackIds set [_callbackId, true];
        };
    }] call AW_fnc_eventRegister;
};

GVAR(Initialized) = true;
