#include "zeustools_macros.hpp"
/*
 * Author: Whigital
 * Description:
 * onUnload function for VehRespawn dialog
 *
 */

params ["_display", ["_config", configNull]];

if (!canSuspend) exitWith {
    _this spawn AW_fnc_zeusTools_DlgVehRespawnonLoad;
};

disableSerialization;

if (!isNil "InA_Client_RespawningVehicles_List") then {
    InA_Client_RespawningVehicles_List = nil;
};

remoteExec ["AW_fnc_vehicleGetRespawns", 2];

private _list = (_display displayCtrl IDC_VEHRESPAWN_LB);

private _timeOut = (diag_tickTime + 5);

waitUntil {
    sleep 0.01;
    ((!isNil "InA_Client_RespawningVehicles_List") || (diag_tickTime > _timeout))
};

if (isNil "InA_Client_RespawningVehicles_List") exitWith {
    systemChat "Failed to get vehicle list from server !";
};

{
    _x params ["_name", "_base", "_timer", "_uid"];

    if (_timer isEqualType 0) then {
        _timer = (str _timer);
    };

    private _row = _list lnbAddRow [_name, _base, _timer];
    _list lnbSetData [[_row, 0], _uid];
} forEach InA_Client_RespawningVehicles_List;

private _respawnBtn = ((findDisplay IDD_VEHRESPAWN_DLG) displayCtrl IDC_VEHRESPAWN_BTN);

_respawnBtn ctrlEnable false;
