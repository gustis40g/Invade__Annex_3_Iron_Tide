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
            // Ctrl + D: Force unconscious
            case 32: {
                private _isPlayer = (isPlayer _unit);

                if (!_isPlayer) exitWith {
                    [objNull, "No player selected"] call BIS_fnc_showCuratorFeedbackMessage;
                    _return = true;
                };

                private _isUnconscious = _unit getVariable ["ACE_isUnconscious", false];

                if (_isUnconscious) exitWith {
                    [objNull, "Player is already unconscious"] call BIS_fnc_showCuratorFeedbackMessage;
                    _return = true;
                };

                // Force unconscious
                [_unit, true, 0, true] call ace_medical_fnc_setUnconscious;
                _return = true;
            };

            // Ctrl + R: Full heal and revive
            case 19: {
                if (!alive _unit || !isPlayer _unit) exitWith {
                    [objNull, "Target must be a living player"] call BIS_fnc_showCuratorFeedbackMessage;
                    _return = true;
                };
                
                // Full heal
                [_unit, _unit] call ace_medical_treatment_fnc_fullHealLocal;
                
                // Wake up if unconscious
                if (_unit getVariable ["ACE_isUnconscious", false]) then {
                    [_unit, false] call ace_medical_fnc_setUnconscious;
                };
                
                _return = true;
            };
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
                _unit setVelocity [0,0,0]; // Prevent sliding after flip

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

_return
