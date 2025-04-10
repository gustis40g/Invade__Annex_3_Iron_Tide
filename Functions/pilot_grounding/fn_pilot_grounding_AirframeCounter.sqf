/*
 * Author: Whigital
 * 
 * Description:
 * Updates the amount of crashed airframes, and sends the player back to lobby
 * if threshold reached.
 *
 */

params ["_unit"];

if (!isServer) exitWith {};

private _playerUID = (getPlayerUID _unit);
private _owner = (owner _unit);
private _name = (name _unit);

private _crashStamps = (InA_Server_PilotAirframeCounters getOrDefault [_playerUID, []]);

private _lastIdx = (_crashStamps pushback serverTime);

InA_Server_PilotAirframeCounters set [_playerUID, _crashStamps];

private _crashCount = (count _crashStamps);

if (_crashCount >= InA_Server_PilotAirframeLimitLow) then {
    InA_Server_PilotAirframeMapper set [_playerUID, _name];

    private _currStamp = (_crashStamps # _lastIdx);
    private _prevStamp = (_crashStamps # (_lastIdx - (InA_Server_PilotAirframeLimitLow - 1)));

    if ((_currStamp - _prevStamp) < InA_Server_PilotAirframeLimitPeriodShort) exitWith {
        private _groundingTimer = (InA_Server_PilotAirframeTimeout * 0.75);
        private _msg = format ["Pilot [%1] (%2) has crashed %3 airframes within %4 minutes and will be grounded for %5 minutes.", _name, _playerUID, InA_Server_PilotAirframeLimitLow, (InA_Server_PilotAirframeLimitPeriodShort / 60), (_groundingTimer / 60)];
        [_msg, "GROUNDED", true] call AW_fnc_log;

        InA_Server_PilotAirframeTimers set [_playerUID, (serverTime + _groundingTimer)];

        ["AirframesDepletedShort", false, 2, false] remoteExecCall ["BIS_fnc_endMission", _owner];
    };

    if (_crashCount >= InA_Server_PilotAirframeLimit) then {
        _prevStamp = (_crashStamps # (_lastIdx - (InA_Server_PilotAirframeLimit - 1)));

        if ((_currStamp - _prevStamp) < InA_Server_PilotAirframeLimitPeriod) then {
            private _msg = format ["Pilot [%1] (%2) has crashed %3 airframes within %4 minutes and will be grounded for %5 minutes.", _name, _playerUID, InA_Server_PilotAirframeLimit, (InA_Server_PilotAirframeLimitPeriod / 60), (InA_Server_PilotAirframeTimeout / 60)];
            [_msg, "GROUNDED", true] call AW_fnc_log;

            InA_Server_PilotAirframeTimers set [_playerUID, (serverTime + InA_Server_PilotAirframeTimeout)];

            ["AirframesDepleted", false, 2, false] remoteExecCall ["BIS_fnc_endMission", _owner];
        };
    };
};
