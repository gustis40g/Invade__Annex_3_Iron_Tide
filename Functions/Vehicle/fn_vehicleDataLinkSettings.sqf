/*
 * Author: Whigital
 *
 * Description:
 * Sets vehicle datalink based sensor availability
 *
 */

params [["_vehicle", objNull]];

if (isNull _vehicle) exitWith {};

private _sensors = (listVehicleSensors _vehicle);

if (_sensors isEqualTo []) exitWith {};

{
    _x params ["_sensorClass", "_sensorType"];

    private _activeArray = ((_vehicle isVehicleSensorEnabled _sensorType) # 0);

    _activeArray  params ["_sensor", "_enabled"];

    if (!_enabled) then {
        _vehicle  enableVehicleSensor [_sensorType, true];
    };
} forEach _sensors;

_vehicle setVehicleReportOwnPosition true;
_vehicle setVehicleReceiveRemoteTargets true;
_vehicle setVehicleReportRemoteTargets true;
