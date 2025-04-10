#include "repair_macros.hpp"
/*
 * Author: Whigital
 *
 * Description: Services a vehicle
 *
 */

params ["_vehicle"];

if (!isServer) exitWith {};

private _pad = nearestObject [_vehicle, "Land_HelipadEmpty_F"];
if (isNull _pad) exitWith {};

if (!(_pad getVariable [QGVAR(isServicePoint), false])) exitWith {};

if (_vehicle getVariable [QGVAR(VehicleIsServicing), false]) exitWith {};

_vehicle setVariable [QGVAR(VehicleIsServicing), true, true];

private _radius = (_pad getVariable [QGVAR(Radius), 5]);

private _vehicleMags = {
    params ["_vehicle", "_timer"];

    private _mags = (magazinesAllTurrets _vehicle);
    private _classes = [];
    private _maginfo = [];

    {
        _x params ["_mag", "_turret", "_ammoCount"];

        private _ammoClass = (getText (configFile >> "CfgMagazines" >> _mag >> "ammo"));
        private _magSize = (getNumber (configFile >> "CfgMagazines" >> _mag >> "count"));
        private _ammoSimType = (getText (configFile >> "CfgAmmo" >> _ammoClass >> "simulation"));
        private _reloadTime = ((1 - (_ammoCount / _magSize)) * _timer);

        _maginfo pushBack [_turret, _mag, _ammoClass, _magSize, _ammoCount, _ammoSimType, _reloadTime];
        _classes pushBackUnique _mag;
    } forEach _mags;

    [_maginfo, _classes]
};

private _vehiclePylons = {
    params ["_vehicle", "_timer"];

    private _mags = (getAllPylonsInfo _vehicle);

    private _classes = [];
    private _maginfo = [];

    {
        _x params ["_pylonIdx", "_pylonName", "_turret", "_mag", "_ammo", "_id"];

        private _ammoClass = (getText (configFile >> "CfgMagazines" >> _mag >> "ammo"));
        private _magSize = (getNumber (configFile >> "CfgMagazines" >> _mag >> "count"));
        private _ammoSimType = (getText (configFile >> "CfgAmmo" >> _ammoClass >> "simulation"));
        private _reloadTime = 0;

        // Handle empty pylons
        if (_magSize > 0) then {
            _reloadTime = ((1 - (_ammo / _magSize)) * _timer);
        };

        _maginfo pushBack [_pylonName, _turret, _mag, _ammoClass, _magSize, _ammo, _ammoSimType, _reloadTime];
        _classes pushBackUnique _mag;
    } forEach _mags;

    [_maginfo, _classes]
};


// Setup timers
private _hitPointTimer = 2;
private _fuelFlow = (1 / 10);
private _magTimer = 5;

switch (true) do {
    case (_vehicle isKindOf "Land"): {
        if (
            (_vehicle isKindOf "Wheeled_APC_F") ||
            (_vehicle isKindOf "APC_Tracked_01_base_F") ||
            (_vehicle isKindOf "APC_Tracked_02_base_F") ||
            (_vehicle isKindOf "APC_Tracked_03_base_F")
        ) then {
            _fuelFlow = (1 / 20);
            _hitPointTimer = 4;
            _magTimer = 8;
        };

        if (_vehicle isKindOf "Tank") then {
            _hitPointTimer = 5;
            _fuelFlow = (1 / 25);
            _magTimer = 10;
        };
    };

    case (_vehicle isKindOf "Air"): {
        _hitPointTimer = 10;
        _fuelFlow = (1 / 60);
        _magTimer = 45;

        if (_vehicle isKindOf "VTOL_Base_F") then {
            _hitPointTimer = 2;
            _fuelFlow = (1 / 10);
            _magTimer = 10;

            if ((_vehicle getVariable ["InA_AssetType", "NONE"]) == "CAS") then {
                _hitPointTimer = 8;
                _fuelFlow = (1 / 45);
                _magTimer = 30;
            };

            if (_vehicle isKindOf "VTOL_01_armed_base_F") then {
                _hitPointTimer = 10;
                _fuelFlow = (1 / 60);
                _magTimer = 45;
            };
        };

        if (_vehicle isKindOf "Helicopter") then {
            _hitPointTimer = 2;
            _fuelFlow = (1 / 10);
            _magTimer = 10;

            if ((_vehicle getVariable ["InA_AssetType", "NONE"]) == "CAS") then {
                _hitPointTimer = 6;
                _fuelFlow = (1 / 30);
                _magTimer = 30;
            };
        };

        if (_vehicle isKindOf "UAV") then {
            _hitPointTimer = 10;
            _fuelFlow = (1 / 30);
            _magTimer = 60;
        };
    };
};


