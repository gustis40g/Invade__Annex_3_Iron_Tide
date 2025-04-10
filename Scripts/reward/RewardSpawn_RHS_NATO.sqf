params ["_rewardId", "_createPos"];
private _vehicle = objNull;
#define CV(veh) createVehicle [veh, _createPos, [], 50, "NONE"]

private _turretCrewEh = {
    params ["_vehicle"];

    private _turretCrewEhIdx = _vehicle addEventHandler ["GetIn", {
        params ["_vehicle", "_role", "_unit", "_turret"];

        private _uavTurretTypes = ["B_SAM_System_02_F", "B_SAM_System_01_F", "B_AAA_System_01_F"];

        private _attachedObjs = (attachedObjects _vehicle);
        private _uavTurretIdx = (_attachedObjs findIf {(typeOf _x) in _uavTurretTypes});

        if (_uavTurretIdx == -1) exitWith {};

        _vehicle removeEventHandler ["GetIn", _thisEventHandler];

        private _uavTurret = (_attachedObjs # _uavTurretIdx);

        _uavTurret setVehicleRadar 1;

        private _grp = (createVehicleCrew _uavTurret);

        _grp setGroupIdGlobal [format ["UAV-Turret-%1", (ceil (random 999))]];

        [(crew _uavTurret)] call AW_fnc_addToAllCurators;
    }];
};

private _hideTurretCode = {
    params ["_vehicle"];

    _vehicle lockTurret [[0,0], true];
    _vehicle lockTurret [[0], true];

    while {(_vehicle animationPhase "HideTurret") == 0} do {
        _vehicle animateSource ["HideTurret", 1, true];
        sleep 0.25;
    };

    private _mags = (magazinesAllTurrets _vehicle);

    {
        _x params ["_class", "_turretPath"];

        _vehicle removeMagazineTurret [_class, _turretPath];
    } forEach _mags;
};


switch (_rewardId) do {
    /**************/
    /**** Jets ****/
    /**************/

    // A-164 Wipeout (CAS)
    case 101: {
        _vehicle = CV("B_Plane_CAS_01_dynamicLoadout_F");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // F/A-181 Black Wasp II (CAS)
    case 105: {
        _vehicle = CV("B_Plane_Fighter_01_F");

        [_vehicle, "CAS"] call AW_fnc_vehicleCustomization;
    };

    // F/A-181 Black Wasp II (CAP)
    case 111: {
        _vehicle = CV("B_Plane_Fighter_01_F");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // F/A-181 Black Wasp II (Stealth)
    case 106: {
        _vehicle = CV("B_Plane_Fighter_01_Stealth_F");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // To-201 Shikra
    case 102: {
        _vehicle = CV("O_Plane_Fighter_02_F");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // To-201 Shikra (Stealth)
    case 103: {
        _vehicle = CV("O_Plane_Fighter_02_Stealth_F");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // A-149 Gryphon (CAS)
    case 107: {
        _vehicle = CV("I_Plane_Fighter_04_F");

        [_vehicle, "CAS"] call AW_fnc_vehicleCustomization;
    };

    // A-149 Gryphon (CAP)
    case 108: {
        _vehicle = CV("I_Plane_Fighter_04_F");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // A-143 Buzzard (CAS)
    case 109: {
        _vehicle = CV("I_Plane_Fighter_03_dynamicLoadout_F");

        [_vehicle, "CAS"] call AW_fnc_vehicleCustomization;
    };

    // A-143 Buzzard (CAP)
    case 110: {
        _vehicle = CV("I_Plane_Fighter_03_dynamicLoadout_F");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };


    /**********************/
    /**** Attack Helis ****/
    /**********************/

    // MI-48 Kajman
    case 201: {
        _vehicle = CV("O_Heli_Attack_02_dynamicLoadout_black_F");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // AH-99 Blackfoot
    case 202: {
        _vehicle = CV("B_Heli_Attack_01_dynamicLoadout_F");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // AH-9 Pawnee
    case 204: {
        _vehicle = CV("B_Heli_Light_01_dynamicLoadout_F");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // WY-55 Hellcat
    case 205: {
        _vehicle = CV("I_Heli_light_03_dynamicLoadout_F");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // PO-30 Orca
    case 203: {
        _vehicle = CV("O_Heli_Light_02_dynamicLoadout_F");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };


    /***************/
    /**** VTOLs ****/
    /***************/

    // V-44 X Blackfish (Armed)
    case 301: {
        _vehicle = CV("B_T_VTOL_01_armed_F");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // Y-32 Xi'an (Infantry Transport, unarmed)
    case 302: {
        _vehicle = CV("O_T_VTOL_02_infantry_dynamicLoadout_F");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // Y-32 Xi'an (Infantry Transport, Armed)
    case 303: {
        _vehicle = CV("O_T_VTOL_02_infantry_dynamicLoadout_F");

        [_vehicle, "CAS"] call AW_fnc_vehicleCustomization;
    };

    // Y-32 Xi'an (Vehicle Transport, unamed)
    case 304: {
        _vehicle = CV("O_T_VTOL_02_vehicle_dynamicLoadout_F");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // Y-32 Xi'an (Vehicle Transport, Armed)
    case 305: {
        _vehicle = CV("O_T_VTOL_02_vehicle_dynamicLoadout_F");

        [_vehicle, "CAS"] call AW_fnc_vehicleCustomization;
    };


    /*************************/
    /**** Transport Helis ****/
    /*************************/

    // MI-290 Taru (Bench)
    case 401: {
        _vehicle = CV("O_Heli_Transport_04_bench_black_F");
    };

    // MI-290 Taru (Heavy Lifter)
    case 402: {
        _vehicle = CV("O_Heli_Transport_04_black_F");
    };

    // CH-49 Mohawk
    case 403: {
        _vehicle = CV("I_Heli_Transport_02_F");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // WY-55 Hellcat (Unarmed)
    case 404: {
        _vehicle = CV("I_Heli_light_03_unarmed_F");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };


    /**************/
    /**** UAVs ****/
    /**************/

    // UCAV Sentinel
    case 501: {
        _vehicle = CV("B_UAV_05_F");
        createVehicleCrew _vehicle;
        [(crew _vehicle)] call AW_fnc_addToAllCurators;

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // Praetorian 1C (AMV-7 Marshall mounted)
    case 502: {
        _vehicle = CV("B_APC_Wheeled_01_cannon_F");

        [_vehicle] call AW_fnc_vehicleCustomization;

        {
            _vehicle animateSource  [_x, (selectRandom [0, 1]), true];
        } forEach ["showCamonetHull", "showSLATHull"];

        [_vehicle] spawn _hideTurretCode;

        private _AAA = CV("B_AAA_System_01_F");

        [_AAA] call AW_fnc_vehicleCustomization;

        _AAA attachTo [_vehicle, [0, -1, 2.3]];

        _vehicle setVariable ["InA_Attached_uavTurret", _AAA, true];
        _vehicle enableVehicleCargo false;

        [[_AAA]] call AW_fnc_addToAllCurators;
        [_vehicle] spawn AW_fnc_vehicleAttachmentKilledEH;
        [_vehicle] spawn _turretCrewEh;
        [_AAA] call AW_fnc_vehicleDataLinkSettings;
        [_vehicle] remoteExec ["AW_fnc_vehicleUAVTurretCtrlAction", 0, _vehicle];
    };

    // Mk49 Spartan (AFV-4 Gorgon mounted)
    case 503: {
        _vehicle = CV("I_APC_Wheeled_03_cannon_F");

        [_vehicle] call AW_fnc_vehicleCustomization;

        {
            _vehicle animateSource  [_x, (selectRandom [0, 1]), true];
        } forEach ["showCamonetHull", "showSLATHull"];

        [_vehicle] spawn _hideTurretCode;

        private _AA = CV("B_SAM_System_01_F");

        [_AA] call AW_fnc_vehicleCustomization;

        _AA attachTo [_vehicle, [0.39, -1.55, 1.42]];

        _vehicle setVariable ["InA_Attached_uavTurret", _AA, true];
        _vehicle enableVehicleCargo false;

        [[_AA]] call AW_fnc_addToAllCurators;
        [_vehicle] spawn AW_fnc_vehicleAttachmentKilledEH;
        [_vehicle] spawn _turretCrewEh;
        [_AA] call AW_fnc_vehicleDataLinkSettings;
        [_vehicle] remoteExec ["AW_fnc_vehicleUAVTurretCtrlAction", 0, _vehicle];
    };

    // Mk21 Centurion (FV-720 Mora mounted)
    case 504: {
        _vehicle = CV("I_APC_tracked_03_cannon_F");

        [_vehicle] call AW_fnc_vehicleCustomization;

        {
            _vehicle animateSource  [_x, (selectRandom [0, 1]), true];
        } forEach ["showCamonetHull", "showSLATHull"];

        [_vehicle] spawn _hideTurretCode;

        private _AA = CV("B_SAM_System_02_F");

        [
            _AA,
            ["Green", 1]
        ] call BIS_fnc_initVehicle;

        _AA attachTo [_vehicle, [0, -1.05, 1.4]];

        _vehicle setVariable ["InA_Attached_uavTurret", _AA, true];
        _vehicle enableVehicleCargo false;

        [[_AA]] call AW_fnc_addToAllCurators;
        [_vehicle] spawn AW_fnc_vehicleAttachmentKilledEH;
        [_vehicle] spawn _turretCrewEh;
        [_AA] call AW_fnc_vehicleDataLinkSettings;
        [_vehicle] remoteExec ["AW_fnc_vehicleUAVTurretCtrlAction", 0, _vehicle];
    };


    /***************/
    /**** Tonks ****/
    /***************/

    // Enhanced T-100 Varsuk
    case 603: {
        _vehicle = CV("O_MBT_02_cannon_F");

        for "_i" from 1 to 10 do {
            _vehicle removeMagazineGlobal "200Rnd_762x51_Belt_Green";
        };

        _vehicle removeWeapon "LMG_coax";

        _vehicle addWeaponTurret ["HMG_127_MBT", [0]];

        for "_i" from 1 to 4 do {
            _vehicle addMagazineTurret ["500Rnd_127x99_mag_Tracer_Red", [0]];
        };

        _vehicle addMagazineTurret ["16Rnd_125mm_APFSDS_T_Green", [0]];
        _vehicle addMagazineTurret ["12Rnd_125mm_HEAT_T_Green", [0]];
        _vehicle addMagazineTurret ["12Rnd_125mm_HE_T_Green", [0]];

        for "_i" from 1 to 2 do {
            _vehicle addMagazineTurret ["150Rnd_127x108_Ball", [0,0]];
        };

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // Enhanced T-140 Angara
    case 605: {
        _vehicle = CV("O_MBT_04_cannon_F");

        for "_i" from 1 to 2 do {
            _vehicle removeMagazineGlobal "1000Rnd_762x51_Belt_Green";
        };

        _vehicle removeWeapon "LMG_coax";

        _vehicle addWeaponTurret ["HMG_127_MBT", [0]];

        for "_i" from 1 to 4 do {
            _vehicle addMagazineTurret ["500Rnd_127x99_mag_Tracer_Red", [0]];
        };

        _vehicle addMagazineTurret ["20Rnd_125mm_APFSDS_T_Green", [0]];
        _vehicle addMagazineTurret ["12Rnd_125mm_HEAT_T_Green", [0]];
        _vehicle addMagazineTurret ["12Rnd_125mm_HE_T_Green", [0]];

        _vehicle addMagazineTurret ["500Rnd_127x99_mag_Tracer_Yellow", [0,0]];

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // Enhanced T-140K Angara
    case 606: {
        _vehicle = CV("O_MBT_04_command_F");

        for "_i" from 1 to 2 do {
            _vehicle removeMagazineGlobal "1000Rnd_762x51_Belt_Green";
        };

        _vehicle removeWeapon "LMG_coax";

        _vehicle addWeaponTurret ["HMG_127_MBT", [0]];

        for "_i" from 1 to 4 do {
            _vehicle addMagazineTurret ["500Rnd_127x99_mag_Tracer_Red", [0]];
        };

        _vehicle addMagazineTurret ["20Rnd_125mm_APFSDS_T_Green", [0]];
        _vehicle addMagazineTurret ["12Rnd_125mm_HEAT_T_Green", [0]];
        _vehicle addMagazineTurret ["12Rnd_125mm_HE_T_Green", [0]];

        for "_i" from 1 to 4 do {
            _vehicle addMagazineTurret ["60Rnd_30mm_MP_shells_Tracer_Green", [0,0]];
        };

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // Enhanced MBT-52 Kuma
    case 604: {
        _vehicle = CV("I_MBT_03_cannon_F");

        for "_i" from 1 to 4 do {
            _vehicle removeMagazineGlobal "200Rnd_762x51_Belt_Yellow";
        };

        _vehicle removeWeapon ("LMG_coax");

        _vehicle addWeaponTurret ["HMG_127_MBT",[0]];

        for "_i" from 1 to 4 do {
            _vehicle addMagazineTurret ["500Rnd_127x99_mag_Tracer_Red", [0]];
        };

        _vehicle addMagazineTurret ["20Rnd_120mm_APFSDS_shells_Tracer_Yellow", [0]];
        _vehicle addMagazineTurret ["14Rnd_120mm_HE_shells_Tracer_Yellow", [0]];
        _vehicle addMagazineTurret ["12Rnd_120mm_HEAT_MP_T_Yellow", [0]];

        for "_i" from 1 to 2 do {
            _vehicle addMagazineTurret ["200Rnd_127x99_mag_Tracer_Yellow", [0,0]];
        };

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // Enhanced M2A4 Slammer (Urban Purpose)
    case 602: {
        _vehicle = CV("B_MBT_01_TUSK_F");

        for "_i" from 1 to 20 do {
            _vehicle removeMagazineGlobal "200Rnd_762x51_Belt_Red";
        };

        _vehicle removeWeapon ("LMG_coax");

        _vehicle addWeaponTurret ["HMG_127_MBT", [0]];

        for "_i" from 1 to 4 do {
            _vehicle addMagazineTurret ["500Rnd_127x99_mag_Tracer_Red", [0]];
        };

        _vehicle addMagazineTurret ["24Rnd_120mm_APFSDS_shells_Tracer_Red", [0]];
        _vehicle addMagazineTurret ["12Rnd_120mm_HE_shells_Tracer_Red", [0]];
        _vehicle addMagazineTurret ["12Rnd_120mm_HEAT_MP_T_Red", [0]];

        for "_i" from 1 to 4 do {
            _vehicle addMagazineTurret ["200Rnd_127x99_mag_Tracer_Red", [0,0]];
        };

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // T-140K Angara
    case 601: {
        _vehicle = CV("O_MBT_04_command_F");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // T-140 Angara
    case 608: {
        _vehicle = CV("O_MBT_04_cannon_F");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // M2A4 Slammer
    case 610: {
        _vehicle = CV("B_MBT_01_cannon_F");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // M2A4 Slammer (Urban Purpose)
    case 611: {
        _vehicle = CV("B_MBT_01_TUSK_F");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // MBT-52 Kuma
    case 609: {
        _vehicle = CV("I_MBT_03_cannon_F");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // T-100 Varsuk
    case 607: {
        _vehicle = CV("O_MBT_02_cannon_F");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };


    /**************/
    /**** IFVs ****/
    /**************/

    // Enhanced FV-720 Mora
    case 707: {
        _vehicle = CV("I_APC_tracked_03_cannon_F");

        for "_i" from 1 to 8 do {
            _vehicle removeMagazineGlobal "200Rnd_762x51_Belt_Yellow";
        };

        _vehicle removeWeapon "LMG_coax";

        _vehicle addWeaponTurret ["HMG_127_MBT", [0]];

        for "_i" from 1 to 4 do {
            _vehicle addMagazineTurret ["500Rnd_127x99_mag_Tracer_Red", [0]];
        };

        _vehicle addMagazineTurret ["60Rnd_30mm_APFSDS_shells_Tracer_Yellow", [0]];
        _vehicle addMagazineTurret ["60Rnd_30mm_APFSDS_shells_Tracer_Yellow", [0]];

        _vehicle addMagazineTurret ["140Rnd_30mm_MP_shells_Tracer_Yellow", [0]];
        _vehicle addMagazineTurret ["140Rnd_30mm_MP_shells_Tracer_Yellow", [0]];

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // Enhanced AFV-4 Gorgon
    case 711: {
        _vehicle = CV("I_APC_Wheeled_03_cannon_F");

        for "_i" from 1 to 8 do {
            _vehicle removeMagazineGlobal "200Rnd_762x51_Belt_Yellow";
        };

        _vehicle removeWeapon "LMG_coax_ext";

        _vehicle addWeaponTurret ["HMG_127_MBT", [0]];

        for "_i" from 1 to 4 do {
            _vehicle addMagazineTurret ["500Rnd_127x99_mag_Tracer_Red", [0]];
        };

        _vehicle addMagazineTurret ["60Rnd_30mm_APFSDS_shells_Tracer_Yellow", [0]];
        _vehicle addMagazineTurret ["60Rnd_30mm_APFSDS_shells_Tracer_Yellow", [0]];

        _vehicle addMagazineTurret ["140Rnd_30mm_MP_shells_Tracer_Yellow", [0]];
        _vehicle addMagazineTurret ["140Rnd_30mm_MP_shells_Tracer_Yellow", [0]];

        _vehicle addMagazineTurret ["2Rnd_GAT_missiles", [0]];
        _vehicle addMagazineTurret ["2Rnd_GAT_missiles", [0]];

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // Enhanced AMV-7 Marshall
    case 713: {
        _vehicle = CV("B_APC_Wheeled_01_cannon_F");

        for "_i" from 1 to 8 do {
            _vehicle removeMagazineGlobal "200Rnd_762x51_Belt_Red";
        };

        _vehicle removeWeapon "LMG_coax";

        _vehicle addWeaponTurret ["HMG_127_MBT", [0]];

        for "_i" from 1 to 4 do {
            _vehicle addMagazineTurret ["500Rnd_127x99_mag_Tracer_Red", [0]];
        };

        _vehicle addMagazineTurret ["60Rnd_40mm_GPR_Tracer_Red_shells", [0]];

        _vehicle addMagazineTurret ["40Rnd_40mm_APFSDS_Tracer_Red_shells", [0]];

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // Enhanced BTR-K Kamysh
    case 709: {
        _vehicle = CV("O_APC_Tracked_02_cannon_F");

        for "_i" from 1 to 8 do {
            _vehicle removeMagazineGlobal "200Rnd_762x51_Belt_Green";
        };

        _vehicle removeWeapon "LMG_coax_ext";

        _vehicle addWeaponTurret ["HMG_127_MBT", [0]];

        for "_i" from 1 to 4 do {
            _vehicle addMagazineTurret ["500Rnd_127x99_mag_Tracer_Red", [0]];
        };

        _vehicle addMagazineTurret ["60Rnd_30mm_APFSDS_shells_Tracer_Green", [0]];
        _vehicle addMagazineTurret ["60Rnd_30mm_APFSDS_shells_Tracer_Green", [0]];

        _vehicle addMagazineTurret ["140Rnd_30mm_MP_shells_Tracer_Green", [0]];
        _vehicle addMagazineTurret ["140Rnd_30mm_MP_shells_Tracer_Green", [0]];

        _vehicle addMagazineTurret ["2Rnd_GAT_missiles_O", [0]];
        _vehicle addMagazineTurret ["2Rnd_GAT_missiles_O", [0]];

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // AFV-4 Gorgon
    case 710: {
        _vehicle = CV("I_APC_Wheeled_03_cannon_F");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // AWC 301 Nyx (AT)
    case 703: {
        _vehicle = CV("I_LT_01_AT_F");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // AWC 303 Nyx (Recon)
    case 701: {
        _vehicle = CV("I_LT_01_scout_F");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // AWC 302 Nyx (AA)
    case 714: {
        _vehicle = CV("I_LT_01_AA_F");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // AWC 304 Nyx (Autocannon)
    case 704: {
        _vehicle = CV("I_LT_01_cannon_F");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // FV-720 Mora
    case 706: {
        _vehicle = CV("I_APC_tracked_03_cannon_F");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // BTR-K Kamysh
    case 708: {
        _vehicle = CV("O_APC_Tracked_02_cannon_F");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // AMV-7 Marshall
    case 712: {
        _vehicle = CV("B_APC_Wheeled_01_cannon_F");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };


    /****************/
    /**** SPAAGs ****/
    /****************/

    // IFV-6a Cheetah
    case 801: {
        _vehicle = CV("B_APC_Tracked_01_AA_F");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // ZSU-39 Tigris
    case 802: {
        _vehicle = CV("O_APC_Tracked_02_AA_F");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };


    /**************/
    /**** APCs ****/
    /**************/

    // CRV-6e Bobcat
    case 901: {
        _vehicle = CV("B_APC_Tracked_01_CRV_F");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // CRV-6e Bobcat (Minigun)
    case 903: {
        _vehicle = CV("B_APC_Tracked_01_CRV_F");

        for "_i" from 1 to 4 do {
            _vehicle removeMagazineGlobal "200Rnd_127x99_mag_Tracer_Red";
        };

        _vehicle removeWeapon "HMG_127_APC";

        _vehicle addWeaponTurret ["LMG_Minigun_Transport", [0]];

        for "_i" from 1 to 4 do {
            _vehicle addMagazineTurret ["500Rnd_65x39_Belt_Tracer_Green_Splash", [0]];
        };

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // MSE-3 Marid
    case 902: {
        _vehicle = CV("O_APC_Wheeled_02_rcws_v2_F");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // Rhino MGS
    case 904: {
        _vehicle = CV("B_AFV_Wheeled_01_cannon_F");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // Rhino MGS (Urban Purpose)
    case 905: {
        _vehicle = CV("B_AFV_Wheeled_01_up_cannon_F");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };


    /***************/
    /**** MRAPs ****/
    /***************/

    // Strider HMG
    case 1006: {
        _vehicle = CV("I_MRAP_03_hmg_F");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // Strider GMG
    case 1004: {
        _vehicle = CV("I_MRAP_03_gmg_F");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // Hunter (Minigun)
    case 1002: {
        _vehicle = CV("B_MRAP_01_hmg_F");

        _vehicle removeMagazineGlobal "200Rnd_127x99_mag_Tracer_Red";
        _vehicle removeMagazineGlobal "200Rnd_127x99_mag_Tracer_Red";
        _vehicle removeWeapon "HMG_127";

        _vehicle addWeapon "LMG_Minigun_Transport";
        _vehicle addMagazine "500Rnd_65x39_Belt_Tracer_Green_Splash";
        _vehicle addMagazine "500Rnd_65x39_Belt_Tracer_Green_Splash";
        _vehicle addMagazine "500Rnd_65x39_Belt_Tracer_Green_Splash";

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // Strider (Minigun)
    case 1003: {
        _vehicle = CV("I_MRAP_03_hmg_F");

        _vehicle removeMagazineGlobal "200Rnd_127x99_mag_Tracer_Yellow";
        _vehicle removeMagazineGlobal "200Rnd_127x99_mag_Tracer_Yellow";
        _vehicle removeWeapon "HMG_127";

        _vehicle addWeaponTurret ["LMG_Minigun_Transport", [0]];

        for "_i" from 1 to 4 do {
            _vehicle addMagazineTurret ["500Rnd_65x39_Belt_Tracer_Green_Splash", [0]];
        };

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // Strider (Lynx)
    case 1001: {
        _vehicle = CV("I_MRAP_03_hmg_F");

        _vehicle removeMagazineGlobal "200Rnd_127x99_mag_Tracer_Yellow";
        _vehicle removeMagazineGlobal "200Rnd_127x99_mag_Tracer_Yellow";
        _vehicle removeWeapon "HMG_127";

        _vehicle addWeaponTurret ["srifle_GM6_F", [0]];

        for "_i" from 1 to 6 do {
            _vehicle addMagazineTurret ["5Rnd_127x108_APDS_Mag", [0]];
        };

        for "_i" from 1 to 12 do {
            _vehicle addMagazineTurret ["5Rnd_127x108_Mag", [0]];
        };

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // Hunter (Titan AT)
    case 1005: {
        _vehicle = CV("B_MRAP_01_gmg_F");

        _vehicle removeMagazineGlobal "96Rnd_40mm_G_belt";
        _vehicle removeMagazineGlobal "96Rnd_40mm_G_belt";
        _vehicle removeWeapon "GMG_40mm";

        _vehicle addWeaponTurret ["missiles_titan_static", [0]];

        for "_i" from 1 to 6 do {
            _vehicle addMagazineTurret ["1Rnd_GAT_missiles", [0]];
        };

        [_vehicle] call AW_fnc_vehicleCustomization;
    };


    /**************/
    /**** Cars ****/
    /**************/

    // Van (Services)
    case 1101: {
        _vehicle = CV("C_Van_02_service_F");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // Qilin (AT)
    case 1113: {
        _vehicle = CV("O_LSV_02_AT_F");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // Qilin (Minigun)
    case 1111: {
        _vehicle = CV("O_LSV_02_armed_F");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // Offroad (Minigun)
    case 1107: {
        _vehicle = CV("B_G_Offroad_01_armed_F");

        for "_i" from 1 to 4 do {
            _vehicle removeMagazineGlobal "100Rnd_127x99_mag_Tracer_Yellow";
        };

        _vehicle removeWeapon "HMG_M2_Mounted";

        _vehicle addWeaponTurret ["LMG_Minigun_Transport", [0]];

        for "_i" from 1 to 4 do {
            _vehicle addMagazineTurret ["500Rnd_65x39_Belt_Tracer_Green_Splash", [0]];
        };

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // Offroad (Titan AT)
    case 1104: {
        _vehicle = CV("B_G_Offroad_01_F");
        _vehicle setDir 0;

        private _ATLauncher = CV("B_static_AT_F");
        _ATLauncher attachTo [_vehicle, [0, -1.5, 0.4]];
        _ATLauncher setDir 180;
        _ATLauncher enableWeaponDisassembly false;

        for "_i" from 1 to 6 do {_ATLauncher addMagazine "1Rnd_GAT_missiles";};

        [[_ATLauncher]] call AW_fnc_addToAllCurators;

        [_vehicle] spawn AW_fnc_vehicleAttachmentKilledEH;

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // Offroad (Titan AA)
    case 1105: {
        _vehicle = CV("B_G_Offroad_01_F");
        _vehicle setDir 0;

        private _AALauncher = CV("B_static_AA_F");
        _AALauncher attachTo [_vehicle, [0, -1.5, 0.4]];
        _AALauncher setDir 180;
        _AALauncher enableWeaponDisassembly false;

        for "_i" from 1 to 8 do {_AALauncher addMagazine "1Rnd_GAA_missiles";};

        [[_AALauncher]] call AW_fnc_addToAllCurators;

        [_vehicle] spawn AW_fnc_vehicleAttachmentKilledEH;

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // Offroad (Repair, Mortar)
    case 1114: {
        _vehicle = CV("B_G_Offroad_01_repair_F");

        private _mortar = CV("B_Mortar_01_F");
        _mortar attachTo [_vehicle, [0, -2.5, 0.3]];
        _mortar enableWeaponDisassembly false;

        [[_mortar]] call AW_fnc_addToAllCurators;

        [_vehicle] spawn AW_fnc_vehicleAttachmentKilledEH;

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // Offroad (GMG)
    case 1108: {
        _vehicle = CV("B_G_Offroad_01_repair_F");

        private _GMG = CV("B_GMG_01_high_F");
        _GMG attachTo [_vehicle, [0, -2.5, 0.8]];
        _GMG enableWeaponDisassembly false;

        [[_GMG]] call AW_fnc_addToAllCurators;

        [_vehicle] spawn AW_fnc_vehicleAttachmentKilledEH;

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // Offroad (AT)
    case 1103: {
        _vehicle = CV("B_G_Offroad_01_AT_F");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // Offroad (Repair)
    case 1102: {
        _vehicle = CV("B_G_Offroad_01_repair_F");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // Offroad (HMG)
    case 1106: {
        _vehicle = CV("B_G_Offroad_01_armed_F");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // MB 4WD (AT)
    case 1109: {
        _vehicle = CV("I_C_Offroad_02_AT_F");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // MB 4WD (LMG)
    case 1110: {
        _vehicle = CV("I_C_Offroad_02_LMG_F");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // Prowler (AT)
    case 1112: {
        _vehicle = CV("B_LSV_01_AT_F");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };


    /**************/
    /**** Misc ****/
    /**************/

    // Battle Tractor
    case 1202: {
        _vehicle = CV("C_Tractor_01_F");

        private _GMG = CV("B_HMG_01_F");
        _GMG attachTo [_vehicle, [0, -0.8, 2]];
        _GMG enableWeaponDisassembly false;

        [[_GMG]] call AW_fnc_addToAllCurators;

        [_vehicle] spawn AW_fnc_vehicleAttachmentKilledEH;
    };

    // Battle Bus
    case 1201: {
        _vehicle = CV("B_Truck_01_flatbed_F");

        private _GMG = CV("B_GMG_01_F");
        _GMG attachTo [_vehicle, [0.15, 4.5, 1.1]];
        _GMG enableWeaponDisassembly false;

        private _hmg = CV("B_HMG_01_high_F");
        _hmg attachTo [_vehicle, [-0.15, -3.8, 0.8]];
        _hmg enableWeaponDisassembly false;
        _hmg setDir 180;

        private _AA = CV("B_static_AA_F");
        _AA attachTo [_vehicle, [0.1, 0.5, 0.2]];
        _AA enableWeaponDisassembly false;
        _AA setDir 90;

        private _AA2 = CV("B_static_AA_F");
        _AA2 attachTo [_vehicle, [0.1, -0.5, 0.2]];
        _AA2 enableWeaponDisassembly false;
        _AA2 setDir 270;

        for "_i" from 1 to 8 do {_AA addMagazineGlobal "1Rnd_GAA_missiles";};
        for "_i" from 1 to 8 do {_AA2 addMagazineGlobal "1Rnd_GAA_missiles";};

        private _AT = CV("B_static_AT_F");
        _AT attachTo [_vehicle, [0.1, -1.5, 0.2]];
        _AT enableWeaponDisassembly false;
        _AT setDir 90;

        private _AT2 = CV("B_static_AT_F");
        _AT2 attachTo [_vehicle, [0.1, -2.5, 0.2]];
        _AT2 enableWeaponDisassembly false;
        _AT2 setDir 270;

        for "_i" from 1 to 8 do {_AT addMagazine "1Rnd_GAT_missiles";};
        for "_i" from 1 to 8 do {_AT2 addMagazine "1Rnd_GAT_missiles";};

        [[_GMG, _hmg, _AA, _AA2, _AT, _AT2]] call AW_fnc_addToAllCurators;

        // Make sure direction for all statics is synced ....
        {
            _x setPos (getPos _x);
        } forEach (attachedObjects _vehicle);

        [_vehicle] spawn AW_fnc_vehicleAttachmentKilledEH;
    };
};

_vehicle
