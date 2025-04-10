//US forces arsenal for I&A 3,prairie fire addition. by LH5

// Make sure to only run once ....
if (!isNil "InA_ArsenalDefinitionsInitialized") exitWith {};

InA_ArsenalDefinitionsInitialized = false;

// Items,optics and accessories all slots have access to.
InA_AllowedArsenal_generalItems = [
//suppressors
"vn_s_m1895","vn_s_m1911","vn_s_mk22","vn_s_m3a1","vn_s_sten","vn_s_mc10","vn_s_m45_camo","vn_s_m45","vn_s_m14","vn_s_m16","vn_s_mpu",

//scopes
"vn_o_4x_m16","vn_o_1x_sp_m16","vn_o_anpvs2_m16","vn_o_anpvs2_m14","vn_o_3x_l1a1",

//bayonets
"vn_b_carbine","vn_b_m14","vn_b_m16","vn_b_m1897","vn_b_l1a1","vn_b_m1_garand",

//bipods
"vn_b_camo_m14","vn_b_camo_m40a1","vn_b_camo_m9130","vn_bipod_m14","vn_bipod_m1918","vn_bipod_m16",

//coms
"vn_o_item_radio_m252","vn_b_item_radio_urc10",

//nav
"vn_b_item_compass_sog","vn_b_item_compass","ItemCompass",

//watch
"vn_b_item_watch",

//bino
"vn_m19_binocs_grn","vn_m19_binocs_grey","vn_mk21_binocs","vn_anpvs2_binoc",

//maps
"vn_b_item_map",

//Camo wraps
"vn_b_camo_m1_garand","vn_b_camo_m14a1","vn_b_camo_vz54",

//misc
"vn_b_item_firstaidkit","vn_b_item_medikit_01","vn_b_item_toolkit","vn_b_item_trapkit","vn_b_item_wiretap","vn_o_item_firstaidkit"
];

InA_AllowedArsenal_reconItems = [];

// UAV Item(s)
InA_AllowedArsenal_uavItems = ["B_UavTerminal"];

// TFAR Radio Backpacks
if (isClass (configFile >> "CfgPatches" >> "task_force_radio")) then {
    InA_AllowedArsenal_generalItems append ["TFAR_rf7800str","TFAR_anprc152","TFAR_microdagr"];

    InA_AllowedArsenal_tfarBackPacks = [
        "TFAR_rt1523g","TFAR_rt1523g_big","TFAR_rt1523g_black","TFAR_rt1523g_fabric","TFAR_rt1523g_green","TFAR_rt1523g_rhs","TFAR_rt1523g_sage","TFAR_anarc210"
    ];
} else {
    InA_AllowedArsenal_generalItems append ["ItemRadio"];
};

