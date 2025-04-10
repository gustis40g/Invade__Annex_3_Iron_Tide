/*
author: stanhope, AW community member.

description: Respawn script for vehicles.  Lives on the server.

*/

if (!isServer) exitWith {};

waitUntil {
    sleep 1;

    (
        (!isNil "InA_Server_controlledZones") &&
        (!isNil "InA_Server_RespawnVehiclesArray")
    )
};

/*
Elements of this array in the format:
[_veh, _vehType, _spawnPos, _spawnDir, _spawnDelay, _timeDestroyed, _base, _uid]
*/

private _isAbandoned = {
    params ["_veh", "_spawnLoc"];

    private _returnVal = false;

    // Vehicle close to spawnLoc
    if ((_veh distance2D _spawnLoc) < 5) exitWith {_returnVal};

    // Vehicle crewed
    if ((count (crew _veh)) > 0) exitWith {_returnVal};

    private _nearBase = [_veh, InA_Server_VehicleRespawnDistance] call AW_fnc_isNearBase;
    private _lastCrewed = (_veh getVariable ["InA_VehicleLastTimeUsed", 0]);
    private _noPlayersClose = !([_veh, InA_Server_VehicleRespawnDistance] call AW_fnc_playersNear);
    private _isHuronContainer = ((typeOf _veh) in ["B_Slingload_01_Ammo_F", "B_Slingload_01_Repair_F", "B_Slingload_01_Fuel_F"]);
    private _isTaruPod = ((_veh isKindOf "Pod_Heli_Transport_04_base_F") || (_veh isKindOf "Pod_Heli_Transport_04_crewed_base_F"));

    if (_isHuronContainer || _isTaruPod) exitWith {
        if (_nearBase || !_noPlayersClose) then {
            _lastCrewed = serverTime;
            _veh setVariable ["InA_VehicleLastTimeUsed", _lastCrewed];
        };

        if (!_nearBase && {(serverTime - _lastCrewed) > 600}) then {
            _returnVal = true;
        };

        if (_veh getVariable ["InA_PodIsAttached", false]) then {
            _returnVal = false;
        };

        _returnVal
    };

    // Vehicle empty
    if ((count (crew _veh)) == 0) then {
        // Vehicle in the field
        if (!_nearBase) then {
            // No players close and no one used it for 10 minutes
            _returnVal = (_noPlayersClose && {(serverTime - _lastCrewed) > 600});
        } else {
            // Vehicle is an air asset
            if (_veh isKindOf "Air") then {
                // Helicopter not in use for 15 minutes
                _returnVal= ((_veh isKindOf "Helicopter") && {((serverTime - _lastCrewed) > 900)});
            } else {
                // Land vehicle close to base/fob, but not used for 5 minutes
                private _noPlayersNear = !([_veh, 10] call AW_fnc_playersNear);
                _returnVal = (_noPlayersNear && {(serverTime - _lastCrewed) > 300});
            };
        };
    };

    _returnVal
};

