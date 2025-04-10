/*
* Author: alganthe
* Handles hotkey presses in the downed state
*
* Arguments:
*
* Return Value:
* Nothing
*/

derp_revive_KeyDownEhIdx = (findDisplay 46) displayAddEventHandler ["KeyDown", {
    params ["_displayOrControl", "_key", "_shift", "_ctrl", "_alt"];

    // Allow ECS
    if (_key == 1 && {alive player}) exitWith {
        false;
    };

    // Allow Zeus
    if ((_key in (actionKeys "CuratorInterface")) && {(getAssignedCuratorLogic player) in allCurators}) exitWith {
        false;
    };

    // Allow map
    if (_key in (actionKeys "ShowMap")) exitWith {
        false;
    };

    // Allow chat
    if (_key in ((actionKeys "chat") + (actionKeys "prevChannel") + (actionKeys "nextChannel") + (actionKeys "pushToTalk"))) exitWith {
        false;
    };

    // Allow 3rd person
    if (_key in (actionKeys "personView")) exitWith {
        false;
    };

    true
}];
