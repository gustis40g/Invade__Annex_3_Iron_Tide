params [
    ["_inArsenal", false]
];

if ((!alive player) || ("GearRestriction" call BIS_fnc_getParamValue == 0)) exitWith {};
if (player getVariable ["InA_isCoreStaff", false]) exitWith {};

// Get current role or default to rifleman
private _role = player getVariable ["AW_role", "rifleman"];
private _whitelist = InA_PrecompiledArsenalWhitelists getOrDefault [_role, InA_DefaultArsenalWhitelist];

private _allowedItemsArray = (_whitelist # 0);
private _allowedWeaponsArray = (_whitelist # 1);
private _allowedBackpacksArray = (_whitelist # 2);
private _allowedWeaponPickupArray = (_whitelist # 4);
private _weaponList = (_allowedWeaponsArray + _allowedItemsArray);

private _removedString = "The following equipment has been removed from your inventory:<br/><br/>";
private _removedItems = [];

// Reusable function to check class inheritance
private _fnc_checkClass = {
    params ["_class", "_baseClasses"];

    private _derivedFromBase = false;

    {
        private _configPath = if (isClass (configFile >> "CfgVehicles" >> _class)) then {
            configFile >> "CfgVehicles"
        } else {
            configFile >> "CfgWeapons"
        };

        if (isClass (_configPath >> _class) && {_class isKindOf [_x, _configPath]}) then {
            _derivedFromBase = true;
            break;
        };
    } forEach _baseClasses;

    _derivedFromBase
};

// Weapons check
{
    if ((_x != "") && {!(_x in _weaponList)}) then {
        private _remove = true;
        
        // Allow pickup of whitelisted weapon classes
        if (!_inArsenal && {[_x, _allowedWeaponPickupArray] call _fnc_checkClass}) then {
            _remove = false;
        };

        if (_remove) then {
            private _displayName = getText (configFile >> "CfgWeapons" >> _x >> "displayName");
            _removedString = _removedString + _displayName + "<br/>";
            _removedItems pushBack _x;
            player removeWeapon _x;
        };
    };
} forEach (weapons player);

// Weapon attachments (primary/secondary/handgun)
private _attachmentCheck = {
    params ["_item"];
    
    if ((_item != "") && {!(_item in _allowedItemsArray)}) then {
        private _displayName = getText (configFile >> "CfgWeapons" >> _item >> "displayName");
        _removedString = _removedString + _displayName + "<br/>";
        _removedItems pushBack _item;
        true
    } else {
        false
    };
};

{ if (_x call _attachmentCheck) then { player removePrimaryWeaponItem _x; } } forEach (primaryWeaponItems player);
{ if (_x call _attachmentCheck) then { player removeSecondaryWeaponItem _x; } } forEach (secondaryWeaponItems player);
{ if (_x call _attachmentCheck) then { player removeHandgunItem _x; } } forEach (handgunItems player);

// Gear check
private _gearCheck = {
    params ["_item", "_configPath", "_removeFunc"];
    
    if ((_item != "") && {!(_item in _allowedItemsArray)}) then {
        private _displayName = getText (_configPath >> _item >> "displayName");
        _removedString = _removedString + _displayName + "<br/>";
        _removedItems pushBack _item;
        call _removeFunc;
    };
};

[headgear player, configFile >> "CfgWeapons", { removeHeadgear player }] call _gearCheck;
[uniform player, configFile >> "CfgWeapons", { removeUniform player }] call _gearCheck;
[vest player, configFile >> "CfgWeapons", { removeVest player }] call _gearCheck;

// Backpack check
private _backpack = backpack player;
if ((_backpack != "") && {!(_backpack in _allowedBackpacksArray)}) then {
    // Special handling for TFAR radios and allowed pickup backpacks
    if ((_backpack find "TFAR" == -1) && {!([_backpack, InA_AllowedPickup_Backpacks] call _fnc_checkClass)}) then {
        private _displayName = getText (configFile >> "CfgVehicles" >> _backpack >> "displayName");
        _removedString = _removedString + _displayName + "<br/>";
        _removedItems pushBack _backpack;
        removeBackpack player;
    };
};

// Assigned items and inventory
{
    if ((_x != "") && {!(_x in _weaponList) && {_x find "TFAR" == -1}}) then {
        private _displayName = getText (configFile >> "CfgWeapons" >> _x >> "displayName");
        _removedString = _removedString + _displayName + "<br/>";
        _removedItems pushBack _x;
        player unassignItem _x;
        player removeItem _x;
    };
} forEach (assignedItems player + items player);

// Display removal message if needed
if (count _removedItems > 0) then {
    _removedString = _removedString + "<br/>Play a different role if you want to use it.";
    hint parseText format ['%1', _removedString];
};