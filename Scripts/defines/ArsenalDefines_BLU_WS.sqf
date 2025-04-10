// Make sure to only run once ....
if (!isNil "InA_ArsenalDefinitionsInitialized") exitWith {};

InA_ArsenalDefinitionsInitialized = false;


// Items, optics and accessories all slots have access to.
InA_AllowedArsenal_generalItems = [
    //Optics:
    "optic_Aco", "optic_ACO_grn", "optic_ACO_grn_smg", "optic_Aco_smg",
    "optic_Arco", "optic_Arco_blk_F", "optic_Arco_arid_F", "optic_Arco_lush_F",
    "optic_ERCO_khk_F", "optic_ERCO_snd_F", "optic_ERCO_blk_F",
    "optic_Hamr", "optic_Hamr_khk_F",
    "optic_Holosight", "optic_Holosight_blk_F", "optic_Holosight_khk_F", "optic_Holosight_arid_F", "optic_Holosight_lush_F",
    "optic_Holosight_smg", "optic_Holosight_smg_blk_F", "optic_Holosight_smg_khk_F",
    "optic_Arco_AK_arid_F", "optic_Arco_AK_blk_F", "optic_Arco_AK_lush_F",
    "optic_ico_01_f", "optic_ico_01_black_f", "optic_ico_01_camo_f", "optic_ico_01_sand_f",
    "optic_MRD", "optic_MRD_black",
    "optic_MRCO",
    "optic_NVS",
    "optic_Yorris",
	"optic_Holosight_snake_lxWS", "optic_Holosight_smg_snake_lxWS", "optic_Hamr_snake_lxWS", "optic_r1_high_snake_lxWS", "optic_r1_low_snake_lxWS", 

    //Accessories:
    "acc_flashlight", "acc_flashlight_smg_01", "acc_pointer_IR",
	"acc_pointer_IR_snake_lxWS", "saber_light_ir_lxWS", "saber_light_ir_snake_lxWS",

    //Suppressors:
    "muzzle_snds_B", "muzzle_snds_B_khk_F", "muzzle_snds_B_snd_F",
    "muzzle_snds_H", "muzzle_snds_H_khk_F", "muzzle_snds_H_snd_F",
    "muzzle_snds_M", "muzzle_snds_m_khk_F", "muzzle_snds_m_snd_F",
    "muzzle_snds_H_MG", "muzzle_snds_H_MG_blk_F", "muzzle_snds_H_MG_khk_F",
    "muzzle_snds_338_black", "muzzle_snds_338_sand",
    "muzzle_snds_B_lush_F", "muzzle_snds_B_arid_F",
    "muzzle_snds_93mmg", "muzzle_snds_93mmg_tan",
    "muzzle_snds_65_TI_blk_F",
    "muzzle_snds_58_blk_F",
    "muzzle_snds_570",
    "muzzle_snds_acp",
    "muzzle_snds_L",
	"suppressor_l_lxWS", "suppressor_l_arid_lxWS", "suppressor_l_snake_lxWS",

    //Bipods:
    "bipod_01_F_blk", "bipod_01_F_khk", "bipod_01_F_mtp", "bipod_01_F_snd",
    "bipod_02_F_blk", "bipod_02_F_tan", "bipod_02_F_lush", "bipod_02_F_arid",
    "bipod_03_F_blk", "bipod_03_F_oli",

    //Handgun Accessories:
    "acc_flashlight_pistol",

    //Night Vision Goggles:
    "NVGoggles", "NVGoggles_INDEP", "NVGoggles_OPFOR", "NVGoggles_tna_F", "O_NVGoggles_grn_F",

    //Binoculars:
    "Binocular", "Rangefinder", "Laserdesignator", "Laserdesignator_01_khk_F", "Laserdesignator_03", "Camera_lxWS",

    //Map, GPS, Radio, Compass, Watch:
    "ItemMap", "ItemGPS", "ItemCompass", "ItemWatch",

    //Other:
    "FirstAidKit", "Medikit", "ToolKit", "MineDetector"
];

InA_AllowedArsenal_reconItems = [
    "NVGogglesB_blk_F", "NVGogglesB_grn_F", "NVGogglesB_gry_F"
];

// UAV Item(s)
InA_AllowedArsenal_uavItems = ["B_UavTerminal"];


// TFAR Radio Backpacks
if (isClass (configFile >> "CfgPatches" >> "task_force_radio")) then {
    InA_AllowedArsenal_generalItems append ["TFAR_rf7800str", "TFAR_anprc152", "TFAR_microdagr"];

    InA_AllowedArsenal_tfarBackPacks = [
        "TFAR_rt1523g", "TFAR_rt1523g_big", "TFAR_rt1523g_black", "TFAR_rt1523g_fabric", "TFAR_rt1523g_green", "TFAR_rt1523g_rhs", "TFAR_rt1523g_sage", "TFAR_anarc210"
    ];
} else {
    InA_AllowedArsenal_generalItems append ["ItemRadio"];
};


