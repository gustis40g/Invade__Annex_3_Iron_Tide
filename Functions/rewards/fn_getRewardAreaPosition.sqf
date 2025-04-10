/*
 * Author: Whigital
 *
 * Description:
 * Selects an empty area at a reward section closest to the asset, based on markers.
 *
 */

params [
    ["_pos", (getMarkerPos "InA_Side_Marker")]
];

private _closestBases = [_pos, "ALL"] call AW_fnc_getClosestBase;

private _rewardBases = (keys InA_Server_RewardMarkerHash);

private _nearestBase = (
    {
        if (_x in _rewardBases) exitWith {_x};
    } forEach _closestBases
);

private _smMarkerList = (InA_Server_RewardMarkerHash get _nearestBase);

private _markers = [];

{
    private _mpos = (getMarkerPos _x);

    private _nearObjects = (_mpos nearEntities [["LandVehicle", "Helicopter", "Ship", "Plane"], 8]);

    if (_nearObjects isEqualTo []) then {
        _markers pushBackUnique _x;
    };
} forEach _smMarkerList;

private _marker = (selectRandom _markers);

[(getMarkerPos _marker), (markerDir _marker)]
