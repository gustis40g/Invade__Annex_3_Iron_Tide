#include "playerSettings_macros.hpp"
/*
 * Author: Whigital
 *
 * Description: 
 * Runs code and enables/disables checkboxes based on selection
 *
 */

params ["_ctrl", "_status"];

private _checked = ([false, true] # _status);
private _idc = (ctrlIDC _ctrl);

private _updateMarkerBoxes = {
    params ["_idc", "_ctrl", "_value"];

    if (_idc == IDC_CB_MARK_CAP) then {
        private _boxAll = ((findDisplay IDD_MAIN) displayCtrl IDC_CB_MARK_ALL);
        private _boxEnemy = ((findDisplay IDD_MAIN) displayCtrl IDC_CB_MARK_HOST);

        waitUntil {!isNil "AW_map_AOMarkers_friendlyShown" && {AW_map_AOMarkers_friendlyShown == _value}};

        if (_value && {ctrlEnabled _boxAll}) then {
            _boxAll ctrlEnable !_value;
        } else {
            if (!cbChecked _boxEnemy) then {
                _boxAll ctrlEnable true;
            };
        };
    };

    if (_idc == IDC_CB_MARK_HOST) then {
        private _boxAll = ((findDisplay IDD_MAIN) displayCtrl IDC_CB_MARK_ALL);
        private _boxFriendly = ((findDisplay IDD_MAIN) displayCtrl IDC_CB_MARK_CAP);

        waitUntil {!isNil "AW_map_AOMarkers_enemyShown" && {AW_map_AOMarkers_enemyShown == _value}};

        if (_value && {ctrlEnabled _boxAll}) then {
            _boxAll ctrlEnable false;
        } else {
            if (!cbChecked _boxFriendly) then {
                _boxAll ctrlEnable true;
            };
        };
    };

    if ((_idc == IDC_CB_MARK_ALL)) then {
        {
            private _boxCtrl = ((findDisplay IDD_MAIN) displayCtrl _x);

            waitUntil {!isNil "AW_map_AOMarkers_allShown" && {AW_map_AOMarkers_allShown == _value}};

            _boxCtrl ctrlEnable !_value;

        } forEach [IDC_CB_MARK_CAP, IDC_CB_MARK_HOST];
    };
};


switch (_idc) do {
    case IDC_CB_MARK_CAP: {
        if (_checked) then {
            ["create", "friendly"] spawn AW_fnc_aoMarkers;
        } else {
            ["delete", "friendly"] spawn AW_fnc_aoMarkers;
        };
    };

    case IDC_CB_MARK_HOST: {
        if (_checked) then {
            ["create", "enemy"] spawn AW_fnc_aoMarkers;
        } else {
            ["delete", "enemy"] spawn AW_fnc_aoMarkers;
        };
    };

    case IDC_CB_MARK_ALL: {
        if (_checked) then {
            ["create", "all"] spawn AW_fnc_aoMarkers;
        } else {
            ["delete", "all"] spawn AW_fnc_aoMarkers;
        };
    };

    case IDC_CB_CHEM: {
        [] spawn AW_fnc_chemlightActionsToggle;
    };

    case IDC_CB_SLING: {
        ["Toggle"] spawn AW_fnc_slingWeapon;
    };

    case IDC_CB_GHD: {
        ["Toggle"] spawn AW_fnc_helicopterDoors;
    };

    case IDC_CB_HUD: {
        [] spawn AW_fnc_toggleVehicleHUD;
    };
};

if (_idc in [IDC_CB_MARK_CAP, IDC_CB_MARK_HOST, IDC_CB_MARK_ALL]) then {
    [_idc, _ctrl, _checked] spawn _updateMarkerBoxes;
};
