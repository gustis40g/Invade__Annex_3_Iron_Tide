// Make sure to only run once ....
if (!isNil "InA_ArsenalDefinitionsInitialized") exitWith {};

InA_ArsenalDefinitionsInitialized = false;


// Items, optics and accessories all slots have access to.
InA_AllowedArsenal_generalItems = [
    //Picatinny Optics: (est. 1 million ACOGs in here)
    "RKSL_optic_EOT552", "RKSL_optic_EOT552_C", "RKSL_optic_EOT552X", "RKSL_optic_EOT552X_C",
    "rhsusf_acc_EOTECH", "rhsusf_acc_g33_T1", "rhsusf_acc_g33_xps3", "rhsusf_acc_g33_xps3_tan", "rhsusf_acc_eotech_xps3",
    "RKSL_optic_LDS", "RKSL_optic_LDS_C", "UK3CB_BAF_SpecterLDS", "UK3CB_BAF_Kite", "UK3CB_BAF_MaxiKite",
    "rhsusf_acc_ELCAN", "rhsusf_acc_ELCAN_ard", "rhsusf_acc_ACOG", "rhsusf_acc_ACOG2", "rhsusf_acc_ACOG3", "rhsusf_acc_M2A1", "rhsusf_acc_eotech_552", "rhsusf_acc_eotech_552_d", "rhsusf_acc_eotech_552_wd",
    "rhsusf_acc_compm4", "rhsusf_acc_mrds", "rhsusf_acc_mrds_c", "rhsusf_acc_RM05", "RKSL_optic_RMR_MS19", "RKSL_optic_RMR_MS19_FDE", "RKSL_optic_RMR_RM33", "RKSL_optic_RMR_RM33_FDE",
    "rhsusf_acc_RX01_NoFilter", "rhsgref_acc_RX01_NoFilter_camo", "rhsgref_acc_RX01_camo", "rhsusf_acc_RX01", "rhsusf_acc_RX01_NoFilter_tan", "rhsusf_acc_RX01_tan","rhsusf_acc_su230", "rhsusf_acc_su230_c",
    "rhsusf_acc_su230_mrds", "rhsusf_acc_su230_mrds_c", "rhsusf_acc_su230a", "rhsusf_acc_su230a_c", "rhsusf_acc_su230a_mrds", "rhsusf_acc_su230a_mrds_c", "rhsusf_acc_ACOG_MDO", "rhsusf_acc_T1_high",
    "rhsusf_acc_T1_low", "UK3CB_BAF_SUIT", "UK3CB_BAF_SUSAT", "rhsusf_acc_ACOG_d", "rhsusf_acc_ACOG_wd", "rhsusf_acc_ACOG_RMR", "UK3CB_BAF_TA31F", "UK3CB_BAF_TA31F_Hornbill", "UK3CB_BAF_TA648",
    "UK3CB_BAF_TA648_308", "optic_MRD_black",
    "rhs_acc_rakursPM", "rhs_acc_1p87", "rhs_acc_ekp8_18", "rhs_acc_okp7_picatinny", //Russian picatinny

    //Misc, for example L1A1 sights or handgun optics
    "rhsgref_acc_l1a1_l2a2", "UK3CB_BAF_SUIT", "rhsgref_mg42_acc_AAsight", "RKSL_optic_RMR_HG", "RKSL_optic_RMR_HG_FDE", "rhs_optic_maaws", "rhs_weap_optic_smaw", 
    
    //Dovetail Optics:
    "rhs_acc_1p29", "rhs_acc_1p63", "rhs_acc_1p78", "rhs_acc_1pn34", "rhs_acc_nita", //Terrible optics, should be illegal to use.
    "rhs_acc_pgo7v3", "rhs_acc_ekp8_02", "rhs_acc_okp7_dovetail", "rhs_acc_pkas", "rhs_acc_pso1m2", "rhs_acc_pso1m21", //Better, many of them are still mid though
    "rhs_acc_pgo7v", "rhs_acc_pgo7v2", "rhs_acc_pgo7v3", "rhs_acc_1pn93_1", "rhs_acc_1pn93_2", //RPG sights

    //Accessories:
    "rhs_acc_2dpZenit_ris", "rhsusf_acc_anpeq15side", "rhsusf_acc_anpeq15side_bk", "rhsusf_acc_anpeq15A", "rhsusf_acc_anpeq16a", "ACE_DBAL_A3_Green", "ACE_DBAL_A3_Red", "ACE_acc_pointer_green",
    "acc_pointer_IR", "UK3CB_BAF_LLM_Flashlight_Black", "UK3CB_BAF_LLM_Flashlight_Tan", "UK3CB_BAF_LLM_IR_Black", "UK3CB_BAF_LLM_IR_Tan", "rhsusf_acc_M952V", "rhs_acc_perst1ik_ris", 
    "rhs_acc_perst3", "ACE_SPIR", "acc_flashlight", "rhsusf_acc_wmx", "rhsusf_acc_wmx_bk", "rhsusf_acc_anpeq15_top", "rhsusf_acc_anpeq15_wmx", "rhsusf_acc_anpeq15_bk_top", "rhsusf_acc_anpeq15",
    "rhsusf_acc_anpeq15_bk", "rhsusf_acc_anpeq16a_top", "rhs_acc_perst3_top", "rhs_acc_perst3_2dp_h", "rhs_acc_perst1ik", "rhs_acc_2dpZenit", "rhs_acc_at4_handler", 

    //Muzzle Attachements:
    "ACE_muzzle_mzls_L", "rhsusf_acc_nt4_black", "rhsusf_acc_nt4_tan", "rhsusf_acc_rotex5_grey", "rhsusf_acc_rotex5_tan", "rhsusf_acc_SF3P556", "rhsusf_acc_SFMB556", "rhssaf_acc_G36_Rotex", //5.56
    "PRACS_AAC_Supressor", "UK3CB_BAF_BFA_L110", "UK3CB_BAF_Silencer_L110", "UK3CB_BAF_SFFH", "UK3CB_BAF_BFA_L85", "UK3CB_BAF_Bayonet_L3A1", "UK3CB_BAF_Silencer_L85",
    "rhsusf_acc_ARDEC_M240", "ACE_muzzle_mzls_B", "rhsusf_acc_aac_762sd_silencer", "rhsusf_acc_aac_762sdn6_silencer", "rhsusf_acc_aac_m14dcqd_silencer", "rhsusf_acc_aac_m14dcqd_silencer_d", //7.62 (shares some with 5.56)
    "rhsusf_acc_aac_m14dcqd_silencer_wd", "rhsusf_acc_m24_muzzlehider_black", "rhsusf_acc_m24_muzzlehider_d", "rhsusf_acc_m24_muzzlehider_wd", "rhsgref_sdn6_suppressor", 
    "rhsusf_acc_aac_scarh_silencer", "rhsgref_acc_falMuzzle_l1a1", "PRACS_AAC_supressor_762", "rhsusf_acc_m14_flashsuppresor", "rhsusf_acc_m24_silencer_black","rhsusf_acc_m24_silencer_d",
    "rhsusf_acc_m24_silencer_wd", "rhsusf_acc_SR25S", "rhsusf_acc_SR25S_d", "rhsusf_acc_SR25S_wd", 
    "rhs_acc_ak5", "rhs_acc_dtk", "rhs_acc_dtk1", "rhs_acc_dtk2", "rhs_acc_dtk3", "rhs_acc_dtk4screws", "rhs_acc_dtk4long", "rhs_acc_pbs1", "rhs_acc_dtkakm", "rhs_acc_dtk1l", //AK, 7.62
    "rhs_acc_uuk", "rhs_acc_dtk1983", "rhs_acc_dtk4short", "rhs_acc_pgs64", "rhs_acc_tgpa", "rhs_acc_dtkrpk", "rhs_acc_pbs4", "rhs_acc_pgs64_74u", "rhs_acc_pgs64_74un", //AK, 5.45 (shares some with 7.62 AKs) 
    "UK3CB_BAF_Silencer_L115A3", "UK3CB_BAF_BFA_L129", "UK3CB_BAF_Silencer_L115A3", "UK3CB_BAF_Silencer_L91A1", "rhsusf_acc_M2010S", "rhsusf_acc_M2010S_d", "rhsusf_acc_M2010S_sa", "rhsusf_acc_M2010S_wd", //Misc.
    "rhsusf_acc_rotex_mp7_aor1", "rhsusf_acc_rotex_mp7", "rhsusf_acc_rotex_mp7_desert", "rhsusf_acc_rotex_mp7_winter", "rhsgref_acc_zendl", "PRACS_CETME_STD_bayonet", "rhs_acc_tgpv", "rhs_acc_tgpv2",
    "rhsusf_acc_omega9k", "UK3CB_BAF_Silencer_L105A1", "ACE_muzzle_mzls_smg_02", "rhs_acc_6p9_suppressor", "muzzle_snds_L",

    //Foregrip rail:
    "rhsusf_acc_grip2", "rhsusf_acc_grip2_tan", "rhsusf_acc_grip2_wd", "rhs_acc_grip_ffg2", "rhsusf_acc_grip1", "rhs_acc_harris_swivel", "rhsusf_acc_harris_bipod", "rhsusf_acc_kac_grip", "rhs_acc_grip_rk2", "rhs_acc_grip_rk6",
    "rhsusf_acc_rvg_blk", "rhsusf_acc_rvg_de", "rhsusf_acc_tacsac_blk", "rhsusf_acc_tacsac_blue", "rhsusf_acc_tacsac_tan", "rhsusf_acc_tdstubby_blk", "rhsusf_acc_tdstubby_tan", "rhsusf_acc_grip3", "rhsusf_acc_grip3_tan",
    "rhsusf_acc_kac_grip_saw_bipod", "rhsusf_acc_saw_bipod", "rhsusf_acc_grip4", "rhsusf_acc_grip4_bipod", "rhsusf_acc_saw_lw_bipod", "UK3CB_underbarrel_acc_bipod", "UK3CB_underbarrel_acc_afg", "UK3CB_underbarrel_acc_afg_d",
    "UK3CB_underbarrel_acc_afg_g", "UK3CB_underbarrel_acc_afg_t", "UK3CB_underbarrel_acc_afg_w", "UK3CB_underbarrel_acc_grippod", "UK3CB_underbarrel_acc_grippod_d", "UK3CB_underbarrel_acc_grippod_g", "UK3CB_underbarrel_acc_grippod_t",
    "UK3CB_underbarrel_acc_grippod_w", "rhsusf_acc_m14_bipod", "rhsusf_acc_grip_m203_blk", "rhsusf_acc_grip_m203_d", "rhsusf_acc_grip_m203_wd", "PRACS_G3_Bipod",

    //Handgun Accessories:
    "acc_flashlight_pistol", "UK3CB_BAF_Flashlight_L105A1", "UK3CB_BAF_L105A1_LLM_IR_G", "UK3CB_BAF_L105A1_LLM_IR_R", "UK3CB_BAF_Flashlight_L131A1", "UK3CB_BAF_Laser_L131A1", 

    //Night Vision Goggles:
    "rhsusf_ANPVS_14", "rhsusf_ANPVS_15", "UK3CB_BAF_HMNVS", "ACE_NVG_Gen4_Black", "ACE_NVG_Gen4_Black_WP", "ACE_NVG_Gen4", "ACE_NVG_Gen4_WP", "ACE_NVG_Gen4_Green", "ACE_NVG_Gen4_Green_WP", "ACE_NVG_Wide_Black",
    "ACE_NVG_Wide_Black_WP", "ACE_NVG_Wide", "ACE_NVG_Wide_WP", "ACE_NVG_Wide_Green", "ACE_NVG_Wide_Green_WP", "rhsusf_Rhino",

    //Binoculars:
    "UK3CB_BAF_Soflam_Laserdesignator", "Binocular", "UK3CB_BAF_Javelin_CLU", "rhsusf_bino_lerca_1200_black", "rhsusf_bino_lerca_1200_tan", "rhsusf_bino_leopold_mk4", "rhsusf_bino_m24", "rhsusf_bino_m24_ARD", "ACE_MX2A",
    "ace_dragon_sight", "ACE_VectorDay", "ACE_Vector", "rhsusf_bino_lrf_Vector21", "ACE_Yardage450",

    //Map, GPS, Radio, Compass, Watch:
    "ItemMap", "ItemGPS", "ItemCompass", "ItemWatch", "ACE_Altimeter", 

    //Tools
    "ACE_ATragMX", "ACE_Chemlight_Shield", "ACE_DAGR", "ACE_DefusalKit", "ACE_EntrenchingTool", "ACE_Flashlight_MX991", "ACE_HuntIR_monitor", "ACE_Kestrel4500", "ACE_M26_Clacker",
    "ACE_Clacker", "ACE_Flashlight_XL50", "ACE_MapTools", "ACE_microDAGR", "MineDetector", "ACE_PlottingBoard", "ACE_RangeCard", "ACE_SpottingScope", "ACE_Tripod", "ToolKit", "ACE_wirecutter",

    //ACE Medical items:
    "ACE_adenosine", "ACE_fieldDressing", "ACE_elasticBandage", "ACE_packingBandage", "ACE_quikclot", "ACE_bloodIV", "ACE_bloodIV_500", "ACE_bloodIV_250",
    "ACE_bodyBag", "ACE_epinephrine", "ACE_morphine", "ACE_personalAidKit", "ACE_plasmaIV", "ACE_plasmaIV_500", "ACE_plasmaIV_250", "ACE_salineIV", "ACE_salineIV_500", "ACE_salineIV_250",
    "ACE_splint", "ACE_surgicalKit", "ACE_tourniquet",

    //Food for food enjoyer Rickard:
    "ACE_Banana", "ACE_Can_Franta", "ACE_Can_RedGull", "ACE_Can_Spirit", "ACE_Canteen", "ACE_Canteen_Empty", "ACE_Canteen_Half", "ACE_Humanitarian_Ration", "ACE_MRE_BeefStew", "ACE_MRE_ChickenTikkaMasala",
    "ACE_MRE_ChickenHerbDumplings", "ACE_MRE_CreamChickenSoup", "ACE_MRE_CreamTomatoSoup", "ACE_MRE_LambCurry", "ACE_MRE_MeatballsPasta", "ACE_MRE_SteakVegetables", "ACE_Sunflower_Seeds", "ACE_Sunflower_Seeds",
    "ACE_WaterBottle", "ACE_WaterBottle_Empty", "ACE_WaterBottle_Half", //Question, is the bottle half empty or half full?

    //Misc:
    "ACE_CableTie", "ACE_EarPlugs", "ACE_IR_Strobe_Item", "ACE_rope36", "ACE_rope27", "ACE_rope18", "ACE_rope15", "ACE_rope12", "ACE_rope6", "ACE_rope3", "ACE_Sandbag_empty", "ACE_SpareBarrel", "ace_flags_white", //for French people
    "ACE_SpraypaintBlack", "ACE_SpraypaintBlue", "ACE_SpraypaintGreen", "ACE_SpraypaintRed", "ACE_SpraypaintWhite", "ACE_SpraypaintYellow", "ACE_UAVBattery"
];
// ACE Medical items for Medics: not used for now, waiting to see if players find all medical items confusing or not.
// InA_AllowedArsenal_medicItems = [
//     "ACE_surgicalKit", "ACE_personalAidKit"
// ];