// Magazines all slots have access to.
InA_AllowedArsenal_generalMagazines = [
//pistol mags
"vn_m10_mag","vn_hp_mag","vn_izh54_mag","vn_izh54_so_mag","vn_m1895_mag","vn_m1911_mag","vn_mk22_mag","vn_s_mk22","vn_welrod_mag","vn_hd_mag",

//40mm
"vn_40mm_m381_he_mag","vn_40mm_m397_ab_mag","vn_40mm_m406_he_mag","vn_40mm_m433_hedp_mag","vn_40mm_m583_flare_w_mag",
"vn_40mm_m651_cs_mag","vn_40mm_m661_flare_g_mag","vn_40mm_m662_flare_r_mag","vn_40mm_m680_smoke_w_mag","vn_40mm_m682_smoke_r_mag","vn_40mm_m695_flare_y_mag","vn_40mm_m715_smoke_g_mag","vn_40mm_m716_smoke_y_mag","vn_40mm_m717_smoke_p_mag","vn_40mm_m576_buck_mag",

//launcher ammo
"vn_m72_mag","vn_sa7b_mag","vn_m127_mag","vn_m128_mag","vn_m129_mag",

//carbine mags
"vn_carbine_15_mag","vn_carbine_15_t_mag","vn_carbine_30_mag","vn_carbine_30_t_mag",

//XM177 + m16 mags
"vn_m16_20_mag","vn_m16_40_mag","vn_m16_20_t_mag","vn_m16_40_t_mag","vn_m16_30_mag","vn_m16_30_t_mag",

//SMG mags
"vn_m3a1_mag","vn_m3a1_t_mag","vn_sten_mag","vn_sten_t_mag","vn_mc10_mag","vn_mc10_t_mag","vn_m45_mag","vn_m45_t_mag","vn_m1a1_20_mag","vn_m1a1_20_t_mag","vn_m1a1_30_mag","vn_m1a1_30_t_mag","vn_m1928_mag","vn_m1928_t_mag","vn_mpu_mag","vn_mpu_t_mag","vn_vz61_mag","vn_vz61_t_mag",
"vn_f1_smg_mag","vn_f1_smg_t_mag",

//M14
"vn_m14_10_mag","vn_m14_10_t_mag","vn_m14_mag","vn_m14_t_mag","20Rnd_762x51_Mag","10Rnd_Mk14_762x51_Mag",

//M1 garand
"vn_m1_garand_mag","vn_m1_garand_t_mag",

//m63a mags
"vn_m63a_30_mag","vn_m63a_30_t_mag","vn_m63a_150_mag","vn_m63a_150_t_mag","vn_m63a_100_mag","vn_m63a_100_t_mag",

//shotgun rounds
"vn_m1897_buck_mag","vn_m1897_fl_mag",

//AK
"vn_type56_mag","vn_type56_t_mag",

//rifle nades
"vn_22mm_cs_mag","vn_22mm_lume_mag","vn_22mm_m17_frag_mag","vn_22mm_m19_wp_mag","vn_22mm_m1a2_frag_mag","vn_22mm_m22_smoke_mag","vn_22mm_m9_heat_mag",

//M60 box
"vn_m60_100_mag",

//M40
"vn_m40a1_mag","vn_m40a1_t_mag",

//VZ54
"vn_m38_mag","vn_m38_t_mag",

//BAR
"vn_m1918_mag","vn_m1918_t_mag",

//underwater ammo
"vn_mk1_udg_mag",

//L1/2A1
"vn_l1a1_20_mag","vn_l1a1_20_t_mag","vn_l1a1_30_mag","vn_l1a1_30_t_mag","vn_l1a1_30_02_mag","vn_l1a1_30_02_t_mag","vn_l1a1_10_mag","vn_l1a1_10_t_mag",
"vn_22mm_n94_heat_mag","vn_22mm_m61_frag_mag",

//grenades
"vn_molotov_grenade_mag","vn_f1_grenade_mag","vn_m14_grenade_mag","vn_m14_early_grenade_mag","vn_m34_grenade_mag","vn_m61_grenade_mag","vn_m67_grenade_mag","vn_m7_grenade_mag",
"vn_m18_green_mag","vn_m18_white_mag","vn_m18_yellow_mag","vn_v40_grenade_mag",
"vn_rkg3_grenade_mag"
];

// Recon optics
InA_AllowedArsenal_opticsRecon = [];

// Marksman optics
InA_AllowedArsenal_opticsMarksman = [
"vn_o_3x_m84","vn_o_9x_m14","vn_o_9x_m16","vn_o_3x_m84","vn_o_3x_vz54"
];

// Sniper optics
InA_AllowedArsenal_opticsSniper = [
"vn_o_9x_m40a1","vn_o_anpvs2_m40a1","vn_o_3x_m84","vn_o_3x_vz54"
];

// Mines and explosives
InA_AllowedArsenal_Explosives = [
"vn_mine_m18_mag","vn_mine_m18_x3_mag","vn_mine_satchel_remote_02_mag","vn_mine_m112_remote_mag"
];

// Underwater gun
InA_AllowedArsenal_underWaterGun = [
"vn_mk1_udg"
];

// General Pistols
InA_AllowedArsenal_generalPistols = [
"vn_p38s","vn_fkb1","vn_hd","vn_fkb1_red","vn_hp","vn_izh54_p","vn_m1895","vn_m1911","vn_mx991_m1911","vn_mk22","vn_m10","vn_mx991","vn_mx991_red","vn_welrod",

//Flare launcher
"vn_m127"
];