// Magazines all slots have access to.
InA_AllowedArsenal_generalMagazines = [
    // LIM
    "200Rnd_556x45_Box_F", "200Rnd_556x45_Box_Red_F", "200Rnd_556x45_Box_Tracer_F", "200Rnd_556x45_Box_Tracer_Red_F",

    // Mk200
    "200Rnd_65x39_cased_Box", "200Rnd_65x39_cased_Box_Tracer", "200Rnd_65x39_cased_Box_Red", "200Rnd_65x39_cased_Box_Tracer_Red",

    // Zafir
    "150Rnd_762x54_Box", "150Rnd_762x54_Box_Tracer",

    // MX
    "30Rnd_65x39_caseless_mag", "30Rnd_65x39_caseless_mag_Tracer", "30Rnd_65x39_caseless_black_mag", "30Rnd_65x39_caseless_black_mag_Tracer", "30Rnd_65x39_caseless_khaki_mag", "30Rnd_65x39_caseless_khaki_mag_Tracer",
    "100Rnd_65x39_caseless_mag", "100Rnd_65x39_caseless_khaki_mag", "100Rnd_65x39_caseless_black_mag", "100Rnd_65x39_caseless_mag_Tracer", "100Rnd_65x39_caseless_khaki_mag_tracer", "100Rnd_65x39_caseless_black_mag_tracer",

    // SPAR-16, XMS
    "150Rnd_556x45_Drum_Mag_F", "150Rnd_556x45_Drum_Mag_Tracer_F", "150Rnd_556x45_Drum_Sand_Mag_F", "150Rnd_556x45_Drum_Sand_Mag_Tracer_F", "150Rnd_556x45_Drum_Green_Mag_F", "150Rnd_556x45_Drum_Green_Mag_Tracer_F",
    "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag_Tracer_Red", "30Rnd_556x45_Stanag_Tracer_Green", "30Rnd_556x45_Stanag_Tracer_Yellow", "30Rnd_556x45_Stanag_red", "30Rnd_556x45_Stanag_green",
    "30Rnd_556x45_Stanag_Sand", "30Rnd_556x45_Stanag_Sand_green", "30Rnd_556x45_Stanag_Sand_red", "30Rnd_556x45_Stanag_Sand_Tracer_Red", "30Rnd_556x45_Stanag_Sand_Tracer_Green", "30Rnd_556x45_Stanag_Sand_Tracer_Yellow",

    // Katiba
    "30Rnd_65x39_caseless_green", "30Rnd_65x39_caseless_green_mag_Tracer",

    // Promet
    "30Rnd_65x39_caseless_msbs_mag_Tracer", "30Rnd_65x39_caseless_msbs_mag",
    "10Rnd_50BW_Mag_F",

    // AKS-74
    "30Rnd_545x39_Mag_F", "30Rnd_545x39_Mag_Green_F", "30Rnd_545x39_Mag_Tracer_F", "30Rnd_545x39_Mag_Tracer_Green_F",

    // AKM/AK-12
    "30Rnd_762x39_Mag_F", "30Rnd_762x39_Mag_Green_F", "30Rnd_762x39_Mag_Tracer_F", "30Rnd_762x39_Mag_Tracer_Green_F",
    "30Rnd_762x39_AK12_Mag_F", "30Rnd_762x39_AK12_Mag_Tracer_F", "30rnd_762x39_AK12_Arid_Mag_F", "30rnd_762x39_AK12_Arid_Mag_Tracer_F", "30rnd_762x39_AK12_Lush_Mag_F", "30rnd_762x39_AK12_Lush_Mag_Tracer_F",
    "75Rnd_762x39_Mag_F", "75Rnd_762x39_Mag_Tracer_F", "75rnd_762x39_AK12_Mag_F", "75rnd_762x39_AK12_Mag_Tracer_F",
    "75rnd_762x39_AK12_Lush_Mag_F", "75rnd_762x39_AK12_Lush_Mag_Tracer_F", "75rnd_762x39_AK12_Arid_Mag_F", "75rnd_762x39_AK12_Arid_Mag_Tracer_F",

    // CAR-95
    "30Rnd_580x42_Mag_F", "30Rnd_580x42_Mag_Tracer_F",
    "100Rnd_580x42_Mag_F", "100Rnd_580x42_Mag_Tracer_F",

    // Heavy MGs
    "130Rnd_338_Mag",
    "150Rnd_93x64_Mag",

    // SMGs
    "30Rnd_45ACP_Mag_SMG_01", "30Rnd_45ACP_Mag_SMG_01_Tracer_Green", "30Rnd_45ACP_Mag_SMG_01_Tracer_Red", "30Rnd_45ACP_Mag_SMG_01_Tracer_Yellow",
    "30Rnd_9x21_Mag", "30Rnd_9x21_Red_Mag", "30Rnd_9x21_Yellow_Mag", "30Rnd_9x21_Green_Mag",
    "30Rnd_9x21_Mag_SMG_02", "30Rnd_9x21_Mag_SMG_02_Tracer_Green", "30Rnd_9x21_Mag_SMG_02_Tracer_Yellow", "30Rnd_9x21_Mag_SMG_02_Tracer_Red",
    "50Rnd_570x28_SMG_03",
    "20Rnd_556x45_UW_mag",

    //Sniper/Marksman
    "5Rnd_127x108_APDS_Mag", "5Rnd_127x108_Mag",
    "10Rnd_127x54_Mag",
    "7Rnd_408_Mag",
    "10Rnd_93x64_DMR_05_Mag",
    "10Rnd_338_Mag",
    "10Rnd_762x51_Mag",
    "20Rnd_762x51_Mag",
    "10Rnd_Mk14_762x51_Mag",
    "20Rnd_650x39_Cased_Mag_F",
	"20Rnd_762x51_Mag_blk_lxWS", "20Rnd_762x51_Mag_snake_lxWS",

    // Handguns
    "16Rnd_9x21_Mag", "16Rnd_9x21_red_Mag", "16Rnd_9x21_green_Mag", "16Rnd_9x21_yellow_Mag",
    "10Rnd_9x21_Mag",
    "11Rnd_45ACP_Mag",
    "9Rnd_45ACP_Mag",
    "6Rnd_45ACP_Cylinder",

    // Shotgun
    "2Rnd_12Gauge_Pellets", "2Rnd_12Gauge_Slug",
    "6Rnd_12Gauge_Pellets", "6Rnd_12Gauge_Slug",
	"20Rnd_12Gauge_AA40_Pellets_lxWS", "20Rnd_12Gauge_AA40_Slug_lxWS", "20Rnd_12Gauge_AA40_Pellets_lxWS", "20Rnd_12Gauge_AA40_Slug_lxWS", "20Rnd_12Gauge_AA40_Smoke_lxWS", "20Rnd_12Gauge_AA40_HE_lxWS", "20Rnd_12Gauge_AA40_Pellets_Snake_lxWS", "20Rnd_12Gauge_AA40_Pellets_Tan_lxWS", "20Rnd_12Gauge_AA40_Slug_Snake_lxWS", 

    // Underbarrel Grenade Launcher Rounds:
    "1Rnd_HE_Grenade_shell",
    "3Rnd_HE_Grenade_shell",
    "1Rnd_Smoke_Grenade_shell", "1Rnd_SmokeBlue_Grenade_shell", "1Rnd_SmokeGreen_Grenade_shell", "1Rnd_SmokeOrange_Grenade_shell", "1Rnd_SmokePurple_Grenade_shell", "1Rnd_SmokeRed_Grenade_shell", "1Rnd_SmokeYellow_Grenade_shell",
    "3Rnd_Smoke_Grenade_shell", "3Rnd_SmokeBlue_Grenade_shell", "3Rnd_SmokeGreen_Grenade_shell", "3Rnd_SmokeOrange_Grenade_shell", "3Rnd_SmokePurple_Grenade_shell", "3Rnd_SmokeRed_Grenade_shell", "3Rnd_SmokeYellow_Grenade_shell",
    "UGL_FlareCIR_F", "UGL_FlareGreen_F", "UGL_FlareRed_F", "UGL_FlareWhite_F", "UGL_FlareYellow_F",
    "3Rnd_UGL_FlareCIR_F", "3Rnd_UGL_FlareGreen_F", "3Rnd_UGL_FlareRed_F", "3Rnd_UGL_FlareWhite_F", "3Rnd_UGL_FlareYellow_F",

    // Mines and Explosives:
    "DemoCharge_Remote_Mag",

    // Grenades:
    "SmokeShell", "SmokeShellBlue", "SmokeShellGreen", "SmokeShellOrange", "SmokeShellYellow",
    "Chemlight_blue", "Chemlight_green", "Chemlight_red", "Chemlight_yellow",
    "HandGrenade", "MiniGrenade",
    "B_IR_Grenade",

    // Rockets and Missiles:
    "MRAWS_HE_F", "MRAWS_HEAT55_F", "MRAWS_HEAT_F", "NLAW_F", "RPG32_F", "RPG32_HE_F", "RPG7_F", "Titan_AA", "Titan_AP", "Titan_AT", "Vorona_HE", "Vorona_HEAT",

    // Misc:
    "Laserbatteries"
];


