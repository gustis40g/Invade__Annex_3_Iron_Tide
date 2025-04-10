#include "reward_macros.hpp"
/*
 * Author: Whigital
 *
 * Opens the Reward dialog, populates treeview, enables buttons etc.
 *
 */

if (!hasInterface) exitWith {};

if (commandingMenu != "") then {
    waitUntil {
        sleep 0.01;
        (commandingMenu == "")
    };
};

disableSerialization;

createDialog REWARD_DLG;

waitUntil {!isNull MAIN_DSPL};

private _mainDspl = MAIN_DSPL;
private _treeCtrl = TREE_CTRL;

private _types = ["GETTYPES"] call AW_fnc_rewardsDef;

private _playerPos = (getPosATL player);
private _cursorPos = (screenToWorld [0.5, 0.5]);

_mainDspl setVariable [NEARPOSVAR, _playerPos];
_mainDspl setVariable [CURPOSVAR, _cursorPos];

private _isPlayerPosSafe = !([player, 100] call AW_fnc_isNearBase);

private _isCursorPosSafe = (((_playerPos distance2D _cursorPos) < 100) && !([_cursorPos, 100] call AW_fnc_isNearBase));
private _isCursorPosEmpty = ((_cursorPos nearObjects 6) isEqualTo []);

private _rewardArray = [] call AW_fnc_rewardsDef;

{
    _x params ["_typeId", "_typeDesc"];

    private _typeTreeIdx = _treeCtrl tvAdd [[], _typeDesc];
    _treeCtrl tvSetValue [[_typeTreeIdx], _typeId];

    private _typeItems = (_rewardArray select {(_x # 0) == _typeId});

    {
        _x params ["_itemType", "_itemId", "_itemDesc", "_itemWeight"];

        private _itemIdx = _treeCtrl tvAdd [[_typeTreeIdx], _itemDesc];
        _treeCtrl tvSetValue [[_typeTreeIdx, _itemIdx], _itemId];
    } forEach _typeItems;
} forEach _types;

{
    private _ctrl = (_mainDspl displayCtrl _x);

    _ctrl ctrlEnable false;

    if ((_x == BTN_NEAR_IDC) && {!_isPlayerPosSafe}) then {
        SETVIABLE(_ctrl,false);
        systemChat "Near spawning disabled because you're too close to base";
    };

    if ((_x == BTN_CUR_IDC) && !_isCursorPosSafe) then {
        SETVIABLE(_ctrl,false);
        systemChat "Cursor spawning disabled because you're too close to base";
    } else {
        if ((_x == BTN_CUR_IDC) && !_isCursorPosEmpty) then {
            SETVIABLE(_ctrl,false);
            systemChat "Cursor spawning disabled because area not clear";
        };
    };
} forEach [BTN_BASE_IDC, BTN_NEAR_IDC, BTN_CUR_IDC];
