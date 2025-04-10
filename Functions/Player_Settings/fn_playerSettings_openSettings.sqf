#include "playerSettings_macros.hpp"
/*
 * Author: Whigital
 *
 * Description: 
 * Main Player Settings dialog code for populating values and checkboxes
 *
 */

if (!isNull (findDisplay IDD_MAIN)) exitWith {
    systemChat "Settings menu already open";
};

private _opened = createDialog "InA_Player_Dialog";

if (!_opened) exitWith {
    systemChat "Failed to open Player Settings";
};

disableSerialization;

private _main = (findDisplay IDD_MAIN);

{
    _x params ["_idc", "_checked"];

    private _ctrl = (_main displayCtrl _idc);

    _ctrl cbSetChecked _checked;

    if (_idc == IDC_CB_GHD && {!([player] call AW_fnc_isPilot)}) then {
        _ctrl ctrlEnable false;
    };

    if ((_idc == IDC_CB_MARK_CAP) && {((!isNil "AW_map_AOMarkers_allShown") && {AW_map_AOMarkers_allShown})}) then {
        _ctrl ctrlEnable false;
    };

    if ((_idc == IDC_CB_MARK_HOST) && {((!isNil "AW_map_AOMarkers_allShown") && {AW_map_AOMarkers_allShown})}) then {
        _ctrl ctrlEnable false;
    };

    if ((_idc == IDC_CB_MARK_ALL) && {
        ((!isNil "AW_map_AOMarkers_friendlyShown") && {AW_map_AOMarkers_friendlyShown}) ||
        ((!isNil "AW_map_AOMarkers_enemyShown") && {AW_map_AOMarkers_enemyShown})
    }) then {
        _ctrl ctrlEnable false;
    };
} forEach [
    [IDC_CB_MARK_CAP, ((!isNil "AW_map_AOMarkers_friendlyShown") && {AW_map_AOMarkers_friendlyShown})],
    [IDC_CB_MARK_HOST, ((!isNil "AW_map_AOMarkers_enemyShown") && {AW_map_AOMarkers_enemyShown})],
    [IDC_CB_MARK_ALL, ((!isNil "AW_map_AOMarkers_allShown") && {AW_map_AOMarkers_allShown})],
    [IDC_CB_CHEM, ((!isNil "InA_ChemlightActionsEnabled") && {InA_ChemlightActionsEnabled})],
    [IDC_CB_SLING, ((!isNil "SlingWeaponActionID") && {SlingWeaponActionID != -1})],
    [IDC_CB_GHD, ((!isNil "HelicopterDoorsActionID") && {HelicopterDoorsActionID != -1})],
    [IDC_CB_HUD, (!isNil "InA_ExtendedVehicleHudHandle")]
];

sliderSetRange [IDC_SWAY_SLD, SWAY_MIN, SWAY_MAX];
sliderSetSpeed [IDC_SWAY_SLD, SWAY_STEP, SWAY_STEP];
sliderSetPosition [IDC_SWAY_SLD, SWAY_VALUE];
ctrlSetText [IDC_SWAY_VALUE, format ["%1%2", SWAY_VALUE, "%"]];

if (InA_Client_AimingCoefSetting != 1) then {
    ctrlEnable [IDC_SWAY_SLD, false];
    (_main displayCtrl IDC_SWAY_SLD) ctrlSetTooltip "Weapon sway governed by mission setting";
};

if (isNil "InA_Client_EarplugsAttenuation") then {
    InA_Client_EarplugsAttenuation = ((profileNamespace getVariable ["InA_Client_EarplugsAttenuationPct", 20]) / 100);
};

sliderSetRange [IDC_ATT_SLD, ATT_MIN, ATT_MAX];
sliderSetSpeed [IDC_ATT_SLD, ATT_STEP, ATT_STEP];
sliderSetPosition [IDC_ATT_SLD, ATT_VALUE];
ctrlSetText [IDC_ATT_VALUE, format ["%1%2", ATT_VALUE, "%"]];
