// initplayerlocal, does stuff when the player spawns

// Make sure player is initialized
waitUntil {!isNull player};

// We don't want anything but real players here
if (!hasInterface) exitWith {
    if ((typeOf player) == "HeadlessClient_F") then {
        ["InA_Event_HeadlessClientConnected", player] remoteExecCall ["AW_fnc_eventTrigger", 2];
    };
};

cutText ["", "BLACK"];

// AO and Base variables
if (isNil "InA_Client_controlledZones") then {
    InA_Client_controlledZones = [];
};

if (isNil "InA_Client_BaseArray") then {
    InA_Client_BaseArray = [];
};

if (isNil "InA_Client_SideMissionUp") then {
    InA_Client_SideMissionUp = false;
};

if (isNil "InA_Client_currentAO") then {
    InA_Client_currentAO = "BASE";
};

private _marker = createMarkerLocal ["spawn_marker", [99999,99999,0]];
_marker setMarkerColorLocal "ColorGreen";
_marker setMarkerTypeLocal "mil_end";

// Disable chatter
player disableConversation true;

// Local checks
0 = execVM "scripts\misc\localChecks.sqf";

// Player TK counters
amountOfTKs = 0;
TKLimit = 3;
player setVariable ["timeTKd", (round time), false];

// Weapon sway
InA_Client_AimingCoefSetting = (["PlayerAimingCoefSetting", -1] call BIS_fnc_getParamValue);

if (InA_Client_AimingCoefSetting != -1) then {
    InA_Client_AimingCoef = ((([(["PlayerAimingCoef", 100] call BIS_fnc_getParamValue), (profileNamespace getVariable ["InA_Client_AimingCoefPct", 100])] select InA_Client_AimingCoefSetting) max 25) / 100);

    // Don't try and cheat the limits by setting the variable lower
    InA_Client_AimingCoef = (InA_Client_AimingCoef max 0.25);
} else {
    InA_Client_AimingCoef = 1;
};

player setCustomAimCoef InA_Client_AimingCoef;
profileNamespace setVariable ["InA_Client_AimingCoefPct", (InA_Client_AimingCoef * 100)];
saveProfileNamespace;


// Player settings menu EH
[] spawn {
    waitUntil {sleep 1; !isNull (findDisplay 46)};

    (findDisplay 46) displayAddEventHandler ["KeyDown", {
        params ["_ctrl", "_key", "_shift", "_ctrl", "_alt"];

        if ((inputAction "User20") > 0) then {
            if (isNull (findDisplay 13371)) then {
                0 = [] spawn AW_fnc_playerSettings_openSettings;
            };
        };
    }];
};


// Extended passenger information hud
0 = [] spawn {
    if (profileNamespace getVariable ["InA_ExtendedVehicleHud_Enabled", false]) then {
        InA_ExtendedVehicleHudHandle = [] execVM "scripts\vehicle\crew\crew.sqf";
    };
};


// Action filtering
inGameUISetEventHandler ["Action", (toString {
    params ["_target", "_caller", "_index", "_engineName", "_text", "_priority", "_showWindow", "_hideOnUse", "_shortcut", "_visibleMenu", "_eventName"];

    private _override = false;

    switch (true) do {

        case (_engineName == "UAVTerminalHackConnection"): {
            if !(_target getVariable ["InA_UAV_CanBeHacked", false]) then {
                _override = true;

                showCommandingMenu "RscGroupRootMenu";
                showCommandingMenu "";

                systemChat "This drone/turret cannot be hacked ....";
            };
        };
    };

    _override
})];

