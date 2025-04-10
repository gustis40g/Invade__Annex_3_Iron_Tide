#include "zeustools_macros.hpp"
/*
 * Author: Whigital
 * Description:
 * onUnload function for NextAO dialog
 *
 */

params ["_display", ["_config", configNull]];

removeMissionEventHandler ["MapSingleClick", (missionNamespace getVariable [QGVAR(mapClickEhIdx), -1])];

deleteMarkerLocal QGVAR(SelectMarker);

GVAR(AOData) = nil;

missionNamespace setVariable [QGVAR(mapClickEhIdx), nil];
