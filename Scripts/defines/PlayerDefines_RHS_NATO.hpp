class Dynamic_Groups {
    faction_name = "NATO";
    group_setup[] = {
        {"Alpha", {"sl", "medic", "repair", "ar", "grenadier", "marksman", "hat", "lat"}, "true"},
        {"Bravo", {"sl", "medic", "repair", "ar", "grenadier", "marksman", "hat", "lat"}, "true"},
        {"Charlie", {"sl", "medic", "repair", "ar", "grenadier", "marksman", "hat", "lat"}, "true"},
        {"Delta", {"sl", "medic", "repair", "ar", "grenadier", "marksman", "hat", "lat"}, "true"},
        {"Echo", {"sl", "medic", "repair", "ar", "grenadier", "marksman", "hat", "lat"}, "true"},
        {"EOD", {"tl", "engineer", "exp", "exp"}, "true"},
        {"Recon", {"rtl", "rmedic", "rjtac", "rmarksman", "rhat", "rhat", "rmarksman", "rexp"}, "true"},
        {"Sniper Team Alpha", {"sniper", "spotter"}, "true"},
        {"Sniper Team Bravo", {"sniper", "spotter"}, "true"},
        {"CLS", {"tl", "ar", "medic", "medic"}, "true"},
        {"FSG", {"tl", "mortar", "uav"}, "true"},
        {"Vortex", {"pilot", "pilot", "pilot", "pilot", "pilot"}, "true"}
    };
};

class Dynamic_Roles {
	class sl {
        name = "Squad Leader";
        rank = "Private";
        description = $STR_AW_SL_Description;
        traits[] = {

        };
        customVariables[] = {

        };
        icon = "a3\ui_f\data\map\vehicleicons\iconMan_ca.paa";
        defaultLoadout[] = {
            {"rhs_weap_m4a1_blockII_M203_d","rhsusf_acc_nt4_tan","rhsusf_acc_anpeq15side","rhsusf_acc_ACOG_d",{"rhs_mag_30Rnd_556x45_M855A1_PMAG_Tan",30},{"rhs_mag_M433_HEDP",1},"rhsusf_acc_grip_m203_d"},
            {"rhs_weap_M136_hp","","","",{"rhs_m136_hp_mag",1},"",""},
            {"rhsusf_weap_glock17g4","","","",{"rhsusf_mag_17Rnd_9x19_JHP",17},"",""},
            {"rhs_uniform_acu_oefcp",{
                {"ACE_packingBandage",10},{"ACE_quikclot",10},{"ACE_elasticBandage",10},{"ACE_CableTie",4},{"ACE_EarPlugs",1},{"ACE_epinephrine",3},{"ACE_morphine",3},{"ACE_MapTools",1},{"ACE_microDAGR",1},
                {"ACE_Flashlight_XL50",1},{"ACE_tourniquet",2},{"ACE_splint",2},{"ACE_PlottingBoard",1}
            }},
            {"rhsusf_iotv_ocp_Squadleader",{
                {"rhsusf_ANPVS_14",1},{"rhs_mag_30Rnd_556x45_M855A1_PMAG_Tan",6,30},{"rhs_mag_M433_HEDP",3,1},{"rhs_mag_M397_HET",4,1},{"rhs_mag_m576",2,1},{"rhs_mag_m713_Red",2,1},
                {"rhs_mag_m714_White",1,1},{"rhs_mag_m715_Green",1,1}
            }},
            {},
            "rhsusf_ach_helmet_headset_ocp","G_Aviator",
            {"UK3CB_BAF_Soflam_Laserdesignator","","","",{"Laserbatteries",1},{},""},
            {"ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch",""}
        };
        arsenalWeapons[] = { "arifle_MX_F" };
        arsenalMagazines[] = { "30Rnd_65x39_caseless_mag" };
        arsenalItems[] = { "optic_Holosight" };
        arsenalBackpacks[] = { "B_AssaultPack_rgr" };
    };

    class medic {
        name = "Medic";
        rank = "Private";
        description = $STR_AW_Medic_Description;
        traits[] = {
            {"Medic",true}
        };
        customVariables[] = {
            {"ace_medical_medicClass",2,true}
        };
        icon = "a3\ui_f\data\map\vehicleicons\iconMan_ca.paa";
        defaultLoadout[] = {
            {"rhs_weap_m4a1_blockII_d","rhsusf_acc_nt4_tan","rhsusf_acc_anpeq15_top","rhsusf_acc_eotech_552_d",{"rhs_mag_30Rnd_556x45_M855A1_PMAG_Tan",30},"","rhsusf_acc_rvg_de"},
            {},
            {"rhsusf_weap_glock17g4","","","",{"rhsusf_mag_17Rnd_9x19_JHP",17},"",""},
            {"rhs_uniform_acu_oefcp",{
                {"ACE_packingBandage",10},{"ACE_quikclot",10},{"ACE_elasticBandage",10},{"ACE_CableTie",4},{"ACE_EarPlugs",1},{"ACE_epinephrine",3},{"ACE_morphine",3},{"ACE_MapTools",1},
                {"ACE_microDAGR",1},{"ACE_Flashlight_XL50",1},{"ACE_tourniquet",2},{"ACE_splint",2},{"ACE_PlottingBoard",1}
            }},
            {"rhsusf_iotv_ocp_Medic",{
                {"rhsusf_ANPVS_14",1},{"rhs_mag_30Rnd_556x45_M855A1_PMAG_Tan",6,30}
            }},
            {"rhsusf_assault_eagleaiii_ocp",{
                {"ACE_bloodIV",2},{"ACE_bloodIV_500",3},{"ACE_bloodIV_250",4},{"ACE_plasmaIV",2},{"ACE_plasmaIV_500",3},{"ACE_plasmaIV_250",4},{"ACE_salineIV",2},{"ACE_salineIV_500",3},{"ACE_salineIV_250",4},
                {"ACE_quikclot",20},{"ACE_elasticBandage",20},{"ACE_packingBandage",20},{"ACE_morphine",10},{"ACE_epinephrine",10},{"ACE_tourniquet",3},{"ACE_surgicalKit",1},{"ACE_personalAidKit",1},{"ACE_splint",10}
            }},
            "rhsusf_ach_helmet_headset_ocp","rhsusf_shemagh2_tan",
            {"rhsusf_bino_m24","","","",{},"",""},
            {"ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch",""}
        };
        arsenalWeapons[] = { "arifle_MX_F" };
        arsenalMagazines[] = { "30Rnd_65x39_caseless_mag" };
        arsenalItems[] = { "optic_Holosight" };
        arsenalBackpacks[] = { "B_AssaultPack_rgr" };
    };