// Sub Machine Guns
InA_AllowedArsenal_generalSMGs = [
"vn_m3a1","vn_sten","vn_mc10","vn_m45","vn_m45_camo","vn_m45_fold","vn_m1928_tommy","vn_m1928a1_tommy","vn_m1a1_tommy","vn_m1a1_tommy_so","vn_mpu",
"vn_f1_smg"
];

// Carbines
InA_AllowedArsenal_generalCarbines = [
"vn_xm177_short","vn_m3carbine","vn_m1carbine","vn_m2carbine","vn_m1897","vn_gau5a"
];

// Pilot Carbines
InA_AllowedArsenal_pilotCarbines = [
"vn_m1carbine","vn_m2carbine","vn_xm177_short","vn_m1897"
];

// Assault rifles
InA_AllowedArsenal_generalAssaultRifles = [
"vn_m14","vn_m14_camo","vn_m14a1","vn_m16","vn_m16_camo","vn_m16_usaf","vn_m63a","vn_xm177","vn_xm177_camo","vn_xm177_fg","vn_xm177_stock","vn_xm177_stock_camo",
"vn_l1a1_01","vn_l1a1_01_camo","vn_l1a1_02","vn_l1a1_02_camo","vn_l1a1_03","vn_l1a1_03_camo","vn_l2a1_01","vn_m1_garand","vn_m14_a1","vn_xm16e1","vn_xm177e1",
"vn_xm177e1_camo"
];

// Underslung Assault rifles
InA_AllowedArsenal_assaultRiflesUGL = [
"vn_m79_p","vn_m1carbine_gl","vn_m79","vn_xm177_xm148","vn_xm177_xm148_camo","vn_m16_xm148","vn_m2carbine_gl",
"vn_l1a1_01_gl","vn_l1a1_02_gl","vn_l1a1_03_gl","vn_m1_garand_gl","vn_l1a1_xm148","vn_l1a1_xm148_camo","vn_m16_m203_camo",
"vn_m16_m203","vn_xm16e1_xm148"
];

// Light/Medium Machine Guns
InA_AllowedArsenal_Machineguns = [
"vn_m60","vn_m60_shorty","vn_m60_shorty_camo","vn_m63a_cdo","vn_m63a_lmg","vn_m1918"
];

// Designated Marksman Rifles
InA_AllowedArsenal_marksmanRifles = [
"vn_m16","vn_m16_camo","vn_m1carbine","vn_m14","vn_m14_camo","vn_m2carbine"
];

// Sniper Rifles
InA_AllowedArsenal_sniperRifles = [
"vn_m40a1","vn_m40a1_camo","vn_vz54"
];

// Light AT launchers
InA_AllowedArsenal_launchersLight = [
"vn_m72"
];

// Heavy Missile launchers
InA_AllowedArsenal_launchersHeavy = [
"vn_m72","vn_m127","vn_sa7b"
];

// Recon Rifles
InA_AllowedArsenal_reconRifles = [
"vn_izh54","vn_izh54_shorty","vn_k50m","vn_m1891","vn_m38","vn_m4956",
"vn_m9130","vn_mat49","vn_mat49_f","vn_mat49_vc","vn_mp40","vn_pps43","vn_pps52",
"vn_ppsh41","vn_sks","vn_type56","vn_vz61","vn_vz61_p"
];

// General Facewear
InA_AllowedArsenal_generalFacewear = [
"vn_b_aviator","vn_b_bandana_a","vn_o_bandana_b","vn_o_bandana_g","vn_o_acc_goggles_01","vn_b_acc_m17_01","vn_b_acc_m17_02","vn_b_acc_goggles_01","vn_o_acc_km32_01","vn_b_acc_ms22001_01","vn_b_acc_ms22001_02",
"vn_o_acc_goggles_02","vn_o_acc_goggles_03","vn_o_poncho_01_01","vn_b_scarf_01_03","vn_o_scarf_01_04","vn_o_scarf_01_03","vn_o_scarf_01_02","vn_b_scarf_01_01","vn_o_scarf_01_01","vn_b_spectacles","vn_g_spectacles_02",
"vn_g_spectacles_01","vn_b_squares","vn_b_squares_tinted","vn_g_glasses_01","vn_b_spectacles_tinted",
"G_Aviator","G_Bandanna_aviator","G_Bandanna_beast","G_Bandanna_khk","G_Bandanna_tan","G_Diving","G_B_Diving","G_Spectacles",

"vn_b_acc_seal_01",
"vn_b_acc_towel_01","vn_b_acc_towel_02"
];

