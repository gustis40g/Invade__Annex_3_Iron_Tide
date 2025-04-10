/*
 * Author: Whigital
 *
 * Description:
 * Validates if cargo pod can be attached
 *
 */

params [
    "_target",
    "_caller",
    "_origin"
];

// Not in pilot seat
if ((driver _target) != _caller) exitWith {false};

// Pod already attached
if ((!isNull (_target getVariable ["InA_AttachedPod", objNull])) || (!isNull (getSlingLoad _target))) exitWith {false};

// Still moving and too much altitude
if (((speed _target) > 2) || (((getPos _target) # 2) > 3)) exitWith {false};


// Any pods around ?
private _hookPos = [0, 0.39, -0.645];
private _hookPosWorld = (_target modelToWorld _hookPos);

private _pods =((nearestObjects [_hookPosWorld, ["Pod_Heli_Transport_04_base_F", "Pod_Heli_Transport_04_crewed_base_F"], 8]) select {alive _x});


// No pods found nearby
if (_pods isEqualTo []) exitWith {false};


// Get nearest pod and attachment position
private _pod = (_pods # 0);

private _podAttachPoint = [0, 0, 0];

switch (true) do {
    case (_pod isKindOf "Land_Pod_Heli_Transport_04_bench_F"): {_podAttachPoint =[0, 0.35, 1]};
    case (_pod isKindOf "Land_Pod_Heli_Transport_04_covered_F"): {_podAttachPoint = [0, 1.4, 1]};
    case (_pod isKindOf "Land_Pod_Heli_Transport_04_fuel_F"): {_podAttachPoint =  [0, 0.6, 1]};
    case (_pod isKindOf "Land_Pod_Heli_Transport_04_medevac_F"): {_podAttachPoint = [0, 1.4, 1]};
    case (_pod isKindOf "Land_Pod_Heli_Transport_04_repair_F"): {_podAttachPoint = [0, 1.45, 1]};
    case (_pod isKindOf "Land_Pod_Heli_Transport_04_box_F"): {_podAttachPoint = [0, 1.45, 1]};
    case (_pod isKindOf "Land_Pod_Heli_Transport_04_ammo_F"): {_podAttachPoint = [0, 1.4, 1]};
};

private _podAttachWorld = (_pod modelToWorld _podAttachPoint);


// Too far away
if ((_hookPosWorld distance _podAttachWorld) > 2) exitWith {false};

private _heliDir = (getDir _target);
private _podDir = (getDir _pod);

private _maxAngle = (_heliDir + 20);
private _minAngle = (_heliDir - 20);


// Not aligned with pod
if ((_podDir < _minAngle) || (_podDir > _maxAngle)) exitWith {false};


// Success
true
