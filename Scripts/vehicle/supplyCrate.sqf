/*
author: stanhope
description: adds a supply crate to the nearest helicoter + addaction to drop it.

Quartermaster_5 addAction ["Add supplyCrate to heli", {execVM "scripts\vehicle\supplyCrate.sqf"}, [], 0, false, true, "",
"([_this] call AW_fnc_isPilot) || (_this getVariable ['InA_isZeus', false])", 5];

Most functionality moved to AW_fnc_dropSupplybox, actions for adding the box on Steve remain here ....

*/


_helis = nearestObjects [liftZonePad, ["Air"], 20, true];
if (count _helis < 1) exitWith {hint "No heli/plane found.  Make sure your heli/plane is close enough.";};
{
    if ((_x isKindOf 'B_Heli_Light_01_armed_F') || (_x isKindOf 'B_Heli_Light_01_dynamicLoadout_F') || (_x isKindOf 'B_Heli_Light_01_F')) then {
        _helis = _helis - [_x];
    }
} forEach _helis;

if (count _helis < 1) exitWith {hint "No heli/plane found.  (Pawnees and hummingbirds are too small)";};

_heli = _helis select 0;
if (_heli getVariable ["InA_HasSupplyboxLoaded", false]) exitWith {hint "Your heli/plane already has a supplycrate, cannot add another one.";};

private _cond = "(_this == (driver _target)) && {!(surfaceIsWater (getPos _target)) && {(((getPos _target) # 2) < 2) || (((getPos _target) # 2) > 60)}}";

_heli setVariable ["InA_HasSupplyboxLoaded", true, true];


[parseText format ["<br/><br/><t align='center' font='PuristaBold' ><t size='1.2'>Supplybox loaded</t></t>"], true, nil, 2, 0.5, 0.3] spawn BIS_fnc_textTiles;