// Recon item(s)
InA_AllowedArsenal_reconItems = [
    "ace_marker_flags_blue", "ace_marker_flags_red", "ace_marker_flags_white"
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
//Handguns
    //Glock17
    "rhsusf_mag_17Rnd_9x19_FMJ", "rhsusf_mag_17Rnd_9x19_JHP",

    //L105A2/ L9A1
    "UK3CB_BAF_9_15Rnd", "UK3CB_BAF_9_13Rnd",

    //M1911
    "rhsusf_weap_m1911a1",

    //Beretta
    "rhsusf_mag_15Rnd_9x19_FMJ", "rhsusf_mag_15Rnd_9x19_JHP",

    //CZ99
    "rhssaf_mag_15Rnd_9x19_FMJ", "rhssaf_mag_15Rnd_9x19_JHP",

    //TT-33
    "rhs_weap_tt33",

    //PMK/ PB
    "rhs_mag_9x18_8_57N181S",

    //ROP-30s
    "rhs_mag_rsp30_white", "rhs_mag_rsp30_green", "rhs_mag_rsp30_red",
    
//SMGs
    // L91A1/ L92A1
    "UK3CB_BAF_9_30Rnd", 
    
    //MP7A1
    "rhsusf_mag_40Rnd_46x30_AP", "rhsusf_mag_40Rnd_46x30_FMJ", "rhsusf_mag_40Rnd_46x30_JHP",
    
    //UZI
    "PRACS_35rd_9mm_UZI", "PRACS_30rd_9mm_UZI",
    
    //PP-2000
    "PRACS_35rd_9mm_UZI", "rhs_mag_9x19mm_7n31_20", "rhs_mag_9x19mm_7n21_44", "rhs_mag_9x19mm_7n31_44",

    //M3A1
    "rhsgref_30rnd_1143x23_M1T_SMG", "rhsgref_30rnd_1143x23_M1T_2mag_SMG", "rhsgref_30rnd_1143x23_M1911B_SMG", "rhsgref_30rnd_1143x23_M1911B_2mag_SMG",
    
//Rifles
    //AK 5.45
    "rhs_30Rnd_545x39_7N10_2mag_AK", "rhs_30Rnd_545x39_7N10_2mag_camo_AK", "rhs_30Rnd_545x39_7N10_2mag_desert_AK", "rhs_30Rnd_545x39_7N10_2mag_plum_AK", "rhs_30Rnd_545x39_7N10_AK", "rhs_30Rnd_545x39_7N22_AK",
    "rhs_30Rnd_545x39_7U1_AK", "rhs_60Rnd_545X39_AK_Green", "rhs_60Rnd_545X39_7N10_AK", "rhs_60Rnd_545X39_7N22_AK", "rhs_60Rnd_545X39_7U1_AK", "rhs_45Rnd_545X39_7N6M_AK",

    //AK 7.62
    "rhs_30Rnd_762x39mm_polymer", "rhs_30Rnd_762x39mm_polymer_tracer", "rhs_30Rnd_762x39mm_polymer_U", "rhs_30Rnd_762x39mm_bakelite", "rhs_30Rnd_762x39mm_bakelite_tracer", "rhs_30Rnd_762x39mm_bakelite_U", 
    "rhs_75Rnd_762x39mm", "rhs_75Rnd_762x39mm_tracer", "rhssaf_30Rnd_762x39_M82_api",

    // STANAG 5.56 (Limiting ammo choice to mostly M855A1 for now, as all the ammo options can be confusing)
    "rhssaf_30rnd_556x45_EPR_G36", "rhssaf_30rnd_556x45_MDIM_G36", "rhssaf_30rnd_556x45_Tracers_G36", "rhssaf_100rnd_556x45_EPR_G36", "rhs_mag_100Rnd_556x45_M855A1_cmag", "rhs_mag_100Rnd_556x45_M855A1_cmag_mixed",
    "rhs_mag_30Rnd_556x45_M855A1_EPM_Pull", "rhs_mag_30Rnd_556x45_M855A1_EPM_Pull_Tracer_Red", "rhs_mag_30Rnd_556x45_M855A1_EPM_Ranger", "rhs_mag_30Rnd_556x45_M855A1_EPM_Ranger_Tracer_Red", "rhs_mag_30Rnd_556x45_M855A1_EPM", "rhs_mag_30Rnd_556x45_M855A1_EPM_Tracer_Red",
    "rhs_mag_30Rnd_556x45_M855A1_PMAG", "rhs_mag_30Rnd_556x45_M855A1_PMAG_Tan", "rhs_mag_30Rnd_556x45_M855A1_PMAG_Tan_Tracer_Red", "rhs_mag_30Rnd_556x45_M855A1_PMAG_Tracer_Red", "rhs_mag_30Rnd_556x45_M855A1_Stanag_Pull", "rhs_mag_30Rnd_556x45_M855A1_Stanag_Pull_Tracer_Red",
    "rhs_mag_30Rnd_556x45_M855A1_Stanag_Ranger", "rhs_mag_30Rnd_556x45_M855A1_Stanag_Ranger_Tracer_Red", "rhs_mag_30Rnd_556x45_M855A1_Stanag", "rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red",

    //HK-33
    "PRACS_30rd_HK33_M855A1_mag", "PRACS_40rd_HK33_M855A1_mag",

    //Shotguns 
    "UK3CB_BAF_12G_Pellets", "UK3CB_BAF_12G_Slugs", "rhsusf_8Rnd_00Buck", "rhsusf_8Rnd_FRAG", "rhsusf_8Rnd_HE", "rhsusf_8Rnd_Slug", "rhsusf_5Rnd_Slug", "rhsusf_5Rnd_HE", "rhsusf_5Rnd_FRAG", "rhsusf_5Rnd_00Buck",

    //AS Val (No 30 rounders :(   )
    "rhs_20rnd_9x39mm_SP6", "rhs_10rnd_9x39mm_SP6",

    //HCAR
    "PRACS_30rd_HCAR_mag", "PRACS_30rd_HCAR_camo_mag", "PRACS_30rd_HCAR_T_mag", "PRACS_30rd_HCAR_T_camo_mag", "rhs_mag_20Rnd_SCAR_762x51_m62_tracer_bk", "PRACS_50rd_HCAR_camo_mag", "PRACS_50rd_T_HCAR_mag", "PRACS_50rd_T_HCAR_camo_mag",

    //SCAR-H
    "rhs_mag_20Rnd_SCAR_762x51_m61_ap", "rhs_mag_20Rnd_SCAR_762x51_m61_ap_bk", "rhs_mag_20Rnd_SCAR_762x51_m62_tracer",

    //G3
    "PRACS_20rd_CETME_AP_mag", "PRACS_20rd_CETME_T_mag", "PRACS_20rd_G3_AP_mag", "PRACS_20rd_G3_T_mag", "PRACS_50rd_G3_AP_mag", "PRACS_50rd_G3_T_mag",


//Barrel launched grenades
    //GP-25
    "rhs_GDM40", "rhs_GRD40_Green", "rhs_GRD40_Red", "rhs_GRD40_White", "rhs_VG40MD", "rhs_VG40OP_green", "rhs_VG40OP_red", "rhs_VG40OP_white", "rhs_VG40SZ", "rhs_VG40TB", "rhs_VOG25", "rhs_VOG25P",

    //40mm
    "ACE_40mm_Pike", "rhs_mag_m4009", "ACE_HuntIR_M203", "rhs_mag_M397_HET", "rhs_mag_M433_HEDP", "rhs_mag_M441_HE", "rhs_mag_m576", "ACE_40mm_Flare_white", "rhs_mag_M583A1_white", "rhs_mag_M585_white_cluster",
    "rhs_mag_m661_green", "ACE_40mm_Flare_green", "ACE_40mm_Flare_red", "rhs_mag_m662_red", "rhs_mag_M663_green_cluster", "rhs_mag_M664_red_cluster", "rhs_mag_m713_Red", "rhs_mag_m714_White", "rhs_mag_m715_Green", "ACE_40mm_Flare_ir",

    //M32
    "rhsusf_mag_6Rnd_M397_HET", "rhsusf_mag_6Rnd_M433_HEDP", "rhsusf_mag_6Rnd_M441_HE", "rhsusf_mag_6Rnd_m4009", "rhsusf_mag_6Rnd_M576_Buckshot", "rhsusf_mag_6Rnd_M583A1_white", "rhsusf_mag_6Rnd_M714_white", "rhsusf_mag_6Rnd_M715_green",
     "rhsusf_mag_6Rnd_M713_red", "rhsusf_mag_6Rnd_m661_green", "rhsusf_mag_6Rnd_m662_red",

//LMG/MMGs
    //7.62
    "rhsusf_100Rnd_762x51_m61_ap", "rhsusf_100Rnd_762x51_m62_tracer", "rhsusf_100Rnd_762x51_m80a1epr", "rhsusf_50Rnd_762x51_m61_ap", "rhsusf_50Rnd_762x51_m62_tracer", "rhsusf_50Rnd_762x51_m80a1epr", "UK3CB_BAF_762_100Rnd", "UK3CB_BAF_762_100Rnd_T",
    "UK3CB_BAF_762_200Rnd", "UK3CB_BAF_762_200Rnd_T", 

    //5.56
    "rhsusf_100Rnd_556x45_soft_pouch", "rhsusf_100Rnd_556x45_soft_pouch_coyote", "rhsusf_100Rnd_556x45_soft_pouch_ucp", "rhsusf_100Rnd_556x45_mixed_soft_pouch", "rhsusf_100Rnd_556x45_mixed_soft_pouch_coyote", "rhsusf_100Rnd_556x45_mixed_soft_pouch_ucp", 
    "rhsusf_100Rnd_556x45_M995_soft_pouch", "rhsusf_100Rnd_556x45_M995_soft_pouch_coyote", "rhsusf_100Rnd_556x45_M995_soft_pouch_ucp", "rhsusf_200Rnd_556x45_box", "rhsusf_200rnd_556x45_mixed_box", "rhsusf_200Rnd_556x45_soft_pouch", "rhsusf_200Rnd_556x45_soft_pouch_coyote",
    "rhsusf_200Rnd_556x45_soft_pouch_ucp", "rhsusf_200Rnd_556x45_mixed_soft_pouch", "rhsusf_200Rnd_556x45_mixed_soft_pouch_coyote", "rhsusf_200Rnd_556x45_mixed_soft_pouch_ucp",

    //MG42
    "rhsgref_296Rnd_792x57_SmK_belt", "rhsgref_296Rnd_792x57_SmK_alltracers_belt", "rhsgref_50Rnd_792x57_SmK_drum", "rhsgref_50Rnd_792x57_SmK_alltracers_drum",

//DMRs/ SRs
    //DMRs
    "UK3CB_BAF_L129A1", "UK3CB_BAF_762_L42A1_20Rnd_T", "rhsusf_20Rnd_762x51_m62_Mag", "rhsusf_20Rnd_762x51_m993_Mag", "rhsgref_30rnd_1143x23_M1911B_2mag_SMG",
    "rhsusf_20Rnd_762x51_SR25_m62_Mag", "rhsusf_20Rnd_762x51_SR25_m993_Mag", "rhs_10Rnd_762x54mmR_7N1", "rhs_10Rnd_762x54mmR_7N14",  "rhsgref_8Rnd_762x63_M2B_M1rifle",

    //Snipers
    "UK3CB_BAF_338_5Rnd", "UK3CB_BAF_338_5Rnd_Tracer",
    "UK3CB_BAF_762_L42A1_10Rnd", "UK3CB_BAF_762_L42A1_10Rnd_T",
    "rhsusf_mag_10Rnd_STD_50BMG_M33", "rhsusf_mag_10Rnd_STD_50BMG_mk211",
    "rhsusf_5Rnd_300winmag_xm2010",
    "rhsusf_5Rnd_762x51_m118_special_Mag", "rhsusf_5Rnd_762x51_m62_Mag", "rhsusf_5Rnd_762x51_m993_Mag",
    "rhsusf_10Rnd_762x51_m118_special_Mag", "rhsusf_10Rnd_762x51_m62_Mag", "rhsusf_10Rnd_762x51_m993_Mag",
    "rhs_5Rnd_338lapua_t5000",
    "rhsgref_5Rnd_792x57_kar98k",

//Rockets and missiles
    //RPG-7
    "rhs_rpg7_PG7VS_mag", "rhs_rpg7_PG7VR_mag", "rhs_rpg7_OG7V_mag", "rhs_rpg7_type69_airburst_mag", "rhs_rpg7_TBG7V_mag",

    //Carl Gustaf
    "rhs_mag_maaws_HE", "rhs_mag_maaws_HEDP", "rhs_mag_maaws_HEAT",

    //SMAW
    "rhs_mag_smaw_HEDP", "rhs_mag_smaw_HEAA",

    //Misc HATS
    "Titan_AA", "PRACS_Saeghe_mag", "rhs_fim92_mag",

    // Mines and Explosives:
    "rhsusf_m112_mag", "rhsusf_m112x4_mag", 

    // Grenades:
    "ACE_M14", "rhs_mag_an_m8hc", "Chemlight_blue", "Chemlight_green", "ACE_Chemlight_HiBlue",
    "ACE_Chemlight_HiGreen", "ACE_Chemlight_HiRed", "ACE_Chemlight_HiWhite", "ACE_Chemlight_IR",
    "rhs_mag_m18_green", "rhs_mag_m18_purple", "rhs_mag_m18_red", "rhs_mag_m67", "rhs_mag_m7a3_cs",
    "rhs_mag_mk84", "rhs_grenade_anm8_mag", "ACE_Chemlight_UltraHiOrange", "ACE_Chemlight_Orange", "ACE_Chemlight_White",

    // Misc:
    "Laserbatteries"
];


