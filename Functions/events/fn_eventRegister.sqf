#include "event_macros.hpp"
/*
 * Author: Whigital
 * Description:
 * Register handler for an event
 *
 */

params [
    ["_event", "", [""]],
    ["_code", {}, [{}, ""]]
];

if (!(EVT_ALLOWED(_event))) exitWith {
    diag_log text format ["%1 :: Registration of unsanctioned event '%1'!", _fnc_scriptName, _event];
};

private _eventData = GET_EVT(_event);

if (_code isEqualType "") then {
    _code = (compile _code)
};

SET_EVT(_event,_code);
