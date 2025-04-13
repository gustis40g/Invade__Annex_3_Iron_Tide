/*
 * Author: Gustis40g
 *
 * Description: Applies precompiled arsenal restrictions based on player role
 *
 */

if (!hasInterface) exitWith {};

// Wait for definitions to be loaded
waitUntil {sleep 0.1; !isNil "InA_ArsenalDefinitionsInitialized" && {InA_ArsenalDefinitionsInitialized}};

private _isTFARloaded = (isClass (configFile >> "CfgPatches" >> "task_force_radio"));

// Create a namespace to store all precompiled whitelists
InA_PrecompiledArsenalWhitelists = createHashMap;

// Define all roles
private _roles = [
    "sl", "tl", "rtl",          // Leaders
    "medic", "rmedic",          // Medics
    "grenadier",                // Grenadier
    "ar",                       // Autorifleman
    "marksman", "rmarksman",    // Marksmen
    "lat",                      // Light AT
    "hat", "rhat",              // Missile Specialists
    "repair", "engineer",       // Engineers
    "exp", "rexp",              // Demolition
    "rjtac",                    // JTAC
    "sniper", "spotter",        // Snipers
    "mortar",                   // FSG
    "uav",                      // UAV Operator
    "pilot",                    // Pilot
    "rifleman"                  // Default role
];

