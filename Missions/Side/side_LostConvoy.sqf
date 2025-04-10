/*
Author: stanhope, AW-community member
bassed off of existing AW created side missions
Description: A bunch of blufor vehicles on a road somewhere that players must drive back to the nearest FOB
*/
private _toRescueVehiclesArr = [];
private _minesArr = [];

//-------------------- FIND SAFE POSITION FOR heliwreck
private _findSmPosResult = ["road",[[nil, nil, 10, 0.2], InA_Server_MissionMinDistance * 2.5]] call AW_fnc_findSideMissionPos;
if (!(_findSmPosResult select 0)) exitWith {};
private _flatPos = _findSmPosResult select 1;
private _flatPosRoad = roadAt _flatPos;

//Convoy Creation -----------------------
private _getRoadDir = {
    params ["_road"];
    private _roadConnectedTo = roadsConnectedTo _road;
    private _connectedRoad = _roadConnectedTo select 0;
    private _direction = [_road, _connectedRoad] call BIS_fnc_DirTo;
    _direction
};

private _setupConvoyVehicle = {
    params ["_veh", "_dir", "_damage"];
    _veh setDir _dir;
    _veh setFuel (0.4 + random 0.2);
    _veh setDamage _damage;
    _veh forceFlagTexture "\A3\Data_F\Flags\Flag_nato_CO.paa";
};
private _convoyDir = [_flatPosRoad] call _getRoadDir;

sideObj = (selectRandom AW_OPFOR_side_convoyProtectionVehicles) createVehicle _flatPos;
_toRescueVehiclesArr pushBack sideObj;
[sideObj, _convoyDir, (0.6 + random 0.2)] call _setupConvoyVehicle;

private _findNextVehiclePos = {
    params ["_previousPos", "_convoyDir"];
    private _returnPos = _previousPos getPos [15, (_convoyDir + 180)];
    private _currentRoad = roadAt _previousPos;
    if (!isNull _currentRoad) then {
        private _roads = roadsConnectedTo _currentRoad;
        if (count _roads > 1) then {
            private _viableRoads = _roads select {
                private _dir = (getPos _x) getDir (_previousPos);
                private _idealDir = _convoyDir;
                while {_idealDir > 360} do {_idealDir = _idealDir - 360};
                (_idealDir - 45 < _dir && _idealDir + 45 > _dir)
            };
            if (count _viableRoads > 0) then{
                private _temp = getPos (_viableRoads select 0);
                if ((_temp distance _previousPos) > 15) then {
                    _returnPos = _temp;
                };
            };
        };
    };

    _returnPos
};

private _previousVehicle = sideObj;
private _amountOfConvoyVehiclesToCreate = 2 + random 2;

for "_i" from 1 to _amountOfConvoyVehiclesToCreate do {
    private _createVehPos = [getPos _previousVehicle, getDir _previousVehicle] call _findNextVehiclePos;
    private _convoyVeh = (selectRandom AW_OPFOR_side_convoyTransportVehicles) createVehicle _createVehPos;
    _toRescueVehiclesArr pushBack _convoyVeh;
    [_convoyVeh, _convoyDir, (0.4 + random 0.2)] call _setupConvoyVehicle;
    _previousVehicle = _convoyVeh;
};

[_toRescueVehiclesArr] call AW_fnc_addToAllCurators;

InA_Server_Side_convoyVehiclesFound = false;
{
    private _markerEh = _x addEventHandler ["getIn", {
        params ["_vehicle"];
        InA_Server_Side_convoyVehiclesFound = true;
    }];
    _x setVariable ["SIDE_ConvoyFoundEh", _markerEh];
} forEach _toRescueVehiclesArr;

// Create mines around convoy
{
    private _mineCount = 2 + random 2;
    for "_i" from 0 to _mineCount do {
        _minePos = (getPos _x) getPos [random [3, 6, 10], (getDir _x) + ((selectRandom [45, -135]) + random 90)];
        private _mineType = selectRandom AW_OPFOR_side_convoyMines;
        _mine = createMine [_mineType, _minePos, [],0];
        _minesArr pushBack _mine;
        InA_EnemyFactionSide revealMine _mine;
        civilian revealMine _mine;
    };
} forEach _toRescueVehiclesArr;

// Spawn enemy forces--------------------------------------
private _vehAmount = [
    nil,                        // MBTs
    (selectRandom [0, 1]),     // SPAAs
    (selectRandom [0, 1]),     // IFVs
    (selectRandom [2, 3, 4])   // MRAPs
];

private _infAmount = [
    (selectRandom [2, 3]),  // Squads
    (selectRandom [0, 1]),  // SF Squads
    1,                      // AA Teams
    1,                      // AT Teams
    (selectRandom [1, 2]),  // Snipers
    nil,                    // Teams
    (selectRandom [0, 1])   // SF Teams
];

