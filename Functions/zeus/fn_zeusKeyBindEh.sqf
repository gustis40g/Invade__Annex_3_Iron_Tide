/*
 * Author: Whigital
 *
 * Description:
 * Adds Zeus interface keykind EH
 *
 */

params [["_unit", objNull]];

if (isNull _unit) exitWith {};

if ((missionNamespace getVariable ["InA_CuratorObjectRegisteredEhIdx", -1]) != -1) exitWith {};

waitUntil {sleep 1; !isNull (getAssignedCuratorLogic _unit)};

private _zeusMod = (getAssignedCuratorLogic _unit);

private _corEhIdx = _zeusMod addEventHandler ["CuratorObjectRegistered", {
    params ["_module", "_input"];

    0 spawn {
        waitUntil {sleep 0.1; !isNull (findDisplay 312)};

        (findDisplay 312) displayAddEventHandler ["KeyDown", {
            _this call AW_fnc_zeusKeyBinds;
        }];
    };
}];

missionNamespace setVariable ["InA_CuratorObjectRegisteredEhIdx", _corEhIdx];
