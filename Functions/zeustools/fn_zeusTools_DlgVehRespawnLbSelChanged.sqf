#include "zeustools_macros.hpp"
/*
 * Author: Whigital
 * Description:
 * onLBSelChanged function for VehRespawn/RespawnList control
 *
 */

params ["_control", "_selectedIndex"];

disableSerialization;

private _respawnBtn = ((findDisplay IDD_VEHRESPAWN_DLG) displayCtrl IDC_VEHRESPAWN_BTN);

_respawnBtn ctrlEnable ((_control lnbText [_selectedIndex, 2]) != "<1");