// Player safe zone EHs
0 = [] spawn {
    waitUntil {sleep 0.5; !isNil "InA_Client_BaseArray"};
    player addEventHandler ["FiredMan", {
        params ["_unit", "_weapon", "", "", "", "_mag", "_projectile"];
        private _pos = getPos _projectile;

        private _baseIndex = (InA_Client_BaseArray findIf {_pos distance (getMarkerPos _x) < 1000});

        if (_baseIndex == -1) exitWith {};
        if (_weapon find "CMFlareLauncher" != -1) exitWith {};
        private _base = InA_Client_BaseArray select _baseIndex;

        if ((_pos distance (getMarkerPos _base)) < 300) exitWith {
            if (player getVariable ["InA_isZeus", false]) exitWith { hint "You are shooting in base. Be careful when doing this. Don't abuse it!"; };

            _projectile call AW_fnc_delete;
            hintC format ["%1, don't goof at base. Don't throw, fire or place anything inside the base.", name _unit];
        };

        [_projectile, getMarkerPos _base] spawn {
            if (player getVariable ["InA_isZeus", false]) exitWith {};
            params ["_proj", "_markerPos"];
            private _dist = _proj distance _markerPos;
            private _initialDist =  _dist;
            while {alive _proj} do {
                sleep 0.2;
                _dist = _proj distance _markerPos;
                if (_dist < 300) exitWith { _proj call AW_fnc_delete; };
                if ((_dist - _initialDist) > 1000) exitWith {};
            };
        };

        private _GLs  = [
            "1Rnd_Smoke_Grenade_shell",
            "1Rnd_SmokeRed_Grenade_shell",
            "1Rnd_SmokeGreen_Grenade_shell",
            "1Rnd_SmokeYellow_Grenade_shell",
            "1Rnd_SmokePurple_Grenade_shell",
            "1Rnd_SmokeBlue_Grenade_shell",
            "1Rnd_SmokeOrange_Grenade_shell",
            "3Rnd_Smoke_Grenade_shell",
            "3Rnd_SmokeRed_Grenade_shell",
            "3Rnd_SmokeGreen_Grenade_shell",
            "3Rnd_SmokeYellow_Grenade_shell",
            "3Rnd_SmokePurple_Grenade_shell",
            "3Rnd_SmokeBlue_Grenade_shell",
            "3Rnd_SmokeOrange_Grenade_shell",
            "UK3CB_BAF_1Rnd_SmokeBlue_Grenade_shell",
            "UK3CB_BAF_1Rnd_SmokeGreen_Grenade_shell",
            "UK3CB_BAF_1Rnd_SmokeOrange_Grenade_shell",
            "UK3CB_BAF_1Rnd_SmokePurple_Grenade_shell",
            "UK3CB_BAF_1Rnd_SmokeRed_Grenade_shell",
            "UK3CB_BAF_1Rnd_Smoke_Grenade_shell",
            "UK3CB_BAF_1Rnd_SmokeYellow_Grenade_shell",
            "rhs_mag_M583A1_white",
            "rhs_mag_M585_white_cluster",
            "rhs_mag_m661_green",
            "rhs_mag_m662_red",
            "rhs_mag_m713_Red",
            "rhs_mag_m714_White",
            "rhs_mag_m715_Green",
            "rhs_mag_m716_yellow",
            "rhsusf_mag_6Rnd_M583A1_white",
            "rhsusf_mag_6Rnd_m661_green",
            "rhsusf_mag_6Rnd_m662_red",
            "rhsusf_mag_6Rnd_M713_red",
            "rhsusf_mag_6Rnd_M714_white",
            "rhsusf_mag_6Rnd_M715_green",
            "rhsusf_mag_6Rnd_M716_yellow",
            "rhs_GDM40",
            "rhs_GRD40_Green",
            "rhs_GRD40_Red",
            "rhs_GRD40_White"
        ];

        if (_mag in _GLs) then {
            [_projectile] spawn {
                params ["_projectile"];

                private _vel = 999;
                waitUntil {
                    _vel = abs (velocity _projectile select 0) + abs (velocity _projectile select 1);
                    ((getPosATL _projectile) select 2) < 0.15 || _vel < 20
                };
                _projectile setVelocity [0,0,0];
            };
        };
    }];

    player addEventHandler ["WeaponAssembled", {
        params ["_unit", "_staticWeapon"];

        // Prohibit assembling static weapons near base
        if ((_staticWeapon isKindOf "StaticWeapon") && {[_unit, 300] call AW_fnc_isNearBase}) exitWith {
            hintC format ["%1, assembling static weapons near base is prohibited!", (name _unit)];
            _staticWeapon call AW_fnc_delete;
            private _msg = format ["Player %1 assembled a %2 near base", (name _unit), (typeOf _staticWeapon)];
            [_msg, "STATIC", true] call AW_fnc_log;
        };

        private _isUAV = ((typeOf _staticWeapon) in ["B_UAV_01_F", "B_UGV_02_Demining_F", "B_UGV_02_Science_F", "B_UAV_06_F", "B_UAV_06_medical_F", "B_rhsusf_B_BACKPACK"]); 

        // Prohibit deploying drones near base
        if (_isUAV && {[_unit, 50] call AW_fnc_isNearBase}) exitWith {
            hintC format ["%1, assembling UAVs near base is prohibited!", (name _unit)];
            _staticWeapon call AW_fnc_delete;
            private _msg = format ["Player %1 assembled a %2 near base", (name _unit), (typeOf _staticWeapon)];
            [_msg, "UAV", true] call AW_fnc_log;
        };

        private _type = "STATIC";
        private _action = "assembled";

        // Handle assembled UAVs
        if (_isUAV) then {
            (group (driver _staticWeapon)) setGroupIdGlobal [format ["Drone-%1", round (random 500)]];

            _staticWeapon remoteExec ["AW_fnc_vehicleCustomization", _staticWeapon];

            _type = "UAV";
            _action = "deployed";
        };

        private _msg = format ["Player %1 %2 a %3", (name _unit), _action, (typeOf _staticWeapon)];

        [_msg, _type, true] call AW_fnc_log;

        if (_staticWeapon isKindOf "StaticWeapon") then {
            _staticWeapon setVariable ["InA_isStaticWeaponPlayerAssembled", true, true];
        };

        // Add to Zeus
        [[_staticWeapon]] remoteExec ["AW_fnc_addToAllCurators", 2];

        // Add EH to clean Zeus of disassembled statics ....
        [_staticWeapon] remoteExec ["AW_fnc_disassembledWeaponEh", 2];
    }];

    player addEventHandler ["Take", {
        params ["_unit", "_container", "_item"];

        private _pos = (getPos _unit);

        if ([_unit, 300] call AW_fnc_isNearBase) then {
            if (isNull _container && {(_item in (InA_AllowedArsenal_Explosives + ["DemoCharge_Remote_Mag"]))}) then {
                [_pos, _item] spawn {
                    params ["_pos", "_mag"];

                    private _ammo = (getText (configFile >> "CfgMagazines" >> _mag >> "ammo"));
                    sleep 0.2;
                    private _explosive = (nearestObject [_pos, _ammo]);
                    _explosive call AW_fnc_delete;
                };

                hintC format ["%1, you're placing explosives near base. This will not be tolerated and it has been removed!", (name _unit)];

                private _msg = format ["Player %1 placed explosive %2 near base", (name _unit), _item];
                [_msg, "BOOM", true] call AW_fnc_log;
            };

            if (((typeOf _container) == "GroundWeaponHolder") && {((magazineCargo _container) arrayIntersect (InA_AllowedArsenal_Explosives + ["DemoCharge_Remote_Mag"])) isNotEqualTo []}) then {
                _container call AW_fnc_delete;
                systemChat format ["%1, please don't leave explosives laying around base!", (name player)];
            };
        };
    }];

    player addEventHandler ["Put", {
        params ["_unit", "_container", "_item"];

        if (([_unit, 300] call AW_fnc_isNearBase) && {((typeOf _container) == "GroundWeaponHolder") && {(_item in (InA_AllowedArsenal_Explosives + ["DemoCharge_Remote_Mag"]))}}) then {
            _container call AW_fnc_delete;
            systemChat format ["%1, you're dropping explosives near base, which is prohibited!", (name player)];
        };
    }];

    player addEventHandler ["InventoryClosed", {
        params ["_unit", "_container"];

        if ([_unit, 300] call AW_fnc_isNearBase) then {
            private _holders = (nearestObjects [player, ["GroundWeaponHolder"], 5]);

            {
                if (((magazineCargo _x) arrayIntersect (InA_AllowedArsenal_Explosives + ["DemoCharge_Remote_Mag"])) isNotEqualTo []) then {
                    _x call AW_fnc_delete;
                    systemChat format ["%1, please don't leave explosives laying around base!", (name player)];
                };
            } forEach _holders;
        };
    }];
};


