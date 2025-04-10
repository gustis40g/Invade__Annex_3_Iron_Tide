#include "playerSettings_macros.hpp"
/*
 * Author: Whigital
 *
 * Description: 
 * Code that runs when the earplugs attenuation slider is updated
 *
 */

params ["_ctrl", "_value"];

private _newValue = ((round (_value / ATT_STEP)) * ATT_STEP);

_ctrl sliderSetPosition _newValue;
ctrlSetText [IDC_ATT_VALUE, format ["%1%2", _newValue, "%"]];

InA_Client_EarplugsAttenuation = (_newValue / 100);

if (!isNil "InA_EarplugsFitted" && {InA_EarplugsFitted}) then {
    0 fadeSound InA_Client_EarplugsAttenuation;
};

profileNamespace setVariable ["InA_Client_EarplugsAttenuationPct", _newValue];
