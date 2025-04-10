params [
    "_unit",
    "_vehicle"
];

// Don't execute if the unit isn't in an actual vehicle
if (isNull (objectParent _unit)) exitWith {};

private _moveToCargo = {
    params ["_unit", "_vehicle"];

    unassignVehicle _unit;
    moveOut _unit;

    waitUntil {
        sleep 0.1;
        (isNull (objectParent _unit))
    };

    private _emptySeats = (fullCrew [_vehicle, "cargo", true]) select {isNull (_x # 0)};

    if ((count _emptySeats) != 0) then {
        0 = [_unit, _vehicle, _emptySeats] spawn {
            params ["_unit", "_vehicle", "_emptySeats"];

            private _seat = (selectRandom _emptySeats);

            private _seatIdx = (_seat # 2);
            _unit assignAsCargoIndex [_vehicle, _seatIdx];
            _unit moveInCargo [_vehicle, _seatIdx];

            systemChat "You entered a restricted seat and were moved to a cargo seat.";
        };
    } else {
        systemChat "No empty cargo seats found apart from restricted ones.";
    };
};

if (!(_vehicle isKindOf "Air") || (_vehicle isKindOf "ParachuteBase")) exitWith {};

private _isPilot = ([_unit] call AW_fnc_isPilot);
private _inPilotSeat = ((_vehicle turretUnit [-1]) == _unit);

if (_isPilot && _inPilotSeat) exitWith {};

private _inCopilotSeat = ((_vehicle turretUnit [0]) == _unit);
private _copilotPassengersAllowed = (_vehicle getVariable ["InA_AllowCoPilotPassengers", false]);
private _inGunnerSeat = ((((allTurrets _vehicle) - [[0]]) findIf {(_vehicle turretUnit _x) == _unit}) != -1);

private _isGunship = (
    (_vehicle isKindOf "Heli_Attack_01_base_F") ||
    (_vehicle isKindOf "Heli_Attack_02_base_F") ||
    (_vehicle isKindOf "VTOL_02_base_F") ||
    (_vehicle isKindOf "vn_air_ah1g_01_base") ||
    (_vehicle isKindOf "vn_air_uh1c_base")
);

private _isVTOL = (_vehicle isKindOf "VTOL_Base_F");

private _seatAllowed = (
    (!_inPilotSeat && !_inCopilotSeat) || {
        (_inCopilotSeat && _isGunship) ||
        (_inCopilotSeat && _copilotPassengersAllowed)
    }
);

// Seat allowed and no special conditions based on role
if (!_isPilot && {_seatAllowed}) exitWith {};

private _isAdmin = (_unit getVariable ["InA_isAdmin", false]);
if (_isAdmin && {!_seatAllowed}) exitWith {
    systemChat "Your staff privileges give you access to this restricted seat, don't abuse it.";
};

private _isZeus = (_unit getVariable ["InA_isZeus", false]);
if (_isZeus && {!_seatAllowed && _inCopilotSeat}) exitWith {
    systemChat "Your spartan privileges give you access to this restricted seat, don't abuse it.";
};

if (_isPilot) exitWith {
    private _closeToBase = ([_unit, 250] call AW_fnc_isNearBase);
    private _hasPilot = (!isNull (_vehicle turretUnit [-1]));

    switch (true) do {
        // Gunner in gunship, never allow
        case ((_inCopilotSeat && _isGunship) || (_inGunnerSeat && !_isGunship)): {
            unassignVehicle _unit;
            moveOut _unit;
            hintC "Pilots do the flying, not the shooting!";
        };

        // Empty aircraft but entered Copilot/Gunner seat
        case (_inCopilotSeat && {!_hasPilot}): {
            unassignVehicle _unit;
            moveOut _unit;
            systemChat "You need to be in the pilot seat to fly this aircraft.";
        };

        // Aircraft already has a pilot and is near base. Allowed outside base for evacing downed pilot
        case (!_inPilotSeat && _closeToBase): {
            unassignVehicle _unit;
            moveOut _unit;
            hintC "Pilots fly the aircrafts, not ride in them.";
        };

        // Move pilot away from Copilot seat
        case _inCopilotSeat: {
            if (!_copilotPassengersAllowed) then {
                0 = [_unit, _vehicle] spawn _moveToCargo;
            };
        };
    };
};

if (_inPilotSeat) exitWith {
    unassignVehicle _unit;
    moveOut _unit;
    hintC "You need to be a pilot to get fly this aircraft.";
};

if (_inCopilotSeat && _copilotPassengersAllowed) exitWith {};

0 = [_unit, _vehicle] spawn _moveToCargo;
