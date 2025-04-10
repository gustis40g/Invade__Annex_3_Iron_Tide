/*
    File: taskPatrol.sqf
    Author: Joris-Jan van 't Land
    Revised by: Ryko, Feb 18, 2016

    Description:
    Create a random patrol of six waypoints around a given position.
    ... this one actually goes AROUND the position, not hell knows where

    Parameter(s):
    _this select 0: the group to which to assign the waypoints (Group)
    _this select 1: the position on which to base the patrol (Array)
    _this select 2: the minimum distance from central position (Number)
    _this select 3: the maximum distance between waypoints (Number)
    _this select 4: default behaviour (string)
    _this select 5: default combat mode (string)
    _this select 6: default waypoint speed (string)
    _this select 7: is allowed in water (boolean)

    Returns:
    Boolean - success flag
*/

// Validate parameter count
if ((count _this) < 3) exitWith {
    [(format ["%1 :: Function requires at least 3 parameters!", _fnc_scriptName]), "ERROR"] call AW_fnc_log;
    false
};

params [
    "_group",
    "_pos",
    ["_minDist", 25],
    ["_maxDist", 400],
    ["_behaviour", "AWARE"],
    ["_combatMode", "YELLOW"],
    ["_speed", "LIMITED"],
    ["_water", false]
];

if (isNil "_group") exitWith {
    [(format ["%1 :: Input group isNull!", _fnc_scriptName]), "ERROR"] call AW_fnc_log;
    false
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


// Create a circular waypoints.
private _waypoint = [];
private _randDist = floor (_maxDist / 10);

if (isNull (objectParent (leader _group))) then {
    /* Case groupleader is on foot */
    private _v1 = _maxDist;
    private _v2 = ceil (_maxDist * 0.41);
    private _v3 = ceil (_maxDist * 0.83);
    private _cc = selectRandom [false, true];

    if (_cc) then {
        _waypoint set [1, [(_pos select 0) - (_v1), (_pos select 1)]];
        _waypoint set [2, [(_pos select 0) - (_v2), (_pos select 1) + (_v3)]];
        _waypoint set [3, [(_pos select 0) + (_v2), (_pos select 1) + (_v3)]];
        _waypoint set [4, [(_pos select 0) + (_v1), _pos select 1]];
        _waypoint set [5, [(_pos select 0) + (_v2), (_pos select 1) - (_v3)]];
        _waypoint set [6, [(_pos select 0) - (_v2), (_pos select 1) - (_v3)]];
    } else {
        _waypoint set [6, [(_pos select 0) - (_v1), _pos select 1]];
        _waypoint set [5, [(_pos select 0) - (_v2), (_pos select 1) + (_v3)]];
        _waypoint set [4, [(_pos select 0) + (_v2), (_pos select 1) + (_v3)]];
        _waypoint set [3, [(_pos select 0) + (_v1), _pos select 1]];
        _waypoint set [2, [(_pos select 0) + (_v2), (_pos select 1) - (_v3)]];
        _waypoint set [1, [(_pos select 0) - (_v2), (_pos select 1) - (_v3)]];
    };

    for "_w" from 1 to 6 do {
        private _pos = (_waypoint select _w);
        private _inWater = (surfaceIsWater _pos);

        if (_inWater && !_water) then {continue};
        if (!_inWater && _water) then {continue};

        private _wp = _group addWaypoint [(_waypoint select _w), 25];

        _wp setWaypointType "MOVE";
        _wp setWaypointCompletionRadius 15;
    };
} else {
    /* Case groupleader is in a vehicle */
    private _newWp = [];
    private _wps = 0;
    private _wpT = [0,0];

    private _waypointPos = selectBestPlaces [_pos, _maxDist, "1+(2*meadow) - (1*forest) - (1*trees) - (1*houses) - (10*sea)", 25, 80];

    {
        _wpT = _x select 0;
        if (_wpT distance _pos > _minDist) then {
            _newWp pushBack _wpT;
        };
    } forEach _waypointPos;

    _waypoint set [0, (getPos vehicle leader _group)];
    _wp = _group addWaypoint [(_waypoint select 0), 0];
    _wp setWaypointType "MOVE";
    _wp setWaypointCompletionRadius 25;

    if (count _newWp > 5) then {
        _wps = 5;
    } else {
        _wps = count _newWp;
    };

    for "_w" from 1 to _wps do {
        private ["_dist", "_testWp"];
        private _dist = 0;

        if (count _waypoint < _w-1) then {
            break;
        };

        private _testWp = _waypoint select (_w - 1);

        if (!isNil "_testWp") then {
            {
                if ( _x distance _testWp > _dist ) then {
                    _dist = _x distance _testWp;
                    _wpT = _x;
                };
            } forEach _newWp;
        };

        if (_wpT isEqualTo [0,0]) then { continue; };
        if ((surfaceIsWater _wpT) && !_water) then {continue;};
        if (!(surfaceIsWater _wpT) && _water) then {continue;};
        _waypoint set [_w, _wpT];
        _newWp = _newWp - [_wpT];
        _wp = _group addWaypoint [_wpT, 0];
        _wp setWaypointType "MOVE";
        _wp setWaypointCompletionRadius 25;
    };
};

if (((getWPPos [_group, 0]) distance2D _pos) > _maxDist) then {
    deleteWaypoint [_group, 0];
};

if ((count waypoints _group) == 0) exitWith {
    ["Task patrol could not find any waypoints for group " + groupId _group, "DEBUG"] call AW_fnc_log;
    false
};

if ((count (waypoints _group)) > 1) then {
    private _cycleWp = _group addWaypoint [(getWPPos [_group, 0]), 0];
    _cycleWp setWaypointType "CYCLE";
};

true
