/*
 * Author: Whigital
 *
 * Lookup vehicle family key and return random/weighted classname
 * for vehicle creation. Used in respawn script to randomize FOB vehicles.
 *
 */

params ["_vehKey"];

private _vehType = nil;
private _typeDesc = nil;

switch (_vehKey) do {

    // Aircraft
    case "JET_CAS": {
        _vehType = selectRandomWeighted [
            "RHS_A10", 3,
            "PRACS_F16CJR", 2
        ];

        _typeDesc = "Attack Jet (CAS)";
    };

    // Aircraft prairie fire
    case "JET_CAS_PF": {
        _vehType = selectRandomWeighted [
            "vn_b_air_f4b_usmc_cas", 2,
            "vn_b_air_f100d_cas", 2
        ];

        _typeDesc = "Attack Jet (CAS)";
    };

    case "JET_CAP": {
        _vehType = selectRandomWeighted [
            "rhsusf_f22", 1,
            "PRACS_F16", 2
        ];

        _typeDesc = "Fighter Jet (CAP)";
    };

    // Heli CAS
    case "HELI_CAS": {
        _vehType = selectRandomWeighted [
            "RHS_AH64D", 1,
            "RHS_AH1Z", 1,
            "rhsgref_mi24g_CAS", 1
        ];

        _typeDesc = "Heli Gunship (CAS)";
    };

    case "HELI_LCAS": {
        _vehType = selectRandomWeighted [
            "RHS_UH1Y_FFAR_d", 2,
            "RHS_UH60M_ESSS_d", 3,
            "RHS_MELB_AH6M", 3,
            "UK3CB_BAF_Wildcat_AH1_CAS_8D_DDPM", 1
        ];

        _typeDesc = "Attack Heli (Light)";
    };

    // Heli Transport
    case "HELI_MED": {
        _vehType = selectRandomWeighted [
            "UK3CB_BAF_Wildcat_HMA2_TRN_8A_DDPM", 2,
            "RHS_UH60M", 3,
            "RHS_UH1Y_d", 2
        ];

        _typeDesc = "Heli (Medium)";
    };

    case "HELI_BIG": {
        _vehType = selectRandomWeighted [
            "UK3CB_BAF_Merlin_HC4_18_GPMG_DDPM", 3,
            "rhsusf_CH53E_USMC_D", 1,
            "RHS_CH_47F", 2
        ];

        _typeDesc = "Heli (Heavy)";
    };

    //prairie fire gunships
    case "HELI_GUNSHIP_PF": {
        _vehType = selectRandomWeighted [
            "vn_b_air_ah1g_03", 1,
            "vn_b_air_ah1g_04", 1,
            "vn_b_air_ah1g_05", 1,
            "vn_b_air_ah1g_01", 1,
            "vn_b_air_ah1g_08", 1,
            "vn_b_air_ah1g_09", 1,
            "vn_b_air_ah1g_10", 1,
            "vn_b_air_ah1g_06", 1
        ];

        _typeDesc = "Heli Gunship (CAS)";
    };

    //Heavy CAS heli prairie fire
    case "HELI_HCAS_PF": {
        _vehType = selectRandomWeighted [
            "vn_b_air_uh1e_02_04", 1,
            "vn_b_air_uh1c_05_01", 1,
            "vn_b_air_uh1c_03_01", 1,
            "vn_b_air_uh1d_03_06", 1,
            "vn_b_air_uh1c_06_01", 1
        ];

        _typeDesc = "Attack Heli (HCAS)";
    };

    //CAS heli prairie fire
    case "HELI_CAS_PF": {
        _vehType = selectRandomWeighted [
            "vn_b_air_uh1c_01_01", 2,
            "vn_b_air_uh1c_04_01", 2,
            "vn_b_air_uh1c_02_01", 2,
            "vn_b_air_uh1e_01_04", 2,
            "vn_b_air_ch34_04_01", 1,
            "vn_b_air_ch34_04_04", 1,
            "vn_b_air_ch34_04_02", 1
        ];

        _typeDesc = "Attack Heli (CAS)";
    };

    //Light CAS heli prairie fire
    case "HELI_LCAS_PF": {
        _vehType = selectRandomWeighted [
            "vn_b_air_oh6a_03", 1,
            "vn_b_air_oh6a_02", 1,
            "vn_b_air_oh6a_05", 1,
            "vn_b_air_oh6a_04", 1,
            "vn_b_air_oh6a_07", 1
        ];

        _typeDesc = "Attack Heli (LCAS)";
    };

    // Heli Transport PF
    case "HELI_BIG_PF": {
        _vehType = selectRandomWeighted [
            "vn_b_air_ch34_03_01", 3,
            "vn_b_air_ch34_01_01", 1
        ];

        _typeDesc = "Heli (Heavy)";
    };
    case "HELI_MED_PF": {
        _vehType = selectRandomWeighted [
            "vn_b_air_uh1d_02_01", 1,
            "vn_b_air_uh1c_07_01", 1,
            "vn_b_air_uh1c_07_06", 1,
            "vn_b_air_uh1d_02_06", 1
        ];

        _typeDesc = "Heli (Medium)";
    };
    case "HELI_SML_PF": {
        _vehType = selectRandomWeighted [
             "vn_b_air_oh6a_01", 1
        ];

        _typeDesc = "Heli (Small)";
    };

    // Armor
    case "ARMOR_TANK": {
        _vehType = selectRandomWeighted [
            "rhsusf_m1a2sep1tuskiiwd_usarmy", 1,
            "rhsusf_m1a2sep2wd_usarmy", 2
        ];

        _typeDesc = "Armor (Tank)";
    };

    case "ARMOR_TANK_PF": {
        _vehType = selectRandomWeighted [
            "vn_b_armor_m41_01_01", 1,
            "vn_b_armor_m41_01_02", 1
        ];

        _typeDesc = "Armor (Tank)";
    };

    case "ARMOR_IFV": {
        _vehType = selectRandom [
            "RHS_M2A3",
            "RHS_M2A3_BUSKIII"
        ];

        _typeDesc = "Armor (IFV)";
    };


    // Cars
    case "CAR_MRAP": {
        _vehType = selectRandomWeighted [
            "rhsusf_m1240a1_usarmy_d", 3,
            "rhsusf_m1240a1_m2crows_usarmy_d", 2,
            "rhsusf_m1240a1_mk19_uik_usarmy_d", 2,
            "rhsusf_m1240a1_mk19crows_usarmy_d", 1
        ];

        _typeDesc = "Car (MRAP)";
    };

    case "CAR_LSV": {
        _vehType = selectRandomWeighted [
            "rhsusf_m1151_m2crows_usarmy_d", 1,
            "rhsusf_m1165_usarmy_d", 2,
            "rhsusf_m998_d_4dr", 2,
            "rhsusf_m998_d_2dr", 2
        ];

        _typeDesc = "Car (LSV)";
    };

    case "SUPPORT_PF": {
        _vehType = selectRandomWeighted [
            "vn_b_wheeled_m54_mg_03", 2,
            "vn_b_wheeled_m54_mg_01", 2,
            "vn_b_wheeled_m54_mg_02", 2,
            "vn_b_armor_m113_acav_04", 1,
            "vn_b_armor_m113_acav_02", 1,
            "vn_b_armor_m113_acav_05", 1,
            "vn_b_armor_m113_acav_06", 1,
            "vn_b_armor_m113_acav_04_rok_army", 1,
            "vn_b_armor_m113_acav_02_rok_army", 1,
            "vn_b_armor_m113_acav_05_rok_army", 1,
            "vn_b_armor_m113_acav_06_rok_army", 1
        ];

        _typeDesc = "Support vehicle";
    };

    case "TRANSPORT_PF": {
        _vehType = selectRandomWeighted [
            "vn_b_armor_m113_01", 1,
            "vn_b_armor_m113_acav_03", 1,
            "vn_b_armor_m113_acav_01", 1,
            "vn_b_armor_m113_01_rok_army", 1,
            "vn_b_armor_m113_acav_01_rok_army", 1,
            "vn_b_armor_m113_acav_03_rok_army", 1,
            "vn_b_armor_m113_01_aus_army", 1
        ];

        _typeDesc = "Transport";
    };

    case "SUPPORT_LIGHT_PF": {
        _vehType = selectRandomWeighted [
            "vn_b_wheeled_m151_mg_03", 1,
            "vn_b_wheeled_m151_mg_06", 1,
            "vn_b_wheeled_m151_mg_05", 1
        ];

        _typeDesc = "Light support vehicle";
    };

    case "TRANSPORT_LIGHT_PF": {
        _vehType = selectRandomWeighted [
            "vn_b_wheeled_m151_02", 1,
            "vn_b_wheeled_m151_mg_02", 1,
            "vn_b_wheeled_m151_mg_04", 1,
            "vn_b_wheeled_m151_01", 1,
            "vn_b_wheeled_m54_01", 1,
            "vn_b_wheeled_m54_02", 1
        ];

        _typeDesc = "Light transport";
    };

    case "BOAT_PF": {
        _vehType = selectRandomWeighted [
            "vn_b_boat_12_04", 2,
            "vn_b_boat_13_04", 2,
            "vn_b_boat_06_02", 2,
            "vn_b_boat_05_02", 2,
            "vn_b_boat_10_01", 1,
            "vn_b_boat_09_01", 1,
            "vn_b_boat_11_01", 1
        ];

        _typeDesc = "Boat";
    };


    // Cars Western Sahara
    case "CAR_MRAP_WS": {
        _vehType = selectRandomWeighted [
            "B_UN_MRAP_01_lxWS", 3,
            "B_D_MRAP_01_gmg_lxWS", 2,
            "B_D_MRAP_01_hmg_lxWS", 1,
            "B_ION_Offroad_armed_lxWS", 1
        ];

        _typeDesc = "Car (MRAP)";
    };

    case "CAR_LSV_WS": {
        _vehType = selectRandomWeighted [
            "B_ION_Offroad_armed_lxWS", 1,
            "B_ION_Offroad_lxWS", 2,
            "B_UN_Offroad_Armor_lxWS", 2
        ];

        _typeDesc = "Car (LSV)";
    };

    // Aircraft Western Sahara
    case "JET_CAS_WS": {
        _vehType = selectRandomWeighted [
            "B_Plane_Fighter_01_F", 1,
            "B_D_Plane_CAS_01_dynamicLoadout_lxWS", 3,
            "I_Plane_Fighter_03_dynamicLoadout_F", 2
        ];

        _typeDesc = "Attack Jet (CAS)";
    };

    // Heli CAS Western Sahara
    case "HELI_CAS_WS": {
        _vehType = selectRandomWeighted [
            "O_SFIA_Heli_Attack_02_dynamicLoadout_lxWS", 1,
            "B_D_Heli_Attack_01_dynamicLoadout_lxWS", 2
        ];

        _typeDesc = "Heli Gunship (CAS)";
    };

    case "HELI_LCAS_WS": {
        _vehType = selectRandomWeighted [
            "B_D_Heli_Light_01_dynamicLoadout_lxWS", 2,
            "I_Heli_light_03_dynamicLoadout_F", 3,
            "B_ION_Heli_Light_02_dynamicLoadout_lxWS", 1
        ];

        _typeDesc = "Attack Heli (Light)";
    };

    // Heli Transport Western Sahara
    case "HELI_MED_WS": {
        _vehType = selectRandomWeighted [
            "B_D_Heli_Transport_01_lxWS", 2,
            "I_Heli_light_03_unarmed_F", 4,
            "B_UN_Heli_Transport_02_lxWS", 1
        ];

        _typeDesc = "Heli (Medium)";
    };

    // Armor Western Sahara
    case "ARMOR_TANK_WS": {
        _vehType = selectRandomWeighted [
            "B_D_MBT_01_TUSK_lxWS", 1,
            "B_D_MBT_01_cannon_lxWS", 2
        ];

        _typeDesc = "Armor (Tank)";
    };

   case "ARMOR_IFV_WS": {
        _vehType = selectRandom [
            "B_D_APC_Wheeled_01_cannon_lxWS",
            "B_ION_APC_Wheeled_02_hmg_lxWS",
            "B_D_APC_Tracked_01_rcws_lxWS"
        ];

        _typeDesc = "Armor (IFV)";
    };
};

[_vehType, _typeDesc]
