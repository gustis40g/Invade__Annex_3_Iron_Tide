// Main -> Admin
MENU(Admin) = [
    ["Admin", true]
];

private _status = "Disabled";

if (missionNamespace getVariable ["Ares_Allow_Zeus_To_Execute_Code", true]) then {_status = "Enabled"};
MENU(Admin) pushBack [(format ["Toggle Ares CodeExec (%1)", _status]), [0], "", -5, [["expression", "['InA_Event_ToggleCodeExec', 'Ares'] remoteExec ['AW_fnc_eventTrigger', 2]"]], "1", "1"];

_status = "Disabled";
if !(missionNamespace getVariable ["ZEN_disableCodeExecution", false]) then {_status = "Enabled"};
MENU(Admin) pushBack [(format ["Toggle ZEN CodeExec (%1)", _status]), [0], "", -5, [["expression", "['InA_Event_ToggleCodeExec', 'ZEN'] remoteExec ['AW_fnc_eventTrigger', 2]"]], "1", "1"];

MENU(Admin) pushBack ["Pilot Grounding", [0], "", -5, [["expression", "[] spawn AW_fnc_pilot_grounding_openDialog"]], "1", "1"];
