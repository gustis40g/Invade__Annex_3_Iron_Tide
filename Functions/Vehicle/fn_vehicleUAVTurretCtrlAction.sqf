/*
 * Author: Whigital
 *
 * Description:
 * Adds Turret Control action to UAV turrets attached to a vehicle
 *
 */

params [["_vehicle", objNull]];

if (isNull _vehicle) exitWith {};

if (!hasInterface) exitWith {};

private _cond = "(!isNil {_target getVariable ['InA_Attached_uavTurret', nil]}) && {((objectParent _this) == _target) && {_this != (driver _target)}}";

_vehicle addAction [
    "<t color='#0174df' size='1.2' font='PuristaBold'><img size='1.1' image='\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa' /> Turret Control</t>",
    {
        params ["_target", "_caller", "_actionId", "_arguments"];

        private _turret = _target getVariable ["InA_Attached_uavTurret", objNull];

        if (isNull _turret) exitWith {};

        private _uavControl = (UAVControl _turret);
        private _controller = (_uavControl # 0);

        if (!isNull _controller) exitWith {
            hint format ["Player %1 currently in control of UAV Turret", (name _controller)];
        };

        _caller action ["SwitchToUAVGunner", _turret];
    },
    [],
    0,
    false,
    true,
    "",
    _cond,
    2
];
