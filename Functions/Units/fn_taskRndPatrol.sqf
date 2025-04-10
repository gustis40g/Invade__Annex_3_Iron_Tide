/*
    File: taskPatrol.sqf
    Author: Joris-Jan van 't Land
    Revised by: Whigital, 2022-04-05

    Description:
    Create a random patrol of several waypoints around a given position.

    Parameter(s):
    _this select 0: the group to which to assign the waypoints (Group)
    _this select 1: the position on which to base the patrol (Array)
    _this select 2: the maximum distance between waypoints (Number)
    _this select 3: the maximum distance between waypoints (Number)
    _this select 4: (optional) blacklist of areas (Array)
    _this select 5: default behaviour (string)
    _this select 6: default combat mode (string)
    _this select 7: default waypoint speed (string)
    _this select 8: is allowed in water (boolean)

    Returns:
    Boolean - success flag
*/

// Validate parameter count
if ((count _this) < 3) exitWith {
    [(format ["%1 :: Function requires at least 3 parameters!", _fnc_scriptName]), "ERROR"] call AW_fnc_log;
};

params [
    "_group",
    "_pos",
    ["_minDist", 50],
    ["_maxDist", 200],
    ["_blacklist", []],
    ["_behaviour", "AWARE"],
    ["_combatMode", "YELLOW"],
    ["_speed", "LIMITED"],
    ["_water", 0]
];

if (isNil "_group") exitWith {
    [(format ["%1 :: Input group isNull!", _fnc_scriptName]), "ERROR"] call AW_fnc_log;
    false
};

private _completeRadius = 15;
private _objRadius = 10;

if (!isNull (objectParent (leader _group))) then {
    _completeRadius = 25;
    _objRadius = 15;
};

// Set group behavior, combatmode and speed
if (!isNil "_behaviour") then {
    _group setBehaviour _behaviour;
    _group setCombatBehaviour _behaviour;
};

if (!isNil "_combatMode") then {
    _group setCombatMode _combatMode;
};

if (!isNil "_speed") then {
    _group setSpeedMode _speed;
};


// Create a string of randomly placed waypoints.
private _prevPos = _pos;

for "_i" from 0 to (4 + (floor (random 3))) do {
    private _newPos = [_prevPos, _minDist, _maxDist, _objRadius, _water, (60 * (pi / 180)), 0, _blacklist] call BIS_fnc_findSafePos;
    _prevPos = _newPos;

    private _wp = _group addWaypoint [_newPos, 0];
    _wp setWaypointType "MOVE";
    _wp setWaypointCompletionRadius _completeRadius;
};

//Cycle back to the first position.
_wp = _group addWaypoint [_pos, 0];
_wp setWaypointType "CYCLE";
_wp setWaypointCompletionRadius _completeRadius;

true
