/*
    fn_findSideMissionPos.sqf
    Author: stanhope
    Description: Finds a safe pos that meets all of the requirements for a side mission.

    Params:
    _type: supported values: "town", "safePos", "water", "road"
    _typeOptions: options for the above mentioned type

    Returns:
    Array: [_accepted, _position],
        _accepted: success flag: true if a valid pos was found, false otherwise
        _position: found position
*/

params ["_type", ["_typeOptions", []]];

private _blacklistedPositions = [
    (getMarkerPos InA_Server_currentAO)
];

if ((getMarkerColor "InA_Prio_Marker") != "") then {
    _blacklistedPositions pushBack (getMarkerPos "InA_Prio_Marker");
};

{
    _blacklistedPositions pushBack (getMarkerPos _x);
} forEach InA_Server_BaseArray;

{
    _blacklistedPositions pushBack _x;
} forEach InA_Server_blacklistPositions;

private _checksDone = false;
private _minRange = InA_Server_MissionMinDistance;
private _maxRange = (worldSize / 2);

private _accepted = false;
private _tries = 0;
private _pos = [0,0,0];

while {!_accepted} do {
    if (_tries > 10000) then {
        break;
    };
    _tries = _tries + 1;

    switch (_type) do {
        case "town": {
            private _locations = nearestLocations [[_maxRange, _maxRange], _typeOptions, (_maxRange * (sqrt 2))];
            private _locationsFiltered = [];

            {
                private _locPos = (locationPosition _x);

                if ((_blacklistedPositions findIf {(_x distance2D _locPos) < _minRange}) == -1) then {
                    _locationsFiltered pushBack _x;
                };
            } forEach _locations;

            _pos = locationPosition (selectRandom _locationsFiltered);

            _checksDone = true;
        };

        case "safePos": {
            _pos = _typeOptions call AW_fnc_findSafePos;
        };

        case "water": {
            private _beachPos = [(getMarkerPos "BASE"), 500, 5000, 0, 0, 1, 1] call BIS_fnc_findSafePos;
            private _waterPos = [[[_beachPos, 3000]], [[_beachPos, 1500], "ground"], {
                (abs (getTerrainHeightASL _this)) > 25
            }] call BIS_fnc_randomPos;

            _pos = (ATLToASL _waterPos);
            _pos set [2, (abs (getTerrainHeightASL _pos))];
        };

        case "road": {
            _typeOptions params ["_safePosOptions", "_maxDist"];
            _maxRange = _maxDist;
            private _tempPos = _safePosOptions call AW_fnc_findSafePos; //Get a safe pos
            private _road = [_tempPos, 100] call BIS_fnc_nearestRoad; //Find the closest road

            if (isNull _road) then {
                continue;
            };
            _pos = getPos _road;
        };
    };

    // Check that nothing went wrong
    if (isNil "_pos") then {
        _pos = [0,0,0];
        continue;
    };

    // Check that we didn't fail to find a position
    if (_pos distance2D [0,0,0] < 50) then { continue; };

    _accepted = true;

    // Below checks already done
    if (_checksDone) then {break};

    // Check that we're far enough away from everything
    {
        if ((_x distance2D _pos) > _minRange) then { continue; };
        _accepted = false;
        break;
    } forEach _blacklistedPositions;
    if (!_accepted) then {continue;};

    // Check that we're close enough to a FOB or main base
    private _closeEnoughToAFob = false;
    {
        if ((getMarkerPos _x) distance2D _pos > _maxRange) then {continue;};
        _closeEnoughToAFob = true;
        break;
    } forEach InA_Server_BaseArray;

    // To far from BASE/FOBs
    if (!_closeEnoughToAFob) then {
        _accepted = false;
        continue;
    };
};

[_accepted, _pos]
