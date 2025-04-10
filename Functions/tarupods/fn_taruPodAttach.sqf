/*
 * Author: Whigital
 *
 * Description:
 * Attaches cargo pod
 *
 */

params [
    "_heli"
];

private _hookPos = [0.0025, 0.39, -0.645];
private _hookPosWorld = (_heli modelToWorld _hookPos);

private _pods = (nearestObjects [_hookPosWorld, ["Pod_Heli_Transport_04_base_F", "Pod_Heli_Transport_04_crewed_base_F"], 5]);

if (_pods isEqualTo []) exitWith {};

private _pod = (_pods # 0);

private _heliMass = (getmass _heli);
private _podMass = (getmass _pod);
private _attachPoint = [0, 0, 0];

switch (true) do {
    case (_pod isKindOf "Land_Pod_Heli_Transport_04_bench_F"): {
        _attachPoint = [0, 0.1, -1.3];
    };

    case (_pod isKindOf "Land_Pod_Heli_Transport_04_covered_F"): {
        _attachPoint = [0, -1.05, -0.995];
    };

    case (_pod isKindOf "Land_Pod_Heli_Transport_04_fuel_F"): {
        _attachPoint = [0.05, -0.35, -1.44];
    };

    case (_pod isKindOf "Land_Pod_Heli_Transport_04_medevac_F"): {
        _attachPoint = [-0.04, -1.05, -1.087];
    };

    case (_pod isKindOf "Land_Pod_Heli_Transport_04_repair_F"): {
        _attachPoint = [0, -1.05, -1.276];
    };

    case (_pod isKindOf "Land_Pod_Heli_Transport_04_box_F"): {
        _attachPoint = [0, -1.05, -1.265];
    };

    case (_pod isKindOf "Land_Pod_Heli_Transport_04_ammo_F"): {
        _attachPoint = [0, -1.05, -1.265];
    };
};

private _rtdCustomWeight = ((weightRTD _heli) # 3);

_pod attachTo [_heli, _attachPoint];

playSound3D ["A3\Sounds_F\vehicles\air\Heli_Transport_01\gear_up_IN.wss", _heli, false, (AGLToASL _hookPosWorld), 1, 1, 25];

_heli setCustomWeightRTD (_rtdCustomWeight + _podMass);
_heli setmass (_podMass + _heliMass);

[_heli, false] remoteExec ["enableRopeAttach", _heli];

_heli setVariable ["InA_AttachedPod", _pod, true];
_pod setVariable ["InA_PodIsAttached", true, true];

[_heli] remoteExec ["AW_fnc_taruPodKilledEH", 2];
[_pod] remoteExec ["AW_fnc_taruPodKilledEH", 2];