// Repair
private _hitPointData = (getAllHitPointsDamage _vehicle);
private _hitPoints = (_hitPointData # 0);
private _hitPointsDamage = (_hitPointData # 2);
private _repairTotal = 0;

private _hpDamages = createHashMap;

{
    private _hp = _x;
    private _damage = (_hitPointsDamage # _forEachIndex);
    private _timer = (_damage * _hitPointTimer);
    _hpDamages insert [[_x, _timer]];
    _repairTotal = (_repairTotal + _timer);
} foreach _hitPoints;


// Rearm
private _rearmTimer = 0;

private _magData = [];
private _pylonData = [];

private _unsupportedType = false;

switch (true) do {
    case (_vehicle isKindOf "Land"): {
        private _info = [_vehicle, _magTimer] call _vehicleMags;

        _magData = (_info # 0);

        _magData apply {_rearmTimer = (_rearmTimer + (_x # 6))};
    };

    case (_vehicle isKindOf "Air"): {
        private _magInfo = [_vehicle, _magTimer] call _vehicleMags;
        private _pylonInfo = [_vehicle, _magTimer] call _vehiclePylons;

        _magData = (_magInfo # 0);
        _pylonData = (_pylonInfo # 0);

        private _pylonMags = _pylonData apply {_x # 2};
        _magData = (_magData select {!((_x # 1) in _pylonMags)});

        _pylonData apply {_rearmTimer = (_rearmTimer + (_x # 7))};
        _magData apply {_rearmTimer = (_rearmTimer + (_x # 6))};
    };

    default {
        ["Unsupported vehicle type"] remoteExecCall ["systemChat", remoteExecutedOwner];
        _unsupportedType = true;
    };
};

if (_unsupportedType) exitWith {
    _vehicle setVariable [QGVAR(VehicleIsServicing), false, true];
};


// Refuel
private _fuelDec = (fuel _vehicle);
private _fuelMissing = (1 - _fuelDec);
private _fuelStepDelay = 0.1;
private _fuelStep = (_fuelFlow * _fuelStepDelay);
private _fuelTimer = (_fuelMissing / _fuelFlow);
private _fuelIters = (_fuelMissing / _fuelStep);

// Start serivcing
private _serviceTime = (_repairTotal + _rearmTimer + _fuelTimer);

if (!(_serviceTime > 10)) exitWith {
    [_vehicle] call AW_fnc_vehicleReplenish;
    _vehicle setVariable [QGVAR(VehicleIsServicing), false, true];
};

private _isUAV = (unitIsUAV _vehicle);
private _autonomous = (isAutonomous _vehicle);

[_vehicle, true] remoteExecCall ["lock", _vehicle];

if (_isUAV) then {
    [_vehicle, false] remoteExecCall ["setAutonomous", _vehicle];

    private _controller = ((UAVControl _vehicle) # 0);

    if (!isNull _controller) then {
        [_vehicle, ["BackFromUAV", _controller]] remoteExecCall ["action", _controller];
    };
} else {
    {
        [[_x, _vehicle], {
            params ["_unit", "_vehicle"];

            if (hasInterface) then {
                private _typeName = (getText ((configOf _vehicle) >> "displayName"));

                systemChat (format ["%1 is being serviced, you're being ejected ....", _typeName]);
            };

            _unit moveOut _vehicle;
        }] remoteExecCall ["call", _x];
    } forEach (crew _vehicle);
};

private _radarOn = (isVehicleRadarOn _vehicle);

if (_radarOn) then {
    [_vehicle, 2] remoteExecCall ["setVehicleRadar", (owner _vehicle)];
};


private _serviceTimeout = (diag_tickTime + _serviceTime);

_pad setVariable [QGVAR(CompleteTime), (serverTime + _serviceTime), true];
_pad setVariable [QGVAR(InUse), true, true];


// Fire off servicing thread
private _serviceHandle = [
    _vehicle,
    _pad,
    _hpDamages,
    _magData,
    _pylonData,
    [_fuelStep, _fuelIters, _fuelMissing, _fuelStepDelay]
] spawn {
    params [
        "_vehicle",
        "_pad",
        "_hpDamages",
        "_magData",
        "_pylonData",
        "_fuelData"
    ];

    // Setup
    private _repairCount = (count ((values _hpDamages) select {_x > 0}));
    private _repairCounter = 0;

    private _magRearmCount = ({(_x # 4) < (_x # 3)} count _magData);
    private _pylonRearmCount = ({((_x # 4) > 0) && {(_x # 5) < (_x # 4)}} count _pylonData);
    private _rearmCount = (_magRearmCount + _pylonRearmCount);
    private _rearmCounter = 0;

    _fuelData params ["_fuelStep", "_fuelIters", "_fuelMissing", "_fuelStepDelay"];

    private _refuelCount = (floor _fuelIters);

    _pad setVariable [QGVAR(RepairPct), ([100, 0] select (_repairCount > 0)), true];
    _pad setVariable [QGVAR(RearmPct), ([100, 0] select (_rearmCount > 0)), true];
    _pad setVariable [QGVAR(RefuelPct), ([100, 0] select (_refuelCount > 0)), true];

    private _getPct = {
        params ["_total", "_handled"];

        ((round ((_handled / _total) * 100)) min 100)
    };


    // Repairs
    if (_repairCount > 0) then {
        {
            sleep _y;

            [_vehicle, [_x, 0]] remoteExecCall ["setHitPointDamage", (owner _vehicle)];

            if (_y > 0) then {
                _repairCounter = (_repairCounter + 1);
                _pad setVariable [QGVAR(RepairPct), ([_repairCount, _repairCounter] call _getPct), true];
            };
        } forEach _hpDamages;
    };

    if ((damage _vehicle) > 0) then {
        _vehicle setDamage 0;
    };


    // Rearming
    if (_rearmCount > 0) then {
        private _removedMags = [];

        {
            _x params ["_turret", "_mag", "_ammoClass", "_magSize", "_ammoCount", "_ammoSimType", "_reloadTime"];

            private _turrentMagKey = [_turret, _mag];

            if !(_turrentMagKey in _removedMags) then {
                _removedMags pushBackUnique _turrentMagKey;
                [_vehicle, [_mag, _turret]] remoteExecCall ["removeMagazinesTurret", (_vehicle turretOwner _turret)];
            };

            sleep _reloadTime;

            [_vehicle, [_mag, _turret]] remoteExecCall ["addMagazineTurret", (_vehicle turretOwner _turret)];

            if (_ammoCount == _magSize) then {continue};

            _rearmCounter = (_rearmCounter + 1);
            _pad setVariable [QGVAR(RearmPct), ([_rearmCount, _rearmCounter] call _getPct), true];
        } forEach _magData;

        {
            _x params ["_pylonName", "_turret", "_mag", "_ammoClass", "_magSize", "_ammo", "_ammoSimType", "_reloadTime"];

            if ((_magSize == 0) || {(_ammo == _magSize)}) then {continue};

            sleep _reloadTime;

            [_vehicle, [_pylonName, _magSize]] remoteExecCall ["setAmmoOnPylon", (owner _vehicle)];

            _rearmCounter = (_rearmCounter + 1);
            _pad setVariable [QGVAR(RearmPct), ([_rearmCount, _rearmCounter] call _getPct), true];
        } forEach _pylonData;
    };


    // Refueling
    if (_refuelCount > 0) then {
        private _fuelBase = (1 - _fuelMissing);

        for "_i" from 1 to _refuelCount do {
            if ((_i % 10) == 0) then {
                private _fuelLevel = (_fuelBase + (_fuelStep * _i));
                [_vehicle, _fuelLevel] remoteExecCall ["setFuel", (owner _vehicle)];
            };

            if ((_i % 5) == 0) then {
                _pad setVariable [QGVAR(RefuelPct), ([_refuelCount, _i] call _getPct), true];
            };

            sleep _fuelStepDelay;
        };
    };
};


// Wait for service thread to finish
waitUntil {
    sleep 0.1;
    (
        (
            (!alive _vehicle) ||
            ((_vehicle distance2D _pad) > _radius)
        ) || (
            (isNull _serviceHandle) ||
            (diag_tickTime > (_serviceTimeout + 5))
        )
    )
};


// Did everything go OK ?
if (
    (!alive _vehicle) ||
    ((_vehicle distance2D _pad) > _radius) ||
    (diag_tickTime > (_serviceTimeout + 5))
) then {
    terminate _serviceHandle;
};

if (alive _vehicle) then {
    [_vehicle] call AW_fnc_vehicleReplenish;

    [_vehicle, false] remoteExecCall ["lock", _vehicle];

    if (_isUAV) then {
        [_vehicle, _autonomous] remoteExecCall ["setAutonomous", (owner _vehicle)];

        if (_radarOn) then {
            [_vehicle, 1] remoteExecCall ["setVehicleRadar", (owner _vehicle)];
        };
    };

    _vehicle setVariable [QGVAR(VehicleIsServicing), false, true];
};

_pad setVariable [QGVAR(RepairPct), nil, true];
_pad setVariable [QGVAR(RearmPct), nil, true];
_pad setVariable [QGVAR(RefuelPct), nil, true];

_pad setVariable [QGVAR(InUse), false, true];
_pad setVariable [QGVAR(CompleteTime), nil, true];