// Recon optics
InA_AllowedArsenal_opticsRecon = ["optic_Nightstalker"];


// Marksman optics
InA_AllowedArsenal_opticsMarksman = [
    "optic_AMS", "optic_AMS_khk", "optic_AMS_snd",
    "optic_DMS", "optic_DMS_weathered_F", "optic_DMS_weathered_Kir_F",
    "optic_KHS_blk", "optic_KHS_tan", "optic_KHS_old",
    "optic_SOS", "optic_SOS_khk_F"
];


// Sniper optics
InA_AllowedArsenal_opticsSniper = [
    "optic_LRPS", "optic_LRPS_tna_F",
    "optic_Nightstalker",
    "optic_tws", "optic_tws_mg"
];


// Mines and explosives
InA_AllowedArsenal_Explosives = [
    "APERSBoundingMine_Range_Mag", "APERSMine_Range_Mag", "APERSTripMine_Wire_Mag", "ATMine_Range_Mag", "ClaymoreDirectionalMine_Remote_Mag",
    "IEDLandBig_Remote_Mag", "IEDLandSmall_Remote_Mag", "IEDUrbanBig_Remote_Mag", "IEDUrbanSmall_Remote_Mag", "SatchelCharge_Remote_Mag", "SLAMDirectionalMine_Wire_Mag",
    "TrainingMine_Mag"
];


// Underwater gun
InA_AllowedArsenal_underWaterGun = ["arifle_SDAR_F"];


// General Pistols
InA_AllowedArsenal_generalPistols = [
    "hgun_ACPC2_F", "hgun_P07_F", "hgun_P07_khk_F", "hgun_Pistol_01_F",
    "hgun_Pistol_heavy_01_F", "hgun_Pistol_heavy_02_F", "hgun_Rook40_F",
    "hgun_Rook40_snds_F", "hgun_Pistol_heavy_01_green_F"
];


// Sub Machine Guns
InA_AllowedArsenal_generalSMGs = [
    "hgun_PDW2000_F", "SMG_01_F", "SMG_02_F", "SMG_05_F", "SMG_03_black", "SMG_03_khaki", "SMG_03_TR_black", "SMG_03_TR_khaki", "SMG_03C_black", "SMG_03C_khaki",
    "SMG_03C_TR_black", "SMG_03C_TR_khaki", "sgun_HunterShotgun_01_sawedoff_F"
];


