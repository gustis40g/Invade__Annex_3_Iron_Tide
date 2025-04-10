/*
 * Author: Whigital
 *
 * Description: Generates lists of allowed items for the players role,
 * used to populate Arsenal and to clear the invenory of unwanted
 * items (AW_fnc_cleanInventory).
 *
 * Params:
 * None
 *
 *
 */

// Make sure to only run once ....
if (!isNil "InA_ArsenalRestrictionsInitialized") exitWith {};

InA_ArsenalRestrictionsInitialized = false;

// Wait for InA_ArsenalDefinitionsInitialized to be initialized ....
waitUntil {sleep 0.1; !isNil "InA_ArsenalDefinitionsInitialized" && {InA_ArsenalDefinitionsInitialized}};

private _roleDesc = (roleDescription player);

// TFAR Loaded ?
private _isTFARloaded = (isClass (configFile >> "CfgPatches" >> "task_force_radio"));

// Get role attributes
private _isSquadLeader = ((_roleDesc find "Squad Leader") != -1);
private _isTeamLeader = ((_roleDesc find "Team Leader") !=-1);
private _isLeader = (_isSquadLeader || _isTeamLeader);

private _isMedic = (player getUnitTrait "medic");

private _isGrenadier = ((_roleDesc find "Grenadier") != -1);
private _isAutorifleman = ((_roleDesc find "Autorifleman") != -1);
private _isMarksman = ((_roleDesc find "Marksman") != -1);

private _isLightAT = ((_roleDesc find "LAT") != -1);
private _isMissileSpec = (((_roleDesc find "AT") != -1) && ((_roleDesc find "LAT") == -1));

private _isEngineer = (player getUnitTrait "engineer");
private _isDemo = (player getUnitTrait "explosiveSpecialist");

private _isJTAC = ((_roleDesc find "JTAC") != -1);
private _isRecon = ((_roleDesc find "Recon") != -1) || ((_roleDesc find "MACV-SOG") != -1);
private _isSniper = (((_roleDesc find "Sniper") != -1) && ((_roleDesc find "Spotter") == -1));
private _isSpotter = ((_roleDesc find "Spotter") != -1);

private _isFSG = ((_roleDesc find "FSG Gunner") != -1);
private _isUAVop = (player getUnitTrait "UAVHacker");
private _isPilot = ((_roleDesc find "Pilot") != -1);


// Build weapon/mag/item arrays from ArsenalDefinitions ....
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


// Init pickup array for future use ....
private _allowedWeaponPickupArray = +InA_AllowedPickup_Rifles;

// Main block to build list of Arsenal content ....
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
            InA_AllowedArsenal_facewearMedic //+
            // InA_AllowedArsenal_medicItems
        );

        _allowedBackpacksArray append InA_AllowedArsenal_backpackMedic;
    };

    // Autorifleman
    case _isAutorifleman: {
        _allowedWeaponsArray = (
            InA_AllowedArsenal_generalPistols +
            InA_AllowedArsenal_Machineguns
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


// Give Recon their shpechal gear
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


// Give access TFAR backpacks based on role ....
if (_isTFARloaded && {_isSquadLeader || _isSpotter || _isSniper || _isUAVop || _isPilot || _isJTAC}) then {
    _allowedBackpacksArray append InA_AllowedArsenal_tfarBackPacks;
};


// Store arrays in global var for future use ....
InA_ArsenalWhitelistArray = [
    _allowedItemsArray,
    _allowedWeaponsArray,
    _allowedBackpacksArray,
    _allowedMagazinesArray,
    _allowedWeaponPickupArray
];

// ArsenalRestrictions initialized ....
InA_ArsenalRestrictionsInitialized = true;