// Medical facewaer
InA_AllowedArsenal_facewearMedic = [
"G_Respirator_white_F"
];

// General Headgear
InA_AllowedArsenal_generalHeadgear = [
"vn_b_bandana_03","vn_b_bandana_06","vn_b_bandana_01","vn_b_bandana_07","vn_b_bandana_04","vn_b_bandana_05","vn_b_bandana_02","vn_b_beret_01_02","vn_b_beret_01_01","vn_b_beret_01_05","vn_b_beret_01_04","vn_b_beret_01_03",
"vn_b_beret_01_06","vn_b_boonie_02_03","vn_b_boonie_02_06","vn_b_boonie_02_01","vn_b_boonie_02_07","vn_b_boonie_02_04","vn_b_boonie_02_05","vn_b_boonie_02_02","vn_b_boonie_03_03","vn_b_boonie_03_06","vn_b_boonie_03_01","vn_b_boonie_03_07",
"vn_b_boonie_03_04","vn_b_boonie_03_05","vn_b_boonie_03_02","vn_b_boonie_04_03","vn_b_boonie_04_06","vn_b_boonie_04_01","vn_b_boonie_04_07","vn_b_boonie_04_04","vn_b_boonie_04_05","vn_b_boonie_04_02","vn_b_boonie_05_03","vn_b_boonie_05_06",
"vn_b_boonie_05_01","vn_b_boonie_05_07","vn_b_boonie_05_04","vn_b_boonie_05_05","vn_b_boonie_05_02","vn_b_boonie_01_03","vn_b_boonie_01_06","vn_b_boonie_01_01","vn_b_boonie_01_07","vn_b_boonie_01_04","vn_b_boonie_01_05","vn_b_boonie_01_02",
"vn_b_headband_03","vn_c_headband_04","vn_c_headband_03","vn_b_headband_05","vn_c_headband_02","vn_b_headband_01","vn_c_headband_01","vn_b_headband_04","vn_b_headband_02",
"H_Cap_blk","H_Cap_blu","H_Cap_blk_CMMG","H_Cap_grn","H_Cap_surfer","H_Cap_tan","H_Cap_khaki_specops_UK","H_Cap_usblack","H_Cap_tan_specops_US","H_Hat_camo","H_HeadBandage_clean_F","H_HeadBandage_stained_F","H_HeadBandage_bloody_F",
"H_Hat_Safari_olive_F","H_Hat_Safari_sand_F","H_StrawHat","H_StrawHat_dark"
];

// General Helmets
InA_AllowedArsenal_generalHelmets = [

"vn_b_helmet_t56_01_01","vn_b_helmet_t56_02_01","vn_b_helmet_t56_01_02","vn_b_helmet_t56_02_02","vn_b_helmet_t56_01_03","vn_b_helmet_t56_02_03","vn_b_helmet_m1_01_02","vn_i_helmet_m1_01_01","vn_b_helmet_m1_01_01","vn_i_helmet_m1_01_02",
"vn_b_helmet_m1_02_02","vn_b_helmet_m1_02_01","vn_b_helmet_m1_03_02","vn_b_helmet_m1_03_01","vn_b_helmet_m1_05_02","vn_b_helmet_m1_05_01","vn_b_helmet_m1_06_02","vn_b_helmet_m1_06_01","vn_b_helmet_m1_07_02","vn_b_helmet_m1_07_01",
"vn_b_helmet_m1_09_02","vn_b_helmet_m1_09_01","vn_b_helmet_m1_04_02","vn_b_helmet_m1_04_01","vn_b_helmet_m1_08_02","vn_b_helmet_m1_08_01",

"vn_i_helmet_m1_02_01","vn_i_helmet_m1_03_01","vn_b_helmet_m1_12_01","vn_b_helmet_m1_12_02","vn_i_helmet_m1_02_02","vn_i_helmet_m1_03_02","vn_b_helmet_m1_10_01","vn_b_helmet_m1_11_01"
];

