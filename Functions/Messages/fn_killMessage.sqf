/*
Author: Unknown

Description: 
	Gets a bunch of params from derp revive about the killer and puts those into a some nice string.  Next print that string in both sidechat and admin channel.

Last edited: 23/02/2019 by stanhope

edited: reworked to fix a few bugs with it hopefully
*/

//get params
params ["_killedObj", "_sourceObj", "_projectile", "_instigatorObj"];

if (!isServer) exitWith {};

//get some additional things for the reporting
private _killedName = (name _killedObj);
private _killedVehicle = (typeOf (vehicle _killedObj));
private _killedVehicleName = (getText (configFile >> "CfgVehicles" >> _killedVehicle >> "DisplayName"));
private _killedUID = (getPlayerUID _killedObj);
private _killedIsZeus = ([_killedObj] call AW_fnc_isZeus);

private _killerName = (name _sourceObj);
private _sourceVehicleType = (typeOf (vehicle _sourceObj));
private _sourceVehicleName = (getText (configFile >> "CfgVehicles" >> _sourceVehicleType >> "DisplayName"));
private _killerUID = (getPlayerUID _sourceObj);
private _killerIsZeus = ([_sourceObj] call AW_fnc_isZeus);

private _instigatorName = (name _instigatorObj);
private _instigatorObjVehicleType = (typeOf (vehicle _instigatorObj));
private _instigatorVehicleName = (getText (configFile >> "CfgVehicles" >> _instigatorObjVehicleType >> "DisplayName"));
private _instigatorUID = (getPlayerUID _instigatorObj);
private _instigatorIsZeus = ([_instigatorObj] call AW_fnc_isZeus);

private _send = {
    _this call AW_fnc_log;
    _this call AW_fnc_sendDiscordMessage;
};

//================check if it's a UAV doing the killing
if (_sourceObj isKindOf "UAV" || _instigatorObj isKindOf "UAV") exitWith {
    if ((side _killedObj) != (side _sourceObj)) exitWith {}; // Not a TK

    private _adminTkMessage = format ["%1 was killed by a UAV (%2) (%3). UAV operator: %4 (%5).  Projectile: %6", _killedName, _projectile, _sourceVehicleName, (name uavOperator), (getPlayerUID uavOperator), _projectile];
    [_adminTkMessage, "TK", true] call _send;
};

//=============Check if the person isn't killing himself==============
if (
    (_killedName == _killerName) ||
    (_killedName == _instigatorName) ||
    (_killedObj == _sourceObj) ||
    (_killedObj == _instigatorObj) ||
    (_killedUID == _killerUID) ||
    (_killedUID == _instigatorUID)
) exitWith {
    private _publicTkMsg = format ["%1 killed himself", _killedName];
    [Quartermaster, _publicTkMsg] remoteExecCall ["sideChat", 0];
    private _adminTkMessage = format ["%1 killed himself with projectile: %2. Vehicle of the TKer: %3", _killedName, _projectile, _sourceVehicleName];
    [format ["[TK] %1", _adminTkMessage], false] spawn AW_fnc_adminChannelMsg;

    // Airframe counter
    if (([_killedObj] call AW_fnc_isPilot) && (_killedVehicle isKindOf "Air") && {!_killedIsZeus}) then {
        [_killedObj] call AW_fnc_pilot_grounding_AirframeCounter;
    };
};

//==================normal case
if ((_instigatorName != "Error: No vehicle") && (_instigatorName != "Error: No unit")) exitWith {
    private _distance = round (_instigatorObj distance _killedObj);
    private _adminTkMessage = "";

    if (_instigatorIsZeus) then {
       _adminTkMessage = format ["%1 got killed by Zeus: %2 (%3). Projectile used: %4. Distance: %7m. Vehicle of TKer: %5 (%6)", _killedName, _killerName, _instigatorName, _projectile, _sourceVehicleName, _instigatorVehicleName, _distance];
    } else {
        [_killedName] remoteExecCall ["AW_fnc_onTKFunc", _instigatorObj];
        private _publicTkMsg = format ["%1 teamkilled by %2", _killedName, _instigatorName];
        [Quartermaster, _publicTkMsg] remoteExecCall ["sideChat", 0];
        _adminTkMessage = format ["%1 got killed by: %2. Projectile %6. Distance: %5m. Vehicle of TKer: %4, TKer uid: %3", _killedName, _instigatorName, _instigatorUID, _instigatorVehicleName, _distance, _projectile];
    };

    [_adminTkMessage, "TK", true] call _send;
};

if ((_instigatorName == "Error: No vehicle") || (_instigatorName == "Error: No unit")) exitWith {
    private _distance = round (_sourceObj distance _killedObj);

    if ((_killerName == "Error: No vehicle") || (_killerName == "Error: No unit")) exitWith {};

    private _adminTkMessage = "";

    if (_killerIsZeus || _instigatorIsZeus) then {
        _adminTkMessage = format ["%1 got killed by Zeus: %2 (%3). Projectile: %4. Distance: %7. Vehicle of TKer: %5 (%6)", _killedName, _killerName, _instigatorName, _projectile, _sourceVehicleName, _instigatorVehicleName, _distance];
    } else {
        [_killedName] remoteExecCall ["AW_fnc_onTKFunc", _sourceObj];
        private _publicTkMsg = format ["%1 teamkilled by someone in %2s vehicle", _killedName, _killerName];
        [Quartermaster, _publicTkMsg] remoteExecCall ["sideChat", 0];
        _adminTkMessage = format ["%1 got killed by: %2. Projectile: %6. Distance: %5m Vehicle of TKer: %4, Tker uid: %3", _killedName, _killerName, _killerUID, _sourceVehicleName, _distance, _projectile];
    };

    [_adminTkMessage, "TK", true] call _send;
};
