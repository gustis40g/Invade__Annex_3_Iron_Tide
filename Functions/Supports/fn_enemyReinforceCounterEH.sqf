/*
 * Author: Whigital
 *
 * Description: Adds EHs to lower (or not) the Reinforce counters based on
 * type and if requested (var onKilledDeletedLowerCounter)
 *
 */

params ["_vehicle"];

{
    _vehicle addEventHandler [_x, {
        params ["_unit"];

        private _type = _unit getVariable ["InA_AOReinforceType", nil];

        if (!isNil "_type") then {
            private _count = missionNamespace getVariable [(format ["InA_Server_AOReinforce%1Count", _type]), 0];

            if (_count > 0) then {
                missionNamespace setVariable [(format [(format ["InA_Server_AOReinforce%1Count", _type]), _type]), (_count - 1)];
            };
        };
    }];
} forEach ["Killed", "Deleted"];
