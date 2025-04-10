#include "zeustools_macros.hpp"
/*
 * Author: Whigital
 * Description:
 * onLoad function for NextAO dialog
 *
 */

params ["_display", ["_config", configNull]];

disableSerialization;

private _aosConfigPath = (missionConfigFile >> worldName >> "AOs");

private _aoClasses = ("true" configClasses _aosConfigPath);
private _aoList = [];

{
    private _configName = (configName _x);

    if (_configName in (InA_Client_controlledZones + [InA_Client_currentAO])) then {continue};

    private _name = (getText (_x >> "name"));

    _aoList pushBack [_name, _configName];
} forEach _aoClasses;

private _listBox = (_display displayCtrl IDC_NEXTAO_LB);

private _selector = createMarkerLocal [QGVAR(SelectMarker), [0, 0]];
_selector setMarkerTypeLocal "selector_selectedMission";
_selector setMarkerColorLocal "colorOPFOR";
_selector setMarkerSizeLocal ((getMarkerSize _selector) apply {_x * 1.5});

GVAR(AOData) = [];

_aoList sort true;

{
    _x params ["_text", "_data"];
    
    private _idx = (_listBox lbAdd _text);
    _listBox lbSetData [_idx, _data];
    GVAR(AOData) pushBack [_data, (getMarkerPos _data), _idx];
} forEach _aoList;

private _mapClickHandler = addMissionEventHandler ["MapSingleClick", {
    params ["_units", "_pos", "_alt", "_shift"];

    private _nearAOs = (GVAR(AOData) select {
        ((_pos distance2D (_x # 1)) < 800)
    });

    if (_nearAOs isNotEqualTo []) then {
        private _nearAODist = (_nearAOs apply {[(_pos distance2D (_x # 1))] + _x});
        _nearAODist sort true;

        private _nearestAO = (_nearAODist #0);
        private _lbIdx = (_nearestAO # 3);

        private _lb = ((findDisplay IDD_NEXTAO_DLG) displayCtrl IDC_NEXTAO_LB);

        _lb lbSetCurSel _lbIdx;
    };
}];

missionNamespace setVariable [QGVAR(mapClickEhIdx), _mapClickHandler];