{
    private _role = _x;
    
    // Get role attributes
    private _isSquadLeader = (_role == "sl");
    private _isTeamLeader = (_role in ["tl", "rtl"]); 
    private _isLeader = (_isSquadLeader || _isTeamLeader);
    private _isMedic = (_role in ["medic", "rmedic"]); 
    private _isGrenadier = (_role == "grenadier");
    private _isAutorifleman = (_role == "ar");
    private _isMarksman = (_role in ["marksman", "rmarksman"]); 
    private _isLightAT = (_role == "lat");
    private _isMissileSpec = (_role in ["hat", "rhat"]); 
    private _isEngineer = (_role in ["repair", "engineer"]);
    private _isDemo = (_role in ["exp", "rexp", "engineer"]); 
    private _isJTAC = (_role == "rjtac");
    private _isRecon = (_role in ["rtl", "rmedic", "rjtac", "rmarksman", "rhat", "rexp"]); 
    private _isSniper = (_role == "sniper");
    private _isSpotter = (_role == "spotter");
    private _isFSG = (_role == "mortar");
    private _isUAVop = (_role == "uav");
    private _isPilot = (_role == "pilot");

    // Start with general items
    private _allowedItemsArray = (
        InA_AllowedArsenal_generalItems +
        InA_AllowedArsenal_generalMagazines +
        InA_AllowedArsenal_generalFacewear +
        InA_AllowedArsenal_generalHeadgear +
        InA_AllowedArsenal_generalHelmets +
        InA_AllowedArsenal_generalUniforms +
        InA_AllowedArsenal_generalVests
    );

    private _allowedWeaponsArray = (
        InA_AllowedArsenal_generalPistols +
        InA_AllowedArsenal_generalSMGs +
        InA_AllowedArsenal_generalCarbines +
        InA_AllowedArsenal_generalAssaultRifles +
        InA_AllowedArsenal_underWaterGun
    );

    private _allowedBackpacksArray = (
        InA_AllowedArsenal_generalBackpacks +
        InA_AllowedArsenal_backpackDrones +
        InA_AllowedArsenal_backpackStatics
    );

    private _allowedMagazinesArray = +InA_AllowedArsenal_generalMagazines;
    private _allowedWeaponPickupArray = +InA_AllowedPickup_Rifles;

    // Apply role-specific additions
    switch (true) do {
        // Squad/Team Leader
        case _isLeader: {
            _allowedWeaponsArray append (
                InA_AllowedArsenal_launchersLight +
                InA_AllowedArsenal_assaultRiflesUGL
            );

            if (_isSquadLeader) then {
                _allowedItemsArray append (
                    InA_AllowedArsenal_uniformsOfficer +
                    InA_AllowedArsenal_heagearOfficer
                );
                _allowedBackpacksArray append InA_AllowedArsenal_backpacksRadio;
            };
        };

        // Medic
        case _isMedic: {
            _allowedItemsArray append (
                InA_AllowedArsenal_uniformsMedic +
                InA_AllowedArsenal_vestsMedic +
                InA_AllowedArsenal_facewearMedic
            );
            _allowedBackpacksArray append InA_AllowedArsenal_backpackMedic;
        };

        // Autorifleman
        case _isAutorifleman: {
            _allowedWeaponsArray = (
                InA_AllowedArsenal_generalPistols +
                InA_AllowedArsenal_Machineguns +
                InA_AllowedArsenal_MGmags
            );
        };

        // Light AT
        case _isLightAT: {
            _allowedWeaponsArray append InA_AllowedArsenal_launchersLight;
            _allowedWeaponPickupArray append InA_AllowedPickup_Launchers;
        };

        // Grenadier
        case _isGrenadier: {
            _allowedWeaponsArray = (
                InA_AllowedArsenal_generalPistols +
                InA_AllowedArsenal_assaultRiflesUGL
            );
        };

        // Marksman
        case _isMarksman: {
            _allowedItemsArray append (
                InA_AllowedArsenal_opticsMarksman +
                InA_AllowedArsenal_uniformsMarksman
            );
            _allowedWeaponsArray = (
                InA_AllowedArsenal_generalPistols +
                InA_AllowedArsenal_marksmanRifles
            );
        };

        // Missile Spec.
        case _isMissileSpec: {
            _allowedWeaponsArray append (
                InA_AllowedArsenal_launchersLight +
                InA_AllowedArsenal_launchersHeavy
            );
            _allowedWeaponPickupArray append InA_AllowedPickup_Launchers;
        };

        // Spotter
        case _isSpotter: {
            _allowedItemsArray append (
                InA_AllowedArsenal_uniformsMarksman +
                InA_AllowedArsenal_uniformsSniper
            );
            _allowedBackpacksArray append InA_AllowedArsenal_backpacksRadio;
            _allowedWeaponsArray = (
                InA_AllowedArsenal_generalPistols +
                InA_AllowedArsenal_generalAssaultRifles +
                InA_AllowedArsenal_assaultRiflesUGL
            );
        };

        // Sniper
        case _isSniper: {
            _allowedItemsArray append (
                InA_AllowedArsenal_opticsMarksman +
                InA_AllowedArsenal_opticsSniper +
                InA_AllowedArsenal_uniformsMarksman +
                InA_AllowedArsenal_uniformsSniper
            );
            _allowedBackpacksArray append InA_AllowedArsenal_backpacksRadio;
            _allowedWeaponsArray = (
                InA_AllowedArsenal_generalPistols +
                InA_AllowedArsenal_sniperRifles
            );
        };

        // FSG
        case _isFSG: {
            _allowedWeaponsArray = (
                InA_AllowedArsenal_generalPistols +
                InA_AllowedArsenal_generalSMGs +
                InA_AllowedArsenal_generalCarbines
            );
        };

        // JTAC
        case _isJTAC: {
            _allowedWeaponsArray append InA_AllowedArsenal_assaultRiflesUGL;
            _allowedBackpacksArray append InA_AllowedArsenal_backpacksRadio;
        };

        // UAV Op
        case _isUAVop: {
            _allowedItemsArray append InA_AllowedArsenal_uavItems;
            _allowedBackpacksArray append InA_AllowedArsenal_backpacksRadio;
            _allowedWeaponsArray = (
                InA_AllowedArsenal_generalPistols +
                InA_AllowedArsenal_generalSMGs +
                InA_AllowedArsenal_generalCarbines +
                InA_AllowedArsenal_generalAssaultRifles
            );
        };

        // Pilot
        case _isPilot: {
            _allowedItemsArray = (
                InA_AllowedArsenal_generalItems +
                InA_AllowedArsenal_generalMagazines +
                InA_AllowedArsenal_generalFacewear +
                InA_AllowedArsenal_headgearPilot +
                InA_AllowedArsenal_uniformsPilot +
                InA_AllowedArsenal_vestsPilot
            );
            _allowedBackpacksArray append InA_AllowedArsenal_backpacksRadio;
            _allowedWeaponsArray = (
                InA_AllowedArsenal_generalPistols +
                InA_AllowedArsenal_generalSMGs +
                InA_AllowedArsenal_pilotCarbines
            );
        };
    };

    // Recon additions
    if (_isRecon) then {
        _allowedItemsArray append (
            InA_AllowedArsenal_reconItems +
            InA_AllowedArsenal_opticsRecon
        );
        _allowedWeaponsArray append InA_AllowedArsenal_reconRifles;
    };

    // Engineer/Repair Spec. vests and helmets
    if (_isEngineer && {!_isDemo}) then {
        _allowedItemsArray append (
            InA_AllowedArsenal_headgearEngineer +
            InA_AllowedArsenal_vestsEngineer +
            InA_AllowedArsenal_uniformsEngineer
        );
    };

    // EOD / Explosive Specs.
    if (_isDemo) then {
        _allowedItemsArray append InA_AllowedArsenal_vestsEOD;
        _allowedMagazinesArray append InA_AllowedArsenal_Explosives;
    };

    // TFAR backpacks
    if (_isTFARloaded && {_isSquadLeader || _isSpotter || _isSniper || _isUAVop || _isPilot || _isJTAC}) then {
        _allowedBackpacksArray append InA_AllowedArsenal_tfarBackPacks;
    };

    // Store in hashmap
    InA_PrecompiledArsenalWhitelists set [_role, [
        _allowedItemsArray,
        _allowedWeaponsArray,
        _allowedBackpacksArray,
        _allowedMagazinesArray,
        _allowedWeaponPickupArray
    ]];
} forEach _roles;

// Set default rifleman whitelist as fallback
InA_DefaultArsenalWhitelist = InA_PrecompiledArsenalWhitelists getOrDefault ["rifleman", [
    InA_AllowedArsenal_generalItems + InA_AllowedArsenal_generalMagazines + InA_AllowedArsenal_generalFacewear + InA_AllowedArsenal_generalHeadgear + InA_AllowedArsenal_generalHelmets + InA_AllowedArsenal_generalUniforms + InA_AllowedArsenal_generalVests,
    InA_AllowedArsenal_generalPistols + InA_AllowedArsenal_generalSMGs + InA_AllowedArsenal_generalCarbines + InA_AllowedArsenal_generalAssaultRifles + InA_AllowedArsenal_underWaterGun,
    InA_AllowedArsenal_generalBackpacks + InA_AllowedArsenal_backpackDrones + InA_AllowedArsenal_backpackStatics,
    InA_AllowedArsenal_generalMagazines,
    InA_AllowedPickup_Rifles
]];