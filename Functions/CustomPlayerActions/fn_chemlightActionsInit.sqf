[] spawn {
    // Get action preference from profile
    InA_ChemlightActionsEnabled = profileNamespace getVariable ["InA_EnableChemlightActions", false];

    // Add attach actions
    call AW_fnc_chemlightActions;

    // Killed and Respawn EH to clean up any attached item(s)
    player addEventHandler ["Killed", {
        params [
            "_unit",
            "_killer",
            "_instigator",
            "_useEffects"
        ];

        [_unit] call AW_fnc_chemlightActionsCleanup;
    }];

    player addEventHandler ["Respawn", {
       params [
            "_unit",
            "_corpse"
        ];

        [_corpse] call AW_fnc_chemlightActionsCleanup;
    }];
};