// Recon optics
InA_AllowedArsenal_opticsRecon = ["rhsusf_acc_anpas13gv1"];


// Marksman optics
InA_AllowedArsenal_opticsMarksman = [
    "rhsusf_acc_anpas13gv1", "rhsusf_acc_M8541", "rhsusf_acc_M8541_d", "rhsusf_acc_M8541_mrds", "rhsusf_acc_M8541_wd", "rhsusf_acc_premier_low", "rhsusf_acc_premier_anpvs27", "rhsusf_acc_premier", "rhsusf_acc_premier_mrds",
    "rhsusf_acc_LEUPOLDMK4_2", "rhsusf_acc_LEUPOLDMK4_2_d", "rhsusf_acc_LEUPOLDMK4_2_mrds", "rhsusf_acc_nxs_3515x50_md", "rhsusf_acc_nxs_3515x50f1_h58", "rhsusf_acc_nxs_3515x50f1_md", "rhsusf_acc_nxs_3515x50f1_h58_sun",
    "rhsusf_acc_nxs_3515x50f1_md_sun", "RKSL_optic_PMII_312", "RKSL_optic_PMII_312_des", "RKSL_optic_PMII_312_sunshade", "RKSL_optic_PMII_312_sunshade_des", "RKSL_optic_PMII_312_sunshade_wdl", "RKSL_optic_PMII_312_wdl"
];


