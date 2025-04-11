AW_OPFOR_mission_arty_artyVeh = "rhs_2s3_tv";
AW_OPFOR_mission_arty_ammoVeh = "rhs_kamaz5350_ammo_msv";
AW_OPFOR_mission_arty_barrier = "Land_HBarrierBig_F";

AW_OPFOR_mission_aa_launchersList = ["PRACS_SLA_SA8", "PRACS_SLA_2S6M_Tunguska", "PRACS_SLA_SA13"];
AW_OPFOR_mission_aa_shooters = 3; //number of the vehicles in the above array that can actually shoot
AW_OPFOR_mission_aa_ammoVeh = AW_OPFOR_mission_arty_ammoVeh;
AW_OPFOR_mission_aa_barrier = AW_OPFOR_mission_arty_barrier;

AW_OPFOR_side_destroyUrban_crateTypes = ["Box_NATO_AmmoVeh_F","Box_East_AmmoVeh_F"];
AW_OPFOR_side_destroyUrban_excludedBuildings = [];

AW_OPFOR_side_rescuePilot_wreckType = "Land_UH1H_Wreck_F";
AW_OPFOR_side_rescuePilot_pilotUniformVestHelmet = ["rhs_uniform_acu_oefcp", "rhsusf_spcs_ocp", "rhsusf_hgu56p"];

AW_OPFOR_side_secureAsset_assets = [
   [203, "RHS_AH64D"],
   [204, "rhs_mi28n_vvsc"],
   [205, "rhsgref_mi24g_CAS"],
   [607, "rhs_t90sm_tv"],
   [603, "rhs_t90sm_tv"],
   [609, "rhs_t80um"],
   [708, "rhs_bmd4ma_vdv"],
   [709, "rhs_bmd4ma_vdv"],
   [710, "PRACS_Pizarro_SLE"],
   [711, "rhs_bmd2m"],
   [714, "rhs_bmd2m"],
   [901, "PRACS_VEC_MGS"],
   [802, "PRACS_SLA_2S6M_Tunguska"],
   [904, "PRACS_BMR_ATGM_TOW"]
];

AW_OPFOR_side_militiaCamp = [
    ["Land_Campfire_F",[0,0,0.0299988],0,1,0,[0,0],"","",true,false],
    ["Land_TentDome_F",[-1.28137,-3.32617,0],122.089,1,0,[0,-0],"","",true,false],
    ["Land_TentDome_F",[2.53247,2.74023,0],303.114,1,0,[0,0],"","",true,false],
    ["Land_TentDome_F",[4.07275,-0.182129,0],0,1,0,[0,0],"","",true,false],
    ["Land_TentDome_F",[2.4043,-3.30664,0],55.6407,1,0,[0,0],"","",true,false],
    ["Land_WoodPile_large_F",[-3.88135,1.06055,0.0232067],211.026,1,0,[0,0],"","",true,false],
    ["Land_WoodPile_large_F",[-2.39673,3.41162,0.0232067],211.026,1,0,[0,0],"","",true,false],
    ["Land_BagFence_Long_F",[-2.89856,-6.09668,-0.000999928],33.0038,1,0,[0,0],"","",true,false],
    ["Land_BagFence_Round_F",[0.671631,7.08691,-0.00130129],161.752,1,0,[0,-0],"","",true,false],
    ["Land_BagFence_Round_F",[-6.63623,-2.62598,-0.00130129],75.7071,1,0,[0,0],"","",true,false],
    ["Land_BagFence_Long_F",[4.21338,5.65918,-0.000999928],211.892,1,0,[0,0],"","",true,false],
    ["Land_BagFence_Long_F",[1.14624,-7.08984,-0.000999928],353.914,1,0,[0,0],"","",true,false],
    ["Land_BagFence_Long_F",[4.74402,-5.60986,-0.000999928],325.317,1,0,[0,0],"","",true,false],
    ["Land_BagFence_Long_F",[7.09131,-2.18994,-0.000999928],288.679,1,0,[0,0],"","",true,false],
    ["Land_BagFence_Long_F",[7.44275,2.18311,-0.000999928],255.074,1,0,[0,0],"","",true,false]
];

AW_OPFOR_side_militiaCamp_vehicles = ["rhsgref_cdf_reg_uaz_dshkm","rhsgref_cdf_Igla_AA_pod","rhsgref_cdf_Igla_AA_pod","rhs_Kornet_9M133_2_msv"];

AW_OPFOR_side_convoyProtectionVehicles = ["rhsusf_stryker_m1126_m2_d", "rhsusf_m1240a1_m2crows_usarmy_d"];
AW_OPFOR_side_convoyTransportVehicles = ["rhsusf_m1240a1_usarmy_d", "rhsusf_M1083A1P2_B_M2_D_fmtv_usarmy", "rhsusf_M1085A1P2_B_D_Medical_fmtv_usarmy", "rhsusf_M1078A1P2_B_D_CP_fmtv_usarmy"];
AW_OPFOR_side_convoyMines = ["APERSMine", "APERSMine", "ATMine"];

AW_OPFOR_main_military_bunkers = [
    [["Land_BagBunker_Small_F",[-2.65381,4.97363,-0.965631],120],["Land_BagBunker_Small_F",[3.09277,4.99512,-0.965631],240],["Land_BagFence_Round_F",[3.04004,1.51514,-0.965631],300],["Land_BagFence_Round_F",[0.19043,6.83691,-0.965631],180],["Land_BagFence_Round_F",[-2.83691,1.55322,-0.965631],60]],
    [["Land_BagFence_Long_F",[1.84766,2.30322,-0.965631],270],["Land_BagBunker_Tower_F",[-0.0625,6.53906,-0.965631],90]],
    [["Land_HBarrierWall_corner_F",[-4.82227,2.42334,-0.965631],180],["Land_BagBunker_Small_F",[-8.09033,6.02588,-0.965631],90],["Land_HBarrierWall_corner_F",[3.25537,7.63623,-0.965631],0],["Land_HBarrierWall_corner_F",[3.93408,3.0166,-0.965631],90],["Land_HBarrier_5_F",[-2.35303,7.75342,-0.965631],0]]
];
