/*
 * Author: Whigital
 * 
 * Description:
 * Opens Pilot grounding menu.
 *
 */

if (!isNil "InA_PilotGrounding_Client_UI_Data") then {
    InA_PilotGrounding_Client_UI_Data = nil;
};

["_COLLECT_", nil] remoteExec ["AW_fnc_pilot_grounding_handleOperation", 2];

if (commandingMenu != "") then {
    waitUntil {
        sleep 0.01;
        (commandingMenu == "")
    };
};

disableSerialization;

createDialog "InA_PilotGrounding_Dialog";

waitUntil {!isNull (findDisplay 18000)};

private _parentDisplay = (findDisplay 18000);

private _headerGrounded = (_parentDisplay displayCtrl 18103);
private _contentGrounded = (_parentDisplay displayCtrl 18105);
private _btnExtend = (_parentDisplay displayCtrl 18106);
private _btnReset = (_parentDisplay displayCtrl 18107);

_headerGrounded ctrlEnable false;
_btnExtend ctrlEnable false;
_btnReset ctrlEnable false;

private _headerActive = (_parentDisplay displayCtrl 18203);
private _contentActive = (_parentDisplay displayCtrl 18205);
private _btnGround = (_parentDisplay displayCtrl 18206);

_headerActive ctrlEnable false;
_btnGround ctrlEnable false;

waitUntil {!isNil "InA_PilotGrounding_Client_UI_Data"};

InA_PilotGrounding_Client_UI_Data params ["_groundedPlayer", "_activePilots"];

{
    _x params ["_name", "_uid", "_timer"];

    private _row = _contentGrounded lnbAddRow [_name, _uid, format ["%1", _timer]];
    _contentGrounded lnbSetValue [[_row, 2], _timer];
} forEach _groundedPlayer;

_contentGrounded lnbSortByValue [2, true];

{
    _x params ["_name", "_uid"];

    private _row = _contentActive lnbAddRow [_name, _uid];
} forEach _activePilots;

InA_PilotGrounding_Client_UI_Data = nil;