// Sniper optics
InA_AllowedArsenal_opticsSniper = [
    "rhsusf_acc_nxs_5522x56_md", "rhsusf_acc_nxs_5522x56_md_sun", "RKSL_optic_PMII_525","RKSL_optic_PMII_525_des", "RKSL_optic_PMII_525_wdl"
];


// Mines and explosives
InA_AllowedArsenal_Explosives = [
    "SatchelCharge_Remote_Mag", "rhs_ec75_mag", "rhs_ec200_sand_mag", "ClaymoreDirectionalMine_Remote_Mag",
    "rhs_ec200_mag", "rhs_ec400_sand_mag", "rhs_ec400_mag", "rhs_ec75_sand_mag", "IEDUrbanBig_Remote_Mag", "IEDLandBig_Remote_Mag",
    "TrainingMine_Mag", "rhs_mine_msk40p_blue_mag", "rhs_mine_msk40p_green_mag", "rhs_mine_msk40p_red_mag", "rhs_mine_msk40p_white_mag",
    "rhssaf_mine_mrud_c_mag", "rhssaf_mine_mrud_b_mag", "rhssaf_mine_mrud_a_mag", "rhssaf_mine_mrud_d_mag", "rhssaf_mine_mrud_d_mag"
];


// Underwater gun
InA_AllowedArsenal_underWaterGun = [];


// General Pistols
InA_AllowedArsenal_generalPistols = [
    //Pistols
    "rhsusf_weap_glock17g4", "UK3CB_BAF_L105A2", "UK3CB_BAF_L9A1", "rhsusf_weap_m1911a1",
    "rhsusf_weap_m9", "rhs_weap_cz99", "rhs_weap_cz99_etched", "rhs_weap_tt33", "rhs_weap_pb_6p9", "rhs_weap_makarov_pm",
    //Misc
    "ACE_Flashlight_Maglite_ML300L", "rhs_weap_tr8", "ACE_VMH3", "ACE_VMM3",
    //Flares
    "rhs_weap_rsp30_white", "rhs_weap_rsp30_green", "rhs_weap_rsp30_red"
];


// Sub Machine Guns
InA_AllowedArsenal_generalSMGs = [
    "UK3CB_BAF_L91A1", "UK3CB_BAF_L92A1", "rhsusf_weap_MP7A2", "rhsusf_weap_MP7A2_aor1", "rhsusf_weap_MP7A2_desert", "rhsusf_weap_MP7A2_winter", "PRACS_UZI", "rhs_weap_pp2000"
];


// Carbines
InA_AllowedArsenal_generalCarbines = [
    "rhs_weap_ak105_zenitco01", "rhs_weap_ak105_zenitco01_b33", "rhs_weap_ak104_zenitco01", "rhs_weap_ak104_zenitco01_b33", "rhs_weap_g36c", "rhs_weap_hk416d10", "rhs_weap_hk416d10_LMT", "rhs_weap_hk416d10_LMT_d", "rhs_weap_hk416d10_LMT_wd",
    "UK3CB_BAF_L119A1_CQB", "UK3CB_BAF_L119A1", "UK3CB_BAF_L22A2", "rhs_weap_mk18_bk", "rhs_weap_mk18_KAC_bk", "rhs_weap_mk18_d", "rhs_weap_mk18_KAC_d", "rhs_weap_mk18_wd", "rhs_weap_mk18_KAC_wd", "PRACS_HK53", "UK3CB_BAF_L128A1", "rhs_weap_M590_8RD", "rhs_weap_M590_5RD"
];


// Pilot Carbines
InA_AllowedArsenal_pilotCarbines = [
    "rhs_weap_g36c", "rhs_weap_hk416d10", "rhs_weap_hk416d10_LMT", "rhs_weap_hk416d10_LMT_d", "rhs_weap_hk416d10_LMT_wd",
    "UK3CB_BAF_L119A1_CQB", "UK3CB_BAF_L22A2", "PRACS_HK53"
];


// Assault rifles
InA_AllowedArsenal_generalAssaultRifles = [
    "rhs_weap_ak103_zenitco01", "rhs_weap_ak103_zenitco01_b33", "rhs_weap_ak74m_zenitco01", "rhs_weap_ak74m_zenitco01_b33", "rhs_weap_ak74mr", "rhs_weap_akmn", 
    "rhs_weap_asval_grip", "rhs_weap_asval_grip_npz", "PRACS_FNC", "PRACS_HCAR", "PRACS_HCAR_Warchild", "rhs_weap_g36kv", "rhs_weap_hk416d145", 
    "rhs_weap_hk416d145_d", "rhs_weap_hk416d145_d_2", "rhs_weap_hk416d145_wd", "rhs_weap_hk416d145_wd_2", "UK3CB_BAF_L85A3", "rhs_weap_m4a1_blockII_bk", "rhs_weap_m4a1_blockII_KAC_bk",
    "rhs_weap_m4a1_blockII_d", "rhs_weap_m4a1_blockII_KAC_d", "rhs_weap_m4a1_blockII_wd", "rhs_weap_m4a1_blockII_KAC_wd", "rhs_weap_SCARH_CQC", "rhs_weap_SCARH_FDE_CQC", "rhs_weap_SCARH_FDE_LB",
    "rhs_weap_SCARH_LB", "rhs_weap_SCARH_FDE_STD", "rhs_weap_SCARH_STD", "PRACS_g3a3", "PRACS_g3a3_w", "PRACS_g3a4", "PRACS_g3a4_w", "PRACS_HK33", "PRACS_HK33A4"
];


// Underslung Assault rifles
InA_AllowedArsenal_assaultRiflesUGL = [
    "rhs_weap_ak103_gp25", "rhs_weap_ak103_gp25_npz", "rhs_weap_ak74m_gp25", "rhs_weap_ak74m_gp25_npz", "rhs_weap_ak74mr_gp25",
    "rhs_weap_g36kv_ag36", "rhs_weap_hk416d10_m320", "rhs_weap_hk416d145_m320", "UK3CB_BAF_L119A1_UKUGL", "UK3CB_BAF_L85A3_UGL", "rhs_weap_m4a1_blockII_M203_bk",
    "rhs_weap_m4a1_blockII_M203_d", "rhs_weap_m4a1_blockII_M203_wd", "rhs_weap_m79", "rhs_weap_mk18_m320", "PRACS_g3a3t40", "PRACS_g3a4t40", "rhs_weap_akmn_gp25", "rhs_weap_m32"
];

// Light/Medium Machine Guns
InA_AllowedArsenal_Machineguns = [
    "UK3CB_BAF_L110_762", "UK3CB_BAF_L86A2", "rhs_weap_m240B", "rhs_weap_m240G", "rhs_weap_m249_pip",
    "rhs_weap_m249_light_L", "rhs_weap_m249_pip_L_para", "rhs_weap_m249_pip_L", "rhs_weap_m249_pip_ris", "rhs_weap_m249_pip_S_para", "rhs_weap_m249_pip_S", "rhs_weap_m27iar", "rhs_weap_m27iar_grip", "rhs_weap_mg42",
    "rhs_weap_rpk74m", "rhs_weap_rpk74m_npz"
];


// Designated Marksman Rifles
InA_AllowedArsenal_marksmanRifles = [
    "UK3CB_BAF_L129A1", "UK3CB_BAF_L86A3", "rhs_weap_m14_rail", "rhs_weap_m14_ris", "rhs_weap_m14ebrri", "rhs_weap_sr25",
    "rhs_weap_sr25_d", "rhs_weap_sr25_ec", "rhs_weap_sr25_ec_d", "rhs_weap_sr25_ec_wd", "rhs_weap_sr25_wd", "rhs_weap_svdp", "rhs_weap_svdp_wd",
    "rhs_weap_svdp_wd_npz", "rhs_weap_svdp_npz", "rhs_weap_svds_npz", "rhs_weap_vss", "rhs_weap_vss_grip",
    "rhs_weap_vss_grip_npz", "rhs_weap_vss_npz"
];


// Sniper Rifles
InA_AllowedArsenal_sniperRifles = [
    "UK3CB_BAF_L115A3", "UK3CB_BAF_L115A3_BL", "UK3CB_BAF_L115A3_DE", "UK3CB_BAF_L115A3_Ghillie", "UK3CB_BAF_L115A3_BL_Ghillie", "UK3CB_BAF_L115A3_DE_Ghillie", "UK3CB_BAF_L118A1_Covert", "UK3CB_BAF_L118A1_Covert_BL",
    "UK3CB_BAF_L118A1_Covert_DE", "rhs_weap_M107", "rhs_weap_M107_d", "rhs_weap_M107_w", "rhs_weap_XM2010", "rhs_weap_XM2010_wd", "rhs_weap_XM2010_d", "rhs_weap_XM2010_sa", "rhs_weap_m24sws", "rhs_weap_m24sws_d", "rhs_weap_m24sws_wd",
    "rhs_weap_m40a5", "rhs_weap_m40a5_d", "rhs_weap_m40a5_wd", "rhs_weap_t5000"
];