// Carbines
InA_AllowedArsenal_generalCarbines = [
    "arifle_AKS_F", "arifle_Katiba_C_F", "arifle_Mk20C_F", "arifle_Mk20C_plain_F", "arifle_MXC_Black_F", "arifle_MXC_F", "arifle_MXC_khk_F", "arifle_TRG20_F",
    "arifle_AK12U_F", "arifle_AK12U_arid_F", "arifle_AK12U_lush_F", "sgun_HunterShotgun_01_F", "arifle_MSBS65_F", "arifle_MSBS65_black_F", "arifle_MSBS65_sand_F",
	"arifle_XMS_M_Sand_lxWS", "sgun_aa40_lxWS", "sgun_aa40_snake_lxWS", "sgun_aa40_tan_lxWS"
];


// Pilot Carbines
InA_AllowedArsenal_pilotCarbines = [
    "arifle_MXC_Black_F", "arifle_MXC_F", "arifle_MXC_khk_F",
    "arifle_SPAR_01_blk_F", "arifle_SPAR_01_khk_F", "arifle_SPAR_01_snd_F"
];


// Assault rifles
InA_AllowedArsenal_generalAssaultRifles = [
    "arifle_AK12_F", "arifle_AK12_arid_F", "arifle_AK12_lush_F", "arifle_AKM_F", "arifle_AKM_FL_F", "arifle_CTAR_blk_F", 
    "arifle_Katiba_F", "arifle_Mk20_plain_F", "arifle_MX_Black_F", "arifle_MX_F", "arifle_MX_khk_F", "arifle_SPAR_01_blk_F", "arifle_SPAR_01_khk_F", 
    "arifle_SPAR_01_snd_F", "arifle_TRG21_F", "arifle_MSBS65_UBS_F", "arifle_MSBS65_UBS_black_F", "arifle_MSBS65_UBS_sand_F",
	"arifle_XMS_Base_lxWS", "arifle_XMS_Base_Sand_lxWS", "arifle_XMS_M_lxWS", "arifle_XMS_M_Sand_lxWS"
];


// Underslung Assault rifles
InA_AllowedArsenal_assaultRiflesUGL = [
    "arifle_AK12_GL_F", "arifle_AK12_GL_arid_F", "arifle_AK12_GL_lush_F", "arifle_CTAR_GL_blk_F", "arifle_Katiba_GL_F",
    "arifle_Mk20_GL_plain_F", "arifle_MX_GL_Black_F", "arifle_MX_GL_F", "arifle_MX_GL_khk_F", "arifle_SPAR_01_GL_blk_F", "arifle_SPAR_01_GL_khk_F",
    "arifle_SPAR_01_GL_snd_F", "arifle_TRG21_GL_F", "arifle_MSBS65_GL_F", "arifle_MSBS65_GL_black_F", "arifle_MSBS65_GL_sand_F",
	"arifle_XMS_GL_lxWS", "arifle_XMS_GL_Sand_lxWS", "arifle_XMS_Shot_lxWS", "arifle_XMS_Shot_Sand_lxWS"
];

// Light/Medium Machine Guns
InA_AllowedArsenal_Machineguns = [
    "arifle_CTARS_blk_F", "arifle_MX_SW_Black_F", "arifle_MX_SW_F", "arifle_MX_SW_khk_F", "arifle_SPAR_02_blk_F",
    "arifle_SPAR_02_khk_F", "arifle_SPAR_02_snd_F", "LMG_03_F", "LMG_Mk200_F", "LMG_Mk200_black_F", "LMG_Zafir_F", "MMG_01_tan_F", "MMG_02_black_F", "MMG_02_camo_F",
    "MMG_02_sand_F", "arifle_RPK12_F", "arifle_RPK12_arid_F", "arifle_RPK12_lush_F", "LMG_Zafir_pointer_F"
];


// Designated Marksman Rifles
InA_AllowedArsenal_marksmanRifles = [
    "arifle_MXM_Black_F", "arifle_MXM_F", "arifle_MXM_khk_F", "arifle_SPAR_03_blk_F", "arifle_SPAR_03_khk_F", "arifle_SPAR_03_snd_F",
    "srifle_DMR_02_camo_F", "srifle_DMR_02_F", "srifle_DMR_02_sniper_F", "srifle_DMR_03_F", "srifle_DMR_03_khaki_F", "srifle_DMR_03_multicam_F", "srifle_DMR_03_tan_F",
    "srifle_DMR_03_woodland_F", "srifle_DMR_05_blk_F", "srifle_DMR_05_tan_f", "srifle_DMR_06_camo_F", "srifle_DMR_06_olive_F",
    "srifle_DMR_07_blk_F", "srifle_EBR_F", "srifle_DMR_06_hunter_F", "arifle_MSBS65_Mark_F",
    "arifle_MSBS65_Mark_black_F", "arifle_MSBS65_Mark_sand_F",
	"srifle_EBR_blk_lxWS", "srifle_EBR_snake_lxWS"
];


// Sniper Rifles
InA_AllowedArsenal_sniperRifles = [
    "srifle_DMR_02_camo_F", "srifle_DMR_02_F", "srifle_DMR_02_sniper_F", "srifle_GM6_F", "srifle_LRR_camo_F", "srifle_LRR_F", "srifle_LRR_tna_F",
	"srifle_EBR_blk_lxWS", "srifle_EBR_snake_lxWS"
];


