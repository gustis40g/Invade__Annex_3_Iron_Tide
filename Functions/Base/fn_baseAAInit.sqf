/*
 * Author: Whigital
 * Description:
 * Initializes Base AA functionalty
 *
 */

if (!isServer) exitWith {};

private _aaBases = ("isArray (_x >> 'aaDefences')" configClasses (missionConfigFile >> worldName >> "AOs"));

private _aaArray = [];

{
    private _baseCfg = _x;
    private _baseAAs = (getArray (_baseCfg >> "aaDefences"));

    private _baseAAvehicles = [];

    {
        private _aaVar = _x;
        private _aaVeh = missionNamespace getVariable [_aaVar, objNull];

        if (isNull _aaVeh) then {
            [(format ["Object reference '%1' not found for base '%2'", _aaVar, (configName _baseCfg)]), _fnc_scriptName] call AW_fnc_log;
            continue;
        };

        if (!surfaceIsWater (getPos _aaVeh)) then {
            [_aaVeh] call AW_fnc_vehicleApperanceApply;
        };

        _aaVeh allowDamage false;
        _aaVeh setVehicleRadar 2;
        _aaVeh setVehicleAmmo 0;
        _aaVeh setFuel 0;
        _aaVeh setVehicleLock "LOCKED";
        (crew _aaVeh) call AW_fnc_delete;

        _baseAAvehicles pushBack _aaVeh;
    } forEach _baseAAs;

    _aaArray append _baseAAvehicles;

    private _baseVar = (format ["InA_Server_BaseDefenses_%1", (configName _baseCfg)]);

    missionNamespace setVariable [(format ["%1_Active", _baseVar]), false];
    missionNamespace setVariable [(format ["%1_Cooldown", _baseVar]), false];
    missionNamespace setVariable [(format ["%1_Vehicles", _baseVar]), _baseAAvehicles];
    missionNamespace setVariable [(format ["%1_Enabled", _baseVar]), true];
} forEach _aaBases;

missionNamespace setVariable ["InA_BaseAAVehicles", _aaArray, true];