// Light AT launchers
InA_AllowedArsenal_launchersLight = [
    "rhs_weap_rpg7", "rhs_weap_maaws", "rhs_weap_smaw", "rhs_weap_smaw_green",
    "rhs_weap_M136", "rhs_weap_M136_hedp", "rhs_weap_M136_hp", "launch_NLAW_F"
];


// Heavy Missile launchers
InA_AllowedArsenal_launchersHeavy = [
    "ace_dragon_super", "UK3CB_BAF_Javelin_Slung_Tube",
    "PRACS_SLA_Saeghe", "rhs_weap_fim92"
];


// Recon Rifles
InA_AllowedArsenal_reconRifles = [
    "rhs_weap_m3a1_specops", "rhs_weap_m3a1", "rhs_weap_m1garand_sa43", "rhs_weap_kar98k"
];


// General Facewear
InA_AllowedArsenal_generalFacewear = [
    "UK3CB_BAF_G_Tactical_Black", "UK3CB_BAF_G_Tactical_Clear", "UK3CB_BAF_G_Tactical_Grey", "UK3CB_BAF_G_Tactical_Orange", "UK3CB_BAF_G_Tactical_Yellow", "rhsusf_oakley_goggles_ylw", "rhsusf_oakley_goggles_clr", "rhsusf_oakley_goggles_blk",
    "rhsusf_shemagh2_gogg_white", "rhsusf_shemagh_gogg_white", "rhsusf_shemagh2_gogg_tan", "rhsusf_shemagh_gogg_tan", "rhsusf_shemagh2_gogg_od", "rhsusf_shemagh_gogg_od", "rhsusf_shemagh2_gogg_grn",
    "rhsusf_shemagh_gogg_grn", "rhsusf_shemagh2_white", "rhsusf_shemagh_white", "rhsusf_shemagh2_tan", "rhsusf_shemagh_tan", "rhsusf_shemagh2_od", "rhsusf_shemagh_od", "rhsusf_shemagh2_grn",
    "rhsusf_shemagh_grn", "rhs_scarf", "rhs_ess_black", "rhs_googles_yellow", "rhs_googles_orange", "rhs_googles_clear", "rhs_googles_black", "UK3CB_BAF_G_Balaclava_Win", "rhs_balaclava1_olive",
    "rhs_balaclava", "rhs_facewear_6m2", "rhs_facewear_6m2_1", "G_AirPurifyingRespirator_01_F", "G_Aviator", "G_Balaclava_blk", "G_Balaclava_Flecktarn", "G_Balaclava_lowprofile",
    "G_Balaclava_oli", "G_Bandanna_aviator", "G_Bandanna_beast", "G_Bandanna_blk", "G_Bandanna_CandySkull",
    "G_Bandanna_khk","G_Bandanna_oli","G_Bandanna_shades","G_Bandanna_Skull1","G_Bandanna_Syndikat1",
	"G_Bandanna_Skull2","G_Bandanna_tan","G_B_Diving","G_Bandanna_Syndikat2","G_Bandanna_BlueFlame1","G_Bandanna_RedFlame1"
];


// Medical facewaer
InA_AllowedArsenal_facewearMedic = [
    "G_Respirator_white_F"
];


// General Headgear
InA_AllowedArsenal_generalHeadgear = [
    "rhs_8point_marpatd", "rhs_8point_marpatwd", "UK3CB_BAF_H_Wool_Hat", "H_Shemag_olive", "H_Shemag_olive_hs", "H_ShemagOpen_tan", "H_ShemagOpen_khk", "H_Cap_headphones",
    "PRACS_Pilot_Headset", "rhsusf_patrolcap_ucp", "rhsusf_patrolcap_ocp", "H_Cap_marshal", "UK3CB_BAF_H_Headset_PRR", "UK3CB_BAF_H_Earphone", "H_Cap_surfer",
    "H_Cap_khaki_specops_UK", "H_Cap_usblack", "H_Cap_tan_specops_US", "H_Cap_oli_hs", "H_Cap_oli", "H_Cap_blk", "H_Cap_grn", "rhsusf_bowman_cap", "rhsusf_Bowman",
    "rhs_Booniehat_ucp", "rhs_Booniehat_ocp", "rhs_booniehat2_marpatwd", "rhs_booniehat2_marpatd", "rhs_Booniehat_m81", "UK3CB_BAF_H_Boonie_DDPM", "UK3CB_BAF_H_Boonie_DDPM_PRR", "UK3CB_BAF_H_Boonie_DPMT",
    "UK3CB_BAF_H_Boonie_DPMT_PRR", "UK3CB_BAF_H_Boonie_DPMW", "UK3CB_BAF_H_Boonie_DPMW_PRR", "UK3CB_BAF_H_Beret_UN", "UK3CB_BAF_H_Beret_UN_Officer", "UK3CB_BAF_H_Beret_UN_Officer_PRR", "UK3CB_BAF_H_Beret_UN_Officer_PRR_Over",
    "UK3CB_BAF_H_Beret_UN_PRR", "UK3CB_BAF_H_Beret_UN_PRR_Over", "UK3CB_BAF_H_Beret_SAS", "UK3CB_BAF_H_Beret_SAS_PRR", "H_Watchcap_blk", "H_Watchcap_cbr", "H_Watchcap_camo",
    "H_Watchcap_khk", "H_Bandanna_gry", "H_Bandanna_cbr", "H_Bandanna_khk_hs", "H_Bandanna_khk", "H_Bandanna_mcamo", "H_Bandanna_sand",
    "UK3CB_BAF_H_Beret_Rifles", "UK3CB_BAF_H_Beret_Rifles_PRR", "UK3CB_BAF_H_Beret_RAF", "UK3CB_BAF_H_Beret_RAF_PRR", "UK3CB_BAF_H_Beret_GG", "UK3CB_BAF_H_Beret_GG_PRR"
];


