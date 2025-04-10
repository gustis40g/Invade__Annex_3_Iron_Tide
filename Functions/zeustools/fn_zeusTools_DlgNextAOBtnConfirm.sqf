#include "zeustools_macros.hpp"
/*
 * Author: Whigital
 * Description:
 * onButtonClick function for NextAO/BtnConfirm
 *
 */

params ["_control"];

disableSerialization;

private _lb = ((ctrlParent _control) displayCtrl IDC_NEXTAO_LB);

private _nextAO = (_lb lbData (lbCurSel _lb));

["InA_Event_ManualAO", _nextAO] remoteExec ["AW_fnc_eventTrigger", 2];

closeDialog 0;