    class repair {
        name = "Repair";
        rank = "Private";
        description = $STR_AW_Repair_Description;
        traits[] = {
            {"Engineer",true}
        };
        customVariables[] = {
            {"ace_isEngineer",2,true}
        };
        icon = "a3\ui_f\data\map\vehicleicons\iconMan_ca.paa";
        defaultLoadout[] = {
            {"rhs_weap_m4a1_blockII_d","rhsusf_acc_nt4_tan","rhsusf_acc_anpeq15_top","rhsusf_acc_eotech_552_d",{"rhs_mag_30Rnd_556x45_M855A1_PMAG_Tan",30},"","rhsusf_acc_rvg_de"},
            {},
            {"rhsusf_weap_glock17g4","","","",{"rhsusf_mag_17Rnd_9x19_JHP",17},"",""},
            {"rhs_uniform_acu_oefcp",{
                {"ACE_packingBandage",10},{"ACE_quikclot",10},{"ACE_elasticBandage",10},{"ACE_CableTie",4},{"ACE_EarPlugs",1},{"ACE_epinephrine",3},{"ACE_morphine",3},{"ACE_MapTools",1},
                {"ACE_microDAGR",1},{"ACE_Flashlight_XL50",1},{"ACE_tourniquet",2},{"ACE_splint",2},{"ACE_PlottingBoard",1}
                }},
            {"rhsusf_iotv_ocp_Repair",{
                {"rhsusf_ANPVS_14",1},{"ACE_DefusalKit",1},{"ACE_EntrenchingTool",1},{"ACE_wirecutter",1},{"rhs_mag_30Rnd_556x45_M855A1_PMAG_Tan",6,30}
                }},
            {"rhsusf_falconii_mc",{
                {"ToolKit",1}
                }},
            "rhsusf_ach_helmet_headset_ocp","rhsusf_shemagh_gogg_tan",
            {"rhsusf_bino_m24","","","",{},"",""},
            {"ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch",""}
        };
        arsenalWeapons[] = { "arifle_MX_F" };
        arsenalMagazines[] = { "30Rnd_65x39_caseless_mag" };
        arsenalItems[] = { "optic_Holosight" };
        arsenalBackpacks[] = { "B_AssaultPack_rgr" };
    };

    class ar {
        name = "Autorifleman";
        rank = "Private";
        description = $STR_AW_AR_Description;
        traits[] = {
            
        };
        customVariables[] = {
            
        };
        icon = "a3\ui_f\data\map\vehicleicons\iconMan_ca.paa";
        defaultLoadout[] = {
            {"rhs_weap_m249_light_L","rhsusf_acc_SFMB556","rhsusf_acc_anpeq15side_bk","rhsusf_acc_ACOG_RMR",{"rhsusf_200Rnd_556x45_mixed_soft_pouch_coyote",200},"","rhsusf_acc_grip4_bipod"},
            {},
            {"rhsusf_weap_glock17g4","","","",{"rhsusf_mag_17Rnd_9x19_JHP",17},"",""},
            {"rhs_uniform_acu_oefcp",{
                {"ACE_packingBandage",10},{"ACE_quikclot",10},{"ACE_elasticBandage",10},{"ACE_CableTie",4},{"ACE_EarPlugs",1},{"ACE_epinephrine",3},{"ACE_morphine",3},{"ACE_MapTools",1},{"ACE_microDAGR",1},
                {"ACE_Flashlight_XL50",1},{"ACE_tourniquet",2},{"ACE_splint",2},{"ACE_PlottingBoard",1}
                }},
            {"rhsusf_iotv_ocp_SAW",{
                {"rhsusf_ANPVS_14",1},{"ACE_EntrenchingTool",1},{"rhsusf_200Rnd_556x45_mixed_soft_pouch_coyote",2,200}
                }},
            {},
            "rhsusf_ach_helmet_headset_ocp","rhsusf_shemagh_tan",
            {"rhsusf_bino_m24","","","",{},"",""},
            {"ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch",""}
        };
        arsenalWeapons[] = { "arifle_MX_F" };
        arsenalMagazines[] = { "30Rnd_65x39_caseless_mag" };
        arsenalItems[] = { "optic_Holosight" };
        arsenalBackpacks[] = { "B_AssaultPack_rgr" };
    };

    class grenadier {
        name = "Grenadier";
        rank = "Private";
        description = $STR_AW_Grenadier_Description;
        traits[] = {
            
        };
        customVariables[] = {
            
        };
        icon = "a3\ui_f\data\map\vehicleicons\iconMan_ca.paa";
        defaultLoadout[] = {
            {"rhs_weap_m4a1_blockII_M203_d","rhsusf_acc_SFMB556","rhsusf_acc_anpeq15side","rhsusf_acc_eotech_552_d",{"rhs_mag_30Rnd_556x45_M855A1_PMAG_Tan",30},{"rhs_mag_M397_HET",1},"rhsusf_acc_grip_m203_d"},
            {},
            {"rhsusf_weap_glock17g4","","","",{"rhsusf_mag_17Rnd_9x19_JHP",17},"",""},
            {"rhs_uniform_acu_oefcp",{
                {"ACE_packingBandage",10},{"ACE_quikclot",10},{"ACE_elasticBandage",10},{"ACE_CableTie",4},{"ACE_EarPlugs",1},{"ACE_epinephrine",3},{"ACE_morphine",3},{"ACE_MapTools",1},{"ACE_microDAGR",1},
                {"ACE_Flashlight_XL50",1},{"ACE_tourniquet",2},{"ACE_splint",2},{"ACE_PlottingBoard",1}
                }},
            {"rhsusf_iotv_ocp_Grenadier",{
                {"rhsusf_ANPVS_14",1},{"ACE_HuntIR_monitor",1},{"rhs_mag_M397_HET",4,1},{"rhs_mag_M433_HEDP",4,1},{"rhs_mag_30Rnd_556x45_M855A1_PMAG_Tan",3,30},{"ACE_HuntIR_M203",2,1},{"rhs_mag_m713_Red",1,1},
                {"rhs_mag_m714_White",2,1},{"rhs_mag_m715_Green",1,1}
                }},
            {},
            "rhsusf_ach_helmet_headset_ocp","rhsusf_shemagh2_tan",
            {"rhsusf_bino_m24","","","",{},"",""},
            {"ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch",""}
        };
        arsenalWeapons[] = { "arifle_MX_F" };
        arsenalMagazines[] = { "30Rnd_65x39_caseless_mag" };
        arsenalItems[] = { "optic_Holosight" };
        arsenalBackpacks[] = { "B_AssaultPack_rgr" };
    };