// General Helmets
InA_AllowedArsenal_generalHelmets = [
    "rhsusf_ach_bare", "rhsusf_ach_bare_des", "rhsusf_ach_bare_des_ess", "rhsusf_ach_bare_des_headset", "rhsusf_ach_bare_des_headset_ess", "rhsusf_ach_bare_ess", "rhsusf_ach_bare_headset", "rhsusf_ach_bare_headset_ess",
    "rhsusf_ach_bare_semi", "rhsusf_ach_bare_semi_ess", "rhsusf_ach_bare_semi_headset", "rhsusf_ach_bare_semi_headset_ess", "rhsusf_ach_bare_tan", "rhsusf_ach_bare_tan_ess",
    "rhsusf_ach_bare_tan_headset", "rhsusf_ach_bare_tan_headset_ess", "rhsusf_ach_bare_wood", "rhsusf_ach_bare_wood_ess", "rhsusf_ach_bare_wood_headset", "rhsusf_ach_bare_wood_headset_ess", "rhsusf_ach_helmet_DCU",
    "rhsusf_ach_helmet_DCU_early", "rhsusf_ach_helmet_DCU_early_rhino", "rhsusf_ach_helmet_M81", "rhsusf_ach_helmet_ocp", "rhsusf_ach_helmet_ocp_alt", "rhsusf_ach_helmet_ESS_ocp",
    "rhsusf_ach_helmet_ESS_ocp_alt", "rhsusf_ach_helmet_headset_ocp", "rhsusf_ach_helmet_headset_ocp_alt", "rhsusf_ach_helmet_headset_ess_ocp", "rhsusf_ach_helmet_headset_ess_ocp_alt", "rhsusf_ach_helmet_camo_ocp",
    "rhsusf_ach_helmet_ocp_norotos", "rhsusf_ach_helmet_ucp", "rhsusf_ach_helmet_ucp_alt", "rhsusf_ach_helmet_ESS_ucp", "rhsusf_ach_helmet_ESS_ucp_alt", "rhsusf_ach_helmet_headset_ucp",
    "rhsusf_ach_helmet_headset_ucp_alt", "rhsusf_ach_helmet_headset_ess_ucp", "rhsusf_ach_helmet_headset_ess_ucp_alt", "rhsusf_ach_helmet_ucp_norotos", "rhsusf_cvc_green_helmet", "rhsusf_cvc_green_alt_helmet", 
    "rhsusf_cvc_green_ess", "rhsusf_cvc_helmet", "rhsusf_cvc_alt_helmet", "rhsusf_cvc_ess", "UK3CB_BAF_H_CrewHelmet_DDPM_A", "UK3CB_BAF_H_CrewHelmet_DDPM_ESS_A", "UK3CB_BAF_H_CrewHelmet_DPMT_A", "UK3CB_BAF_H_CrewHelmet_DPMT_ESS_A", 
    "UK3CB_BAF_H_CrewHelmet_DPMW_A", "UK3CB_BAF_H_CrewHelmet_DPMW_ESS_A", "UK3CB_BAF_H_CrewHelmet_A", "UK3CB_BAF_H_CrewHelmet_ESS_A", "UK3CB_BAF_H_CrewHelmet_B", "rhsusf_opscore_aor1", "rhsusf_opscore_aor1_pelt", "rhsusf_opscore_aor1_pelt_nsw", 
    "rhsusf_opscore_aor2", "rhsusf_opscore_aor2_pelt", "rhsusf_opscore_aor2_pelt_nsw", "rhsusf_opscore_bk", "rhsusf_opscore_bk_pelt", "rhsusf_opscore_coy_cover", "rhsusf_opscore_coy_cover_pelt", "rhsusf_opscore_fg", "rhsusf_opscore_fg_pelt", "rhsusf_opscore_fg_pelt_cam", 
    "rhsusf_opscore_fg_pelt_nsw", "rhsusf_opscore_mc_cover", "rhsusf_opscore_mc_cover_pelt", "rhsusf_opscore_mc_cover_pelt_nsw", "rhsusf_opscore_mc_cover_pelt_cam", "rhsusf_opscore_mc", "rhsusf_opscore_mc_pelt", "rhsusf_opscore_mc_pelt_nsw", "rhsusf_opscore_paint", "rhsusf_opscore_paint_pelt", 
    "rhsusf_opscore_paint_pelt_nsw", "rhsusf_opscore_paint_pelt_nsw_cam", "rhsusf_opscore_rg_cover", "rhsusf_opscore_rg_cover_pelt", "rhsusf_opscore_ut", "rhsusf_opscore_ut_pelt", "rhsusf_opscore_ut_pelt_cam", "rhsusf_opscore_ut_pelt_nsw", "rhsusf_opscore_ut_pelt_nsw_cam", "rhsusf_opscore_mar_fg", 
    "rhsusf_opscore_mar_fg_pelt", "rhsusf_opscore_mar_ut", "rhsusf_opscore_mar_ut_pelt", "UK3CB_BAF_H_Mk6_DDPM_A", "UK3CB_BAF_H_Mk6_DDPM_B", "UK3CB_BAF_H_Mk6_DDPM_C", "UK3CB_BAF_H_Mk6_DDPM_D", "UK3CB_BAF_H_Mk6_DDPM_E", "UK3CB_BAF_H_Mk6_DDPM_F", "UK3CB_BAF_H_Mk6_DPMT_A", "UK3CB_BAF_H_Mk6_DPMT_B", 
    "UK3CB_BAF_H_Mk6_DPMT_C", "UK3CB_BAF_H_Mk6_DPMT_D", "UK3CB_BAF_H_Mk6_DPMT_E", "UK3CB_BAF_H_Mk6_DPMT_F", "UK3CB_BAF_H_Mk6_DPMW_A", "UK3CB_BAF_H_Mk6_DPMW_B", "UK3CB_BAF_H_Mk6_DPMW_C", "UK3CB_BAF_H_Mk6_DPMW_D", "UK3CB_BAF_H_Mk6_DPMW_E", "UK3CB_BAF_H_Mk6_DPMW_F", "UK3CB_BAF_H_Mk7_Win_A", 
    "UK3CB_BAF_H_Mk7_Win_ESS_A", "UK3CB_BAF_H_Mk7_HiVis", "UK3CB_BAF_H_Mk7_Camo_A", "UK3CB_BAF_H_Mk7_Camo_B", "UK3CB_BAF_H_Mk7_Camo_C", "UK3CB_BAF_H_Mk7_Camo_D", "UK3CB_BAF_H_Mk7_Camo_E", "UK3CB_BAF_H_Mk7_Camo_F", "UK3CB_BAF_H_Mk7_Camo_ESS_A", "UK3CB_BAF_H_Mk7_Camo_ESS_B", "UK3CB_BAF_H_Mk7_Camo_ESS_C", 
    "UK3CB_BAF_H_Mk7_Camo_ESS_D", "UK3CB_BAF_H_Mk7_Net_A", "UK3CB_BAF_H_Mk7_Net_B", "UK3CB_BAF_H_Mk7_Net_C", "UK3CB_BAF_H_Mk7_Net_D", "UK3CB_BAF_H_Mk7_Net_ESS_A", "UK3CB_BAF_H_Mk7_Net_ESS_B", "UK3CB_BAF_H_Mk7_Net_ESS_C", "UK3CB_BAF_H_Mk7_Net_ESS_D", "UK3CB_BAF_H_Mk7_Net_CESS_A", 
    "UK3CB_BAF_H_Mk7_Net_CESS_B", "UK3CB_BAF_H_Mk7_Net_CESS_C", "UK3CB_BAF_H_Mk7_Net_CESS_D", "UK3CB_BAF_H_Mk7_Scrim_A", "UK3CB_BAF_H_Mk7_Scrim_B", "UK3CB_BAF_H_Mk7_Scrim_C", "UK3CB_BAF_H_Mk7_Scrim_D", "UK3CB_BAF_H_Mk7_Scrim_E", "UK3CB_BAF_H_Mk7_Scrim_F", "UK3CB_BAF_H_Mk7_Scrim_ESS_A", 
    "UK3CB_BAF_H_Mk7_Scrim_ESS_B", "UK3CB_BAF_H_Mk7_Scrim_ESS_C", "UK3CB_BAF_H_Mk7_Camo_CESS_A", "UK3CB_BAF_H_Mk7_Camo_CESS_B", "UK3CB_BAF_H_Mk7_Camo_CESS_C", "UK3CB_BAF_H_Mk7_Camo_CESS_D", "rhsusf_lwh_helmet_M1942", "rhsusf_lwh_helmet_marpatd", "rhsusf_lwh_helmet_marpatd_ess", "rhsusf_lwh_helmet_marpatd_headset", 
    "rhsusf_lwh_helmet_marpatwd", "rhsusf_lwh_helmet_marpatwd_blk_ess", "rhsusf_lwh_helmet_marpatwd_headset_blk2", "rhsusf_lwh_helmet_marpatwd_headset_blk", "rhsusf_lwh_helmet_marpatwd_headset", "rhsusf_lwh_helmet_marpatwd_ess", "rhsusf_mich_bare", "rhsusf_mich_bare_alt", "rhsusf_mich_bare_headset", 
    "rhsusf_mich_bare_norotos", "rhsusf_mich_bare_norotos_alt", "rhsusf_mich_bare_norotos_alt_headset", "rhsusf_mich_bare_norotos_arc", "rhsusf_mich_bare_norotos_arc_alt", "rhsusf_mich_bare_norotos_arc_alt_headset", "rhsusf_mich_bare_norotos_arc_headset", "rhsusf_mich_bare_norotos_arc_headset", 
    "rhsusf_mich_bare_norotos_headset", "rhsusf_mich_bare_semi", "rhsusf_mich_bare_alt_semi", "rhsusf_mich_bare_semi_headset", "rhsusf_mich_bare_norotos_semi", "rhsusf_mich_bare_norotos_alt_semi", "rhsusf_mich_bare_norotos_alt_semi_headset", "rhsusf_mich_bare_norotos_arc_semi", 
    "rhsusf_mich_bare_norotos_arc_alt_semi", "rhsusf_mich_bare_norotos_arc_alt_semi_headset", "rhsusf_mich_bare_norotos_arc_semi_headset", "rhsusf_mich_bare_norotos_semi_headset", "rhsusf_mich_bare_tan", "rhsusf_mich_bare_alt_tan", "rhsusf_mich_bare_tan_headset", "rhsusf_mich_bare_norotos_tan", 
    "rhsusf_mich_bare_norotos_alt_tan", "rhsusf_mich_bare_norotos_alt_tan_headset", "rhsusf_mich_bare_norotos_arc_tan", "rhsusf_mich_bare_norotos_arc_alt_tan", "rhsusf_mich_bare_norotos_arc_alt_tan_headset", "rhsusf_mich_bare_norotos_tan_headset", "rhsusf_mich_helmet_marpatd", 
    "rhsusf_mich_helmet_marpatd_alt", "rhsusf_mich_helmet_marpatd_alt_headset", "rhsusf_mich_helmet_marpatd_headset", "rhsusf_mich_helmet_marpatd_norotos", "rhsusf_mich_helmet_marpatd_norotos_arc", "rhsusf_mich_helmet_marpatd_norotos_arc_headset", "rhsusf_mich_helmet_marpatd_norotos_headset", 
    "rhsusf_mich_helmet_marpatwd", "rhsusf_mich_helmet_marpatwd_alt", "rhsusf_mich_helmet_marpatwd_alt_headset", "rhsusf_mich_helmet_marpatwd_headset", "rhsusf_mich_helmet_marpatwd_norotos", "rhsusf_mich_helmet_marpatwd_norotos_arc", "rhsusf_mich_helmet_marpatwd_norotos_arc_headset", "rhsusf_mich_helmet_marpatwd_norotos_headset",
    "rhsusf_protech_helmet", "rhsusf_protech_helmet_ess", "rhsusf_protech_helmet_rhino", "rhsusf_protech_helmet_rhino_ess", "rhsusf_ihadss"
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
    "UK3CB_BAF_H_Beret_RAMC_Officer", "UK3CB_BAF_H_Beret_RM_Officer"
];


// Pilot Headgear
InA_AllowedArsenal_headgearPilot = [
    "rhsusf_hgu56p_black", "rhsusf_hgu56p_mask_black", "rhsusf_hgu56p_mask_black_skull", "rhsusf_hgu56p_visor_black", "rhsusf_hgu56p_visor_mask_black", "rhsusf_hgu56p_visor_mask_Empire_black", "rhsusf_hgu56p_visor_mask_black_skull", "rhsusf_hgu56p_green", "rhsusf_hgu56p_mask_green", 
    "rhsusf_hgu56p_mask_green_mo", "rhsusf_hgu56p_visor_green", "rhsusf_hgu56p_visor_mask_green", "rhsusf_hgu56p_visor_mask_green_mo", "rhsusf_hgu56p", "rhsusf_hgu56p_mask", "rhsusf_hgu56p_mask_mo", "rhsusf_hgu56p_mask_skull", "rhsusf_hgu56p_visor", "rhsusf_hgu56p_visor_mask", "rhsusf_hgu56p_visor_mask_mo", 
    "rhsusf_hgu56p_visor_mask_skull", "rhsusf_hgu56p_pink", "rhsusf_hgu56p_mask_pink", "rhsusf_hgu56p_visor_pink", "rhsusf_hgu56p_visor_mask_pink", "rhsusf_hgu56p_saf", "rhsusf_hgu56p_mask_saf", "rhsusf_hgu56p_visor_saf", "rhsusf_hgu56p_visor_mask_saf", "rhsusf_hgu56p_mask_smiley", 
    "rhsusf_hgu56p_visor_mask_smiley", "rhsusf_hgu56p_tan", "rhsusf_hgu56p_mask_tan", "rhsusf_hgu56p_visor_tan", "rhsusf_hgu56p_visor_mask_tan", "rhsusf_hgu56p_usa", "rhsusf_hgu56p_visor_usa", "rhsusf_hgu56p_white", "rhsusf_hgu56p_visor_white", "RHS_jetpilot_usaf"
];


