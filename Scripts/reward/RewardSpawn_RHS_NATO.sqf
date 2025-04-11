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

    // A-10A Thunderbolt II (CAS)
    case 101: {
        _vehicle = CV("RHS_A10");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };


    // SU-25SM Frogfoot
    case 111: {
        _vehicle = CV("RHS_Su25SM_vvs");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // F-22A Raptor (CAS)
    case 104: {
        _vehicle = CV("rhsusf_f22");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // F/A-181 Black Wasp II (Stealth)
    case 106: {
        _vehicle = CV("rhsusf_f22");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // F-16C Fighting Falcon (CAP)
    case 107: {
        _vehicle = CV("PRACS_F16");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // Su-57 Felon (CAS)
    case 102: {
        _vehicle = CV("RHS_T50_vvs_generic_ext");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // Su-57 Felon (Stealth)
    case 103: {
        _vehicle = CV("RHS_T50_vvs_blueonblue");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };


    // F-16C Fighting Falcon (CAS)
    case 108: {
        _vehicle = CV("PRACS_F16CJR");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // Mirage V (CAS)
    case 109: {
        _vehicle = CV("PRACS_MirageV");

        [_vehicle, "CAS"] call AW_fnc_vehicleCustomization;
    };

    // Mirage V (CAP)
    case 110: {
        _vehicle = CV("PRACS_MirageV");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };


    /**********************/
    /**** Attack Helis ****/
    /**********************/

    // AH-64D Apache
    case 201: {
        _vehicle = CV("RHS_AH64D");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // AH-1Z Viper
    case 202: {
        _vehicle = CV("RHS_AH1Z");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // Ka-52 Hokum-B
    case 203: {
        _vehicle = CV("RHS_Ka52_vvsc");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };


    // Mi-28N Havoc
    case 204: {
        _vehicle = CV("rhs_mi28n_vvsc");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // Mi-24G Super Hind
    case 205: {
        _vehicle = CV("rhsgref_mi24g_CAS");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // AH-6M Little Bird
    case 206: {
        _vehicle = CV("RHS_MELB_AH6M");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // UH-60M Black Hawk (ESSS)
    case 207: {
        _vehicle = CV("RHS_UH60M_ESSS_d");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // AW159 Wildcat AH1 (CAS)
    case 208: {
        _vehicle = CV("UK3CB_BAF_Wildcat_AH1_CAS_8A_DDPM");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };


    /***************/
    /**** VTOLs ****/
    /***************/


    /*************************/
    /**** Transport Helis ****/
    /*************************/

    // MI-290 Taru (Bench)


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

    /***************/
    /**** Tonks ****/
    /***************/

    // Enhanced T-90M
    case 603: {
        _vehicle = CV("rhs_t90sm_tv");

        for "_i" from 1 to 8 do {
            _vehicle removeMagazineGlobal "rhs_mag_762x54mm_250";
        };

        _vehicle removeWeaponTurret ["rhs_weap_pkt", [0]];

        _vehicle addWeaponTurret ["RHS_M2_Abrams_Gunner", [0]];

        for "_i" from 1 to 6 do {
            _vehicle addMagazineTurret ["rhs_mag_200rnd_127x99_SLAP_mag_Tracer_Red", [0]];
        };

        _vehicle removeMagazineTurret ["rhs_mag_3bm46_8", [0]];
        _vehicle removeMagazineTurret ["rhs_mag_3bk31_3", [0]];
        _vehicle removeMagazineTurret ["rhs_mag_3of26_7", [0]];
        _vehicle removeMagazineTurret ["rhs_mag_9m119_4", [0]];
        _vehicle addMagazineTurret ["rhs_mag_3bm46", [0]];
        _vehicle addMagazineTurret ["rhs_mag_3bk31", [0]];
        _vehicle addMagazineTurret ["rhs_mag_3of26", [0]];
        _vehicle addMagazineTurret ["rhs_mag_9m119m_6", [0]];
        _vehicle addMagazineTurret ["rhs_mag_9m119f_6", [0]];

        for "_i" from 1 to 4 do {
            _vehicle addMagazineTurret ["rhs_mag_127x108mm_150", [0,0]];
        };

        [_vehicle] call AW_fnc_vehicleCustomization;
    };


    // Enhanced M1A2SEPv2
    case 602: {
        _vehicle = CV("rhsusf_m1a2sep2d_usarmy");

        for "_i" from 1 to 8 do {
            _vehicle removeMagazineGlobal "rhs_mag_762x51_M240_1200";
        };

        _vehicle removeWeaponTurret ["rhs_weap_m240_abrams_coax", [0]];
        _vehicle addWeaponTurret ["RHS_M2_Abrams_Gunner", [0]];

        for "_i" from 1 to 6 do {
            _vehicle addMagazineTurret ["rhs_mag_200rnd_127x99_SLAP_mag_Tracer_Red", [0]];
        };

        _vehicle removeMagazineTurret ["rhs_mag_M829A3", [0]];
        _vehicle removeMagazineTurret ["rhs_mag_M830A1", [0]];
        _vehicle addMagazineTurret ["rhs_mag_M829A4_max", [0]];
        _vehicle addMagazineTurret ["rhs_mag_M1147_max", [0]];
        _vehicle addMagazineTurret ["rhs_mag_M416", [0]];

        for "_i" from 1 to 4 do {
            _vehicle addMagazineTurret ["rhs_mag_400rnd_127x99_SLAP_mag_Tracer_Red", [0,0]];
        };

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // M60S Pantera
    case 608: {
        _vehicle = CV("PRACS_M60S");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // M1A2SEPv2
    case 610: {
        _vehicle = CV("rhsusf_m1a2sep2d_usarmy");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // M1A2SEPv1 (TUSK II)
    case 611: {
        _vehicle = CV("rhsusf_m1a2sep1tuskiid_usarmy");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // T-80UM
    case 609: {
        _vehicle = CV("rhs_t80um");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // T-90M
    case 607: {
        _vehicle = CV("rhs_t90sm_tv");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };


    /**************/
    /**** IFVs ****/
    /**************/

    // Enhanced M2A3 (BUSK III)
    case 707: {
        _vehicle = CV("RHS_M2A3_BUSKIII");

        for "_i" from 1 to 2 do {
            _vehicle removeMagazineGlobal "rhs_mag_1100Rnd_762x51_M240";
        };

        _vehicle removeWeaponTurret ["rhs_weap_m240_bradley_coax", [0]];

        _vehicle addWeaponTurret ["RHS_M2_Abrams_Gunner", [0]];

        for "_i" from 1 to 6 do {
            _vehicle addMagazineTurret ["rhs_mag_200rnd_127x99_SLAP_mag_Tracer_Red", [0]];
        };

        _vehicle addMagazineTurret ["rhs_mag_70Rnd_25mm_M242_APFSDS", [0]];
        _vehicle addMagazineTurret ["rhs_mag_70Rnd_25mm_M242_APFSDS", [0]];

        _vehicle addMagazineTurret ["rhs_mag_230Rnd_25mm_M242_HEI", [0]];
        _vehicle addMagazineTurret ["rhs_mag_230Rnd_25mm_M242_HEI", [0]];

        _vehicle addMagazineTurret ["rhs_mag_2Rnd_TOW2A", [0]];
        _vehicle addMagazineTurret ["rhs_mag_2Rnd_TOW2A", [0]];
        _vehicle addMagazineTurret ["rhs_mag_2Rnd_TOW2B_AERO", [0]];
        _vehicle addMagazineTurret ["rhs_mag_2Rnd_TOW2BB", [0]];

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // Enhanced BMD-2M
    case 711: {
        _vehicle = CV("rhs_bmd2m");

        for "_i" from 1 to 8 do {
            _vehicle removeMagazineGlobal "rhs_mag_762x54mm_250";
        };

        _vehicle removeWeaponTurret ["rhs_weap_pkt", [0]];

        _vehicle addWeaponTurret ["RHS_M2_Abrams_Gunner", [0]];

        for "_i" from 1 to 6 do {
            _vehicle addMagazineTurret ["rhs_mag_200rnd_127x99_SLAP_mag_Tracer_Red", [0]];
        };

        _vehicle removeMagazineTurret ["rhs_mag_3uof8_180", [0]];
        _vehicle removeMagazineTurret ["rhs_mag_3ubr8_120", [0]];

        _vehicle addMagazineTurret ["rhs_mag_3ubr11_250", [0]];
        _vehicle addMagazineTurret ["rhs_mag_3ubr11_250", [0]];

        _vehicle addMagazineTurret ["rhs_mag_3uof8_305", [0]];
        _vehicle addMagazineTurret ["rhs_mag_3uof8_305", [0]];

        _vehicle addMagazineTurret ["rhs_mag_9m133_2", [0]];
        _vehicle addMagazineTurret ["rhs_mag_9m133_2", [0]];

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // Enhanced BMD-4M(A)
    case 709: {
        _vehicle = CV("rhs_bmd4ma_vdv");

        for "_i" from 1 to 16 do {
            _vehicle removeMagazineGlobal "rhs_mag_762x54mm_250";
        };

        _vehicle removeWeaponTurret ["rhs_weap_pkt_bmd_coax", [0]];

        _vehicle addWeaponTurret ["RHS_M2_Abrams_Gunner", [0]];

        for "_i" from 1 to 6 do {
            _vehicle addMagazineTurret ["rhs_mag_200rnd_127x99_SLAP_mag_Tracer_Red", [0]];
        };

        _vehicle removeMagazineTurret ["rhs_mag_3uof8_180", [0]];
        _vehicle removeMagazineTurret ["rhs_mag_3ubr8_120", [0]];

        _vehicle addMagazineTurret ["rhs_mag_3ubr11_250", [0]];
        _vehicle addMagazineTurret ["rhs_mag_3ubr11_250", [0]];

        _vehicle addMagazineTurret ["rhs_mag_3uof8_305", [0]];
        _vehicle addMagazineTurret ["rhs_mag_3uof8_305", [0]];

        _vehicle addMagazineTurret ["rhs_mag_9m117m1_8", [0]];
        _vehicle addMagazineTurret ["rhs_mag_9m117m1_8", [0]];

        _vehicle addMagazineTurret ["rhs_mag_762x54mm_2000", [1]];
        _vehicle addMagazineTurret ["rhs_mag_762x54mm_2000", [1]];

        _vehicle addMagazineTurret ["rhs_mag_762x54mm_2000", [2]];
        _vehicle addMagazineTurret ["rhs_mag_762x54mm_2000", [2]];

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // ASCOD Pizarro SLE
    case 710: {
        _vehicle = CV("PRACS_Pizarro_SLE");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // FV-107 Scimitar
    case 703: {
        _vehicle = CV("PRACS_FV107");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // FV-101 Scorpion
    case 701: {
        _vehicle = CV("PRACS_FV101");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // BMD-2M
    case 714: {
        _vehicle = CV("rhs_bmd2m");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // M2A3
    case 704: {
        _vehicle = CV("RHS_M2A3");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // M2A3 (BUSK III)
    case 706: {
        _vehicle = CV("RHS_M2A3_BUSKIII");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // BMD-4M(A)
    case 708: {
        _vehicle = CV("rhs_bmd4ma_vdv");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // FV-510 Warrior
    case 712: {
        _vehicle = CV("UK3CB_BAF_Warrior_A3_D_Cage_Camo");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };


    /****************/
    /**** SPAAGs ****/
    /****************/

    // M6A2
    case 801: {
        _vehicle = CV("RHS_M6");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // 2S6M Tunguska
    case 802: {
        _vehicle = CV("PRACS_SLA_2S6M_Tunguska");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // M-163A3 Machbet
    case 803: {
        _vehicle = CV("M-163A3 Machbet");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };


    /**************/
    /**** APCs ****/
    /**************/

    // VEC-MGS
    case 901: {
        _vehicle = CV("PRACS_VEC_MGS");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // VEC-M1
    case 902: {
        _vehicle = CV("PRACS_VEC_M242");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };


    // M88 Hercules
    case 903: {
        _vehicle = CV("PRACS_M88");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };


    // BMR-600 TOW ATGM
    case 904: {
        _vehicle = CV("PRACS_BMR_ATGM_TOW");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // BMR-600 ATGM
    case 905: {
        _vehicle = CV("PRACS_BMR_ATGM");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // BMR-600 20MM
    case 906: {
        _vehicle = CV("PRACS_BMR_A3_GA1");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // Stryker TOW
    case 907: {
        _vehicle = CV("rhsusf_stryker_m1134_d");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };


    /***************/
    /**** MRAPs ****/
    /***************/


    // Humvee TOW
    case 1002: {
        _vehicle = CV("rhsusf_m1045_d");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // M1117 ASV
    case 1001: {
        _vehicle = CV("rhsusf_M1117_D");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // Hunter (Titan AT)

    /**************/
    /**** Cars ****/
    /**************/


    /**************/
    /**** Misc ****/
    /**************/

};

_vehicle