// EOD / Explosive Spec. Headgear
InA_AllowedArsenal_headgearEngineer = [
];

// Officer Berets
InA_AllowedArsenal_heagearOfficer = [
    "H_Beret_Colonel"
];

// Pilot Headgear
InA_AllowedArsenal_headgearPilot = [
"vn_b_helmet_aph6_01_02","vn_b_helmet_aph6_02_02","vn_b_helmet_aph6_01_05","vn_b_helmet_aph6_02_05","vn_b_helmet_aph6_01_03","vn_b_helmet_aph6_02_03","vn_b_helmet_aph6_01_04","vn_b_helmet_aph6_02_04","vn_b_helmet_aph6_01_01","vn_b_helmet_aph6_02_01",
"vn_b_helmet_svh4_01_01","vn_b_helmet_svh4_02_01","vn_b_helmet_svh4_01_04","vn_b_helmet_svh4_02_04","vn_b_helmet_svh4_01_06","vn_b_helmet_svh4_02_06","vn_b_helmet_svh4_01_03","vn_b_helmet_svh4_02_03"
] + InA_AllowedArsenal_generalHeadgear;

// General Uniforms
InA_AllowedArsenal_generalUniforms = [
"vn_b_uniform_macv_01_02","vn_b_uniform_macv_01_05","vn_b_uniform_macv_01_04","vn_b_uniform_macv_01_01","vn_b_uniform_macv_01_07","vn_b_uniform_macv_01_08","vn_b_uniform_macv_01_06","vn_b_uniform_macv_01_03",
"vn_b_uniform_macv_02_01","vn_b_uniform_macv_02_02","vn_b_uniform_macv_02_03","vn_b_uniform_macv_02_04","vn_b_uniform_macv_02_05","vn_b_uniform_macv_02_06","vn_b_uniform_macv_02_07","vn_b_uniform_macv_02_08",
"vn_b_uniform_macv_03_01","vn_b_uniform_macv_03_02","vn_b_uniform_macv_03_03","vn_b_uniform_macv_03_04","vn_b_uniform_macv_03_05","vn_b_uniform_macv_03_06","vn_b_uniform_macv_03_07","vn_b_uniform_macv_03_08",
"vn_b_uniform_macv_04_01","vn_b_uniform_macv_04_02","vn_b_uniform_macv_03_04","vn_b_uniform_macv_04_04","vn_b_uniform_macv_04_05","vn_b_uniform_macv_04_06","vn_b_uniform_macv_04_07","vn_b_uniform_macv_04_08",
"vn_b_uniform_macv_05_01","vn_b_uniform_macv_05_02","vn_b_uniform_macv_03_05","vn_b_uniform_macv_05_04","vn_b_uniform_macv_05_05","vn_b_uniform_macv_05_06","vn_b_uniform_macv_05_07","vn_b_uniform_macv_05_08",
"vn_b_uniform_macv_06_01","vn_b_uniform_macv_06_02","vn_b_uniform_macv_03_06","vn_b_uniform_macv_06_04","vn_b_uniform_macv_06_05","vn_b_uniform_macv_06_06","vn_b_uniform_macv_06_07","vn_b_uniform_macv_06_08",
"vn_b_uniform_sog_01_01","vn_b_uniform_sog_01_02","vn_b_uniform_sog_01_03","vn_b_uniform_sog_01_04","vn_b_uniform_sog_01_05","vn_b_uniform_sog_01_06",
"vn_b_uniform_sog_02_01","vn_b_uniform_sog_02_02","vn_b_uniform_sog_02_03","vn_b_uniform_sog_02_04","vn_b_uniform_sog_02_05","vn_b_uniform_sog_02_06",

"vn_b_uniform_seal_01_06","vn_b_uniform_seal_01_01","vn_b_uniform_seal_01_07","vn_b_uniform_seal_01_05","vn_b_uniform_seal_01_02","vn_b_uniform_seal_02_06","vn_b_uniform_seal_02_01","vn_b_uniform_seal_02_07","vn_b_uniform_seal_02_05","vn_b_uniform_seal_02_02","vn_b_uniform_seal_03_01","vn_b_uniform_seal_04_01","vn_b_uniform_seal_05_06","vn_b_uniform_seal_05_01","vn_b_uniform_seal_05_07","vn_b_uniform_seal_05_05","vn_b_uniform_seal_05_02","vn_b_uniform_seal_06_06","vn_b_uniform_seal_06_01","vn_b_uniform_seal_06_07","vn_b_uniform_seal_06_05","vn_b_uniform_seal_06_02",
"vn_b_uniform_seal_07_01","vn_b_uniform_seal_07_02","vn_b_uniform_seal_07_03","vn_b_uniform_seal_07_04","vn_b_uniform_seal_08_01","vn_b_uniform_seal_08_02","vn_b_uniform_seal_08_03","vn_b_uniform_seal_08_04","vn_b_uniform_seal_09_01",

"vn_b_uniform_macv_01_17","vn_b_uniform_macv_02_17","vn_b_uniform_macv_03_17","vn_b_uniform_macv_04_17","vn_b_uniform_macv_05_17","vn_b_uniform_macv_06_17",
"vn_b_uniform_aus_01_01","vn_b_uniform_aus_02_01","vn_b_uniform_aus_03_01","vn_b_uniform_aus_04_01","vn_b_uniform_aus_05_01","vn_b_uniform_aus_06_01","vn_b_uniform_aus_07_01","vn_b_uniform_aus_08_01","vn_b_uniform_aus_09_01","vn_b_uniform_aus_10_01",
"vn_b_uniform_nz_01_01","vn_b_uniform_nz_02_01","vn_b_uniform_nz_03_01","vn_b_uniform_nz_04_01","vn_b_uniform_nz_05_01","vn_b_uniform_nz_06_01",
"vn_b_uniform_macv_01_16","vn_b_uniform_macv_02_16","vn_b_uniform_macv_03_16","vn_b_uniform_macv_04_16","vn_b_uniform_macv_05_16","vn_b_uniform_macv_06_16",
"vn_b_uniform_macv_01_18","vn_b_uniform_macv_02_18","vn_b_uniform_macv_03_18","vn_b_uniform_macv_04_18","vn_b_uniform_macv_05_18","vn_b_uniform_macv_06_18"
];

