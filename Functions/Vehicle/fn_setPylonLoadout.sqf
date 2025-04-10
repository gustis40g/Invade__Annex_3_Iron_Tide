params [
    ["_aircraft", objNull],
    ["_pylonArray", []]
];

if ((isNull _aircraft) || (_pylonArray isEqualTo [])) exitWith {};

private _mags = (getPylonMagazines _aircraft);
private _weapons = [];

{
    if (_x == "") then {continue};

    private _weapon = (getText (configFile >> "CfgMagazines" >> _x >> "pylonWeapon"));

    _aircraft removeMagazine _x;
    _weapons pushBackUnique _weapon;
} forEach _mags;

{
    _aircraft removeWeapon _x;
} forEach _weapons;

{
    _x params ["_pylon", "_mag", ["_owner", []]];

    _aircraft setPylonLoadOut [_pylon, _mag, true, _owner];
} forEach _pylonArray;