    class marksman {
        name = "Marksman";
        rank = "Private";
        description = $STR_AW_Marksman_Description;
        traits[] = {
            
        };
        customVariables[] = {
            
        };
        icon = "a3\ui_f\data\map\vehicleicons\iconMan_ca.paa";
        defaultLoadout[] = {
            {"rhs_weap_sr25_ec_d","rhsgref_sdn6_suppressor","","rhsusf_acc_M8541_mrds",{"rhsusf_20Rnd_762x51_SR25_m993_Mag",20},"","rhsusf_acc_harris_bipod"},
            {},
            {"rhsusf_weap_glock17g4","","","",{"rhsusf_mag_17Rnd_9x19_JHP",17},"",""},
            {"rhs_uniform_acu_oefcp",{
                {"ACE_packingBandage",10},{"ACE_quikclot",10},{"ACE_elasticBandage",10},{"ACE_CableTie",4},{"ACE_EarPlugs",1},{"ACE_epinephrine",3},{"ACE_morphine",3},{"ACE_MapTools",1},{"ACE_microDAGR",1},
                {"ACE_Flashlight_XL50",1},{"ACE_tourniquet",2},{"ACE_splint",2},{"ACE_PlottingBoard",1}
                }},
            {"rhsusf_iotv_ocp_Rifleman",{
                {"rhsusf_ANPVS_14",1},{"rhsusf_20Rnd_762x51_SR25_m993_Mag",7,20},{"rhsusf_mag_17Rnd_9x19_FMJ",1,17}
                }},
            {},
            "rhsusf_ach_helmet_headset_ocp","",
            {"ACE_VectorDay","","","",{},"",""},
            {"ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch",""}
        };
        arsenalWeapons[] = { "arifle_MX_F" };
        arsenalMagazines[] = { "30Rnd_65x39_caseless_mag" };
        arsenalItems[] = { "optic_Holosight" };
        arsenalBackpacks[] = { "B_AssaultPack_rgr" };
    };

    class hat {
        name = "Heavy Anti-Tank";
        rank = "Private";
        description = $STR_AW_HAT_Description;
        traits[] = {
            
        };
        customVariables[] = {
            
        };
        icon = "a3\ui_f\data\map\vehicleicons\iconMan_ca.paa";
        defaultLoadout[] = {
            {"rhs_weap_m4a1_blockII_d","rhsusf_acc_nt4_tan","rhsusf_acc_anpeq15_top","rhsusf_acc_ACOG_d",{"rhs_mag_30Rnd_556x45_M855A1_PMAG_Tan",30},"","rhsusf_acc_rvg_de"},
            {"UK3CB_BAF_Javelin_Slung_Tube","","","",{},"",""},
            {"rhsusf_weap_glock17g4","","","",{"rhsusf_mag_17Rnd_9x19_JHP",17},"",""},
            {"rhs_uniform_acu_oefcp",{
                {"ACE_packingBandage",10},{"ACE_quikclot",10},{"ACE_elasticBandage",10},{"ACE_CableTie",4},{"ACE_EarPlugs",1},{"ACE_epinephrine",3},{"ACE_morphine",3},{"ACE_MapTools",1},{"ACE_microDAGR",1},
                {"ACE_Flashlight_XL50",1},{"ACE_tourniquet",2},{"ACE_splint",2},{"ACE_PlottingBoard",1}
                }},
            {"rhsusf_iotv_ocp_Rifleman",{
                {"rhsusf_ANPVS_14",1},{"rhs_mag_30Rnd_556x45_M855A1_PMAG_Tan",6,30}
                }},
            {},
            "rhsusf_ach_helmet_headset_ocp","rhs_googles_black",
            {"UK3CB_BAF_Javelin_CLU","","","",{},"",""},
            {"ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch",""}
        };
        arsenalWeapons[] = { "arifle_MX_F" };
        arsenalMagazines[] = { "30Rnd_65x39_caseless_mag" };
        arsenalItems[] = { "optic_Holosight" };
        arsenalBackpacks[] = { "B_AssaultPack_rgr" };
    };

    class lat {
        name = "Light Anti-Tank";
        rank = "Private";
        description = $STR_AW_LAT_Description;
        traits[] = {
            
        };
        customVariables[] = {
            
        };
        icon = "a3\ui_f\data\map\vehicleicons\iconMan_ca.paa";
        defaultLoadout[] = {
            {"rhs_weap_m4a1_blockII_d","rhsusf_acc_nt4_tan","rhsusf_acc_anpeq15_top","rhsusf_acc_ACOG_d",{"rhs_mag_30Rnd_556x45_M855A1_PMAG_Tan",30},"","rhsusf_acc_rvg_de"},
            {"ACE_launch_NLAW_ready_F","","","",{"NLAW_F",1},"",""},
            {"rhsusf_weap_glock17g4","","","",{"rhsusf_mag_17Rnd_9x19_JHP",17},"",""},
            {"rhs_uniform_acu_oefcp",{
                {"ACE_packingBandage",10},{"ACE_quikclot",10},{"ACE_elasticBandage",10},{"ACE_CableTie",4},{"ACE_EarPlugs",1},{"ACE_epinephrine",3},{"ACE_morphine",3},{"ACE_MapTools",1},{"ACE_microDAGR",1},
                {"ACE_Flashlight_XL50",1},{"ACE_tourniquet",2},{"ACE_splint",2},{"ACE_PlottingBoard",1}}},{"rhsusf_iotv_ocp_Rifleman",{{"rhsusf_ANPVS_14",1},{"rhs_mag_30Rnd_556x45_M855A1_PMAG_Tan",6,30}
                }},
            {},
            "rhsusf_ach_helmet_headset_ocp","G_Bandanna_tan",
            {"rhsusf_bino_m24","","","",{},"",""},
            {"ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch",""}
        };
        arsenalWeapons[] = { "arifle_MX_F" };
        arsenalMagazines[] = { "30Rnd_65x39_caseless_mag" };
        arsenalItems[] = { "optic_Holosight" };
        arsenalBackpacks[] = { "B_AssaultPack_rgr" };
    };

