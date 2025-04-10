/*
Author: Quiksilver
*/

params ["_unit"];

if (!hasInterface) exitWith {};

_unit addAction [
    "<t color='#ff1111'>Surrender</t>",
    {
        params ["_target", "_caller", "_actionId", "_arguments"];

        hint "You ordered him to surrender";
        sleep 1;

        ["InA_Event_SideOfficerSurrender", _target] remoteExecCall ["AW_fnc_eventTrigger", 2];
    },
    [],
    21,
    true,
    true,
    "",
    "(_target distance player) < 25"
];
