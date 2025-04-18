/*
 * Author: Whigital
 * Description:
 * Initializes Arsenal
 *
 */

if (!hasInterface) exitWith {};

if (isNil "InA_PlayerFaction") then {
    waitUntil {
        sleep 0.1;
        (!isNil "InA_PlayerFaction")
    };
};

// Only run full initialization on first load
if (isNil "InA_ArsenalDefinitionsInitialized") then {
    execVM (format ["Scripts\defines\ArsenalDefines_%1.sqf", InA_PlayerFaction]);
    waitUntil {
        sleep 0.1;
        (!isNil "InA_ArsenalDefinitionsInitialized" && {InA_ArsenalDefinitionsInitialized})
    };
    
    // Precompile all role restrictions
    execVM "Scripts\arsenal\ArsenalRoleprecompile.sqf";
};

// Set up event handlers
player addEventHandler ["InventoryClosed", {
    0 = [] spawn AW_fnc_cleanInventory;
    0 = [] spawn AW_fnc_inventoryInformation;
}];

player addEventHandler ["Take", {
    0 = [] spawn AW_fnc_cleanInventory;
    0 = [] spawn AW_fnc_inventoryInformation;
}];

private _openEH = ["ace_arsenal_displayOpened", {
    [true] call AW_fnc_cleanInventory;
}] call CBA_fnc_addEventHandler;

private _closeEH = ["ace_arsenal_displayClosed", {   
    [player] call AW_fnc_persistentLoadoutSet;
    AW_savedLoadout = getUnitLoadout player;
    missionNamespace setVariable ["InA_PlayerLoadout", (getUnitLoadout player)];
    
    [true] call AW_fnc_cleanInventory;
    0 = [] spawn AW_fnc_inventoryInformation;

    // TFAR radio handling
    if (!isNil "TFAR_core") then {
        call {
            if (call TFAR_fnc_haveSWRadio) exitWith { call RYK_fnc_TFAR_SR };
            if (call TFAR_fnc_haveLRRadio) exitWith { call RYK_fnc_TFAR_LR };
        };
    };

    ["ace_arsenal_displayClosed", _thisEventHandler] call CBA_fnc_removeEventHandler;
}] call CBA_fnc_addEventHandler;

// Run initial restrictions
[] execVM "Scripts\arsenal\ArsenalRoleRestrictions.sqf";