private _enemiesArray = [
    _flatPos,
    "SIDE",
    "#circ",
    _vehAmount,
    _infAmount,
    100,
    150
] call AW_fnc_spawnEnemyUnits;

// Briefing ------------------------------------------------
private _fuzzyPos = [_flatPos, 300] call AW_fnc_getFuzzyPos;

InA_Server_SideMarkers = ["SIDE", "Lost convoy", _fuzzyPos, 300] call AW_fnc_missionMarkersCreate;
private _sideMarker = (InA_Server_SideMarkers # 0);

[
    west,
    "LostConvoyTask",
    [
        "We lost contact with a convoy in this area.  Locate the convoy and bring it back to any of our bases.  <br/>All surviving convoy vehicles (and at least 1 vehicle) must make it back to any of our bases for this mission to be considered a success.",
        "Side Mission: Lost convoy",
        _sideMarker
    ],
    _fuzzyPos,
    "Created",
    -1,
    true,
    "search",
    true
] call BIS_fnc_taskCreate;

//mission core
InA_Server_SideMissionUp = true;
InA_Server_SideMissionSuccess = false;
InA_Server_SideMissionSpawned = true;

private _aliveCount = count _toRescueVehiclesArr;
private _nearBaseCount = 0;

private _markers = [];
private _createMarker = {
    params ["_name", "_pos"];
    _marker = createMarkerLocal [_name, _pos];
    _marker setMarkerShapeLocal "ICON";
    _marker setMarkerTypeLocal "B_motor_inf";
    _marker setMarkerSizeLocal [0.5,0.5];
    _marker setMarkerColorLocal "colorBLUFOR";
    _marker setMarkerAlphaLocal 0.25;
    _marker
};
private _markersHaveBeenSetUp = false;

while {InA_Server_SideMissionUp} do {
    if (InA_Server_Side_convoyVehiclesFound && !_markersHaveBeenSetUp) then {
        _markersHaveBeenSetUp = true;
        {
            private _ehIndex = _x getVariable ["SIDE_ConvoyFoundEh", -1];
            if (_ehIndex != -1) then {
                _x removeEventHandler ["getIn", _ehIndex];
            };
            if (alive _x) then {
                private _mrk = [str _x + "_marker", getPos _x] call _createMarker;
                _markers pushBack _mrk;
                _x setVariable ["SIDE_vehicleMarker", _mrk];
            };
        } forEach _toRescueVehiclesArr;
    };

    _aliveCount = 0;
    _nearBaseCount = 0;

    {
        private _veh = _x;
        if (alive _veh) then {
            _aliveCount = _aliveCount + 1;
            if ([_veh, 250] call AW_fnc_isNearBase) then {
                _nearBaseCount = _nearBaseCount + 1;
                _veh lock true;
                { moveOut _x; } forEach crew _veh;
            };

            private _mrk = _veh getVariable ["SIDE_vehicleMarker", ""];
            if (_mrk != "") then {
                _mrk setMarkerPos (position _veh);
            };
        };
    } forEach _toRescueVehiclesArr;

    if (count _markers > _aliveCount) then {
        { deleteMarker _x; } forEach _markers;
        _markers = [];

        {
            if (alive _x) then {
                private _mrk = [str _x + "_marker", getPos _x] call _createMarker;
                _markers pushBack _mrk;
                _x setVariable ["SIDE_vehicleMarker", _mrk];
            };
        } forEach _toRescueVehiclesArr;
    };

    if (_aliveCount == 0 || _nearBaseCount == _aliveCount) exitWith {
		InA_Server_SideMissionUp = false;
	};

	sleep 5;
};

{ deleteMarker _x; } forEach _markers;
[_toRescueVehiclesArr] call AW_fnc_delete;

if (_aliveCount > 0 && _nearBaseCount == _aliveCount) then {
    0 = ["LostConvoyTask"] spawn AW_fnc_finishTask;
    private _rewardPos = getPos ((_toRescueVehiclesArr select {alive _x}) select 0);
    [nil, _rewardPos] call AW_fnc_SMhintSUCCESS;
};

if (_aliveCount > 0 && _nearBaseCount != _aliveCount) then {
    0 = ["LostConvoyTask", "Canceled"] spawn AW_fnc_finishTask;
};

if (_aliveCount == 0) then {
    0 = ["LostConvoyTask", "Failed"] spawn AW_fnc_finishTask;
};

sleep 5;

[InA_Server_SideMarkers] call AW_fnc_missionMarkersRemove;

//-------------------- DELETE
sleep 120;
[_enemiesArray] spawn AW_fnc_delete;
[_minesArr] spawn AW_fnc_delete;
