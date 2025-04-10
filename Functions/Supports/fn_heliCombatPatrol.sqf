/*
 * Author: Whigital
 *
 * Description: Spawns a CAS heli that seeks targets around the AO.
 *
 */

params [
    "_startPos",
    ["_loiterPos", (getMarkerPos InA_Server_currentAO)],
    ["_scaleLimit", false]
];

if (!isServer) exitWith {
    [_startPos, _loiterPos, _scaleLimit] remoteExec ["AW_fnc_heliCombatPatrol", 2];
};

if (!isNil "heliCombatPatrol_isRunning" && {heliCombatPatrol_isRunning}) then {
    waitUntil {sleep 1; !heliCombatPatrol_isRunning}
} else {
    heliCombatPatrol_isRunning = true;
};

if (_scaleLimit && {InA_Server_AOReinforceHeliCount >= InA_Server_AOReinforceHeliLimit}) exitWith {};

if (isNil "InA_AOReinforceHeliCounter") then {
    InA_AOReinforceHeliCounter = 0;
};

InA_Server_AOReinforceHeliCount = (InA_Server_AOReinforceHeliCount + 1);

private _heliType = ["#cas_helis"] call AW_fnc_getUnitsFromHash;

private _heli = (createVehicle [_heliType, _startPos, [], 50, "FLY"]);

waitUntil {
    sleep 0.1;
    !isNull _heli
};

_heli setVariable ["InA_AOReinforceType", "Heli"];

_heli call AW_fnc_vehicleCustomizationOpfor;
[_heli] call AW_fnc_enemyReinforceCounterEH;

private _heliGrp = (createVehicleCrew _heli);
_heliGrp = [_heliGrp] call AW_fnc_changeGroupSide;

InA_AOReinforceHeliCounter = (InA_AOReinforceHeliCounter + 1);
_heliGrp setGroupIdGlobal [format ["AO-Reinforce-Heli-%1", InA_AOReinforceHeliCounter]];

[(units _heliGrp)] call derp_fnc_AISkill;
[((units _heliGrp) + [_heli])] call AW_fnc_addToAllCurators;

[_heli, true, _loiterPos, (InA_Server_MainAOSize * (0.5 + (random 0.5))), (InA_Server_MainAOSize * 1.5)] spawn AW_fnc_enemyAirEngagement;

// Inflict some critical damage if fuel is empty ....
_heli addEventHandler ["Fuel", {
    params ["_vehicle", "_hasFuel"];

    if (!_hasFuel) then {
        _vehicle setHitPointDamage [(selectRandom ["HitEngine", "HitHRotor"]), 1, true];
    };
}];

// Kill off the heli if it lands and crew gets out ....
_heli addEventHandler ["GetOut", {
    params ["_vehicle", "_role", "_unit", "_turret"];

    private _grp = (group _unit);

    _vehicle setDamage 1;

    {
        if (alive _x) then {
            _x setDamage 1;
        };
    } forEach (units _grp);
}];

heliCombatPatrol_isRunning = false;
