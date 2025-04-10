#include "playerSettings_macros.hpp"
/*
 * Author: Whigital
 *
 * Description: 
 * Code that runs when the aim coef. slider is updated
 *
 */

params ["_ctrl", "_value"];

private _newValue = ((round (_value / SWAY_STEP)) * SWAY_STEP);

_ctrl sliderSetPosition _newValue;
ctrlSetText [IDC_SWAY_VALUE, format ["%1%2", _newValue, "%"]];

InA_Client_AimingCoef = (_newValue / 100);

player setCustomAimCoef InA_Client_AimingCoef;

profileNamespace setVariable ["InA_Client_AimingCoefPct", _newValue];