    class tl {
        name = "Team Leader";
        rank = "Private";
        description = $STR_AW_TL_Description;
        traits[] = {
            
        };
        customVariables[] = {
            
        };
        icon = "a3\ui_f\data\map\vehicleicons\iconMan_ca.paa";
        defaultLoadout[] = {
            {"rhs_weap_m4a1_blockII_M203_d","rhsusf_acc_nt4_tan","rhsusf_acc_anpeq15side","rhsusf_acc_ACOG_d",{"rhs_mag_30Rnd_556x45_M855A1_PMAG_Tan",30},{"rhs_mag_M433_HEDP",1},"rhsusf_acc_grip_m203_d"},
            {"rhs_weap_M136_hp","","","",{"rhs_m136_hp_mag",1},"",""},
            {"rhsusf_weap_glock17g4","","","",{"rhsusf_mag_17Rnd_9x19_JHP",17},"",""},
            {"rhs_uniform_acu_oefcp",{
                {"ACE_packingBandage",10},{"ACE_quikclot",10},{"ACE_elasticBandage",10},{"ACE_CableTie",4},{"ACE_EarPlugs",1},{"ACE_epinephrine",3},{"ACE_morphine",3},{"ACE_MapTools",1},{"ACE_microDAGR",1},
                {"ACE_Flashlight_XL50",1},{"ACE_tourniquet",2},{"ACE_splint",2},{"ACE_PlottingBoard",1}
                }},
            {"rhsusf_iotv_ocp_Teamleader",{
                {"rhsusf_ANPVS_14",1},{"rhs_mag_30Rnd_556x45_M855A1_PMAG_Tan",6,30},{"rhs_mag_M433_HEDP",3,1},{"rhs_mag_M397_HET",4,1},{"rhs_mag_m576",2,1},{"rhs_mag_m713_Red",2,1},{"rhs_mag_m714_White",1,1},
                {"rhs_mag_m715_Green",1,1}
                }},
            {},
            "rhsusf_ach_helmet_headset_ocp","G_Bandanna_aviator",
            {"UK3CB_BAF_Soflam_Laserdesignator","","","",{"Laserbatteries",1},{},""},
            {"ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch",""}
        };
        arsenalWeapons[] = { "arifle_MX_F" };
        arsenalMagazines[] = { "30Rnd_65x39_caseless_mag" };
        arsenalItems[] = { "optic_Holosight" };
        arsenalBackpacks[] = { "B_AssaultPack_rgr" };
    };

    class engineer {
        name = "Engineer";
        rank = "Private";
        description = $STR_AW_Engineer_Description;
        traits[] = {
            {"Engineer",true},
            {"ExplosiveSpecialist",true}
        };
        customVariables[] = {
            {"ace_isEngineer",2,true}
        };
        icon = "a3\ui_f\data\map\vehicleicons\iconMan_ca.paa";
        defaultLoadout[] = {
            {"rhs_weap_m4a1_blockII_d","rhsusf_acc_nt4_tan","rhsusf_acc_anpeq15_top","rhsusf_acc_eotech_552_d",{"rhs_mag_30Rnd_556x45_M855A1_PMAG_Tan",30},"","rhsusf_acc_rvg_de"},
            {},
            {"rhsusf_weap_glock17g4","","","",{"rhsusf_mag_17Rnd_9x19_JHP",17},"",""},
            {"rhs_uniform_acu_oefcp",{
                {"ACE_packingBandage",10},{"ACE_quikclot",10},{"ACE_elasticBandage",10},{"ACE_CableTie",4},{"ACE_EarPlugs",1},{"ACE_epinephrine",3},{"ACE_morphine",3},{"ACE_MapTools",1},{"ACE_microDAGR",1},
                {"ACE_Flashlight_XL50",1},{"ACE_tourniquet",2},{"ACE_splint",2},{"ACE_PlottingBoard",1}
            }},
            {"rhsusf_iotv_ocp_Repair",{
                {"rhsusf_ANPVS_14",1},{"ACE_DefusalKit",1},{"ACE_EntrenchingTool",1},{"ACE_wirecutter",1},{"ACE_M26_Clacker",1},{"rhs_mag_30Rnd_556x45_M855A1_PMAG_Tan",6,30}
                }},
            {"rhsusf_falconii_mc",{
                {"ToolKit",1},{"rhsusf_m112x4_mag",1,1},{"rhsusf_m112_mag",2,1}
                }},
            "rhsusf_ach_helmet_headset_ocp","rhsusf_shemagh_gogg_tan",
            {"rhsusf_bino_m24","","","",{},"",""},
            {"ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch",""}
        };
        arsenalWeapons[] = { "arifle_MX_F" };
        arsenalMagazines[] = { "30Rnd_65x39_caseless_mag" };
        arsenalItems[] = { "optic_Holosight" };
        arsenalBackpacks[] = { "B_AssaultPack_rgr" };
    };

