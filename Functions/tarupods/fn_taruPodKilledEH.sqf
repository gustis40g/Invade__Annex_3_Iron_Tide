/*
 * Author: Whigital
 *
 * Description:
 * Adds EH to heli and cargo to handle destruction
 *
 */

params [
    "_vehicle"
];

if (!isServer) exitWith {};

if (!isNil {_vehicle getVariable ["InA_PodKilledEhIdx", nil]}) exitWith {};

private _ehIdx = _vehicle addMPEventHandler ["MPKilled", {
    params ["_unit", "_killer", "_instigator", "_useEffects"];

    if (!isServer) exitWith {};

    if (_unit getVariable ["InA_PodIsAttached", false]) then {
        private _parent = (attachedTo _unit);

        detach _unit;

        if (alive _parent) then {
            _parent setDamage 1;
        };
    };

    if (!isNull (_unit getVariable ["InA_AttachedPod", objNull])) then {
        private _pod = _unit getVariable ["InA_AttachedPod", objNull];

        detach _pod;

        if (alive _pod) then {
            _pod setDamage 1;
        };
    };
}];

_vehicle setVariable ["InA_PodKilledEhIdx", _ehIdx, true];
