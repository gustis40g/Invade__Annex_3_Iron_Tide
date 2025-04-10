/*
 * Author: Whigital
 *
 * Description:
 * Selects an empty area at a reward section closest to the asset, based on markers.
 *
 */

if (isNil "InA_Server_JetAwardSpawnHash") then {
    InA_Server_JetAwardSpawnHash = createHashMap;
};

private _availPos = [];

{
    private _baseMarker = _x;

    if (!isArray (missionConfigFile >> worldName >> "AOs" >> _baseMarker >> "jetspawn_markers")) then {
        continue;
    };

    if (_baseMarker in InA_Server_JetAwardSpawnHash) then {
        private _posArray = (InA_Server_JetAwardSpawnHash get _baseMarker);
        _availPos append _posArray;
        continue;
    };

    private _spawnMarkers = (getArray (missionConfigFile >> worldName >> "AOs" >> _baseMarker >> "jetspawn_markers"));

    private _posArray = [];

    {
        private _pos = (getMarkerPos [_x, true]);
        //(AGLToASL (getMarkerPos [_x, true]));
        private _dir = (markerDir _x);

        _posArray pushback [_pos, _dir];
    } forEach _spawnMarkers;

    _availPos append _posArray;

    InA_Server_JetAwardSpawnHash insert [[_baseMarker, _posArray]];
} forEach InA_Server_BaseArray;


private _freePos = (_availPos select {((_x # 0) nearEntities [["LandVehicle", "Helicopter", "Ship", "Plane"], 8]) isEqualTo []});

if (_freePos isEqualTo []) exitWith {
    ["Failed to find empty position for reward jet!", _fnc_scriptName, true] call AW_fnc_log;
    [0, 0, 0]
};

(selectRandom _freePos)