// Light AT launchers
InA_AllowedArsenal_launchersLight = [
    "launch_RPG32_F", "launch_RPG7_F", "launch_MRAWS_green_rail_F", "launch_MRAWS_olive_rail_F",
    "launch_MRAWS_sand_rail_F", "launch_MRAWS_green_F", "launch_MRAWS_olive_F", "launch_MRAWS_sand_F", "launch_NLAW_F"
];


// Heavy Missile launchers
InA_AllowedArsenal_launchersHeavy = [
    "launch_B_Titan_F", "launch_B_Titan_olive_F",
    "launch_B_Titan_short_F", "launch_B_Titan_short_tna_F", "launch_B_Titan_tna_F",
    "launch_O_Vorona_brown_F", "launch_O_Vorona_green_F"
];


// Recon Rifles
InA_AllowedArsenal_reconRifles = [
    "arifle_ARX_blk_F", "srifle_DMR_04_F", "srifle_DMR_04_Tan_F"
];


// General Facewear
InA_AllowedArsenal_generalFacewear = [
    "G_Aviator", "G_B_Diving", "G_Balaclava_blk", "G_Balaclava_combat", "G_Balaclava_lowprofile", "G_Balaclava_oli", "G_Balaclava_TI_blk_F", "G_Balaclava_TI_G_blk_F",
    "G_Balaclava_TI_G_tna_F", "G_Balaclava_TI_tna_F", "G_Bandanna_aviator", "G_Bandanna_beast", "G_Bandanna_blk", "G_Bandanna_khk", "G_Bandanna_oli",
    "G_Bandanna_shades", "G_Bandanna_sport", "G_Bandanna_tan", "G_Combat", "G_Combat_Goggles_tna_F", "G_Diving", "G_EyeProtectors_Earpiece_F", "G_EyeProtectors_F",
    "G_Lady_Blue", "G_Lowprofile", "G_Shades_Black", "G_Shades_Blue", "G_Shades_Green", "G_Shades_Red", "G_Spectacles", "G_Spectacles_Tinted", "G_Sport_Blackred",
    "G_Sport_BlackWhite", "G_Sport_Blackyellow", "G_Sport_Checkered", "G_Sport_Greenblack", "G_Sport_Red", "G_Squares", "G_Squares_Tinted", "G_Tactical_Black",
    "G_Tactical_Clear", "G_AirPurifyingRespirator_01_F", "G_RegulatorMask_F", "G_AirPurifyingRespirator_02_black_F", "G_AirPurifyingRespirator_02_olive_F",
    "G_AirPurifyingRespirator_02_sand_F",
	"G_Balaclava_blk_lxWS", "G_Balaclava_oli_lxWS", "G_Balaclava_snd_lxWS", "G_Combat_lxWS", "G_Headset_lxWS"

];


// Medical facewaer
InA_AllowedArsenal_facewearMedic = [
    "G_Respirator_white_F"
];


// General Headgear
InA_AllowedArsenal_generalHeadgear = [
    "H_Bandanna_blu", "H_Bandanna_camo", "H_Bandanna_cbr", "H_Bandanna_gry", "H_Bandanna_khk", "H_Bandanna_khk_hs", "H_Bandanna_mcamo", "H_Bandanna_sand",
    "H_Bandanna_sgg", "H_Bandanna_surfer", "H_Bandanna_surfer_blk", "H_Bandanna_surfer_grn", "H_Booniehat_khk", "H_Booniehat_khk_hs", "H_Booniehat_mcamo",
    "H_Booniehat_oli", "H_Booniehat_tan", "H_Booniehat_tna_F", "H_Cap_blk", "H_Cap_blu", "H_Cap_grn", "H_Cap_grn_BI", "H_Cap_headphones", "H_Cap_khaki_specops_UK",
    "H_Cap_oli", "H_Cap_oli_hs", "H_Cap_red", "H_Cap_surfer", "H_Cap_tan", "H_Cap_tan_specops_US", "H_Cap_usblack", "H_HeadBandage_bloody_F",
    "H_HeadBandage_clean_F", "H_HeadBandage_stained_F", "H_MilCap_blue", "H_MilCap_gry", "H_MilCap_mcamo", "H_MilCap_tna_F", "H_Watchcap_blk",
    "H_Watchcap_camo", "H_Watchcap_cbr", "H_Watchcap_khk", "H_Booniehat_mgrn", "H_Booniehat_wdl", "H_MilCap_grn", "H_MilCap_wdl",
    "H_Booniehat_taiga", "H_Booniehat_eaf", "H_MilCap_taiga", "H_MilCap_eaf", "H_Shemag_olive", "H_Shemag_olive_hs", "H_ShemagOpen_tan",
    "H_ShemagOpen_khk", "H_MilCap_gen_F", "H_Beret_gen_F", "H_Beret_EAF_01_F", "H_Beret_02", "H_Beret_blk",
	"lxWS_H_bmask_base", "H_turban_02_mask_black_lxws", "lxWS_H_bmask_camo01", "H_turban_02_mask_snake_lxws", "lxWS_H_bmask_white", "lxWS_H_bmask_yellow",
	"lxWS_H_PASGT_goggles_UN_F", "lxWS_H_PASGT_goggles_black_F", "lxWS_H_PASGT_goggles_olive_F", "lxWS_H_PASGT_goggles_white_F", "lxWS_H_PASGT_basic_UN_F",
	"lxWS_H_Booniehat_desert", "H_Cap_headphones_ion_lxws", "lxWS_H_CapB_rvs_blk_ION"
	
];


