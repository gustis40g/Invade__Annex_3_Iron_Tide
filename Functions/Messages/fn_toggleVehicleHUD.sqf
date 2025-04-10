if (!hasInterface) exitWith {};

if (isNil "InA_ExtendedVehicleHudHandle") then {
    InA_ExtendedVehicleHudHandle = execVM "scripts\vehicle\crew\crew.sqf";
    systemChat "Extended passenger information HUD on.";
    profileNamespace setVariable ["InA_ExtendedVehicleHud_Enabled", true];
    saveProfileNamespace;
} else {
    terminate InA_ExtendedVehicleHudHandle;
    InA_ExtendedVehicleHudHandle = nil;
    disableSerialization;
    1000 cutRsc ["HudNames", "PLAIN"];
    _ui = uiNamespace getVariable "HudNames";
    _HudNames = _ui displayCtrl 99999;
    _HudNames ctrlSetStructuredText parseText "";
    _HudNames ctrlCommit 0;
    systemChat "Extended passenger information HUD off.";
    profileNamespace setVariable ["InA_ExtendedVehicleHud_Enabled", nil];
    saveProfileNamespace;
};
