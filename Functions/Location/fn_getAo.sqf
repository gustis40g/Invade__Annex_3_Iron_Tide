/*
 * Author: Whigital
 * 
 * Description:
 * Gets next near random AO based on location of current AO. If an FOB
 * is found near, that zone is returned.
 */

params ["_oldAO"];

if (!isServer) exitWith {};

private _aosConfigPath = (missionConfigFile >> worldName >> "AOs");

if (!isNil "InA_Server_manualAO" && {isClass (_aosConfigPath >> InA_Server_manualAO)}) exitWith {
    private _nextAO = InA_Server_manualAO;
    _nextAO
};

private _AORadius = InA_Server_MainAOSize;
private _minDist = (InA_Server_MainAODistanceArray # 0);
private _maxDist = (_minDist + (InA_Server_MainAODistanceArray # 1));
private _distMission = InA_Server_MissionMinDistance;

private _aoClasses = ("true" configClasses _aosConfigPath);
private _aoList = (_aoClasses apply {(configName _x)});
private _posOldAO = (getMarkerPos _oldAO);
private _isRandomAO = (_minDist == -1);

// Generate blacklist positions
private _blacklistPos = [];

{
    _blacklistPos pushBack (getMarkerPos _x);
} forEach InA_Server_BaseArray;

{
    if (getMarkerColor _x != "") then {
        _blacklistPos pushBack (getMarkerPos _x);
    };
} forEach ["InA_Side_Marker", "InA_Prio_Marker"];

if (!isNil "InA_Server_blacklistPositions") then {
    {
        _blacklistPos pushBack _x;
    } forEach InA_Server_blacklistPositions;
};


private _noncontrolledZones = (_aoList - InA_Server_controlledZones);

// AO candidate selection
if (_isRandomAO) exitWith {
   (selectRandom _noncontrolledZones)
};

// Filters all the AOs that are within the min & max ranges
private _filterNearAOs = {
    params ["_oldPos", "_newPos", "_min", "_max"];
    private _distAO = (_oldPos distance2D _newPos);
    ((_distAO < _max) && (_distAO > _min))
};

// Check if AO is an F.O.B
private _isFob = {
    params ["_ao"];
    private _path = (missionConfigFile >> worldName >> "AOs");

    (isClass (_path >> _ao >> "Base")) && {(getText (_path >> _ao >> "Base" >> "baseType")) == "FOB"}
};

private _toPickAOs = (_noncontrolledZones select {[_posOldAO, (getMarkerPos _x), _minDist, _maxDist] call _filterNearAOs});

//Get the closest FOB to the old AO
private _allFobs = _aoList select {[_x] call _isFob && !(_x in InA_Server_BaseArray)};
private _closestFob = "";
if (count _allFobs > 1) then {
    _closestFob = [_allFobs, _oldAO] call BIS_fnc_nearestPosition;
};

// If no AOs are near just pick a random one
if (count _toPickAOs == 0) exitWith {
    ["No nearby AOs found, falling back to random selection", "AO", true] call AW_fnc_log;
    (selectRandom _noncontrolledZones)
};

private _nextValueList = [];
private _nextWeightList = [];
private _selectedFOB = nil;

{
    private _ao = _x;
    private _pos = (getMarkerPos _ao);

    // Check if candidate AO is near a blacklisted pos
    if ((_blacklistPos findIf {(_x distance2D _pos) < _distMission}) != -1) then {
        continue;
    };

    private _scaledWeight = linearConversion [_minDist, _maxDist, (_posOldAO distance2D _pos), 100, 1, true];

    private _fob = ([_ao] call _isFob);

    if (_fob) then {
        _scaledWeight = (100 min (_scaledWeight + 50));
    };

    if (_fob && (_scaledWeight > 65)) then {
        _selectedFOB = _ao;
        break;
    };

    _nextValueList pushBack _ao;
    _nextWeightList pushBack _scaledWeight;
} forEach _toPickAOs;

if (!isNil "_selectedFOB") exitWith {
    _selectedFOB
};

if (_nextValueList isEqualTo []) exitWith {
    ["No nearby AOs found, falling back to random selection", "AO", true] call AW_fnc_log;
    (selectRandom _noncontrolledZones)
};

if (count _nextValueList > 1) then { //Double the weight of the next potential AO that is closest to the closest FOB
    private _closestAoToFob = [_nextValueList, _closestFob] call BIS_fnc_nearestPosition;
    private _cosestAoToFobIndex = _nextValueList find _closestAoToFob;
    _nextWeightList set [_cosestAoToFobIndex, ((_nextWeightList select _cosestAoToFobIndex) * 2)];
};

(_nextValueList selectRandomWeighted _nextWeightList)
