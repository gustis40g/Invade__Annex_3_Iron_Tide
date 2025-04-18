/*
 * Author: Whigital, reworked by Gustis40g to work with ACE arsenal.
 * Description:
 * Adds arsenal and adds scroll wheel actions on the arsenals.
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

// Wait for precompiled lists to be ready (with timeout)
private _startTime = diag_tickTime;
private _timeout = 30; // seconds
waitUntil {
    sleep 0.1;
    (!isNil "InA_PrecompiledArsenalWhitelists" && {!isNil "InA_DefaultArsenalWhitelist"}) || 
    (diag_tickTime - _startTime > _timeout)
};

if (diag_tickTime - _startTime > _timeout) then {
    diag_log "[ARSENAL] Error: Failed to load precompiled whitelists within timeout";
    [_arsenal, true] call ace_arsenal_fnc_initBox; // Fallback to full arsenal
} else {
    _arsenal lockInventory true;

    if (!_full) then {
        // Get current player role or default to rifleman
        private _role = player getVariable ["AW_role", "rifleman"];
        private _whitelist = InA_PrecompiledArsenalWhitelists getOrDefault [_role, InA_DefaultArsenalWhitelist];
        
        // Combine allowed items from the whitelist
        private _allowedItems = (_whitelist # 0) +  // Items
                              (_whitelist # 1) +  // Weapons
                              (_whitelist # 2) +  // Backpacks
                              (_whitelist # 3);   // Magazines
        
        // Initialize arsenal box with restricted items
        [_arsenal, _allowedItems, false] call ace_arsenal_fnc_initBox;
    } else {
        // Full arsenal (for admins/zeus)
        [_arsenal, true, false] call ace_arsenal_fnc_initBox;
    };
};

// Add action with dynamic whitelist
_arsenal addAction [
    format ["<t color='#00dd00' size='1.1' font='PuristaBold'><img size='1.1' image='\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\rearm_ca.paa' /> %1</t>", (localize "STR_A3_Arsenal")], 
    {
        params ["_target", "_caller", "_actionId", "_arguments"];
        _arguments params [["_fullArsenal", false]];
        
        if (!_fullArsenal) then {
            // Wait for precompiled lists if somehow not ready yet
            waitUntil {sleep 0.1; !isNil "InA_PrecompiledArsenalWhitelists" && {!isNil "InA_DefaultArsenalWhitelist"}};
            
            private _role = _caller getVariable ["AW_role", "rifleman"];
            private _whitelist = InA_PrecompiledArsenalWhitelists getOrDefault [_role, InA_DefaultArsenalWhitelist];
            
            // Clear existing virtual items
            [_target, true] call ace_arsenal_fnc_removeVirtualItems;
            
            // Combine allowed items
            private _allowedItems = (_whitelist # 0) +  // Items
                                  (_whitelist # 1) +  // Weapons
                                  (_whitelist # 2) +  // Backpacks
                                  (_whitelist # 3);   // Magazines
            
            // Update arsenal contents
            [_target, _allowedItems] call ace_arsenal_fnc_addVirtualItems;
            [_target, _caller, false] call ace_arsenal_fnc_openBox;
        } else {
            // Full arsenal access
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
        private _loadout = (missionNamespace getVariable "AW_savedLoadout");
        _caller setUnitLoadout _loadout;
    },
    nil,
    5,
    false,
    true,
    "",
    (toString {
        (isNull (objectParent _this)) && {!isNil {missionNamespace getVariable "AW_savedLoadout"}}
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