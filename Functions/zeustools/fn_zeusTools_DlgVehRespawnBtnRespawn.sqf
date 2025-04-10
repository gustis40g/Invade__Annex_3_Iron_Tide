#include "zeustools_macros.hpp"
/*
 * Author: Whigital
 * Description:
 * onButtonClick function for VehRespawn/BtnRespawn
 *
 */

params ["_control"];

disableSerialization;

private _display = (ctrlParent _control);
private _list = (_display displayCtrl IDC_VEHRESPAWN_LB);

private _row = (lnbCurSelRow _list);

if (_row == -1) exitWith {
    systemChat "No vehicle selected!";
};

private _id = (_list lnbData [_row, 0]);

[_id] remoteExec ["AW_fnc_vehicleRequestRespawn", 2];

closeDialog 0;