// Handle any attached cargo pods
private _HandleCargo = {
    params ["_veh"];

    if (!isNull (_veh getVariable ["InA_AttachedPod", objNull])) then {
        private _cargo = (_veh getVariable ["InA_AttachedPod", objNull]);

        [_veh, false] call AW_fnc_taruPodDetach;

        private _cargoItems = (InA_Server_RespawnVehiclesArray select {(_x # 0) == _cargo});

        if (_cargoItems isEqualTo []) exitWith {};

        private _cargoItem = (_cargoItems # 0);

        _cargoItem params ["_veh", "_vehType", "_spawnPos", "_spawnDir", "_spawnDelay", "_timeDestroyed", "_base", "_uid"];

        _cargo setVectorUp (surfaceNormal _spawnPos);
        _cargo setDir _spawnDir;
        _cargo setPosWorld _spawnPos;
    };
};

if (isNil "InA_Server_VehicleRespawnDistance") then {
    InA_Server_VehicleRespawnDistance = (["VehicleRespawnDistance", 500] call BIS_fnc_getParamValue);
};

private _lastRun = serverTime;
private _interval = 60;
private _execTime = 0;

InA_Server_VehicleRespawn_Enabled = true;

["Vehicle Respawn loop starting ....", "VEHICLE RESPAWN", true] call AW_fnc_log;

while {InA_Server_VehicleRespawn_Enabled} do {
    if (serverTime < (_lastRun + _interval)) then {
        sleep 1;
        continue;
    };

    _lastRun = serverTime;

    {
        _x params ["_veh", "_vehType", "_spawnPos", "_spawnDir", "_spawnDelay", "_timeDestroyed", "_base", "_uid"];

        private _respawn = false;

        if (alive _veh) then {
            private _abondoned = ([_veh, _spawnPos] call _isAbandoned);
            if (_abondoned) then {
                if (_spawnDelay > 300) then {
                    _veh setVectorUp (surfaceNormal _spawnPos);
                    _veh setDir _spawnDir;
                    _veh setPosWorld _spawnPos;

                    if (isEngineOn _veh) then {
                        [_veh, false] remoteExec ["engineOn", _veh];
                    };

                    private _hitPointDamage = (getAllHitPointsDamage _veh);

                    _veh setdamage 0;

                    if (!(_veh isKindOf "ThingX")) then {
                        {
                            if (_x > 0.6) then {
                                _veh setHitIndex [_forEachIndex, 0.6, true];
                            };
                        } forEach (_hitPointDamage # 2);

                        if ((fuel _veh) < 0.1) then {
                            [_veh, 0.1] remoteExec ["setFuel", _veh];
                        };
                    };
                } else {
                    if ((typeOf _veh) == "O_Heli_Transport_04_black_F") then {
                        _veh call _HandleCargo;
                    };

                    _veh call AW_fnc_delete;
                    _x set [5, serverTime];
                };
            };
        } else {
            _veh call AW_fnc_delete;

            if (isNil "_timeDestroyed") then {
                    _x set [5, serverTime];
            } else {
                if ((serverTime - _timeDestroyed) > _spawnDelay) then {
                    _respawn = true;
                };
            };
        };

        if (!(_base in InA_Server_controlledZones)) then {
            _respawn = false;
            InA_Server_RespawnVehiclesArray = InA_Server_RespawnVehiclesArray - [_x];
        };

        if (_respawn) then {
            //Spawn the vehicle

            private _vehClass = _vehType;

            if (!(isClass (configFile >> "CfgVehicles" >> _vehClass))) then {
                private _vehArray = [_vehClass] call AW_fnc_vehicleLookup;

                _vehClass = (_vehArray # 0);
            };

            private _newVeh = createVehicle [_vehClass, [-100,-100,100], [], 100, "NONE"];
            waitUntil {sleep 0.1; alive _newVeh};

            //Move it to the right pos
            _newVeh setDir _spawnDir;
            _newVeh setPosWorld [(_spawnPos # 0), (_spawnPos # 1), ((_spawnPos # 2) + 0.3)];

            [_newVeh] spawn {
                params ["_newVeh"];
                sleep 2;
                if (alive _newVeh) then {
                    _newVeh setDamage 0;
                };
            };

            sleep 0.1;

            //Call the init script
            [_newVeh, _vehType] call AW_fnc_vehicleCustomization;
            [_newVeh] call AW_fnc_generalVehicleSettings;

                _x set [5, nil];
                _x set [0, _newVeh];
        };

        sleep 0.1;
    } forEach InA_Server_RespawnVehiclesArray;

    _execTime = (serverTime - _lastRun);

    if (_execTime > _interval) then {
        [(format ["Vehicle Respawn loop runtime (%1) exceeded interval (%2) ....", _execTime, _interval]), "VEHICLE RESPAWN", false] call AW_fnc_log;

        _lastRun = (serverTime + _interval);
    };
};

["Vehicle Respawn loop stopped ....", "VEHICLE RESPAWN", true] call AW_fnc_log;
