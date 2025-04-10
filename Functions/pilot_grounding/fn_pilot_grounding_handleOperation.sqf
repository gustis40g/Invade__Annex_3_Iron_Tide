/*
 * Author: Whigital
 * 
 * Description:
 * Handles operations server side for UI events.
 *
 */

params ["_oper", "_args"];

if (!isServer) exitWith {};

if (isRemoteExecuted && {!([remoteExecutedOwner] call AW_fnc_isStaff)}) exitWith {
    private _caller = objNull;
    private _players = allPlayers;

    private _playerIdx = (_players findIf {(owner _x) == remoteExecutedOwner});

    if (_playerIdx != -1) then {
        _caller = (_players # _playerIdx);
    };

    private _msg = (format ["%1 :: Non Staff %2 (%3) tried to access Pilot grounding functions: (%4 / %5)", _fnc_scriptName, (name _caller), (getPlayerUID _caller), _oper, _args]);
    [_msg, "VIOLATION", true] call AW_fnc_log;
};

if !(_oper in ["_RESET_", "_EXTEND_", "_GROUND_", "_COLLECT_"]) exitWith {};


// Client requested UI data
if (_oper == "_COLLECT_") exitWith {
    if (!isNil "InA_PilotGrounding_Client_UI_Data") then {
        InA_PilotGrounding_Client_UI_Data = nil;
    };

    private _groundedPlayers = [];
    private _activePilots = [];

    {
        if (_y > serverTime) then {
            _groundedPlayers pushBack [(InA_Server_PilotAirframeMapper getOrDefault [_x, "n/a"]), _x, (ceil ((_y - serverTime) / 60))];
        };
    } forEach InA_Server_PilotAirframeTimers;

    private _pilots = (allPlayers select {[_x] call AW_fnc_isPilot});

    {
        _activePilots pushBack [(name _x), (getPlayerUID _x)];
    } forEach _pilots;

    InA_PilotGrounding_Client_UI_Data = [_groundedPlayers, _activePilots];

    remoteExecutedOwner publicVariableClient "InA_PilotGrounding_Client_UI_Data";

    InA_PilotGrounding_Client_UI_Data = nil;
};


// Main operator handler
_args params ["_uid"];

private _name = (InA_Server_PilotAirframeMapper getOrDefault [_uid, "n/a"]);

switch (_oper) do {
    case "_RESET_": {
        InA_Server_PilotAirframeTimers set [_uid, 0];
        InA_Server_PilotAirframeCounters set [_uid, []];

        private _msg = format ["Player [%1] (%2) grounding timer and airframe counts reset.", _name, _uid];
        [_msg, "GROUNDED", true] call AW_fnc_log;
    };

    case "_EXTEND_": {
        private _timer = InA_Server_PilotAirframeTimers getOrDefault [_uid, serverTime];
        private _remaining = (ceil (((_timer - serverTime) max 60)/ 60));

        InA_Server_PilotAirframeTimers set [_uid, (_timer + (30 * 60))];

        private _msg = format ["Player [%1] (%2) grounding timer extended from %3 -> %4 minutes.", _name, _uid, _remaining, (_remaining + 30)];
        [_msg, "GROUNDED", true] call AW_fnc_log;
    };

    case "_GROUND_": {
        private _units = (allPlayers select {getPlayerUID _x == _uid});

        if (_units isNotEqualTo []) then {
            private _unit = (_units # 0);
            _name = (name _unit);

            InA_Server_PilotAirframeTimers set [_uid, (serverTime + InA_Server_PilotAirframeTimeout)];
            InA_Server_PilotAirframeMapper set [_uid, _name];

            ["GroundedManual", false, 2, false] remoteExecCall ["BIS_fnc_endMission", _unit];

            private _msg = format ["Player [%1] (%2) grounded for %3 minutes.", _name, _uid, (InA_Server_PilotAirframeTimeout / 60)];
            [_msg, "GROUNDED", true] call AW_fnc_log;
        };
    };
};
