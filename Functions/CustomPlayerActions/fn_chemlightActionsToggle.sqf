if (profileNamespace getVariable ["InA_EnableChemlightActions", false]) then {
    profileNamespace setVariable ["InA_EnableChemlightActions", false];
    saveProfileNamespace;
    InA_ChemlightActionsEnabled = false;
    systemChat "Chemlight actions DISABLED ....";
} else {
    profileNamespace setVariable ["InA_EnableChemlightActions", true];
    saveProfileNamespace;
    InA_ChemlightActionsEnabled = true;
    systemChat "Chemlight actions ENABLED ....";
};