// General Helmets
InA_AllowedArsenal_generalHelmets = [
    "H_Helmet_Skate", "H_HelmetB", "H_HelmetB_black", "H_HelmetB_camo", "H_HelmetB_desert", "H_HelmetB_Enh_tna_F", "H_HelmetB_grass", "H_HelmetB_light",
    "H_HelmetB_light_black", "H_HelmetB_light_desert", "H_HelmetB_light_grass", "H_HelmetB_light_sand", "H_HelmetB_light_snakeskin", "H_HelmetB_Light_tna_F",
    "H_HelmetB_sand", "H_HelmetB_snakeskin", "H_HelmetB_TI_tna_F", "H_HelmetB_tna_F", "H_HelmetCrew_B", "H_HelmetSpecB", "H_HelmetSpecB_blk",
    "H_HelmetSpecB_paint1", "H_HelmetSpecB_paint2", "H_HelmetSpecB_sand", "H_HelmetSpecB_snakeskin", "H_PASGT_basic_black_F", "H_PASGT_basic_blue_F",
    "H_PASGT_basic_olive_F", "H_PASGT_basic_white_F", "H_HelmetB_plain_wdl", "H_HelmetSpecB_wdl", "H_HelmetB_light_wdl", "H_HelmetHBK_headset_F",
    "H_HelmetHBK_chops_F", "H_HelmetHBK_ear_F", "H_HelmetHBK_F", "H_HelmetAggressor_cover_F", "H_HelmetAggressor_cover_taiga_F", "H_Tank_eaf_F",
    "H_HelmetCrew_I_E", "H_HelmetB_TI_arid_F", "H_HelmetAggressor_F",
	"lxWS_H_HelmetCrew_I", "lxWS_H_HelmetCrew_Blue", "lxWS_H_MilCap_desert",
	"lxWS_H_turban_03_black", "lxWS_H_turban_03_blue_una", "lxWS_H_turban_03_green", "lxWS_H_turban_03_orange", "lxWS_H_turban_03_sand", "lxWS_H_turban_03_yellow"
];


// EOD / Explosive Spec. Headgear
InA_AllowedArsenal_headgearEngineer = [
    "H_Construction_basic_black_F", "H_Construction_basic_orange_F", "H_Construction_basic_red_F", "H_Construction_basic_white_F", "H_Construction_basic_yellow_F",
    "H_Construction_earprot_black_F", "H_Construction_earprot_orange_F", "H_Construction_earprot_red_F", "H_Construction_earprot_white_F",
    "H_Construction_earprot_yellow_F", "H_Construction_headset_black_F", "H_Construction_headset_orange_F", "H_Construction_headset_red_F",
    "H_Construction_headset_white_F", "H_Construction_headset_yellow_F"
];


// Officer Berets
InA_AllowedArsenal_heagearOfficer = [
    "H_Beret_Colonel", "lxWS_H_Beret_Colonel"
];


// Pilot Headgear
InA_AllowedArsenal_headgearPilot = [
    "H_CrewHelmetHeli_B", "H_PilotHelmetFighter_B", "H_PilotHelmetHeli_B",
    "H_CrewHelmetHeli_I_E", "H_PilotHelmetFighter_I_E",  "H_PilotHelmetHeli_I_E",
    "H_Helmet_Skate", "H_Cap_headphones", "H_Cap_blk", "H_Cap_oli"
];


// General Uniforms
InA_AllowedArsenal_generalUniforms = [
    "U_I_C_Soldier_Para_1_F", "U_I_C_Soldier_Para_2_F", "U_I_C_Soldier_Para_3_F", "U_I_C_Soldier_Para_4_F", "U_I_C_Soldier_Para_5_F",
    "U_B_CombatUniform_mcam", "U_B_CombatUniform_mcam_tshirt", "U_B_CombatUniform_mcam_vest", "U_B_CombatUniform_mcam_worn", "U_B_CTRG_1", "U_B_CTRG_2", "U_B_CTRG_3",
    "U_B_CTRG_Soldier_2_F", "U_B_CTRG_Soldier_3_F", "U_B_CTRG_Soldier_F", "U_B_CTRG_Soldier_urb_1_F", "U_B_CTRG_Soldier_urb_2_F", "U_B_CTRG_Soldier_urb_3_F",
    "U_B_survival_uniform", "U_B_Wetsuit", "U_B_CombatUniform_mcam_wdl_f", "U_B_CombatUniform_tshirt_mcam_wdL_f", "U_B_CombatUniform_vest_mcam_wdl_f",
    "U_B_CombatUniform_vest_mcam_wdl_f", "U_B_CBRN_Suit_01_MTP_F", "U_B_CBRN_Suit_01_Tropic_F",
    "U_B_CBRN_Suit_01_Wdl_F", "U_I_E_Uniform_01_shortsleeve_F", "U_I_E_Uniform_01_sweater_F", "U_I_E_Uniform_01_tanktop_F",
    "U_I_E_Uniform_01_F", "U_I_L_Uniform_01_deserter_F", "U_O_R_Gorka_01_F", "U_O_R_Gorka_01_brown_F", "U_O_R_Gorka_01_camo_F", "U_O_R_Gorka_01_black_F",
    "U_I_G_resistanceLeader_F", "U_B_GEN_Soldier_F", "U_B_GEN_Commander_F", "U_B_CTRG_Soldier_Arid_F", "U_B_CTRG_Soldier_2_Arid_F", "U_B_CTRG_Soldier_3_Arid_F",
	"U_lxWS_B_CombatUniform_desert", "U_lxWS_B_CombatUniform_desert_tshirt", "U_lxWS_UN_Camo2", "U_lxWS_UN_Camo3", "U_lxWS_B_CombatUniform_desert_vest",
	"U_lxWS_ION_Casual2", "U_lxWS_ION_Casual3", "U_lxWS_ION_Casual6", "U_lxWS_ION_Casual5", "U_lxWS_ION_Casual4",
	"U_B_CTRG_3_lxWS", "U_B_CTRG_4_lxWS"
];


