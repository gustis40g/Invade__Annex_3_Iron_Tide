/*
 * Author: Whigital
 *
 * Customizes Opfor vehicle appearance based on classname
 *
 */

params [["_vehicle", objNull]];

if (isNull _vehicle) exitWith {};

_totalRandomization = {
    params [
        "_aircraft",
        ["_owner", []]
    ];

    private _allPylons = ("true" configClasses (configFile >> "CfgVehicles" >> (typeOf _aircraft) >> "Components" >> "TransportPylonsComponent" >> "pylons") apply {configName _x});
    private _pylonsArray = [];

    {
        private _magazine = (selectRandom (_aircraft getCompatiblePylonMagazines _x));

        _pylonsArray pushBack [_x, _magazine, _owner];
    } forEach _allPylons;

    [_aircraft, _pylonsArray] remoteExec ["AW_fnc_setPylonLoadout", _aircraft];
};


switch (typeOf _vehicle) do {
    // To-199 Neophron (CAS)
    case "O_Plane_CAS_02_dynamicLoadout_F": {
        private _pylons2 = [
            "PylonMissile_1Rnd_LG_scalpel", 3,
            "PylonRack_1Rnd_Missile_AGM_01_F", 3,
            "PylonRack_3Rnd_LG_scalpel", 2,
            "PylonRack_4Rnd_LG_scalpel", 1
        ];

        private _pylons3 = [
            "PylonMissile_1Rnd_LG_scalpel", 2,
            "PylonRack_20Rnd_Rocket_03_HE_F", 3,
            "PylonRack_20Rnd_Rocket_03_AP_F", 3,
            "PylonRack_19Rnd_Rocket_Skyfire", 3,
            "PylonRack_1Rnd_Missile_AGM_01_F", 2
        ];

        private _pylons4 = [
            "PylonMissile_1Rnd_LG_scalpel", 2,
            "PylonRack_20Rnd_Rocket_03_HE_F", 3,
            "PylonRack_20Rnd_Rocket_03_AP_F", 3,
            "PylonRack_19Rnd_Rocket_Skyfire", 3,
            "PylonRack_1Rnd_Missile_AGM_01_F", 2
        ];

        private _pylons5 = [
            "PylonRack_1Rnd_Missile_AGM_01_F", 1,
            "PylonMissile_1Rnd_Bomb_03_F", 3,
            "PylonMissile_1Rnd_BombCluster_02_cap_F", 2
        ];

        private _pylonsArray = [];

        _pylonsArray pushback ["Pylons1", "PylonRack_1Rnd_Missile_AA_03_F"];
        _pylonsArray pushback ["Pylons10", "PylonRack_1Rnd_Missile_AA_03_F"];

        private _pylonMag = (selectRandomWeighted _pylons2);
        _pylonsArray pushback ["Pylons2", _pylonMag];
        _pylonsArray pushback ["Pylons9", _pylonMag];

        _pylonMag = (selectRandomWeighted _pylons3);
        _pylonsArray pushback ["Pylons3", _pylonMag];
        _pylonsArray pushback ["Pylons8", _pylonMag];

        _pylonMag = (selectRandomWeighted _pylons4);
        _pylonsArray pushback ["Pylons4", _pylonMag];
        _pylonsArray pushback ["Pylons7", _pylonMag];

        _pylonMag = (selectRandomWeighted _pylons5);
        _pylonsArray pushback ["Pylons5", _pylonMag];
        _pylonsArray pushback ["Pylons6", _pylonMag];

        [_vehicle, _pylonsArray] remoteExec ["AW_fnc_setPylonLoadout", _vehicle];
    };

    // To-201 Shikra
    case "O_Plane_Fighter_02_F": {
        [_vehicle, "OPFOR"] call AW_fnc_vehicleApperanceApply;

        _vehicle removeMagazineGlobal "240Rnd_CMFlare_Chaff_Magazine";
        _vehicle addMagazine "120Rnd_CMFlare_Chaff_Magazine";

        private _pylonsArray = [];

        _pylonsArray pushBack ["pylons1", "PylonMissile_Missile_AA_R73_x1"];
        _pylonsArray pushBack ["pylons2", "PylonMissile_Missile_AA_R73_x1"];

        private _pylonsMags = [
            "PylonMissile_Missile_AGM_KH25_x1", 2,
            "PylonMissile_Bomb_KAB250_x1", 1,
            "PylonMissile_1Rnd_BombCluster_02_cap_F", 1
        ];

        private _pylonMag = (selectRandomWeighted _pylonsMags);
        _pylonsArray pushBack ["pylons3", _pylonMag];
        _pylonsArray pushBack ["pylons4", _pylonMag];

        _pylonsMags = [
            "PylonMissile_Bomb_KAB250_x1", 2,
            "PylonMissile_1Rnd_BombCluster_02_cap_F", 1,
            "PylonMissile_Missile_KH58_x1", 3
        ];

        _pylonMag = (selectRandomWeighted _pylonsMags);
        _pylonsArray pushBack ["pylons5", _pylonMag];
        _pylonsArray pushBack ["pylons6", _pylonMag];

        {
            _pylonsArray pushBack [_x, ""];
        } forEach [
            "pylonBayRight1",
            "pylonBayLeft1",
            "pylonBayRight2",
            "pylonBayLeft2",
            "pylonBayCenter1",
            "pylonBayCenter2"
        ];

        _pylonsMags = [
            "PylonMissile_Missile_AGM_KH25_INT_x1", 1,
            "PylonMissile_Bomb_KAB250_x1", 2,
            "PylonMissile_1Rnd_BombCluster_02_cap_F", 2
        ];

        _pylonMag = (selectRandomWeighted _pylonsMags);
        _pylonsArray pushBack ["pylonBayCenter3", _pylonMag];

        [_vehicle, _pylonsArray] remoteExec ["AW_fnc_setPylonLoadout", _vehicle];
    };

    // To-201 Shikra (Stealth)
    case "O_Plane_Fighter_02_Stealth_F": {
        [_vehicle, "OPFOR"] call AW_fnc_vehicleApperanceApply;

        _vehicle removeMagazineGlobal "240Rnd_CMFlare_Chaff_Magazine";
        _vehicle addMagazine "120Rnd_CMFlare_Chaff_Magazine";

        private _AtASR = "PylonMissile_Missile_AA_R73_x1";
        private _AtAMR = "PylonMissile_Missile_AA_R77_INT_x1";

        private _pylonsArray = [];

        _pylonsArray pushBack ["pylonBayRight1", _AtASR];
        _pylonsArray pushBack ["pylonBayLeft1", _AtASR];

        _pylonsArray pushBack ["pylonBayRight2", _AtAMR];
        _pylonsArray pushBack ["pylonBayLeft2", _AtAMR];

        _pylonsArray pushBack ["pylonBayCenter1", (selectRandom [_AtAMR, "", ""])];
        _pylonsArray pushBack ["pylonBayCenter2", (selectRandom [_AtAMR, "", ""])];
        _pylonsArray pushBack ["pylonBayCenter3", ""];

        [_vehicle, _pylonsArray] remoteExec ["AW_fnc_setPylonLoadout", _vehicle];
    };

    // A-149 Gryphon
    case "I_Plane_Fighter_04_F": {
        _vehicle removeMagazineGlobal "240Rnd_CMFlare_Chaff_Magazine";
        _vehicle addMagazine "120Rnd_CMFlare_Chaff_Magazine";

        private _pylonsArray = [];

        _pylonsArray pushBack ["pylon1", "PylonMissile_Missile_BIM9X_x1"];
        _pylonsArray pushBack ["pylon2", "PylonMissile_Missile_BIM9X_x1"];

        _pylonsArray pushBack ["pylon3", "PylonRack_Missile_AGM_02_x1"];
        _pylonsArray pushBack ["Pylon4", "PylonRack_Missile_AGM_02_x1"];

        private _pylonMags = [
            "PylonRack_Missile_AGM_02_x2", 2,
            "PylonMissile_Bomb_GBU12_x1", 3,
            "PylonMissile_1Rnd_BombCluster_01_F", 1,
            "PylonMissile_1Rnd_BombCluster_03_F", 2
        ];

        private _pylonMag = (selectRandomWeighted _pylonMags);
        _pylonsArray pushBack ["pylon5", _pylonMag];
        _pylonsArray pushBack ["Pylon6", _pylonMag];

        [_vehicle, _pylonsArray] remoteExec ["AW_fnc_setPylonLoadout", _vehicle];
    };

    // A-143 Buzzard (CAS)
    case "I_Plane_Fighter_03_dynamicLoadout_F": {
        [_vehicle, "OPFOR"] call AW_fnc_vehicleApperanceApply;

        private _AtA = [
            "PylonRack_1Rnd_Missile_AA_04_F",
            "PylonRack_1Rnd_AAA_missiles",
            "PylonRack_1Rnd_GAA_missiles"
        ];

        private _middle = [
            "PylonRack_1Rnd_LG_scalpel",
            "PylonRack_3Rnd_LG_scalpel",
            "PylonRack_7Rnd_Rocket_04_HE_F",
            "PylonRack_7Rnd_Rocket_04_AP_F",
            "PylonRack_12Rnd_PG_missiles",
            "PylonRack_12Rnd_missiles"
        ];

        private _inner = [
            "PylonRack_1Rnd_Missile_AGM_02_F",
            "PylonMissile_1Rnd_Bomb_04_F",
            "PylonMissile_1Rnd_Mk82_F",
            "PylonMissile_1Rnd_BombCluster_01_F",
            "PylonMissile_1Rnd_BombCluster_03_F"
        ];

        private _pylonsArray = [];

        {
            _pylonsArray pushBack [_x, (selectRandom _AtA)];
        } forEach ["Pylons1", "Pylons7"];

        {
            _pylonsArray pushBack [_x, (selectRandom _middle)];
        } forEach ["Pylons2", "Pylons6"];

        {
            _pylonsArray pushBack [_x, (selectRandom (_middle + _inner))];
        } forEach ["Pylons3", "Pylons5"];

        _pylonsArray pushBack ["Pylons4", "PylonWeapon_300Rnd_20mm_shells"];

        [_vehicle, _pylonsArray] remoteExec ["AW_fnc_setPylonLoadout", _vehicle];
    };

    // Mi-48 Kajman
    case "O_Heli_Attack_02_dynamicLoadout_F": {
        [_vehicle, [0]] call _totalRandomization;
    };

    case "O_SFIA_Heli_Attack_02_dynamicLoadout_lxWS": {
        [_vehicle, [0]] call _totalRandomization;
    };

    // PO-30 Orca
    case "O_Heli_Light_02_dynamicLoadout_F": {
        [_vehicle, "OPFOR"] call AW_fnc_vehicleApperanceApply;

        [_vehicle] call _totalRandomization;
    };

    // WY-55 Hellcat
    case "I_Heli_light_03_dynamicLoadout_F": {
        [_vehicle] call _totalRandomization;
    };

    // Y-32 Xi'an (Infantry Transport)
    case "O_T_VTOL_02_infantry_dynamicLoadout_F": {
        [_vehicle, "OPFOR"] call AW_fnc_vehicleApperanceApply;

        [_vehicle, [0]] call _totalRandomization;
    };

    // PO-30 Orca (Unarmed)
    case "O_Heli_Light_02_unarmed_F": {
        [_vehicle, "OPFOR"] call AW_fnc_vehicleApperanceApply;
    };

    // WY-55 Hellcat (Unarmed)
    case "I_Heli_light_03_unarmed_F": {
        [_vehicle, "OPFOR"] call AW_fnc_vehicleApperanceApply;

        [_vehicle] call _totalRandomization;
    };

    // Qilin (Minigun)
    case "O_LSV_02_armed_F": {
        [_vehicle, "OPFOR"] call AW_fnc_vehicleApperanceApply;
    };

    // Ifrit HMG
    case "O_MRAP_02_hmg_F": {
        [_vehicle, "OPFOR"] call AW_fnc_vehicleApperanceApply;
    };

    // Ifrit GMG
    case "O_MRAP_02_gmg_F": {
        [_vehicle, "OPFOR"] call AW_fnc_vehicleApperanceApply;
    };

    // Offroad (HMG)
    case "O_G_Offroad_01_armed_F": {
        [_vehicle, "OPFOR"] call AW_fnc_vehicleApperanceApply;

        _vehicle forceFlagTexture "\A3\Data_F\Flags\flag_CSAT_CO.paa";
    };

    // Tempest Transport
    case "O_Truck_03_transport_F": {
        [_vehicle, "OPFOR"] call AW_fnc_vehicleApperanceApply;
    };

    // Tempest Ammo
    case "O_Truck_03_ammo_F": {
        [_vehicle, "OPFOR"] call AW_fnc_vehicleApperanceApply;
    };

    // Zamak Ammo
    case "O_Truck_02_Ammo_F": {
        [_vehicle, "OPFOR"] call AW_fnc_vehicleApperanceApply;
    };

    // AWC 301 Nyx (AT)
    case "I_LT_01_AT_F": {
        [_vehicle, "OPFOR"] call AW_fnc_vehicleApperanceApply;
    };

    // AWC 302 Nyx (AA)
    case "I_LT_01_AA_F": {
        [_vehicle, "OPFOR"] call AW_fnc_vehicleApperanceApply;
    };

    // AWC 304 Nyx (Autocannon)
    case "I_LT_01_cannon_F": {
        [_vehicle, "OPFOR"] call AW_fnc_vehicleApperanceApply;
    };

    // MSE-3 Marid
    case "O_APC_Wheeled_02_rcws_v2_F": {
        [_vehicle, "OPFOR"] call AW_fnc_vehicleApperanceApply;
    };

    case "O_SFIA_APC_Wheeled_02_hmg_lxWS": {
        [_vehicle, "OPFOR"] call AW_fnc_vehicleApperanceApply;
    };

    // BTR-K Kamysh
    case "O_APC_Tracked_02_cannon_F": {
        [_vehicle, "OPFOR"] call AW_fnc_vehicleApperanceApply;
    };

    case "O_SFIA_APC_Tracked_02_cannon_lxWS": {
        [_vehicle, "OPFOR"] call AW_fnc_vehicleApperanceApply;
    };

    // BTR-T Iskatel
    case "O_SFIA_APC_Tracked_02_30mm_lxWS": {
        [_vehicle, "OPFOR"] call AW_fnc_vehicleApperanceApply;
    };

    // FV-720 Mora
    case "I_APC_tracked_03_cannon_F": {
        [_vehicle, "OPFOR"] call AW_fnc_vehicleApperanceApply;
    };

    // AFV-4 Gorgon
    case "I_APC_Wheeled_03_cannon_F": {
        [_vehicle, "OPFOR"] call AW_fnc_vehicleApperanceApply;
    };

    // ZSU-39 Tigris
    case "O_APC_Tracked_02_AA_F": {
        [_vehicle, "OPFOR"] call AW_fnc_vehicleApperanceApply;
    };

    case "O_SFIA_APC_Tracked_02_AA_lxWS": {
        [_vehicle, "OPFOR"] call AW_fnc_vehicleApperanceApply;
    };

    // Zamak (Zu23-2)
    case "O_SFIA_Truck_02_aa_lxWS": {
        [_vehicle, "OPFOR"] call AW_fnc_vehicleApperanceApply;
    };

    // 2S9 Sochor
    case "O_MBT_02_arty_F": {
        [_vehicle, "OPFOR"] call AW_fnc_vehicleApperanceApply;
    };

    // Zamak MRL
    case "I_Truck_02_MRL_F": {
        [_vehicle, "OPFOR"] call AW_fnc_vehicleApperanceApply;
    };

    // T-100 Varsuk
    case "O_MBT_02_cannon_F": {
        [_vehicle, "OPFOR"] call AW_fnc_vehicleApperanceApply;
    };

    case "O_SFIA_MBT_02_cannon_lxWS": {
        [_vehicle, "OPFOR"] call AW_fnc_vehicleApperanceApply;
    };

    // MBT-52 Kuma
    case "I_MBT_03_cannon_F": {
        [_vehicle, "OPFOR"] call AW_fnc_vehicleApperanceApply;
    };

    // T-140 Angara
    case "O_MBT_04_cannon_F": {
        [_vehicle, "OPFOR"] call AW_fnc_vehicleApperanceApply;
    };

    // T-140K Angara
    case "O_MBT_04_command_F": {
        [_vehicle, "OPFOR"] call AW_fnc_vehicleApperanceApply;
    };

    // R-750 Cronus Radar
    case "O_Radar_System_02_F": {
        [_vehicle, "OPFOR"] call AW_fnc_vehicleApperanceApply;
    };

    // S-750 Rhea
    case "O_SAM_System_04_F": {
        [_vehicle, "OPFOR"] call AW_fnc_vehicleApperanceApply;
    };
};


// Setup DataLink
if (local _vehicle) then {
    _vehicle call AW_fnc_vehicleDataLinkSettings;
} else {
    _vehicle remoteExec ["AW_fnc_vehicleDataLinkSettings", _vehicle];
};

["ADD", _vehicle] call AW_fnc_vehicleFuelEh;
