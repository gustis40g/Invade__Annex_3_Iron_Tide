params [
    ["_center", [(worldSize / 2), (worldSize / 2)]],
    ["_maxdistance", (worldSize / 2)],
    ["_nearobj", 10],
    ["_gradient", 0.25],
    ["_blacklist", []],
    ["_shore", false],
    ["_water", 0]
];

{
    _blacklist pushBack [(getMarkerPos _x), InA_Server_MissionMinDistance];
} forEach InA_Server_BaseArray;


_blacklist append InA_Server_MapSpecificBlacklistPositions;

{
    _blacklist pushBack [_x, InA_Server_MissionMinDistance];
} forEach InA_Server_blacklistPositions;

{
    if ((getMarkerColor _x) != "") then {
        _blacklist pushBack [(getMarkerPos _x), InA_Server_MissionMinDistance];
    };
} forEach [InA_Server_currentAO, "InA_Side_Marker", "InA_Prio_Marker"];


private _flatPos = [0, 0, 0];
private _defPos = [[0, 0, 0], [0, 0]];

private _accepted = false;

private _minDistance = 100;
private _shoreMode = ([0, 1] select _shore);

while {!_accepted} do {
    _flatPos = [
        _center,                // center
        _minDistance,           // minDist
        _maxDistance,           // maxDist
        _nearobj,               // objDist
        _water,                 // waterMode
        _gradient,              // maxGrad
        _shoreMode,             // shoreMode
        _blacklist,             // blacklistPos
        _defPos                 // defaultPos
    ] call BIS_fnc_findSafePos;

    _accepted = true;
    
    if (_flatPos in _defPos) then {
        _accepted = false;
    };
};

_flatPos
