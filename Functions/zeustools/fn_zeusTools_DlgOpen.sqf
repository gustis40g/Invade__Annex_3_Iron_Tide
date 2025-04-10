#include "zeustools_macros.hpp"
/*
 * Author: Whigital
 * Description:
 * Wrapper to wait for commandingMenu to close before showing dialog
 *
 */

params ["_dialog"];

if (!canSuspend) exitWith {
    0 = [] spawn _fnc_scriptName;
};

waitUntil {
    sleep 0.01;
    (commandingMenu == "")
};

createDialog (format ["%1_%2", QUOTE(MODULE), _dialog]);
