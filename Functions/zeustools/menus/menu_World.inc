private _radiusArray = [25, 50, 100, 250, 500];

// Main -> World
MENU(World) = [
    ["World", true],
    ["Remove smoke", [0], USERMENU(World_Smoke),        -5, [["expression", ""]], "1", "1"],
    ["Remove mines", [0], USERMENU(World_Explosives),   -5, [["expression", ""]], "1", "1"]
];

// Main -> World related -> Smoke
MENU(World_Smoke) = [
    ["Remove smoke", true]
];

{
    MENU(World_Smoke) pushBack [(format ["%1m", _x]), [0], "", -5, [["expression", (format ["[(getPos player), %1, 'Smoke'] remoteExec ['AW_fnc_zeusToolsCleanupItems', 2]", _x])]], "", ""];
} forEach _radiusArray;

MENU(World_Explosives) = [
    ["Remove mines", true]
];

{
    MENU(World_Explosives) pushBack [(format ["%1m", _x]), [0], "", -5, [["expression", (format ["[(getPos player), %1, 'Explosive'] remoteExec ['AW_fnc_zeusToolsCleanupItems', 2]", _x])]], "", ""];
} forEach _radiusArray;