// Medic Uniforms
InA_AllowedArsenal_uniformsMedic = [
"U_C_Paramedic_01_F"
];

// Marksman Uniforms
InA_AllowedArsenal_uniformsMarksman = [
];

// Engineer Uniforms
InA_AllowedArsenal_uniformsEngineer = [
];

// Pilot Uniforms
InA_AllowedArsenal_uniformsPilot = [
"vn_b_uniform_heli_01_01","vn_b_uniform_k2b_02_01","vn_b_uniform_k2b_01_01","vn_b_uniform_k2b_02_02","vn_b_uniform_k2b_01_02","vn_b_uniform_k2b_02_03"
];

// Sniper Ghillie
InA_AllowedArsenal_uniformsSniper = [
];

// Officer Uniform
InA_AllowedArsenal_uniformsOfficer = [
];

// General Vests
InA_AllowedArsenal_generalVests = [
"vn_b_vest_usarmy_01","vn_b_vest_usarmy_02","vn_b_vest_usarmy_04",
"vn_b_vest_usarmy_06","vn_b_vest_usarmy_08","vn_b_vest_usarmy_09","vn_b_vest_usarmy_10",
"vn_b_vest_usarmy_11","vn_b_vest_usarmy_12","vn_b_vest_usarmy_13","vn_b_vest_usarmy_14",
"vn_b_vest_sog_05","vn_b_vest_sog_06","vn_b_vest_sog_01","vn_b_vest_sog_04",
"V_LegStrapBag_black_F","V_LegStrapBag_coyote_F","V_LegStrapBag_olive_F",

"vn_b_vest_seal_01","vn_b_vest_seal_07","vn_b_vest_seal_06","vn_b_vest_seal_03","vn_b_vest_seal_04","vn_b_vest_seal_05","vn_b_vest_seal_02"
];