    class exp {
        name = "Explosive Specialist";
        rank = "Private";
        description = $STR_AW_EOD_Description;
        traits[] = {
            {"ExplosiveSpecialist",true}
        };
        customVariables[] = {
            
        };
        icon = "a3\ui_f\data\map\vehicleicons\iconMan_ca.paa";
        defaultLoadout[] = {
            {"rhs_weap_m4a1_blockII_d","rhsusf_acc_nt4_tan","rhsusf_acc_anpeq15_top","rhsusf_acc_eotech_552_d",{"rhs_mag_30Rnd_556x45_M855A1_PMAG_Tan",30},"","rhsusf_acc_rvg_de"},
            {},
            {"rhsusf_weap_glock17g4","","","",{"rhsusf_mag_17Rnd_9x19_JHP",17},"",""},
            {"rhs_uniform_acu_oefcp",{
                {"ACE_packingBandage",10},{"ACE_quikclot",10},{"ACE_elasticBandage",10},{"ACE_CableTie",4},{"ACE_EarPlugs",1},{"ACE_epinephrine",3},{"ACE_morphine",3},{"ACE_MapTools",1},{"ACE_microDAGR",1},{"ACE_Flashlight_XL50",1},
                {"ACE_tourniquet",2},{"ACE_splint",2},{"ACE_PlottingBoard",1}
                }},
            {"rhsusf_iotv_ocp_Repair",{
                {"rhsusf_ANPVS_14",1},{"ACE_DefusalKit",1},{"ACE_EntrenchingTool",1},{"ACE_wirecutter",1},{"ACE_M26_Clacker",1},{"rhs_mag_30Rnd_556x45_M855A1_PMAG_Tan",6,30}
                }},
            {"rhsusf_falconii_mc",{
                {"rhsusf_m112x4_mag",2,1},{"rhsusf_m112_mag",4,1}
                }},
            "rhsusf_ach_helmet_headset_ocp","rhsusf_shemagh_gogg_tan",
            {"rhsusf_bino_m24","","","",{},"",""},
            {"ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch",""}
        };
        arsenalWeapons[] = { "arifle_MX_F" };
        arsenalMagazines[] = { "30Rnd_65x39_caseless_mag" };
        arsenalItems[] = { "optic_Holosight" };
        arsenalBackpacks[] = { "B_AssaultPack_rgr" };
    };

    class rtl {
        name = "Recon Team Leader";
        rank = "Private";
        description = $STR_AW_TL_Description;
        traits[] = {
            
        };
        customVariables[] = {
            
        };
        icon = "a3\ui_f\data\map\vehicleicons\iconMan_ca.paa";
        defaultLoadout[] = {
            {"rhs_weap_hk416d145_m320","rhsusf_acc_nt4_black","","rhsusf_acc_ACOG_RMR",{"rhs_mag_30Rnd_556x45_M855A1_PMAG",30},{"rhs_mag_M433_HEDP",1},""},
            {"rhs_weap_M136_hp","","","",{},"",""},
            {"rhsusf_weap_glock17g4","","","",{"rhsusf_mag_17Rnd_9x19_JHP",17},"",""},
            {"rhs_uniform_FROG01_wd",{
                {"ACE_packingBandage",10},{"ACE_quikclot",10},{"ACE_elasticBandage",10},{"ACE_CableTie",4},{"ACE_EarPlugs",1},{"ACE_epinephrine",3},{"ACE_morphine",3},{"ACE_MapTools",1},{"ACE_microDAGR",1},
                {"ACE_Flashlight_XL50",1},{"ACE_tourniquet",2},{"ACE_splint",2},{"ACE_PlottingBoard",1}}},{"rhsusf_spc_squadleader",{{"rhsusf_ANPVS_15",1},{"ACE_HuntIR_monitor",1},{"rhs_mag_M433_HEDP",4,1},
                {"rhs_mag_30Rnd_556x45_M855A1_PMAG",3,30},{"rhs_mag_M397_HET",5,1},{"ACE_HuntIR_M203",2,1},{"ACE_40mm_Pike",1,1}
                }},
            {},
            "rhsusf_mich_helmet_marpatwd_alt_headset","rhsusf_shemagh_tan",
            {"UK3CB_BAF_Soflam_Laserdesignator","","","",{"Laserbatteries",1},{},""},
            {"ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch",""}
        };
        arsenalWeapons[] = { "arifle_MX_F" };
        arsenalMagazines[] = { "30Rnd_65x39_caseless_mag" };
        arsenalItems[] = { "optic_Holosight" };
        arsenalBackpacks[] = { "B_AssaultPack_rgr" };
    };

    class rmedic {
        name = "Recon Medic";
        rank = "Private";
        description = $STR_AW_Medic_Description;
        traits[] = {
            {"Medic",true}
        };
        customVariables[] = {
            {"ace_medical_medicClass",2,true}
        };
        icon = "a3\ui_f\data\map\vehicleicons\iconMan_ca.paa";
        defaultLoadout[] = {
            {"rhs_weap_hk416d145","rhsusf_acc_nt4_black","","rhsusf_acc_ACOG_RMR",{"rhs_mag_30Rnd_556x45_M855A1_PMAG",30},"","rhsusf_acc_rvg_blk"},
            {},
            {"rhsusf_weap_glock17g4","","","",{"rhsusf_mag_17Rnd_9x19_JHP",17},"",""},
            {"rhs_uniform_FROG01_wd",{
                {"ACE_packingBandage",10},{"ACE_quikclot",10},{"ACE_elasticBandage",10},{"ACE_CableTie",4},{"ACE_EarPlugs",1},{"ACE_epinephrine",3},{"ACE_morphine",3},{"ACE_MapTools",1},{"ACE_microDAGR",1},
                {"ACE_Flashlight_XL50",1},{"ACE_tourniquet",2},{"ACE_splint",2},{"ACE_PlottingBoard",1}
                }},
            {"rhsusf_spc_rifleman",{
                {"rhsusf_ANPVS_15",1},{"rhs_mag_30Rnd_556x45_M855A1_PMAG",6,30}
                }},
            {"rhsusf_assault_eagleaiii_coy",{
                {"ACE_elasticBandage",20},{"ACE_quikclot",20},{"ACE_bloodIV",2},{"ACE_bloodIV_250",4},{"ACE_bloodIV_500",3},{"ACE_epinephrine",10},{"ACE_morphine",10},{"ACE_packingBandage",20},{"ACE_personalAidKit",1},
                {"ACE_plasmaIV",2},{"ACE_plasmaIV_250",4},{"ACE_plasmaIV_500",3},{"ACE_salineIV",2},{"ACE_salineIV_250",4},{"ACE_salineIV_500",3},{"ACE_splint",10},{"ACE_surgicalKit",1},{"ACE_tourniquet",4}
                }},
            "rhsusf_mich_helmet_marpatwd_alt_headset","rhsusf_shemagh2_tan",
            {"UK3CB_BAF_Soflam_Laserdesignator","","","",{"Laserbatteries",1},{},""},
            {"ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch",""}
        };
        arsenalWeapons[] = { "arifle_MX_F" };
        arsenalMagazines[] = { "30Rnd_65x39_caseless_mag" };
        arsenalItems[] = { "optic_Holosight" };
        arsenalBackpacks[] = { "B_AssaultPack_rgr" };
    };