// General Uniforms
InA_AllowedArsenal_generalUniforms = [
    "rhs_uniform_abu", "rhs_uniform_acu_ocp", "rhs_uniform_acu_oefcp", "rhs_uniform_acu_ucp", "rhs_uniform_acu_ucpd",
    "rhs_uniform_acu_ucp2", "rhs_uniform_bdu_erdl", "UK3CB_BAF_U_CombatUniform_MTP_TShirt", "UK3CB_BAF_U_CombatUniform_MTP_TShirt_RM", "UK3CB_BAF_U_CombatUniform_DDPM", "UK3CB_BAF_U_CombatUniform_DDPM_RM", "UK3CB_BAF_U_CombatUniform_DDPM_ShortSleeve",
    "UK3CB_BAF_U_CombatUniform_DDPM_ShortSleeve_RM", "UK3CB_BAF_U_CombatUniform_DPMJ", "UK3CB_BAF_U_CombatUniform_DPMJ_RM", "UK3CB_BAF_U_CombatUniform_DPMJ_ShortSleeve", "UK3CB_BAF_U_CombatUniform_DPMJ_ShortSleeve_RM", "UK3CB_BAF_U_CombatUniform_DPMT",
    "UK3CB_BAF_U_CombatUniform_DPMT_RM", "UK3CB_BAF_U_CombatUniform_DPMT_ShortSleeve", "UK3CB_BAF_U_CombatUniform_DPMT_ShortSleeve_RM", "UK3CB_BAF_U_CombatUniform_DPMTrop", "UK3CB_BAF_U_CombatUniform_DPMTrop_RM", "rhs_uniform_g3_tan",
    "UK3CB_BAF_U_CombatUniform_DPMTrop_ShortSleeve", "UK3CB_BAF_U_CombatUniform_DPMTrop_ShortSleeve_RM", "UK3CB_BAF_U_CombatUniform_DPMW", "rhs_uniform_FROG01_d", "rhs_uniform_FROG01_wd", "rhs_uniform_g3_aor2", "rhs_uniform_g3_blk",
    "UK3CB_BAF_U_CombatUniform_DPMW_RM", "UK3CB_BAF_U_CombatUniform_DPMW_ShortSleeve", "UK3CB_BAF_U_CombatUniform_DPMW_ShortSleeve_RM", "UK3CB_BAF_U_CombatUniform_MTP", "rhs_uniform_g3_m81", "rhs_uniform_g3_mc", "rhs_uniform_g3_rgr",
    "UK3CB_BAF_U_CombatUniform_MTP_RM", "UK3CB_BAF_U_CombatUniform_MTP_ShortSleeve", "UK3CB_BAF_U_CombatUniform_MTP_ShortSleeve_RM", "rhs_uniform_cu_ocp", "rhs_uniform_cu_ocp_101st", "rhs_uniform_cu_ocp_10th",
    "rhs_uniform_cu_ocp_1stcav", "rhs_uniform_cu_ocp_82nd", "rhs_uniform_cu_ucp", "rhs_uniform_cu_ucp_101st", "rhs_uniform_cu_ucp_10th", "rhs_uniform_cu_ucp_1stcav", "rhs_uniform_cu_ucp_82nd", "UK3CB_BAF_U_CrewmanCoveralls_RTR", 
    "UK3CB_BAF_U_Smock_Arctic", "UK3CB_BAF_U_Smock_DDPM", "UK3CB_BAF_U_Smock_DPMT", "UK3CB_BAF_U_Smock_DPMW_Arctic", "UK3CB_BAF_U_Smock_DPMW_DDPM", "UK3CB_BAF_U_Smock_DPMW_MTP", "UK3CB_BAF_U_Smock_DPMW_OLI", "UK3CB_BAF_U_Smock_DPMW", 
    "UK3CB_BAF_U_Smock_MTP_Arctic", "UK3CB_BAF_U_Smock_MTP_DDPM", "UK3CB_BAF_U_Smock_MTP_DPMW", "UK3CB_BAF_U_Smock_MTP"
];


// Medic Uniforms
InA_AllowedArsenal_uniformsMedic = [
    "U_C_Paramedic_01_F",
    "U_C_ConstructionCoverall_Red_F"
];


// Marksman Uniforms
InA_AllowedArsenal_uniformsMarksman = [
    "UK3CB_BAF_U_CombatUniform_Arctic_Ghillie_RM", "UK3CB_BAF_U_CombatUniform_DDPM_Ghillie_RM", "UK3CB_BAF_U_CombatUniform_DPMT_Ghillie_RM", "UK3CB_BAF_U_CombatUniform_DPMW_Ghillie_RM", "UK3CB_BAF_U_CombatUniform_MTP_Ghillie_RM"
];


// Engineer Uniforms
InA_AllowedArsenal_uniformsEngineer = [
    "U_C_ConstructionCoverall_Black_F"
];


// Pilot Uniforms
InA_AllowedArsenal_uniformsPilot = [
    "UK3CB_BAF_U_HeliPilotCoveralls_Army", "UK3CB_BAF_U_HeliPilotCoveralls_RAF",
    "UK3CB_BAF_U_HeliPilotCoveralls_RN"
];


// Sniper Ghillie
InA_AllowedArsenal_uniformsSniper = [
    "U_B_FullGhillie_ard", "U_B_FullGhillie_lsh", "U_B_FullGhillie_sard", "U_B_T_FullGhillie_tna_F"
];

// Officer Uniform
InA_AllowedArsenal_uniformsOfficer = [

];


// General Vests
InA_AllowedArsenal_generalVests = [
    "rhsusf_iotv_ocp_Grenadier", "rhsusf_iotv_ucp_Grenadier", "rhsusf_iotv_ocp", "rhsusf_iotv_ocp_Rifleman", "rhsusf_iotv_ucp_Rifleman", "rhsusf_iotv_ocp_SAW", "rhsusf_iotv_ucp_SAW", "rhsusf_iotv_ocp_Squadleader",
    "rhsusf_iotv_ucp_Squadleader", "rhsusf_iotv_ocp_Teamleader", "rhsusf_iotv_ucp_Teamleader", "rhsusf_iotv_ucp", "rhsusf_mbav", "rhsusf_mbav_grenadier",
    "rhsusf_mbav_light", "rhsusf_mbav_mg", "rhsusf_mbav_rifleman", "UK3CB_BAF_V_Osprey_Winter", "UK3CB_BAF_V_Osprey_DDPM1", "UK3CB_BAF_V_Osprey_DDPM2",
    "UK3CB_BAF_V_Osprey_DDPM3", "UK3CB_BAF_V_Osprey_DDPM4", "UK3CB_BAF_V_Osprey_DDPM5", "UK3CB_BAF_V_Osprey_DDPM6", "UK3CB_BAF_V_Osprey_DDPM7", "UK3CB_BAF_V_Osprey_DDPM8",
    "UK3CB_BAF_V_Osprey_DDPM9", "UK3CB_BAF_V_Osprey_DPMT1", "UK3CB_BAF_V_Osprey_DPMT2", "UK3CB_BAF_V_Osprey_DPMT3", "UK3CB_BAF_V_Osprey_DPMT4", "UK3CB_BAF_V_Osprey_DPMT5",
    "UK3CB_BAF_V_Osprey_DPMT6", "UK3CB_BAF_V_Osprey_DPMT7", "UK3CB_BAF_V_Osprey_DPMT8", "UK3CB_BAF_V_Osprey_DPMT9", "UK3CB_BAF_V_Osprey_DPMW1", "UK3CB_BAF_V_Osprey_DPMW2", "UK3CB_BAF_V_Osprey_DPMW3",
    "UK3CB_BAF_V_Osprey_DPMW4", "UK3CB_BAF_V_Osprey_DPMW5", "UK3CB_BAF_V_Osprey_DPMW6", "UK3CB_BAF_V_Osprey_DPMW7", "UK3CB_BAF_V_Osprey_DPMW8", "UK3CB_BAF_V_Osprey_DPMW9", "UK3CB_BAF_V_Osprey_HiVis", "UK3CB_BAF_V_Osprey",
    "UK3CB_BAF_V_Osprey_Belt_A", "UK3CB_BAF_V_Osprey_Grenadier_A", "UK3CB_BAF_V_Osprey_Grenadier_B", "UK3CB_BAF_V_Osprey_Holster", "UK3CB_BAF_V_Osprey_Marksman_A", "UK3CB_BAF_V_Osprey_MG_A",
    "UK3CB_BAF_V_Osprey_MG_B", "UK3CB_BAF_V_Osprey_Rifleman_A", "UK3CB_BAF_V_Osprey_Rifleman_B", "UK3CB_BAF_V_Osprey_Rifleman_C", "UK3CB_BAF_V_Osprey_Rifleman_D", "UK3CB_BAF_V_Osprey_Rifleman_E",
    "UK3CB_BAF_V_Osprey_Rifleman_F", "UK3CB_BAF_V_Osprey_SL_A", "UK3CB_BAF_V_Osprey_SL_B", "UK3CB_BAF_V_Osprey_SL_C", "UK3CB_BAF_V_Osprey_SL_D", "UK3CB_BAF_V_Osprey_Lite", "UK3CB_BAF_V_Rebreather_PlateB",
    "UK3CB_BAF_V_RebreatherB", "rhsusf_spc", "rhsusf_spc_corpsman", "rhsusf_spc_crewman", "rhsusf_spc_iar", "rhsusf_spc_light", "rhsusf_spc_mg", "rhsusf_spc_marksman", "rhsusf_spc_patchless", "rhsusf_spc_patchless_radio", 
    "rhsusf_spc_rifleman", "rhsusf_spc_sniper", "rhsusf_spc_squadleader", "rhsusf_spc_teamleader", "rhsusf_spcs_ocp_crewman", "rhsusf_spcs_ucp_crewman", "rhsusf_spcs_ocp_grenadier", "rhsusf_spcs_ucp_grenadier", "rhsusf_spcs_ocp_machinegunner", 
    "rhsusf_spcs_ucp_machinegunner", "rhsusf_spcs_ocp", "rhsusf_spcs_ocp_rifleman_alt", "rhsusf_spcs_ucp_rifleman_alt", "rhsusf_spcs_ocp_rifleman", "rhsusf_spcs_ucp_rifleman", "rhsusf_spcs_ocp_saw", "rhsusf_spcs_ucp_saw", 
    "rhsusf_spcs_ocp_sniper", "rhsusf_spcs_ucp_sniper", "rhsusf_spcs_ocp_squadleader", "rhsusf_spcs_ucp_squadleader", "rhsusf_spcs_ocp_teamleader_alt", "rhsusf_spcs_ucp_teamleader_alt", "rhsusf_spcs_ocp_teamleader", "rhsusf_spcs_ucp_teamleader", 
    "rhsusf_spcs_ucp", "", "", "", "", ""
];


