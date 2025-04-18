params [
    ["_aircraft", objNull],
    ["_pylonArray", []]
];

if (isNull _aircraft || {_pylonArray isEqualTo []}) exitWith {};

// Step 1: Get all pylon weapons to be removed
private _currentMags = getPylonMagazines _aircraft;
private _weaponsToRemove = [];

{
    private _mag = _x;
    if (_mag == "") then {continue};
    
    private _weapon = getText (configFile >> "CfgMagazines" >> _mag >> "pylonWeapon");
    if (_weapon == "") then {continue};
    
    _weaponsToRemove pushBackUnique _weapon;
} forEach _currentMags;

// Step 2: Remove all pylon magazines
{
    if (_x != "") then {
        _aircraft removeMagazine _x;
    };
} forEach _currentMags;

// Step 3: Remove all pylon weapons from all possible turrets
{
    private _weapon = _x;
    
    private _allTurrets = allTurrets [_aircraft, true]; // Include FFV turrets
    _allTurrets pushBack [-1]; // Pilot/primary turret
    _allTurrets pushBack [0]; // Copilot/gunner turret
    
    {
        if (_aircraft turretLocal _x) then {
            _aircraft removeWeaponTurret [_weapon, _x];
        };
    } forEach _allTurrets;
} forEach _weaponsToRemove;

// Step 4: Apply new pylon loadout
{
    _x params ["_pylon", "_mag", ["_owner", []]];
    _aircraft setPylonLoadOut [_pylon, _mag, true, _owner];
} forEach _pylonArray;