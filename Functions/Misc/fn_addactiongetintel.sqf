/*
Author: Quiksilver
*/

params ["_unit"];

if (!hasInterface) exitWith {};

_unit addAction [
    "<t color='#ff1111'>Get Intel</t>", 
    {
        params ["_target", "_caller", "_actionId", "_arguments"];

        hint "Receiving data .... Verifying ....";
        sleep 5;

        private _sidecompleted = format ["<t align='center'><t size='2.2'>Side-mission update</t><br/>____________________<br/>%1 recovered the intel.</t>", (name _caller)];
        [_sidecompleted] remoteExec ["AW_fnc_globalHint", 0];

        sleep 5;

        ["InA_Event_SideMissionSuccess"] remoteExecCall ["AW_fnc_eventTrigger", 2];
    }
    ,
    [],
    21,
    true,
    true,
    "",
    "(_target distance player) < 5"
];