// Medic Uniforms
InA_AllowedArsenal_uniformsMedic = [
    "U_C_Paramedic_01_F",
    "U_C_ConstructionCoverall_Red_F"
];


// Marksman Uniforms
InA_AllowedArsenal_uniformsMarksman = [
    "U_B_GhillieSuit", "U_B_T_Sniper_F"
];


// Engineer Uniforms
InA_AllowedArsenal_uniformsEngineer = [
    "U_C_ConstructionCoverall_Black_F"
];


// Pilot Uniforms
InA_AllowedArsenal_uniformsPilot = [
    "U_B_HeliPilotCoveralls", "U_B_PilotCoveralls",
    "U_I_HeliPilotCoveralls", "U_I_pilotCoveralls",
    "U_I_E_Uniform_01_coveralls_F", "U_O_R_Gorka_01_black_F",
    "U_B_GEN_Soldier_F", "U_B_GEN_Commander_F",
	"U_lxWS_UN_Pilot"
];


// Sniper Ghillie
InA_AllowedArsenal_uniformsSniper = [
    "U_B_FullGhillie_ard", "U_B_FullGhillie_lsh", "U_B_FullGhillie_sard", "U_B_T_FullGhillie_tna_F"
];

// Officer Uniform
InA_AllowedArsenal_uniformsOfficer = [
    "U_I_E_Uniform_01_officer_F", "U_lxWS_UN_Camo1"
];


// General Vests
InA_AllowedArsenal_generalVests = [
    "V_BandollierB_blk", "V_BandollierB_cbr", "V_BandollierB_khk", "V_BandollierB_oli", "V_BandollierB_rgr", "V_Chestrig_blk", "V_Chestrig_khk", "V_Chestrig_oli",
    "V_Chestrig_rgr", "V_I_G_resistanceLeader_F", "V_LegStrapBag_black_F", "V_LegStrapBag_coyote_F", "V_LegStrapBag_olive_F", "V_PlateCarrier1_blk",
    "V_PlateCarrier1_rgr", "V_PlateCarrier1_rgr_noflag_F", "V_PlateCarrier1_tna_F", "V_PlateCarrier2_blk", "V_PlateCarrier2_rgr", "V_PlateCarrier2_rgr_noflag_F",
    "V_PlateCarrier2_tna_F", "V_PlateCarrierGL_blk", "V_PlateCarrierGL_mtp", "V_PlateCarrierGL_rgr", "V_PlateCarrierGL_tna_F", "V_PlateCarrierH_CTRG",
    "V_PlateCarrierIAGL_oli", "V_PlateCarrierL_CTRG", "V_PlateCarrierSpec_blk", "V_PlateCarrierSpec_mtp", "V_PlateCarrierSpec_rgr", "V_PlateCarrierSpec_tna_F",
    "V_Pocketed_black_F", "V_Pocketed_coyote_F", "V_Pocketed_olive_F", "V_Rangemaster_belt", "V_RebreatherB", "V_TacChestrig_cbr_F", "V_TacChestrig_grn_F",
    "V_TacChestrig_oli_F", "V_TacVest_blk", "V_TacVest_brn", "V_TacVest_camo", "V_TacVest_khk", "V_TacVest_oli", "V_TacVestIR_blk", "V_PlateCarrierGL_wdl",
    "V_PlateCarrier1_wdl", "V_PlateCarrier2_wdl", "V_PlateCarrierSpec_wdl", "V_TacVest_gen_F", "V_SmershVest_01_F", "V_SmershVest_01_radio_F",
    "V_CarrierRigKBT_01_heavy_EAF_F", "V_CarrierRigKBT_01_heavy_Olive_F", "V_CarrierRigKBT_01_light_EAF_F", "V_CarrierRigKBT_01_light_Olive_F",
    "V_CarrierRigKBT_01_EAF_F", "V_CarrierRigKBT_01_Olive_F",
	"V_lxWS_PlateCarrierGL_desert", "V_lxWS_PlateCarrier1_desert", "V_lxWS_PlateCarrier2_desert", "V_lxWS_PlateCarrierSpec_desert", "V_PlateCarrier_CTRG_lxWS",
	"V_lxWS_UN_Vest_Lite_F", "V_lxWS_UN_Vest_F"
];


// Medic Vests
InA_AllowedArsenal_vestsMedic = [
    "V_DeckCrew_red_F", "V_DeckCrew_white_F",
    "V_Plain_crystal_F", "V_Plain_medical_F"
];


// Engineer Vests
InA_AllowedArsenal_vestsEngineer = [
    "V_Safety_blue_F", "V_Safety_orange_F", "V_Safety_yellow_F"
];


// EOD Vests
InA_AllowedArsenal_vestsEOD = [
    "V_EOD_blue_F", "V_EOD_coyote_F", "V_EOD_olive_F"
];


