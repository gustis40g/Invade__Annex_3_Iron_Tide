#include "reward_macros.hpp"
/*
 * Author: Whigital
 *
 * Called when either of the spawn buttons are pressed and determines
 * where to spawn a reward.
 *
 */

params ["_ctrl"];

private _ctrlIdc = (ctrlIDC _ctrl);

private _mainDspl = MAIN_DSPL;
private _treeCtrl = TREE_CTRL;

private _treeItemValue = (_treeCtrl tvValue (tvCurSel _treeCtrl));
private _treeItemText = (_treeCtrl tvText (tvCurSel _treeCtrl));

private _pos = [];
private _override = false;

switch (_ctrlIdc) do {
    case BTN_BASE_IDC: {
        _pos = nil;
    };

    case BTN_NEAR_IDC: {
        _pos = _mainDspl getVariable [NEARPOSVAR, []];
    };

    case BTN_CUR_IDC: {
        _pos = _mainDspl getVariable [CURPOSVAR, []];
        _override = true;
        _ctrl ctrlEnable false;
        SETVIABLE(_ctrl,false);
    };
};

[_treeItemValue, _pos, _override, player] remoteExec ["AW_fnc_rewardSpawn", 2];