// EventHandlers for seat restrictions
player addEventHandler ["GetInMan", {
    params ["_unit", "_role", "_vehicle", "_turret"];
    0 = [_unit, _vehicle] spawn AW_fnc_restrictedAircraftSeatsCheck;

    0 = [_unit, _vehicle] spawn AW_fnc_assetDisclaimer;
}];

player addEventHandler ["GetOutMan", {
    params ["_unit", "_role", "_vehicle", "_turret"];

    if (((crew _vehicle) isEqualTo []) && {(alive _vehicle) && {isEngineOn _vehicle}}) then {
        [_vehicle, false] remoteExec ["engineOn", _vehicle];
    };
}];

player addEventHandler ["SeatSwitchedMan", {
    params ["_unit1", "_unit2", "_vehicle"];
    0 = [_unit1, _vehicle] spawn AW_fnc_restrictedAircraftSeatsCheck;

    0 = [_unit1, _vehicle] spawn AW_fnc_assetDisclaimer;
}];

player addEventHandler ["Killed", {
    params ["_unit", "_killer", "_instigator", "_useEffects"];

    if (_unit getUnitTrait "UAVHacker") then {
        _unit connectTerminalToUAV objNull;
    };

    0 = [_unit] call AW_fnc_handleCorpse;
}];


