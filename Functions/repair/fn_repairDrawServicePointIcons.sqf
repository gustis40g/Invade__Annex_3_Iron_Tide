#include "repair_macros.hpp"
/*
 * Author: Whigital
 *
 * Description: Add Draw3D mission EHs to draw service pads and service progress
 *
 */

if (!hasInterface) exitWith {};

waitUntil {
    sleep 1;
    (!isNil QGVAR(AirPads) && !isNil QGVAR(GroundPads))
};

if (isNil QGVAR(DrawIcons) || {!GVAR(DrawIcons)}) exitWith {};

// Draw pads
GVAR(DrawIconEh) = addMissionEventHandler ["Draw3D", {
    if (!alive player) exitWith {};

    if (!GVAR(DrawIcons)) exitWith {
        removeMissionEventHandler ["Draw3D", GVAR(DrawIconEh)];
        GVAR(DrawIconEh) = nil;
    };

    private _vehicle = (objectParent player);

    private _isDriver = false;

    if (!isNull _vehicle) then {
        _isDriver = ((driver _vehicle) == player);
    };

    if ((isNull _vehicle) && (!isNull (getConnectedUAV player))) then {
        _vehicle = (getConnectedUAV player);
        _isDriver = ((UAVControl _vehicle) isEqualTo [player, "DRIVER"]);
    };

    if (isNull _vehicle) exitWith {};

    if (!_isDriver) exitWith {};

    {
        private _dist = (_x distance2D _vehicle);
        if (_dist > 50) then {continue};

        private _radius = (_x getVariable [QGVAR(Radius), 5]);
        if (_dist < _radius) then {continue};

        private _type = _x getVariable [QGVAR(Type), "Land"];
        if (!(_vehicle isKindOf _type)) then {continue};

        private _alpha = linearConversion [15, 50, _dist, 1, 0, true];

        private _serviceData = [];

        switch (_type) do {
            case "Land": {
                _serviceData = [
                    [(41 / 255), (128 / 255), (185 / 255), _alpha],
                    "\A3\ui_f\data\map\markers\nato\c_car.paa",
                    "Ground Service"
                ];
            };

            case "Air": {
                _serviceData = [
                    [(41 / 255), (128 / 255), (185 / 255), _alpha],
                    "\A3\ui_f\data\map\markers\nato\c_plane.paa",
                    "Air Service"
                ];
            };

            default {
                _serviceData = [
                    [(41 / 255), (128 / 255), (185 / 255), _alpha],
                    "\A3\ui_f\data\map\mapcontrol\Fuelstation_CA.paa",
                    "Service"
                ];
            };
        };

        private _pos = _x modelToWorld [0, 0, GVAR(IconHeight)];

        _serviceData params ["_color", "_icon", "_text"];

        drawIcon3D [
            _icon,
            [_color, _color],
            _pos,
            1.5,
            1.5,
            0,
            _text,
            true,
            0.065,
            "PuristaBold"
        ];
    } forEach (GVAR(AirPads) + GVAR(GroundPads));
}];

// Draw service
GVAR(DrawServiceIconEh) = addMissionEventHandler ["Draw3D", {
    if (!alive player) exitWith {};

    if (!GVAR(DrawIcons)) exitWith {
        removeMissionEventHandler ["Draw3D", GVAR(DrawServiceIconEh)];
        GVAR(DrawServiceIconEh) = nil;
    };

    {
        if (!(_x getVariable [QGVAR(InUse), false])) then {continue};

        private _dist = (_x distance2D player);
        if (_dist > 25) then {continue};

        private _alpha = linearConversion [15, 25, _dist, 1, 0, true];
        private _colorMain = [(211 / 255), (84 / 255), 0, _alpha];
        private _colorSub = [(28 / 255), (137 /255), (30 / 255), _alpha];

        private _timeLeft = ((ceil ((_x getVariable [QGVAR(CompleteTime), 0]) - serverTime)) max 0);
        private _timeLeftPretty = [_timeLeft, "MM:SS"] call BIS_fnc_secondsToString;

        private _mainText = format ["Servicing, ETA: %1", _timeLeftPretty];

        private _serviceText = format [
            "Repairing: %1%4 / Rearming: %2%4 / Refueling: %3%4",
            (_x getVariable [QGVAR(RepairPct), 0]),
            (_x getVariable [QGVAR(RearmPct), 0]),
            (_x getVariable [QGVAR(RefuelPct), 0]),
            "%"
        ];

        private _posMain = _x modelToWorld [0, 0, GVAR(IconHeightService)];
        private _posRepair = _x modelToWorld [0, 0, (GVAR(IconHeightService) - 0.25)];
        private _posRearm = _x modelToWorld [0, 0, (GVAR(IconHeightService) - 0.45)];
        private _posRefuel = _x modelToWorld [0, 0, (GVAR(IconHeightService) - 0.65)];

        private _posSub = _x modelToWorld [0, 0, (GVAR(IconHeightService) - 0.4)];

        drawIcon3D ["", [_colorMain, _colorMain], _posMain, 1.5, 1.5, 0, _mainText, true, 0.065, "PuristaBold"];
        drawIcon3D ["", [_colorSub, _colorSub], _posSub, 1.5, 1.5, 0, _serviceText, true, 0.03, "PuristaBold"];
    } forEach (GVAR(AirPads) + GVAR(GroundPads));
}];