    class rjtac {
        name = "Recon JTAC";
        rank = "Private";
        description = $STR_AW_JTAC_Description;
        traits[] = {
            
        };
        customVariables[] = {
            
        };
        icon = "a3\ui_f\data\map\vehicleicons\iconMan_ca.paa";
        defaultLoadout[] = {
            {"rhs_weap_hk416d145","rhsusf_acc_nt4_black","","rhsusf_acc_ACOG_RMR",{"rhs_mag_30Rnd_556x45_M855A1_PMAG",30},"","rhsusf_acc_rvg_blk"},
            {},
            {"rhsusf_weap_glock17g4","","","",{"rhsusf_mag_17Rnd_9x19_JHP",17},"",""},
            {"rhs_uniform_FROG01_wd",{
                {"ACE_packingBandage",10},{"ACE_quikclot",10},{"ACE_elasticBandage",10},{"ACE_CableTie",4},{"ACE_EarPlugs",1},{"ACE_epinephrine",3},{"ACE_morphine",3},{"ACE_MapTools",1},{"ACE_microDAGR",1},
                {"ACE_Flashlight_XL50",1},{"ACE_tourniquet",2},{"ACE_splint",2},{"ACE_PlottingBoard",1}}},{"rhsusf_spc_rifleman",{{"rhsusf_ANPVS_15",1},{"rhs_mag_30Rnd_556x45_M855A1_PMAG",6,30}
                }},
            {"B_RadioBag_01_black_F",{}},
            "rhsusf_mich_helmet_marpatwd_alt_headset","rhsusf_shemagh_tan",
            {"UK3CB_BAF_Soflam_Laserdesignator","","","",{"Laserbatteries",1},{},""},
            {"ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch",""}
        };
        arsenalWeapons[] = { "arifle_MX_F" };
        arsenalMagazines[] = { "30Rnd_65x39_caseless_mag" };
        arsenalItems[] = { "optic_Holosight" };
        arsenalBackpacks[] = { "B_AssaultPack_rgr" };
    };

    class rmarksman {
        name = "Recon Marksman";
        rank = "Private";
        description = $STR_AW_Marksman_Description;
        traits[] = {
            
        };
        customVariables[] = {
            
        };
        icon = "a3\ui_f\data\map\vehicleicons\iconMan_ca.paa";
        defaultLoadout[] = {
            {"UK3CB_BAF_L129A1","UK3CB_BAF_Silencer_L115A3","rhsusf_acc_anpeq15_bk","UK3CB_BAF_TA648_308",{"UK3CB_BAF_762_L42A1_20Rnd",20},"","UK3CB_underbarrel_acc_grippod"},
            {},
            {"rhsusf_weap_glock17g4","","","",{"rhsusf_mag_17Rnd_9x19_JHP",17},"",""},
            {"rhs_uniform_FROG01_wd",{
                {"ACE_packingBandage",10},{"ACE_quikclot",10},{"ACE_elasticBandage",10},{"ACE_CableTie",4},{"ACE_EarPlugs",1},{"ACE_epinephrine",3},{"ACE_morphine",3},{"ACE_MapTools",1},{"ACE_microDAGR",1},
                {"ACE_Flashlight_XL50",1},{"ACE_tourniquet",2},{"ACE_splint",2},{"ACE_PlottingBoard",1}
                }},
            {"rhsusf_spc_rifleman",{
                {"rhsusf_ANPVS_15",1},{"rhsusf_mag_17Rnd_9x19_JHP",1,17},{"UK3CB_BAF_762_L42A1_20Rnd",6,20}
                }},
            {},
            "rhsusf_mich_helmet_marpatwd_alt_headset","rhsusf_shemagh_tan",
            {"UK3CB_BAF_Soflam_Laserdesignator","","","",{"Laserbatteries",1},{},""},
            {"ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch",""}
        };
        arsenalWeapons[] = { "arifle_MX_F" };
        arsenalMagazines[] = { "30Rnd_65x39_caseless_mag" };
        arsenalItems[] = { "optic_Holosight" };
        arsenalBackpacks[] = { "B_AssaultPack_rgr" };
    };

    class rhat {
        name = "Recon Heavy Anti-Tank";
        rank = "Private";
        description = $STR_AW_HAT_Description;
        traits[] = {
            
        };
        customVariables[] = {
            
        };
        icon = "a3\ui_f\data\map\vehicleicons\iconMan_ca.paa";
        defaultLoadout[] = {
            {"rhs_weap_hk416d145","rhsusf_acc_nt4_black","","rhsusf_acc_ACOG_RMR",{"rhs_mag_30Rnd_556x45_M855A1_PMAG",30},"","rhsusf_acc_rvg_blk"},
            {"UK3CB_BAF_Javelin_Slung_Tube","","","",{},"",""},
            {"rhsusf_weap_glock17g4","","","",{"rhsusf_mag_17Rnd_9x19_JHP",17},"",""},
            {"rhs_uniform_FROG01_wd",{
                {"ACE_packingBandage",10},{"ACE_quikclot",10},{"ACE_elasticBandage",10},{"ACE_CableTie",4},{"ACE_EarPlugs",1},{"ACE_epinephrine",3},{"ACE_morphine",3},{"ACE_MapTools",1},{"ACE_microDAGR",1},
                {"ACE_Flashlight_XL50",1},{"ACE_tourniquet",2},{"ACE_splint",2},{"ACE_PlottingBoard",1}
                }},
            {"rhsusf_spc_rifleman",{{"rhsusf_ANPVS_15",1},{"rhs_mag_30Rnd_556x45_M855A1_PMAG",6,30}}},
            {},
            "rhsusf_mich_helmet_marpatwd_alt_headset","rhsusf_shemagh_tan",
            {"UK3CB_BAF_Javelin_CLU","","","",{},"",""},
            {"ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch",""}
        };
        arsenalWeapons[] = { "arifle_MX_F" };
        arsenalMagazines[] = { "30Rnd_65x39_caseless_mag" };
        arsenalItems[] = { "optic_Holosight" };
        arsenalBackpacks[] = { "B_AssaultPack_rgr" };
    };