// Player protection so stupid UAVs don't start shooting friendlies that did some TKing
player addEventHandler ["HandleRating", {
    params ["", "_rating"];
    private _ret = (_rating max 0);
    _ret
}];

// Arsenal
0 = execVM "Scripts\arsenal\ArsenalInit.sqf";

// BIS Dynamic Groups
["InitializePlayer", [player]] call BIS_fnc_dynamicGroups;

if ((getMissionConfigValue ["respawnOnStart", -1]) == -1) then {
    [player] remoteExec ["AW_fnc_assignZeus", 2];
    [player] call AW_fnc_welcomeTitle;

    // Add player to Zeus:
    [[player]] remoteExec ["AW_fnc_addToAllCurators", 2];

    // Fatigue settings
    if ((["Fatigue", 1] call BIS_fnc_getParamValue) == 1) then {
        player enableFatigue true;
    } else {
        player enableFatigue false;
    };
};

// TFAR
if (isClass (configFile >> "CfgPatches" >> "task_force_radio")) then {
    ["unit", {
        if (TFAR_currentUnit != (_this select 0)) then
        {	TFAR_currentUnit setVariable ["tf_controlled_unit",(_this select 0)]; }
        else
        {	TFAR_currentUnit setVariable ["tf_controlled_unit",nil]; };
    }] call CBA_fnc_addPlayerEventHandler;
};


// Chat loging for chat with special chars
0 = [] spawn {
    waitUntil {sleep 1; alive player};

    sleep 5;
    waitUntil {sleep 1; !isNull (findDisplay 46)};
    rwt_chatcom_main_eh = (findDisplay 46) displayAddEventHandler ["KeyDown", "_this call RWT_fnc_chatcomVerify"];
};

0 = execVM "scripts\misc\QS_icons.sqf";          // Icons
0 = execVM "scripts\misc\diary.sqf";             // Diary
// 0 = execVM "scripts\misc\earplugs.sqf";          // Earplugs

player addEventHandler ["GetOutMan", {
    params ["_unit", "", "_vehicle"];
    if (!(alive _unit)) exitWith {};
    if (!(_vehicle isKindOf "Air")) exitWith {};
    if (backpack player == "B_Parachute") exitWith {};
    if (((getPos player) select 2) < 3) exitWith {};
    if (backpack player == "") exitWith {
        _unit addBackpackGlobal "B_Parachute";
    };
    _this spawn {
        params ["_unit"];

        private _packinfo = (getUnitLoadout _unit) select 5;
        removeBackpackGlobal _unit;
        _unit addBackpackGlobal "B_Parachute";
        hint "You've been given a parachute.  Drop it to receive your backpack back";

        waitUntil {sleep 0.5; backpack player != "B_Parachute"};

        private _loadout = getUnitLoadout _unit;
        _loadout set [5, _packinfo];
        _unit setUnitLoadout _loadout;
        hintSilent "";
    };
}];

