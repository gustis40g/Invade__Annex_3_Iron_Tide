/*
* Author: alganthe
* HandleDamage event function
*
*/
params ["_unit", "_selection", "_damage", "_source", "_projectile", "_index", "_instigatorobj", "_hitPoint"];

private _damageReturned = 0;

if (alive _unit) then {
    // Setup global checks
    private _isKillerPlayer = (isPlayer _source);
    private _isKillerUAV = (_source isKindOf "UAV");
    private _isFriendlyKill = (_isKillerPlayer || _isKillerUAV);
    private _isInWater = ((getPosASLW _unit) # 2 < 0);
    private _inVehicle = (!isNull (objectParent _unit));
    private _isSwimming = (!_inVehicle && {_isInWater});

    // If the unit is inside a dead vehicle, kill it
    if (_inVehicle && {!alive (objectParent _unit)}) exitWith {
        _damageReturned = 1;

        if (_isFriendlyKill) then {
            [_unit, _source, _projectile, _instigatorobj] remoteExec ["AW_fnc_killMessage", 2];
        };

        forceRespawn _unit;
    };

    // Handles the source of the damage
    if (isNull _source) then {
        _source = (missionNamespace getVariable ["derp_revive_lastDamageSource", objNull]);
    } else {
        derp_revive_lastDamageSource = _source;
    };

    if (_index > -1) then {
        if (_damage < 0.1) then {
            _damageReturned = ((_unit getHit _selection) min derp_revive_maxSafeDamage);
        } else {
                // Check if the damage received is above the vanilla death treshold
                if (_damage >= 1 && {!(_unit getVariable ["derp_revive_downed", false])}) then {
                    _damageReturned = 0.90;

                    if (_isFriendlyKill) then {
                        [_unit, _source, _projectile, _instigatorobj] remoteExec ["AW_fnc_killMessage", 2];
                    };

                    // Check if the player is on foot and above water, if so put it into downed state
                    if (!_isSwimming) then {
                        _unit setUnconscious true;
                        [_unit, "DOWNED"] call derp_revive_fnc_switchState;
                        //cutText ["", "BLACK", 1];
                        [1000] call BIS_fnc_bloodEffect;
                        _unit allowDamage false;
                    } else {
                        if (_isFriendlyKill) then {
                            [_unit, _source, _projectile, _instigatorobj] remoteExec ["AW_fnc_killMessage", 2];
                        };

                        // If the unit is under water kill it
                        if (_isSwimming) then {
                            _damageReturned = 1;
                            forceRespawn _unit;
                        } else {
                            if (_isFriendlyKill) then {
                                [_unit, _source, _projectile, _instigatorobj] remoteExec ["AW_fnc_killMessage", 2];
                            };

                            // Check if the unit is inside a vehicle, and if that vehicle ejects dead corpses (like the quadbike), in that case kill the unit
                            private _unitVehicle = (objectParent _unit);
                            private _vehicleType = (typeOf _unitVehicle);

                            private _seat = (((fullCrew _unitVehicle) select {(_x # 0) == _unit}) # 0);

                            if (
                                (
                                    ((_seat # 1) == "driver") && {
                                        (getNumber (configFile >> "CfgVehicles" >> _vehicleType >> "ejectDeadDriver") == 1)
                                    }
                                ) || {
                                    ((_seat # 1) in ["cargo", "turret", "gunner"]) && {
                                        (getNumber (configFile >> "CfgVehicles" >> _vehicleType >> "ejectDeadCargo") == 1)
                                    }
                                }
                            ) then {
                                _damageReturned = 1;
                                forceRespawn _unit;
                            } else {
                                [_unit, "DOWNED"] call derp_revive_fnc_switchState;
                                cutText ["", "BLACK", 1];
                                _unit allowDamage false;
                                if (_isFriendlyKill) then {
                                    [_unit, _source, _projectile, _instigatorobj] remoteExec ["AW_fnc_killMessage", 2];
                                };
                            };
                        };
                    };
                } else {
                _damageReturned = (derp_revive_maxSafeDamage min _damage);
            };
        };
    };
};

_damageReturned