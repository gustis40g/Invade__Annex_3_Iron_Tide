/*
 * Author: Whigital
 *
 * Description: Check if dead player body is in a vehicle, and ejects it. Turns off the
 * engine if _corpse was the last occupant of the vehicle, and engine is on.
 *
 * Parameters:
 * 0: _corpse (OBJECT)
 *
 */

params ["_corpse"];

private _vehicle = (objectParent _corpse);

if (!isNull _vehicle && {alive _vehicle}) then {
    [_corpse, _vehicle] spawn {
        params ["_corpse", "_vehicle"];

        moveOut _corpse;

        private _timer = time;
        private _timeout = (_timer + 1);

        waitUntil {
            sleep 0.01;
            (!(_corpse in (crew _vehicle)) || (time > _timeout))
        };

        if (((crew _vehicle) isEqualTo []) && {(alive _vehicle) && {isEngineOn _vehicle}}) then {
            [_vehicle, false] remoteExec ["engineOn", _vehicle];
        };
    };
};
