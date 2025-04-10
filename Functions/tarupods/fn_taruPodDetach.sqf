/*
 * Author: Whigital
 *
 * Description:
 * Detaches cargo pod
 *
 */

params [
    "_heli",
    ["_sound", true]
];

private _pod = (_heli getVariable ["InA_AttachedPod", objNull]);

if (isNull _pod) exitWith {};

private _hookPos = [0.0025, 0.39, -0.645];
private _hookPosWorld = (_heli modelToWorld _hookPos);

private _heliMass = (getmass _heli);
private _podMass = (getmass _pod);
private _rtdCustomWeight = ((weightRTD _heli) # 3);

_heli setCustomWeightRTD (_rtdCustomWeight - _podMass);
_heli setmass (_heliMass - _podMass);

detach _pod;
_pod setVelocity (velocity _heli);

if (_sound) then {
    playSound3D ["A3\Sounds_F\vehicles\air\Heli_Transport_01\gear_down_IN.wss", _heli, false, (AGLToASL _hookPosWorld), 1, 1, 25];
};

if (!ropeAttachEnabled _heli) then {
    [_heli, true] remoteExec ["enableRopeAttach", _heli];
};

_heli setVariable ["InA_AttachedPod", objNull, true];
_pod setVariable ["InA_PodIsAttached", false, true];