// Medic Vests
InA_AllowedArsenal_vestsMedic = [
    "vn_b_vest_usarmy_07","vn_b_vest_sog_02"
];

// Engineer Vests
InA_AllowedArsenal_vestsEngineer = [
    "vn_b_vest_sog_03"
];

// EOD Vests
InA_AllowedArsenal_vestsEOD = [
    "vn_b_vest_sog_03"
];

// Pilot Vests
InA_AllowedArsenal_vestsPilot = [
    "vn_b_vest_aircrew_01","vn_b_vest_usarmy_03","vn_b_vest_usarmy_05",
    "vn_b_vest_aircrew_07","vn_b_vest_aircrew_04","vn_b_vest_aircrew_06","vn_b_vest_aircrew_02"
];

// General Backpacks
InA_AllowedArsenal_generalBackpacks = [
    "vn_b_pack_lw_04","vn_b_pack_lw_05","vn_b_pack_lw_02","vn_b_pack_lw_01","vn_b_pack_lw_03","vn_b_pack_trp_03_02",
    "vn_b_pack_trp_01_02","vn_b_pack_trp_04_02","vn_b_pack_trp_02_02","vn_b_pack_05_02","vn_b_pack_02_02","vn_b_pack_04_02",
    "vn_b_pack_01_02","vn_b_pack_05","vn_b_pack_02","vn_b_pack_04","vn_b_pack_01","vn_b_pack_trp_03","vn_b_pack_trp_01",
    "vn_b_pack_trp_02","B_Parachute","B_LegStrapBag_black_F","B_LegStrapBag_coyote_F","B_LegStrapBag_olive_F",
    "vn_b_pack_02_xm177_pl", "vn_b_pack_02_medic_m45_pl","vn_b_pack_02_eng_xm177_pl",

	"vn_b_pack_seal_01"
];

// Radio Backpacks
InA_AllowedArsenal_backpacksRadio = [
    "vn_b_pack_lw_06","vn_b_pack_prc77_01","vn_b_pack_03_02","vn_b_pack_03","vn_b_pack_trp_04"
];

// Drone Backpacks
InA_AllowedArsenal_backpackDrones = [];

// Medical backpacks
InA_AllowedArsenal_backpackMedic = [
    "vn_b_pack_m5_01","vn_b_pack_lw_07"
];

// Static Weapon Backpacks
InA_AllowedArsenal_backpackStatics = [
    "vn_b_pack_static_base_01",
    "vn_b_pack_static_tow","vn_b_pack_static_m1919a4_low_01","vn_b_pack_static_m1919a4_high_01","vn_b_pack_static_m1919a6_01",
    "vn_b_pack_static_m29_01","vn_b_pack_static_m2_01","vn_b_pack_static_m2_low_01","vn_b_pack_static_m2_high_01",
    "vn_b_pack_static_m60_low_01","vn_b_pack_static_m60_high_01"
];

// Things and stuff that aren't in the Arsenal,but you're allowed to pick up,based on role ....
InA_AllowedPickup_Launchers = [
    "vn_rpg2","vn_rpg2_mag","vn_rpg7","vn_rpg7_mag"
];

// Rifles allowed to be pickud up ....
InA_AllowedPickup_Rifles = [
"vn_izh54","vn_izh54_shorty","vn_k50m","vn_m1891","vn_m38","vn_m4956","vn_m4956_gl",
"vn_m9130","vn_mat49","vn_mat49_f","vn_mat49_vc","vn_mp40","vn_pps43","vn_pps52",
"vn_ppsh41","vn_sks","vn_sks_gl","vn_type56"
];

// Pickup Backpacks
InA_AllowedPickup_Backpacks = [
"Bag_Base"
];

// ArsenalDefinitions initialized ....
InA_ArsenalDefinitionsInitialized = true;
