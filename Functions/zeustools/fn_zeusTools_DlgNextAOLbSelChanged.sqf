#include "zeustools_macros.hpp"
/*
 * Author: Whigital
 * Description:
 * onLBSelChanged function for NextAO/LbZones control
 *
 */

params ["_control", "_selectedIndex"];

disableSerialization;

private _marker = (_control lbData _selectedIndex);
private _pos = (getMarkerPos _marker);

QGVAR(SelectMarker) setMarkerPosLocal _pos;

private _map = ((findDisplay IDD_NEXTAO_DLG) displayCtrl IDC_NEXTAO_MAP);

ctrlMapAnimClear _map;
_map ctrlMapAnimAdd [0.35, 0.2, _pos];
ctrlMapAnimCommit _map;
