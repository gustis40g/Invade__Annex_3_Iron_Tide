/*
 * Author: Whigital
 *
 * Description:
 * Removes all player spawned drones
 *
 * Darter         : UAV_01_base_F
 * Pelican        : UAV_06_base_F
 * Pelter         : UGV_02_Base_F
 * Autonomous HMG : HMG_01_A_base_F
 * Autonomous GMG : GMG_01_A_base_F
 * Autonomous LD  : Static_Designator_01_base_F
 * 
 */

if (!isServer) exitWith {};

private _allUAVs = (entities [["UAV_01_base_F", "UAV_06_base_F", "UGV_02_Base_F", "HMG_01_A_base_F", "GMG_01_A_base_F", "Static_Designator_01_base_F"], [], false, true]);

{
    _x call AW_fnc_delete;
} forEach _allUAVs;
