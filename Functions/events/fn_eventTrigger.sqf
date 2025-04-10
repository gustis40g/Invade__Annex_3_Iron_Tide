#include "event_macros.hpp"
/*
 * Author: Whigital
 * Description:
 * Trigger a specific event
 *
 */

params [
    ["_event", "", [""]],
    ["_args", []]
];

if (!(EVT_ALLOWED(_event))) exitWith {
    diag_log text format ["%1 :: Unsanctioned event '%2' received!", _fnc_scriptName, _event];
};

if (!(HASKEY(_event))) exitWith {};

private _code = GET_EVT(_event);

[_event, _args] call _code;
