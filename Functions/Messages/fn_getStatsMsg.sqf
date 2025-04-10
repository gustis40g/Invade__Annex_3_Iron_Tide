/*
 *
 *
 */

private _allUnits = (allUnits - allPlayers);
private _allGroups = allGroups;

private _hcStats = format [
    "FPS: %1 / Groups: %2 (%3) / Units: %4 (%5)",
    ((round (diag_fps * 100.0)) / 100.0),
    ({local _x} count _allGroups),
    (count _allGroups),
    ({local _x} count _allUnits),
    (count _allUnits)
];

["InA_Event_StatsCallback", _hcStats] remoteExecCall ["AW_fnc_eventTrigger", 2];
