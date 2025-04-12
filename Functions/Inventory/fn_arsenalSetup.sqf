/*
 * Author: Whigital, reworked by Gustis40g to work with ACE arsenal.
 * Description:
 * Adds arsenal with restrictions and add scroll wheel actions on the arsenals.
 *
 */

params [
    ["_arsenal", objNull],
    ["_full", false],
    ["_baseArsenal", false],
    ["_base", nil]
];

if (!hasInterface) exitWith {};
if (isNull _arsenal) exitWith {};

waitUntil {sleep 0.1; !isNil "InA_ArsenalRestrictionsInitialized" && {InA_ArsenalRestrictionsInitialized}};

_arsenal lockInventory true;

// ACE Arsenal setup
private _condition = {true}; // Default condition - can be modified if needed
private _onOpen = {
    params ["_container"];
    // Clean inventory BEFORE opening (matches 'arsenalPreOpen')
    [true] call AW_fnc_cleanInventory;
};

private _onClose = {
    params ["_container"];
    // Save loadout persistently (matches 'arsenalClosed')
    [player] call AW_fnc_persistentLoadoutSet;
    // Update global loadout variable
    missionNamespace setVariable ["InA_PlayerLoadout", (getUnitLoadout player)];
    // Clean inventory AFTER closing
    [true] call AW_fnc_cleanInventory;
    // Update inventory info
    [] spawn AW_fnc_inventoryInformation;
    
    // Handle TFAR radios (if present)
    if (!isNil "TFAR_core") then {
        if (call TFAR_fnc_haveSWRadio) then { call RYK_fnc_TFAR_SR; };
        if (call TFAR_fnc_haveLRRadio) then { call RYK_fnc_TFAR_LR; };
    };
};

// Initialize ACE Arsenal box (for ACE interact)
if (!_full) then {
    private _allowedItemsArray = (InA_ArsenalWhitelistArray # 0);
    private _allowedWeaponsArray = (InA_ArsenalWhitelistArray # 1);
    private _allowedBackpacksArray = (InA_ArsenalWhitelistArray # 2);
    private _allowedMagazinesArray = (InA_ArsenalWhitelistArray # 3);
    
    // Create ACE Arsenal with restricted items
    [_arsenal, _allowedWeaponsArray + _allowedItemsArray + _allowedBackpacksArray + _allowedMagazinesArray, _condition, _onOpen, _onClose] call ace_arsenal_fnc_initBox;
} else {
    // Full arsenal
    [_arsenal, true, _condition, _onOpen, _onClose] call ace_arsenal_fnc_initBox;
};

// Add scroll wheel action to open ACE arsenal
_arsenal addAction [
    format ["<t color='#00dd00' size='1.1' font='PuristaBold'><img size='1.1' image='\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\rearm_ca.paa' /> %1</t>", (localize "STR_A3_Arsenal")], 
    {
        params ["_target", "_caller", "_actionId", "_arguments"];
        _arguments params [["_fullArsenal", false]];
        
        if (!_fullArsenal) then {
            private _allowedItemsArray = (InA_ArsenalWhitelistArray # 0);
            private _allowedWeaponsArray = (InA_ArsenalWhitelistArray # 1);
            private _allowedBackpacksArray = (InA_ArsenalWhitelistArray # 2);
            private _allowedMagazinesArray = (InA_ArsenalWhitelistArray # 3);
            
            [_target, _allowedWeaponsArray + _allowedItemsArray + _allowedBackpacksArray + _allowedMagazinesArray] call ace_arsenal_fnc_addVirtualItems;    
            [_target, _caller] call ace_arsenal_fnc_openBox;
        } else {
            [_target, _caller, true] call ace_arsenal_fnc_openBox;
        };
    },
    [_full],
    9,
    true,
    true,
    "",
    "true",
    5
];

_arsenal addAction [
    "<t color='#0044ff' size='1.1' font='PuristaBold'><img size='1.1' image='\a3\ui_f\data\IGUI\Cfg\Actions\bandage_ca.paa' /> Heal</t>", {
        params ["_target", "_caller", "_actionId", "_arguments"];
        _caller playMove "AinvPknlMstpSlayWrflDnon_medic";
        _caller setDamage 0;
    },
    nil,
    8,
    true,
    true,
    "",
    (toString {
        (isNull (objectParent _this)) && {
            (!(_this getVariable ["derp_revive_isCarrying", false]) || !(_this getVariable ["derp_revive_isDragging", false])) && {
                ((((getAllHitPointsDamage _this) # 2) findIf {_x > 0}) != -1)
            }
        }
    }),
    5
];

_arsenal addAction [
    "<t color='#44ff44' size='1.1' font='PuristaMedium'><img size='1.1' image='\a3\ui_f\data\IGUI\Cfg\Actions\reammo_ca.paa' /> Load saved loadout</t>",
    {
        params ["_target", "_caller", "_actionId", "_arguments"];
        private _loadout = (missionNamespace getVariable "InA_PlayerLoadout");
        _caller setUnitLoadout _loadout;
    },
    nil,
    5,
    false,
    true,
    "",
    (toString {
        (isNull (objectParent _this)) && {!isNil {missionNamespace getVariable "InA_PlayerLoadout"}}
    }),
    5
];

_arsenal addAction [
    "<t color='#0088ff' size='1.1' font='PuristaMedium'><img size='1.1' image='\a3\ui_f\data\IGUI\Cfg\IslandMap\iconCamera_ca.paa' /> View Distance Settings</t>",
    {
        [] spawn CHVD_fnc_openDialog;
    },
    nil,
    4,
    false,
    true,
    "",
    "",
    5
];

_arsenal addAction [
    "<t color='#0044ff' size='1.1' font='PuristaBold'><img size='1.1' image='\a3\ui_f\data\igui\cfg\simpletasks\types\takeoff_ca.paa' />Parachute Jump</t>",
    { [] spawn AW_fnc_doParachuteJump; },
    nil,
    10,
    true,
    true,
    "",
    (toString {(isNull (objectParent _this))}),
    5
];

if (_baseArsenal && {!isNil "_base"}) then {
    [_arsenal, _base] call AW_fnc_baseTeleportSetup;
};