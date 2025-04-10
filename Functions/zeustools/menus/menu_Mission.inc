GVAR(createArsenal) = {
    private _result = ["Would you like to create an arsenal where you are currently looking?  (if you're in zeus, where your zeus camera is looking, if you're in your character, where your character is looking.)", "", "Yes", "No"] call BIS_fnc_guiMessage;

    if (!_result) exitWith {};

    private _pos = screenToWorld [0.5, 0.5];

    [_pos, false, true] remoteExec ["AW_fnc_arsenalCreate", 2];
};

GVAR(medicalState) = {
    params ["_action", "_unit"];

    if (isNull _unit) exitWith {
        systemChat "No object selected !";
    };

    if !(_unit isKindOf "CAManBase") exitWith {
        systemChat format ["%1 is not a unit !", (typeOf _unit)];
    };

    if (!isPlayer _unit) exitWith {
        systemChat format ["%1 is not a player !", (typeOf _unit)];
    };

    switch (_action) do {
        case "down": {
            if !(_unit getVariable ["derp_revive_downed", false]) then {
                [_unit, "DOWNED"] remoteExecCall ["derp_revive_fnc_switchState", _unit];
            } else {
                systemChat format ["%1 is already downed ....", (name _unit)];
            };
        };

        case "revive": {
            if (
                (_unit getVariable ["derp_revive_downed", false]) && {
                    !(_unit getVariable ["derp_revive_isDragged", false]) &&
                    !(_unit getVariable ["derp_revive_isCarried", false])
                }
             ) then {
                 [_unit, "REVIVED"] remoteExecCall ["derp_revive_fnc_switchState", _unit];
            } else {
                systemChat format ["%1 isn't unconscious ....", (name _unit)];
            };
        };
    };
};


// Main -> Mission related
MENU(Mission) = [
    ["Mission related", true],
    ["Exclusion zones",     [0], USERMENU(Mission_Excl),  -5, [["expression", ""]], "1", "1"],
    ["Add to AdminChannel", [0], "", -5, [["expression", "[player] remoteExec ['AW_fnc_addToAdminChannel', 2]"]], "1", "1"],
    ["Spawn Rewards",       [0], "", -5, [["expression", "[] spawn AW_fnc_rewardsMenu_Open"]], "1", "1"],
    ["Create Arsenal",      [0], "", -5, [["expression", "[] spawn InA_ZeusTools_createArsenal"]], "1", "1"],
    ["Down player",         [0], "", -5, [["expression", "['down', cursorTarget] spawn InA_ZeusTools_medicalState"]], "1", "1"],
    ["Revive player",       [0], "", -5, [["expression", "['revive', cursorTarget] spawn InA_ZeusTools_medicalState"]], "1", "1"],
    ["Respawn Vehicles",    [0], "", -5, [["expression", "['VehRespawn_Dialog'] spawn AW_fnc_zeusTools_DlgOpen"]], "1", _active]
];


// Main -> Mission related -> Exclusion zones
MENU(Mission_Excl) = [
    ["Exclusion zones", true],
    ["Add ExclusionZone",       [0], "", -5, [["expression", "['InA_Event_addBlacklistPos', (getPos player)] remoteExec ['AW_fnc_eventTrigger', 2]"]], "1", "1"],
    ["Remove ExclusionZone",    [0], "", -5, [["expression", "['InA_Event_remBlacklistPos', (getPos player)] remoteExec ['AW_fnc_eventTrigger', 2]"]], "1", "1"]
];