// Fire off joinHint
0 = [] spawn {
    sleep 20;
    call AW_fnc_joinHint;
};

// Workaround for Respawn GUI not showing up at gamestart
0 = [] spawn {
    if ((getMissionConfigValue ["respawnOnStart", -1]) < 0) exitWith {
        cutText ["", "BLACK IN", 2];
    };

    private _waitUntil = (diag_tickTime + 2);

    diag_log text format ["[I&A3][DEBUG] %1 :: Waiting until %2 for respawn menu ....", diag_tickTime, _waitUntil];

    while {!(missionNamespace getVariable ["BIS_RscRespawnControlsMap_shown", false])} do {
        sleep 0.1;

        if (diag_tickTime > _waitUntil) exitWith {
            diag_log text format ["[I&A3][DEBUG] %1 :: Timed out waiting for Respawn menu to loaded ....", diag_tickTime];
        };
    };

    if !(missionNamespace getVariable ["BIS_RscRespawnControlsMap_shown", false]) then {
        diag_log text format ["[I&A3][DEBUG] %1 :: Respawn menu failed to load ....", diag_tickTime];
        forceRespawn player;
    } else {
        diag_log text format ["[I&A3][DEBUG] %1 :: Respawn menu loaded ....", diag_tickTime];
    };

    cutText ["", "BLACK IN", 2];
};

player addEventHandler ["Respawn", AW_fnc_onRespawn];

// Add Group Menu to ACE Self-Actions
if (!isNil "ace_interact_menu_fnc_createAction") then {
    private _groupAction = [
        "AW_GroupMenu",
        "Role Selection", 
        "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\meet_ca.paa",
        { [] call AW_fnc_initGroupMenu; },
        {
            isNull objectParent player && // Not in vehicle
            {[player, 150] call AW_fnc_isNearBase} // Base proximity check
        },
        {}, // No children
        [], // No positional offset
        [0,0,0], // Default position
        5 // Priority (higher = appears earlier in menu)
    ] call ace_interact_menu_fnc_createAction;

    [player, 1, ["ACE_SelfActions"], _groupAction] call ace_interact_menu_fnc_addActionToObject;
};
waitUntil {sleep 0.1; !isNil "InA_ArsenalRestrictionsInitialized" && {InA_ArsenalRestrictionsInitialized}};

// Add Arsenal to ACE Self-Actions
if (!isNil "ace_interact_menu_fnc_createAction") then {
    private _arsenalAction = [
        "AW_Arsenal",
        "Arsenal", 
        "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\armor_ca.paa",
        {
            // Get current role or default to rifleman
            private _role = player getVariable ["AW_role", "rifleman"];
            private _whitelist = InA_PrecompiledArsenalWhitelists getOrDefault [_role, InA_DefaultArsenalWhitelist];
            
            // Combine all allowed items
            private _allowedItems = (_whitelist # 0) +  // Items
                                  (_whitelist # 1) +  // Weapons
                                  (_whitelist # 2) +  // Backpacks
                                  (_whitelist # 3);   // Magazines
            
            // Clear and add virtual items
            [player, true] call ace_arsenal_fnc_removeVirtualItems;
            [player, _allowedItems] call ace_arsenal_fnc_addVirtualItems;
            
            // Open arsenal
            [player, player, false] call ace_arsenal_fnc_openBox;
        },
        {
            isNull objectParent player && 
            {[player, 150] call AW_fnc_isNearBase}
        },
        {}, // No children
        [], // No positional offset
        [0,0,0], // Default position
        5 // Priority
    ] call ace_interact_menu_fnc_createAction;

    [player, 1, ["ACE_SelfActions"], _arsenalAction] call ace_interact_menu_fnc_addActionToObject;
};