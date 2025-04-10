/*
 * Author: Whigital
 * Description:
 * Gets faction(s) from index
 *
 */

params ["_idx"];

private _faction = "CSAT";

switch (_idx) do {
    // Random
    case 0: {
        private _randomization = (["FactionRandomization", -1] call BIS_fnc_getParamValue);
        private _randomFactions = (getArray (missionConfigFile >> worldName >> "randomFactions"));

        [_randomization, _randomFactions] call {
            params ["_randomization", "_randomFactions"];

            if (_randomFactions isEqualTo []) exitWith {
                [(format ["Unable to get random faction list for world config (InA_Config.hpp/%1/randomFactions), defaulting to CSAT ....", worldName]), _fnc_scriptName] call AW_fnc_log;
            };

            private _factions = [];

            {
                private _fac = _x;

                _fac = (_fac call AW_fnc_factionsValidate);

                _factions pushBackUnique _fac;
            } forEach _randomFactions;

            InA_EnemyFactionRandomizationData = createHashMapFromArray [
                ["#randomization", _randomization],
                ["#factions", _factions]
            ];
        };
    };

    // CSAT
    case 1: {};
    
    // CSAT_T
    case 2: { _faction = "CSAT_T" };
    
    // AAF
    case 3: { _faction = "AAF" };
    
    // PAVN
    case 4: { _faction = "PAVN" call AW_fnc_factionsValidate };
    
    // SFIA
    case 5: { _faction = "SFIA" call AW_fnc_factionsValidate };
    
    // AFRF
    case 6: { _faction = "AFRF" };
    
    // CDF
    case 7: { _faction = "CDF" };    
    
    // RACS
    case 8: { _faction = "RACS" };

    default {
        [(format ["Unknown EnemyFaction parameter (%1), defaulting to CSAT ....", _idx]), _fnc_scriptName] call AW_fnc_log;
    };
};

_faction