    class rexp {
        name = "Recon Explosive Specialist";
        rank = "Private";
        description = $STR_AW_EOD_Description;
        traits[] = {
            
        };
        customVariables[] = {
            
        };
        icon = "a3\ui_f\data\map\vehicleicons\iconMan_ca.paa";
        defaultLoadout[] = {
            {"rhs_weap_hk416d145","rhsusf_acc_nt4_black","","rhsusf_acc_ACOG_RMR",{"rhs_mag_30Rnd_556x45_M855A1_PMAG",30},"","rhsusf_acc_rvg_blk"},
            {},
            {"rhsusf_weap_glock17g4","","","",{"rhsusf_mag_17Rnd_9x19_JHP",17},"",""},
            {"rhs_uniform_FROG01_wd",{
                {"ACE_packingBandage",10},{"ACE_quikclot",10},{"ACE_elasticBandage",10},{"ACE_CableTie",4},{"ACE_EarPlugs",1},{"ACE_epinephrine",3},{"ACE_morphine",3},{"ACE_MapTools",1},{"ACE_microDAGR",1},
                {"ACE_Flashlight_XL50",1},{"ACE_tourniquet",2},{"ACE_splint",2},{"ACE_PlottingBoard",1}
                }},
            {"rhsusf_spc_rifleman",{
                {"rhsusf_ANPVS_15",1},{"ACE_DefusalKit",1},{"rhs_mag_30Rnd_556x45_M855A1_PMAG",6,30}
                }},
            {"rhsusf_falconii_coy",{
                {"rhsusf_m112x4_mag",2,1},{"rhsusf_m112_mag",4,1}
                }},
            "rhsusf_mich_helmet_marpatwd_alt_headset","rhsusf_shemagh_tan",
            {"UK3CB_BAF_Soflam_Laserdesignator","","","",{"Laserbatteries",1},{},""},
            {"ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch",""}
        };
        arsenalWeapons[] = { "arifle_MX_F" };
        arsenalMagazines[] = { "30Rnd_65x39_caseless_mag" };
        arsenalItems[] = { "optic_Holosight" };
        arsenalBackpacks[] = { "B_AssaultPack_rgr" };
    };

    class sniper {
        name = "Sniper";
        rank = "Private";
        description = $STR_AW_Sniper_Description;
        traits[] = {
            
        };
        customVariables[] = {
            
        };
        icon = "a3\ui_f\data\map\vehicleicons\iconMan_ca.paa";
        defaultLoadout[] = {
            {"rhs_weap_XM2010_sa","rhsusf_acc_M2010S_sa","rhsusf_acc_anpeq15side","rhsusf_acc_premier_mrds",{"rhsusf_5Rnd_300winmag_xm2010",5},"","rhsusf_acc_harris_bipod"},
            {},
            {"rhsusf_weap_glock17g4","","","",{"rhsusf_mag_17Rnd_9x19_JHP",17},"",""},
            {"U_B_FullGhillie_sard",{
                {"ACE_packingBandage",10},{"ACE_quikclot",10},{"ACE_elasticBandage",10},{"ACE_CableTie",4},{"ACE_EarPlugs",1},{"ACE_epinephrine",3},{"ACE_morphine",3},{"ACE_MapTools",1},{"ACE_microDAGR",1},
                {"ACE_Flashlight_XL50",1},{"ACE_tourniquet",2},{"ACE_splint",2},{"ACE_PlottingBoard",1},{"rhsusf_5Rnd_300winmag_xm2010",14,5}
                }},
            {"rhsusf_iotv_ocp_Rifleman",{
                {"rhsusf_ANPVS_14",1},{"rhsusf_5Rnd_300winmag_xm2010",6,5},{"rhs_mag_an_m8hc",3,1},{"rhsusf_mag_17Rnd_9x19_JHP",3,17}
                }},
            {},
            "rhsusf_ach_helmet_headset_ocp","G_Bandanna_tan",{"ACE_VectorDay","","","",{},"",""},
            {"ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch",""}
        };
        arsenalWeapons[] = { "arifle_MX_F" };
        arsenalMagazines[] = { "30Rnd_65x39_caseless_mag" };
        arsenalItems[] = { "optic_Holosight" };
        arsenalBackpacks[] = { "B_AssaultPack_rgr" };
    };

    class spotter {
        name = "Spotter";
        rank = "Private";
        description = $STR_AW_Spotter_Description;
        traits[] = {
            
        };
        customVariables[] = {
            
        };
        icon = "a3\ui_f\data\map\vehicleicons\iconMan_ca.paa";
        defaultLoadout[] = {
            {"rhs_weap_m4a1_blockII_M203_d","rhsusf_acc_nt4_tan","rhsusf_acc_anpeq15side","rhsusf_acc_ACOG_d",{"rhs_mag_30Rnd_556x45_M855A1_PMAG_Tan",30},{"rhs_mag_M433_HEDP",1},"rhsusf_acc_grip_m203_d"},
            {},
            {"rhsusf_weap_glock17g4","","","",{"rhsusf_mag_17Rnd_9x19_JHP",17},"",""},
            {"U_B_FullGhillie_sard",{
                {"ACE_packingBandage",10},{"ACE_quikclot",10},{"ACE_elasticBandage",10},{"ACE_CableTie",4},{"ACE_EarPlugs",1},{"ACE_epinephrine",3},{"ACE_morphine",3},{"ACE_MapTools",1},{"ACE_microDAGR",1},{"ACE_Flashlight_XL50",1},
                {"ACE_tourniquet",2},{"ACE_splint",2},{"ACE_PlottingBoard",1},{"rhs_m136_hp_mag",1,1},{"rhs_mag_30Rnd_556x45_M855A1_PMAG_Tan",1,30},{"rhs_mag_m715_Green",1,1},{"ACE_40mm_Flare_white",1,1},{"ACE_Chemlight_IR",2,1}
                }},
            {"rhsusf_iotv_ocp_Grenadier",{
                {"rhsusf_ANPVS_14",1},{"rhs_mag_30Rnd_556x45_M855A1_PMAG_Tan",6,30},{"rhs_mag_M433_HEDP",3,1},{"rhs_mag_M397_HET",4,1},{"rhs_mag_m576",2,1},{"rhs_mag_m713_Red",1,1},{"rhs_mag_m714_White",1,1}
                }},
            {},
            "rhsusf_ach_helmet_headset_ocp","G_Bandanna_tan",
            {"UK3CB_BAF_Soflam_Laserdesignator","","","",{"Laserbatteries",1},{},""},
            {"ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch",""}
        };
        arsenalWeapons[] = { "arifle_MX_F" };
        arsenalMagazines[] = { "30Rnd_65x39_caseless_mag" };
        arsenalItems[] = { "optic_Holosight" };
        arsenalBackpacks[] = { "B_AssaultPack_rgr" };
    };

