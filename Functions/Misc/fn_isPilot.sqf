/*
 * Author: Whigital
 *
 * Description:
 * Check pilot status
 *
 */

params [["_unit", objNull]];

if !(_unit isEqualType objNull) exitWith {false};

if (isNull _unit) exitWith {false};

(_unit getVariable ["InA_isPilot", false] && {(_unit getVariable ["AW_role", ""]) == "pilot"})
