/*
 * Author: Whigital
 *
 * Description:
 * Validates if cargo pod can be detached
 *
 */

params [
    "_target",
    "_caller",
    "_origin"
];

// Not in pilot seat
if ((driver _target) != _caller) exitWith {false};

// No Pod attached
if (isNull (_target getVariable ["InA_AttachedPod", objNull])) exitWith {false};

// Still moving and too much altitude
if (((speed _target) > 10) || (((getPos _target) # 2) > 2)) exitWith {false};

// Success
true
