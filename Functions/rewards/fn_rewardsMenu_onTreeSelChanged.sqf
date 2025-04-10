#include "reward_macros.hpp"
/*
 * Author: Whigital
 *
 * Updated buttons in InA_Rewards_Dialog based on TreeView selection.
 *
 */

params ["_ctrl", "_path"];

private _type = (_ctrl tvValue _path);

private _isRoot = ((_type % 100) == 0);
private _isPlane = ((_type > 100) && (_type < 500));

{
    private _ctrl = (MAIN_DSPL displayCtrl _x);
    _ctrl ctrlEnable (!_isRoot && (GETVIABLE(_ctrl)));

    if (_isPlane && {_x == BTN_NEAR_IDC}) then {
        _ctrl ctrlEnable false;
    };
} forEach [BTN_BASE_IDC, BTN_NEAR_IDC, BTN_CUR_IDC];
