/*
 * Author: Whigital
 * Description:
 * Gets fanction classname based on index
 *
 */

params ["_idx"];

if ((typeName _idx) != (typeName 0)) exitWith {
    [format ["NaN was passed to function '%1', defaulting to faction 'BLU_F'!", _fnc_scriptName], "FACTION"] call AW_fnc_log;
    "BLU_F"
};

private _faction = "";

switch (_idx) do {
    // Vanilla NATO
    case 0: {
        _faction = "BLU_F";
    };

    // SOG PF MACV
    case 1: {
        _faction = "B_MACV";
    };

   // Western Sahara
    case 2: {
        _faction = "BLU_WS";
    };

    // Vanilla NATO
    default {
        _faction = "BLU_F";
    };
};

_faction
