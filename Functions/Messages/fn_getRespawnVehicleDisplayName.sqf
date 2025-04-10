/*
fn_getRespawnVehicleDisplayName.sqf

params: _vehType: the "classname" used in the respawn script

return: human readable display name
*/

params ["_vehType"];

private _displayName = nil;

if (isClass (configFile >> "CfgVehicles" >> _vehType)) then {
    _displayName = (getText (configFile >> "CfgVehicles" >> _vehType >> "displayName"));
} else {
    private _vehArray = [_vehType] call AW_fnc_vehicleLookup;

    _displayName = (_vehArray # 1);
};

_displayName
