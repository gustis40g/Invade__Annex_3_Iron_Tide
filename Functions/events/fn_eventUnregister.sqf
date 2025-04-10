#include "event_macros.hpp"
/*
 * Author: Whigital
 * Description:
 * Unregister handler for an event
 *
 */

params [
    ["_event", "", [""]]
];


if (!(HASKEY(_event))) exitWith {
    diag_log text format ["%1 :: Event '%1' not registered, cannot unregister ....", _fnc_scriptName, _event];
};

REM_EVT(_event);
