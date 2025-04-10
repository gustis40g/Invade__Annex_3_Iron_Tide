/*
 * Author: Whigital
 * Description:
 * Controls Base AA functionalty
 *
 */

params ["_base", "_caller"];

private _baseVar = (format ["InA_Server_BaseDefenses_%1", _base]);
private _baseName = (getText (missionConfigFile >> worldName >> "AOs" >> _base >> "name"));

if (isNil {missionNamespace getVariable [(format ["%1_Enabled", _baseVar]), nil]}) exitWith {
    [(parseText format ["<br /><t align='center' font='PuristaBold' size='1.4'>No base AA available for '%1'</t>", _baseName]), true, nil, 4, 1, 0.3] remoteExec ["BIS_fnc_textTiles", _caller];
};

if (missionNamespace getVariable [(format ["%1_Active", _baseVar]), false]) exitWith {
    [(parseText format ["<br /><t align='center' font='PuristaBold' size='1.4'>Base AA for '%1' already active</t>", _baseName]), true, nil, 4, 1, 0.3] remoteExec ["BIS_fnc_textTiles", _caller];
};

if (missionNamespace getVariable [(format ["%1_Cooldown", _baseVar]), false]) exitWith {
    [(parseText format ["<br /><t align='center' font='PuristaBold' size='1.4'>Base AA for '%1' is cooling down</t>", _baseName]), true, nil, 4, 1, 0.3] remoteExec ["BIS_fnc_textTiles", _caller];
};

private _msg = format ["Player %1 activated Base AA for '%2'", (name _caller), _base];
[format ["[BASE AA] %1", _msg], false] spawn AW_fnc_adminChannelMsg;

private _aaVehicles = (missionNamespace getVariable [(format ["%1_Vehicles", _baseVar]), []]);

// Activate AA
{
    _x setVehicleReportOwnPosition true;
    _x setVehicleReceiveRemoteTargets true;
    _x setVehicleReportRemoteTargets true;
    _x setVehicleRadar 1;
    _x setVehicleAmmo 1;
    _x setAutonomous true;
    _x setVehicleLock "LOCKEDPLAYER";
    createVehicleCrew _x;

    private _grp = (group (gunner _x));
    _grp setGroupIdGlobal [format ["UAV-BaseAA-%1", _forEachIndex]];
    _grp setCombatMode "RED";
    _grp setBehaviourStrong "COMBAT";
} forEach _aaVehicles;

missionNamespace setVariable [(format ["%1_Active", _baseVar]), true];
missionNamespace getVariable [(format ["%1_Cooldown", _baseVar]), false];

[parseText format ["<br /><t align='center' font='PuristaBold' size='1.4'><t color='#0090ff'>Crossroads: </t><br />Base air-defense for '%1' activated.</t>", _baseName], true, nil, 3, 1, 0.3] remoteExec ["BIS_fnc_textTiles", -2];

// Deactivate and enter cooldown after 300 sec
sleep 300;

missionNamespace setVariable [(format ["%1_Active", _baseVar]), false];
missionNamespace setVariable [(format ["%1_Cooldown", _baseVar]), true];

{
    _x setVehicleRadar 2;
    _x setVehicleAmmo 0;
    _x setVehicleLock "LOCKED";
    (crew _x) call AW_fnc_delete;
} forEach _aaVehicles;

// Cooldown complete after 900 sec
[parseText format ["<br /><t align='center' font='PuristaBold'><t size='1.4' color='#0090ff'>Crossroads: </t><t size='1.2'><br />Base air-defense for '%1' going into cooldown.</t></t>", _baseName], true, nil, 3, 1, 0.3] remoteExec ["BIS_fnc_textTiles", -2];
sleep 900;

missionNamespace setVariable [(format ["%1_Cooldown", _baseVar]), false];
[parseText format ["<br /><t align='center' font='PuristaBold' size='1.4'><t color='#0090ff'>Crossroads: </t><br />Base air-defense for '%1' available.</t>", _baseName], true, nil, 3, 1, 0.3] remoteExec ["BIS_fnc_textTiles", -2];
