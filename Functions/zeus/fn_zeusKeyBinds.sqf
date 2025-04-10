/*
 * Author: Whigital
 *
 * Hook for keyDown displayEventHandler on Zeus interface
 *
 */

params ["_display", "_key", "_shift", "_ctrl", "_alt"];

private _selectedObjects = (curatorSelected # 0);

if ((count _selectedObjects) != 1) exitWith {
    false
};

private _unit = (_selectedObjects # 0);
private _return = false;

if (alive _unit) then {
    if (_ctrl) then {
        switch (_key) do {
            // Ctrl + D: Force unit down ....
            case 32: {
                private _isPlayer = (isPlayer _unit);

                if (!_isPlayer) exitWith {
                    [objNull, "No player selected"] call BIS_fnc_showCuratorFeedbackMessage;
                    _return = true;
                };

                private _isDown = alive _unit && {_unit getvariable ["derp_revive_downed", false] || lifeState _unit == "INCAPACITATED"};

                if (_isDown) exitWith {
                    [objNull, "Player already in revive state"] call BIS_fnc_showCuratorFeedbackMessage;
                    _return = true;
                };

                [_unit, "DOWNED"] remoteExecCall ["derp_revive_fnc_switchState", _unit];
                _return = true;
            };

            // Ctrl + R: Revive downed unit ....
            case 19: {
                private _isPlayer = (isPlayer _unit);

                if (!_isPlayer) exitWith {
                    [objNull, "No player selected"] call BIS_fnc_showCuratorFeedbackMessage;
                    _return = true;
                };

                private _isDown = alive _unit && {_unit getvariable ["derp_revive_downed", false] || lifeState _unit == "INCAPACITATED"};

                if (!_isDown) exitWith {
                    [objNull, "Player not in revive state"] call BIS_fnc_showCuratorFeedbackMessage;
                    _return = true;
                };

                [_unit, "REVIVED"] remoteExecCall ["derp_revive_fnc_switchState", _unit];
                _return = true;
            };
        };
    };

    if (_shift) then {
        switch (_key) do {
            // Shift + C: Customize vehicle ....
            case 46: {
                private _isVehicle = ((_unit isKindOf "AllVehicles") && {!(_unit isKindOf "Man")});

                if (!_isVehicle) exitWith {
                    [objNull, "No vehicle selected"] call BIS_fnc_showCuratorFeedbackMessage;
                    _return = true;
                };

                [_unit] remoteExec ["AW_fnc_generalVehicleSettings", 2];

                _return = true;
            };

            // Shift + F: Flip vehicle ....
            case 33: {
                private _isVehicle = (_unit isKindOf "LandVehicle");

                if (!_isVehicle) exitWith {
                    [objNull, "No vehicle selected"] call BIS_fnc_showCuratorFeedbackMessage;
                    _return = true;
                };

                private _pos = (getPosATL _unit);

                _unit setVectorUp (surfaceNormal _pos);
                _pos set [2, 0.25];
                _unit setPosATL _pos;

                _return = true;
            };

            // Shift + R: Repair/Rearm/Refuel
            case 19: {
                private _isMan = (_unit isKindOf "Man");
                private _isHouse = (_unit isKindOf "Building");

                if (_isMan || _isHouse) exitWith {
                    [objNull, "Wrong type selected"] call BIS_fnc_showCuratorFeedbackMessage;
                    _return = true;
                };

                [_unit] remoteExec ["AW_fnc_vehicleReplenish", 2];

                _return = true;
            };
        };
    };
};

_return