// Medic Vests
InA_AllowedArsenal_vestsMedic = [
    "rhsusf_iotv_ocp_Medic", "rhsusf_iotv_ucp_Medic", "rhsusf_mbav_medic", "UK3CB_BAF_V_Osprey_Medic_A", "UK3CB_BAF_V_Osprey_Medic_B", "UK3CB_BAF_V_Osprey_Medic_C", "UK3CB_BAF_V_Osprey_Medic_D", "rhsusf_spcs_ocp_medic", "rhsusf_spcs_ucp_medic", "", ""
];


// Engineer Vests
InA_AllowedArsenal_vestsEngineer = [
    "rhsusf_iotv_ocp_Repair", "rhsusf_iotv_ucp_Repair", "V_Safety_yellow_F"
];


// EOD Vests
InA_AllowedArsenal_vestsEOD = [
    "V_EOD_blue_F", "V_EOD_coyote_F", "V_EOD_olive_F"
];


// Pilot Vests
InA_AllowedArsenal_vestsPilot = [
    "UK3CB_BAF_V_Pilot_DDPM", "UK3CB_BAF_V_Pilot_DPMT", "UK3CB_BAF_V_Pilot_DPMW", "UK3CB_BAF_V_Pilot_A", "V_Pocketed_black_F"
];


// General Backpacks
InA_AllowedArsenal_generalBackpacks = [
    "UK3CB_BAF_B_Bergen_DDPM_JTAC_A", "UK3CB_BAF_B_Bergen_DDPM_JTAC_H_A", "UK3CB_BAF_B_Bergen_DDPM_Rifleman_A", "UK3CB_BAF_B_Bergen_DDPM_Rifleman_B", "UK3CB_BAF_B_Bergen_DDPM_SL_A", "UK3CB_BAF_B_Bergen_DPMT_JTAC_A", "UK3CB_BAF_B_Bergen_DPMT_JTAC_H_A",
    "UK3CB_BAF_B_Bergen_DPMT_Rifleman_A", "UK3CB_BAF_B_Bergen_DPMT_Rifleman_B", "UK3CB_BAF_B_Bergen_DPMT_SL_A", "UK3CB_BAF_B_Bergen_DPMW_JTAC_A", "UK3CB_BAF_B_Bergen_DPMW_JTAC_H_A", "UK3CB_BAF_B_Bergen_DPMW_Rifleman_A", "UK3CB_BAF_B_Bergen_DPMW_Rifleman_B", 
    "UK3CB_BAF_B_Bergen_DPMW_SL_A", "UK3CB_BAF_B_Bergen_MTP_Engineer_H_A", "UK3CB_BAF_B_Bergen_MTP_Engineer_L_A", "UK3CB_BAF_B_Bergen_MTP_JTAC_H_A", "UK3CB_BAF_B_Bergen_MTP_JTAC_L_A", "UK3CB_BAF_B_Bergen_MTP_PointMan_H_A", "UK3CB_BAF_B_Bergen_MTP_PointMan_L_A", 
    "UK3CB_BAF_B_Bergen_MTP_Radio_H_A", "UK3CB_BAF_B_Bergen_MTP_Radio_H_B", "UK3CB_BAF_B_Bergen_MTP_Radio_L_A", "UK3CB_BAF_B_Bergen_MTP_Radio_L_B", "UK3CB_BAF_B_Bergen_MTP_Rifleman_H_A", "UK3CB_BAF_B_Bergen_MTP_Rifleman_H_B", "UK3CB_BAF_B_Bergen_MTP_Rifleman_H_C", 
    "UK3CB_BAF_B_Bergen_MTP_Rifleman_L_A", "UK3CB_BAF_B_Bergen_MTP_Rifleman_L_B", "UK3CB_BAF_B_Bergen_MTP_Rifleman_L_C", "UK3CB_BAF_B_Bergen_MTP_Rifleman_L_D", "UK3CB_BAF_B_Bergen_MTP_Rifleman_XL_A", "UK3CB_BAF_B_Bergen_MTP_Sapper_H_A", "UK3CB_BAF_B_Bergen_MTP_Sapper_L_A", 
    "UK3CB_BAF_B_Bergen_MTP_SL_H_A", "UK3CB_BAF_B_Bergen_MTP_SL_L_A", "UK3CB_BAF_B_Bergen_OLI_JTAC_A", "UK3CB_BAF_B_Bergen_OLI_JTAC_H_A", "UK3CB_BAF_B_Bergen_OLI_Rifleman_A", "UK3CB_BAF_B_Bergen_OLI_Rifleman_A", "UK3CB_BAF_B_Bergen_OLI_Rifleman_B", "UK3CB_BAF_B_Bergen_OLI_SL_A",
    "UK3CB_BAF_B_Bergen_TAN_JTAC_A", "UK3CB_BAF_B_Bergen_TAN_JTAC_H_A", "UK3CB_BAF_B_Bergen_TAN_Rifleman_A", "UK3CB_BAF_B_Bergen_TAN_Rifleman_B", "UK3CB_BAF_B_Bergen_TAN_SL_A", "UK3CB_BAF_B_Carryall_Arctic", "rhsusf_assault_eagleaiii_coy", "B_rhsusf_B_BACKPACK", "rhsusf_assault_eagleaiii_ocp", 
    "rhsusf_assault_eagleaiii_ucp", "rhsusf_falconii_coy", "rhsusf_falconii_mc", "rhsusf_falconii", "rhsusf_eject_Parachute_backpack", "UK3CB_BAF_B_Carryall_DDPM", "UK3CB_BAF_B_Carryall_DPMT", "UK3CB_BAF_B_Carryall_DPMW", "UK3CB_BAF_B_Carryall_OLI", "UK3CB_BAF_B_Carryall_MTP", "UK3CB_BAF_B_Carryall_TAN"
];


// Radio Backpacks
InA_AllowedArsenal_backpacksRadio = [
    "B_RadioBag_01_black_F", "B_RadioBag_01_mtp_F",
    "B_RadioBag_01_tropic_F", "B_RadioBag_01_wdl_F",
    "B_RadioBag_01_eaf_F"
];


// Drone Backpacks
InA_AllowedArsenal_backpackDrones = [
    "B_UAV_01_backpack_F", "B_UAV_06_backpack_F", "B_UAV_06_medical_backpack_F", "B_W_Static_Designator_01_weapon_F", "B_UGV_02_Demining_backpack_F", "B_UGV_02_Science_backpack_F"
];


// Medical backpacks
InA_AllowedArsenal_backpackMedic = [
    "UK3CB_BAF_B_Bergen_MTP_Medic_H_A", "UK3CB_BAF_B_Bergen_MTP_Medic_H_B", "UK3CB_BAF_B_Bergen_MTP_Medic_L_A", "UK3CB_BAF_B_Bergen_MTP_Medic_L_B"
];


// Static Weapon Backpacks
InA_AllowedArsenal_backpackStatics = [
    "RHS_Mk19_Gun_Bag", "RHS_Mk19_Tripod_Bag", "RHS_M2_Gun_Bag", "RHS_M2_Tripod_Bag", "rhs_M252_Gun_Bag", "rhs_M252_Bipod_Bag"
];


// Things and stuff that aren't in the Arsenal, but you're allowed to pick up (also launchers that get assembled)
InA_AllowedPickup_Launchers = [
    "rhs_weap_igla",
    "rhs_weap_rpg26",
    "rhs_weap_fgm148",
    "rhs_weap_m72a7",
    "rhs_weap_rpg75",
    "UK3CB_BAF_Javelin_Launcher"
];


// Rifles allowed to be pickud up ....
InA_AllowedPickup_Rifles = [
    "rhs_weap_ak74m",
    "rhs_weap_aks74u",
    "arifle_AK12_base_F",
    "PRACS_g3a3",
    "PRACS_g3a4",
    "rhs_weap_hk416d10_LMT_d",
    "rhs_weap_ak74",
    "rhs_weap_vhsd2"
];


// Pickup Backpacks
InA_AllowedPickup_Backpacks = [
    "Bag_Base"
];


// ArsenalDefinitions initialized ....
InA_ArsenalDefinitionsInitialized = true;