// Pilot Vests
InA_AllowedArsenal_vestsPilot = [
    "V_BandollierB_blk", "V_BandollierB_oli", "V_BandollierB_rgr", "V_LegStrapBag_black_F", "V_Pocketed_black_F", "V_Pocketed_coyote_F", "V_Pocketed_olive_F",
    "V_Rangemaster_belt", "V_TacVest_blk", "V_TacVest_oli"
];


// General Backpacks
InA_AllowedArsenal_generalBackpacks = [
    "B_AssaultPack_blk", "B_AssaultPack_cbr", "B_AssaultPack_khk", "B_AssaultPack_mcamo", "B_AssaultPack_rgr", "B_AssaultPack_sgg", "B_AssaultPack_tna_F",
    "B_Bergen_mcamo_F", "B_Bergen_tna_F", "B_Carryall_cbr", "B_Carryall_khk", "B_Carryall_mcamo", "B_Carryall_oli", "B_FieldPack_blk", "B_FieldPack_cbr",
    "B_FieldPack_khk", "B_FieldPack_oli", "B_Kitbag_cbr", "B_Kitbag_mcamo", "B_Kitbag_rgr", "B_Kitbag_sgg", "B_LegStrapBag_black_F", "B_LegStrapBag_coyote_F",
    "B_LegStrapBag_olive_F", "B_Messenger_Black_F", "B_Messenger_Coyote_F", "B_Messenger_Gray_F", "B_Messenger_Olive_F", "B_Parachute", "B_TacticalPack_blk",
    "B_TacticalPack_mcamo", "B_TacticalPack_oli", "B_TacticalPack_rgr", "B_ViperHarness_blk_F", "B_ViperHarness_khk_F", "B_ViperHarness_oli_F",
    "B_ViperLightHarness_blk_F", "B_ViperLightHarness_khk_F", "B_ViperLightHarness_oli_F", "B_AssaultPack_wdl_F", "B_Carryall_green_F", "B_Carryall_wdl_F",
    "B_FieldPack_green_F", "B_AssaultPack_eaf_F", "B_Carryall_eaf_F", "B_Carryall_taiga_F", "B_FieldPack_taiga_F", "B_Carryall_blk", "B_SCBA_01_F",
    "B_CombinationUnitRespirator_01_F", "B_AssaultPack_desert_lxWS", "B_Carryall_desert_lxWS", "B_Kitbag_desert_lxWS", "B_shield_backpack_lxWS"
];


// Radio Backpacks
InA_AllowedArsenal_backpacksRadio = [
    "B_RadioBag_01_black_F", "B_RadioBag_01_mtp_F",
    "B_RadioBag_01_tropic_F", "B_RadioBag_01_wdl_F",
    "B_RadioBag_01_eaf_F"
];


// Drone Backpacks
InA_AllowedArsenal_backpackDrones = [
    "B_UAV_01_backpack_F", "B_UAV_06_backpack_F", "B_UAV_06_medical_backpack_F", "B_W_Static_Designator_01_weapon_F", "B_UGV_02_Demining_backpack_F", "B_UGV_02_Science_backpack_F",
	"ION_UAV_02_backpack_lxWS", "B_UAV_02_backpack_lxWS", "ION_UAV_01_backpack_lxWS", "CIV_UAV_01_backpack_lxWS"
];


// Medical backpacks
InA_AllowedArsenal_backpackMedic = [
    "B_CivilianBackpack_01_Sport_Red_F",
    "B_CivilianBackpack_01_Everyday_IDAP_F",
    "B_CivilianBackpack_01_Everyday_Vrana_F",
    "B_Messenger_IDAP_F"
];


// Static Weapon Backpacks
InA_AllowedArsenal_backpackStatics = [
    "B_AA_01_weapon_F", "B_AT_01_weapon_F", "B_GMG_01_A_weapon_F", "B_GMG_01_high_weapon_F", "B_GMG_01_weapon_F", "B_HMG_01_A_weapon_F", "B_HMG_01_high_weapon_F",
    "B_HMG_01_support_F", "B_HMG_01_support_high_F", "B_HMG_01_weapon_F", "B_Mortar_01_support_F", "B_Mortar_01_weapon_F", "B_Static_Designator_01_weapon_F",
    "I_HMG_02_support_high_F", "I_HMG_02_support_F", "I_HMG_02_weapon_F", "I_HMG_02_weapon_high_F",
    "I_G_HMG_02_high_weapon_F", "I_G_HMG_02_weapon_F", "I_G_HMG_02_support_high_F", "I_G_HMG_02_support_F"
];


// Things and stuff that aren't in the Arsenal, but you're allowed to pick up ....
InA_AllowedPickup_Launchers = [
    "launch_MRAWS_base_F",
    "launch_NLAW_F",
    "launch_Titan_base",
    "launch_RPG7_F",
    "launch_RPG32_F"
];


// Rifles allowed to be pickud up ....
InA_AllowedPickup_Rifles = [
    "arifle_Katiba_Base_F",
    "arifle_CTAR_base_F",
    "arifle_AK12_base_F",
    "mk20_base_F",
    "arifle_MSBS65_base_F",
    "arifle_MX_Base_F",
    "arifle_SPAR_01_base_F",
    "Tavor_base_F",
    "arifle_AKM_base_F",
    "arifle_AKS_base_F"
];


// Pickup Backpacks
InA_AllowedPickup_Backpacks = [
    "Bag_Base"
];


// ArsenalDefinitions initialized ....
InA_ArsenalDefinitionsInitialized = true;
