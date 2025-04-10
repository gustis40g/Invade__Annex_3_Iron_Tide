#include "repair_macros.hpp"
/*
 * Author: Whigital
 *
 * Description: Adds Service action to a vehicle
 *
 */

params ["_vehicle"];

if (!hasInterface) exitWith {};

// No static objects
if !(_vehicle isKindOf "AllVehicles") exitWith {};

// No boats for now
if (_vehicle isKindOf "Ship") exitWith {};

if (isNil QGVAR(ActionConditionCode)) then {
    GVAR(ActionConditionCode) = {
        params ["_vehicle", "_caller"];

        if (_vehicle getVariable [QGVAR(VehicleIsServicing), false]) exitWith {false};

        if (!isNull (objectParent _caller)) exitWith {false};

        if (isEngineOn _vehicle) exitWith {false};
        if (((speed _vehicle) * 3.6) > 1) exitWith {false};

        private _closestPad = nearestObject [_vehicle, "Land_HelipadEmpty_F"];
        if (isNull _closestPad) exitWith {false};

        if (!(_closestPad getVariable [QGVAR(isServicePoint), false])) exitWith {false};

        if (_closestPad getVariable [QGVAR(InUse), false]) exitWith {false};

        private _servicePointType = (_closestPad getVariable [QGVAR(Type), "Land"]);
        if (!(_vehicle isKindOf _servicePointType)) exitWith {false};

        private _radius = (_closestPad getVariable [QGVAR(Radius), GVAR(Ground_Distance)]);
        if ((_vehicle distance2D _closestPad) > _radius) exitWith {false};

        (((needService _vehicle) findIf {_x > 0.025}) != -1)
    };
};

private _actionRadius = (5 max (round ((sizeOf (typeOf _vehicle)) / 4)));

private _actionId = _vehicle addAction [
    "<t color='#1c891e' size='1.4' font='PuristaBold'><img size='1.2' image='\a3\ui_f\data\IGUI\Cfg\Actions\repair_ca.paa' /> Service</t>",
    {
        params ["_target", "_caller", "_actionId", "_arguments"];

        [_target] remoteExec ["AW_fnc_repairServiceVehicle", 2];
    },
    nil,
    100,
    true,
    true,
    "",
    format ["[_target, _this] call %1", GVAR(ActionConditionCode)],
    _actionRadius
];

if (_vehicle isKindOf "UAV") then {
    if (isNil QGVAR(ActionUAVConditionCode)) then {
        GVAR(ActionUAVConditionCode) = {
            params ["_target", "_caller", "_originalTarget"];

            private _uav = (objectParent _originalTarget);
            if (isNull _uav) exitWith {false};

            if (((speed _uav) * 3.6) > 1) exitWith {false};

            if (_uav getVariable [QGVAR(VehicleIsServicing), false]) exitWith {false};

            private _closestPad = nearestObject [_uav, "Land_HelipadEmpty_F"];
            if (isNull _closestPad) exitWith {false};

            if (!(_closestPad getVariable [QGVAR(isServicePoint), false])) exitWith {false};

            if (_closestPad getVariable [QGVAR(InUse), false]) exitWith {false};

            private _servicePointType = (_closestPad getVariable [QGVAR(Type), "Land"]);
            if (!(_uav isKindOf _servicePointType)) exitWith {false};

            private _radius = (_closestPad getVariable [QGVAR(Radius), GVAR(Air_Distance)]);
            if ((_uav distance2D _closestPad) > _radius) exitWith {false};

            (((needService _uav) findIf {_x > 0.025}) != -1)
        };
    };

    private _actionId = (driver _vehicle) addAction [
        "<t color='#c20202' size='1.2' font='PuristaBold'><img size='1.4' image='\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\call_ca.paa' /> Request UAV Service</t>",
        {
            params ["_target", "_caller", "_actionId"];

            private _uav = (objectParent _caller);

            [_uav] remoteExec ["AW_fnc_repairServiceVehicle", 2];
        },
        nil,
        100,
        true,
        true,
        "",
        format ["[_target, _this, _originalTarget] call %1", GVAR(ActionUAVConditionCode)],
        5
    ];
};
