/*
 * Author: Whigital
 *
 * Adds MPKilled EHs to vehicle and any attached objects for complete destruction.
 *
 */

params [["_vehicle", objNull]];

if (isNull _vehicle) exitWith {};

_vehicle addMPEventHandler ["MPKilled", {
    params ["_unit", "_killer", "_instigator", "_useEffects"];

    if (!isServer) exitWith {};

    private _children = (attachedObjects _unit);

    if (_children isNotEqualTo []) then {
        {
            if (alive _x) then {_x setDamage 1};
        } forEach _children;
    };
}];

private _children = (attachedObjects _vehicle);

if (_children isNotEqualTo []) then {
    {
        _x addMPEventHandler ["MPKilled", {
            params ["_unit", "_killer", "_instigator", "_useEffects"];

            if (!isServer) exitWith {};

            private _parent = (attachedTo _unit);

            private _aliveChildren = ({alive _x}  count (attachedObjects _parent));

            if (_aliveChildren < 1) then {
                _parent setDamage 1;
            };
        }];
    } forEach _children;
};