    class mortar {
        name = "Mortar Gunner";
        rank = "Private";
        description = $STR_AW_Mortar_Description;
        traits[] = {
            
        };
        customVariables[] = {
            {"InA_isFSGGunner", true, true}
        };
        icon = "a3\ui_f\data\map\vehicleicons\iconMan_ca.paa";
        defaultLoadout[] = {
            {"rhs_weap_mk18_d","rhsusf_acc_nt4_tan","rhsusf_acc_anpeq15_top","rhsusf_acc_eotech_552_d",{"rhs_mag_30Rnd_556x45_M855_Stanag",30},"","rhsusf_acc_rvg_de"},
            {},
            {"rhsusf_weap_glock17g4","","","",{"rhsusf_mag_17Rnd_9x19_JHP",17},"",""},
            {"rhs_uniform_acu_oefcp",{
                {"ACE_packingBandage",10},{"ACE_quikclot",10},{"ACE_elasticBandage",10},{"ACE_CableTie",4},{"ACE_EarPlugs",1},{"ACE_epinephrine",3},{"ACE_morphine",3},{"ACE_MapTools",1},{"ACE_microDAGR",1},{"ACE_Flashlight_XL50",1},
                {"ACE_tourniquet",2},{"ACE_splint",2},{"ACE_PlottingBoard",1}
                }},
            {"rhsusf_iotv_ocp_Rifleman",{
                {"rhsusf_ANPVS_14",1},{"rhs_mag_30Rnd_556x45_M855_Stanag",3,30}
                }},
            {"rhs_M252_Gun_Bag",{}},
            "rhsusf_patrolcap_ocp","rhs_googles_black",
            {"ACE_VectorDay","","","",{},"",""},
            {"ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch",""}
        };
        arsenalWeapons[] = { "arifle_MX_F" };
        arsenalMagazines[] = { "30Rnd_65x39_caseless_mag" };
        arsenalItems[] = { "optic_Holosight" };
        arsenalBackpacks[] = { "B_AssaultPack_rgr" };
    };

    class uav {
        name = "UAV Operator";
        rank = "Private";
        description = $STR_AW_UAV_Description;
        traits[] = {
            {"UAVHacker",true}
        };
        customVariables[] = {
            
        };
        icon = "a3\ui_f\data\map\vehicleicons\iconMan_ca.paa";
        defaultLoadout[] = {
            {"rhs_weap_mk18_d","rhsusf_acc_nt4_tan","rhsusf_acc_anpeq15_top","rhsusf_acc_eotech_552_d",{"rhs_mag_30Rnd_556x45_M855_Stanag",30},"","rhsusf_acc_rvg_de"},
            {},
            {"rhsusf_weap_glock17g4","","","",{"rhsusf_mag_17Rnd_9x19_JHP",17},"",""},
            {"rhs_uniform_acu_oefcp",{
                {"ACE_packingBandage",10},{"ACE_quikclot",10},{"ACE_elasticBandage",10},{"ACE_CableTie",4},{"ACE_EarPlugs",1},{"ACE_epinephrine",3},{"ACE_morphine",3},{"ACE_MapTools",1},{"ACE_microDAGR",1},
                {"ACE_Flashlight_XL50",1},{"ACE_tourniquet",2},{"ACE_splint",2},{"ACE_PlottingBoard",1}}},{"rhsusf_iotv_ocp_Rifleman",{{"rhsusf_ANPVS_14",1},{"rhs_mag_30Rnd_556x45_M855_Stanag",3,30}
                }},
            {"B_UAV_01_backpack_F", {}},
            "rhsusf_patrolcap_ocp","rhs_googles_black",
            {"ACE_VectorDay","","","",{},"",""},
            {"ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch",""}
        };
        arsenalWeapons[] = { "arifle_MX_F" };
        arsenalMagazines[] = { "30Rnd_65x39_caseless_mag" };
        arsenalItems[] = { "optic_Holosight" };
        arsenalBackpacks[] = { "B_AssaultPack_rgr" };
    };

    class pilot {
        name = "Pilot";
        rank = "Private";
        description = $STR_AW_Pilot_Description;
        traits[] = {
            
        };
        customVariables[] = {
            {"ace_isEngineer",1,true},
            {"ACE_GForceCoef",0.55,false},
            {"InA_isPilot", true, true}
        };
        icon = "a3\ui_f\data\map\vehicleicons\iconMan_ca.paa";
        defaultLoadout[] = {
            {"rhsusf_weap_MP7A2","","","rhsusf_acc_eotech_xps3",{"rhsusf_mag_40Rnd_46x30_FMJ",40},"","rhsusf_acc_grip3"},
            {},
            {"rhsusf_weap_glock17g4","","","",{"rhsusf_mag_17Rnd_9x19_JHP",17},"",""},
            {"UK3CB_BAF_U_HeliPilotCoveralls_Army",{
                {"ACE_packingBandage",10},{"ACE_quikclot",10},{"ACE_elasticBandage",10},{"ACE_CableTie",4},{"ACE_EarPlugs",1},{"ACE_epinephrine",3},{"ACE_morphine",3},{"ACE_MapTools",1},
                {"ACE_microDAGR",1},{"ACE_Flashlight_XL50",1},{"ACE_tourniquet",2},{"ACE_splint",2},{"ACE_PlottingBoard",1}}},{"UK3CB_BAF_V_Pilot_DDPM",{{"rhsusf_ANPVS_14",1},{"rhsusf_mag_40Rnd_46x30_FMJ",3,40}
                }},
            {},
            "rhsusf_hgu56p_visor","",{"rhsusf_bino_m24","","","",{},"",""},
            {"ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch",""}
        };
        arsenalWeapons[] = { "arifle_MX_F" };
        arsenalMagazines[] = { "30Rnd_65x39_caseless_mag" };
        arsenalItems[] = { "optic_Holosight" };
        arsenalBackpacks[] = { "B_AssaultPack_rgr" };
    };
};





