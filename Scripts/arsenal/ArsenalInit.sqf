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

execVM (format ["Scripts\defines\ArsenalDefines_%1.sqf", InA_PlayerFaction]);
waitUntil {
    sleep 0.1;
    (!isNil "InA_ArsenalDefinitionsInitialized" && {InA_ArsenalDefinitionsInitialized})
};

execVM "Scripts\arsenal\ArsenalRoleRestrictions.sqf";
waitUntil {
    sleep 0.1;
    (!isNil "InA_ArsenalRestrictionsInitialized" && {InA_ArsenalRestrictionsInitialized})
};

[player] execVM (format ["Scripts\defines\LoadoutDefines_%1.sqf", InA_PlayerFaction]);

player addEventHandler ["InventoryClosed", {
    0 = [] spawn AW_fnc_cleanInventory;
    0 = [] spawn AW_fnc_inventoryInformation;
}];

player addEventHandler ["Take", {
    0 = [] spawn AW_fnc_cleanInventory;
    0 = [] spawn AW_fnc_inventoryInformation;
}];

// Arsenal eventhandlers
[missionNamespace, "arsenalClosed", {
    [player] call AW_fnc_persistentLoadoutSet;

    missionNamespace setVariable ["InA_PlayerLoadout", (getUnitLoadout player)];

    [true] call AW_fnc_cleanInventory;
    0 = [] spawn AW_fnc_inventoryInformation;

    if (!isNil "TFAR_core") then {
        if (call TFAR_fnc_haveSWRadio) then {
            call RYK_fnc_TFAR_SR;
        };

        if (call TFAR_fnc_haveLRRadio) then {
            call RYK_fnc_TFAR_LR;
        };
    };
}] call BIS_fnc_addScriptedEventHandler;

[missionNamespace, "arsenalPreOpen", {
    [true] call AW_fnc_cleanInventory;
}] call BIS_fnc_addScriptedEventHandler;
