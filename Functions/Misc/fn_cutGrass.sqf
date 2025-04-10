/*
 * Author: Whigital
 * Description:
 * Spawns a gras cutter object in front of a unit to remove obstructing grass
 *
 */

params ["_unit"];

if (!isServer) exitWith {
    [_unit] remoteExec ["AW_fnc_cutGrass", 2];
};

private _caller = remoteExecutedOwner;

private _dir = (getDir _unit);

private _cutterPos = (_unit getPos [2.5, _dir]);

private _cutter = createVehicle ["Land_ClutterCutter_medium_F", [0,0,0], [], 0, "CAN_COLLIDE"];

_cutter setDir _dir;
_cutter setPos _cutterPos;

0 = [_cutter] spawn {
    params ["_cutter"];

    waitUntil {
        sleep 60;

        (count ((_cutter nearEntities ["Man", 25]) select {isPlayer _x}) < 1)
    };

    deleteVehicle _cutter;
};
