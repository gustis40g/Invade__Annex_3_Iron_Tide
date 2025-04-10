params [
    ["_inArsenal", false]
];

private _removedString = "The following equipment has been removed from your inventory:<br/><br/>";
private _removedItems = [];

if ((!alive player) || ("GearRestriction" call BIS_fnc_getParamValue == 0)) exitWith {};
if (player getVariable ["InA_isCoreStaff", false]) exitWith {};

if (isNil "InA_ArsenalWhitelistArray") exitWith {};

private _allowedItemsArray = (InA_ArsenalWhitelistArray # 0);
private _allowedWeaponsArray = (InA_ArsenalWhitelistArray # 1);
private _allowedBackpacksArray = (InA_ArsenalWhitelistArray # 2);
private _allowedWeaponPickupArray = (InA_ArsenalWhitelistArray # 4);
private _weaponList = (_allowedWeaponsArray + _allowedItemsArray);

private _fnc_checkClass = {
    params ["_class", "_baseClasses"];

    private _derivedFromBase = false;

    {
        private _derived = false;

        if (isClass (configFile >> "CfgVehicles" >> _class)) then {
            _derived = (_class isKindOf _x);
        } else {
            _derived = (_class isKindOf [_x, configFile >> "CfgWeapons"]);
        };

        if (_derived) then {
            _derivedFromBase = true;
            break;
        };
    } forEach _baseClasses;

    _derivedFromBase
};


// Weapons:
{

    if ((_x != "") && (!(_x in _weaponList))) then {
        private _weap = _x;
        private _remove = true;

        if (!_inArsenal && {[_weap, _allowedWeaponPickupArray] call _fnc_checkClass}) then {
            continue;
        };

        if (_remove) then {
            _removedString = _removedString + (getText (configFile >> "CfgWeapons" >> _x >> "displayName")) + "<br/>";
            _removedItems pushBack _x;
            player removeWeapon _x;
        };
    };
} forEach (weapons player);


// Primary weapon attachments:
{
    if ((_x != "") && (!(_x in _allowedItemsArray))) then {
        _removedString = _removedString + (getText (configFile >> "CfgWeapons" >> _x >> "displayName")) + "<br/>";
        _removedItems pushBack _x;
        player removePrimaryWeaponItem _x;
    };
} forEach (primaryWeaponItems player);


// Secondary weapon attachments:
{
    if ((_x != "") && (!(_x in _allowedItemsArray))) then {
        _removedString = _removedString + (getText (configFile >> "CfgWeapons" >> _x >> "displayName")) + "<br/>";
        _removedItems pushBack _x;
        player removeSecondaryWeaponItem _x;
    };
} forEach (secondaryWeaponItems player);


// Handgun weapon attachments:
{
    if ((_x != "") && (!(_x in _allowedItemsArray))) then {
        _removedString = _removedString + (getText (configFile >> "CfgWeapons" >> _x >> "displayName")) + "<br/>";
        _removedItems pushBack _x;
        player removeHandgunItem _x;
    };
} forEach (handgunItems player);


// Headgear:
private _headgear = (headgear player);

if ((_headgear != "") && (!(_headgear in _allowedItemsArray))) then {
    _removedString = _removedString + (getText (configFile >> "CfgWeapons" >> _headgear >> "displayName")) + "<br/>";
    _removedItems pushBack _headgear;
    removeHeadgear player;
};


// Uniform:
private _uniform = (uniform player);

if ((_uniform != "") && (!(_uniform in _allowedItemsArray))) then {
    _removedString = _removedString + (getText (configFile >> "CfgWeapons" >> _uniform >> "displayName")) + "<br/>";
    _removedItems pushBack _uniform;
    removeUniform player;
};


// Vest:
private _vest = (vest player);

if ((_vest != "") && (!(_vest in _allowedItemsArray))) then {
    _removedString = _removedString + (getText (configFile >> "CfgWeapons" >> _vest >> "displayName")) + "<br/>";
    _removedItems pushBack _vest;
    removeVest player;
};


// Backpack:
private _backpack = (backpack player);
private _backpackList = _allowedBackpacksArray;

if ((_backpack != "") && {(!(_backpack in _backpackList))}) then {
    if ((_backpack find "TFAR" == -1) || !([_backpack, InA_AllowedPickup_Backpacks] call _fnc_checkClass)) then {
        _removedString = _removedString + (getText (configFile >> "CfgVehicles" >> _backpack >> "displayName")) + "<br/>";
        _removedItems pushBack _backpack;
        removeBackpack player;
    };
};


// Assigned items:
{
    if ((_x != "") && (!(_x in _allowedItemsArray))) then {
        if (_x find "TFAR" == -1) then {
            _removedString = _removedString + (getText (configFile >> "CfgWeapons" >> _x >> "displayName")) + "<br/>";
            _removedItems pushBack _x;
            player unassignItem _x;
            player removeItem _x;
        };
    };
} forEach (assignedItems player);


// Items in inventory:
{
    if ((_x != "") && (!(_x in _weaponList))) then {
        if (_x find "TFAR" == -1) then {
            _removedString = _removedString + (getText (configFile >> "CfgWeapons" >> _x >> "displayName")) + "<br/>";
            _removedItems pushBack _x;
            player removeItem _x;
        };
    };
} forEach (items player);


// Tell the player what happened:
if (count _removedItems > 0) then {
    _removedString = _removedString + "<br/>Play a different role if you want to use it.";
    hint parseText format ['%1', _removedString];
};
