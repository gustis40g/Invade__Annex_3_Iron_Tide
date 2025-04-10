/*
 * Author: Whigital
 *
 * Description: Updates AO reinforcement limits based on playercount
 *
 */

if (!isServer) exitWith {};

{
    private _thesholds = InA_Server_AOReinforceThresholds getOrDefault [_x, [1, 45, 1, 4]];

    _thesholds params ["_playersMin", "_playersMax", "_unitsMin", "_unitsMax"];

    private _limit = ((ceil (linearConversion [_playersMin, _playersMax, InA_Server_PlayerCount, _unitsMin, _unitsMax, true])) max 1);

    missionNamespace setVariable [(format ["InA_Server_AOReinforce%1Limit", _x]), _limit];
} forEach ["Vehicle", "Heli", "Jet"];
