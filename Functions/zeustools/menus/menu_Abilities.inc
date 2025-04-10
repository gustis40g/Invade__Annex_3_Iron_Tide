GVAR(ToggleGod) = {
    private _state = (isDamageAllowed player);

    player allowDamage !_state;

    private _status = (["on", "off"] select !_state);
    cutText [(format ["GodMode toggled %1", _status]), 'PLAIN'];
};


// Main -> Abilities
MENU(Abilities) = [
    ["Abilities", true]
];

private _status = (["On", "Off"] select (isDamageAllowed player));
MENU(Abilities) pushBack [(format ["Toggle GodMode (%1)", _status]), [0], "", -5, [["expression", "call InA_ZeusTools_ToggleGod" ]], "1", "1"];

MENU(Abilities) append [
    ["Fix YOU", [0], "", -5, [["expression", "[cursorTarget] remoteExec ['AW_fnc_zeusToolsFix', 2]"]], "1", "1"],
    ["Fix ME",  [0], "", -5, [["expression", "(vehicle player) setDamage 0; player setDamage 0; (vehicle player) setFuel 1; (vehicle player) setVehicleAmmo 1;"]], "1", "1"]
];

private _visability = (["Visable", "Hidden"] select (isObjectHidden player));
MENU(Abilities) pushBack [(format ["Toggle Hidden (%1)", _visability]), [0], "", -5, [["expression", "[player] remoteExec ['AW_fnc_zeusToolsToggleHide', 2]"]], "1", "1"];

MENU(Abilities) pushBack ["Arsenal (Unrestricted)", [0], "", -5, [["expression", "['Open', true] spawn BIS_fnc_arsenal"]], "1", "1"];
