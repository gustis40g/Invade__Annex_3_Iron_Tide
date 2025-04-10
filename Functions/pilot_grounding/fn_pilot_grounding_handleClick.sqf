/*
 * Author: Whigital
 * 
 * Description:
 * Handles button clicks in the pilot grounding menu.
 *
 */

params ["_oper", "_args"];

if (!hasInterface) exitWith {};

if !(_oper in ["_RESET_", "_EXTEND_", "_GROUND_"]) exitWith {};

_args params ["_lbIdc"];

private _parentDisplay = (findDisplay 18000);
private _ctrl = (_parentDisplay displayCtrl _lbIdc);
private _row = (lnbCurSelRow _ctrl);
private _uid = (_ctrl lnbText [_row, 1]);

_parentDisplay closeDisplay 1;

[_oper, [_uid]] remoteExecCall ["AW_fnc_pilot_grounding_handleOperation", 2];
