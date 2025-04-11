/*
Author: BACONMOP
Description: Defines Main AO's
Contributors: Zissou, Pero, Stanhope & Whigital
*/

class Altis {
    arsenalObjects[] = {
        "Quartermaster",
        "Quartermaster_1",
        "Quartermaster_2",
        "Quartermaster_3",
        "Quartermaster_4",
        "Quartermaster_5",
        "Quartermaster_6",
        "Quartermaster_7",
        "Quartermaster_8"
    };

    missionBlacklistPositions[] = {
        {{14800, 16500}, 1200}, // Terminal
        {{23500, 18400}, 1500}, // Salt Flats
        {{11500, 11675}, 1200}, // AAC Airfield
        {{26960, 24690}, 1200}, // Molos Airfield
        {{9152, 21647}, 1200}   // Fob Mikael
    };

    randomFactions[] = {
        "AFRF",
        "CDF",
        "RACS"
    };

    class Missions {
        SubObjs[] = {
            "AAA-Fort",
            "AA-Fort",
            //"Cache",
            "Command",
            "Comms",
            //"HQ",
            // "Mobile-AAA",
            "Mortar",
            "RadioTower",
            "TankSection"
        };

        Sides[] = {
            "CBRN-Radiological",
            "Destroyer",
            "DestroyUrban",
            "FreeCivs",
            "HQ-Coast",
            "HQ-Research",
            "MilitiaCamp",
            "PilotRescue",
            "PoliceProtection",
            "Prototype-Tank",
            "SecureAsset",
            "SecureIntel-Unit",
            "SecureIntel-Vehicle",
            "SecureRadar",
            "ViperIntel",
            "LostConvoy"
        };

        Prios[] = {
            "Anti-Air",
            "Artillery",
            "Depot",
            "Factory",
            "FARP",
            "MLRS",
            "SAM",
            "ShoreBombardmentRelay"
        };
    };

    class Bases {
        staticBases[] = {
            "BASE",
            "USS_Freedom"
        };

        baseMarkers[] = {
            "term_pl_res",
            "aac_pl_res",
            "sdm_pl_res",
            "mol_pl_res",
            "mikael_pl_res"
        };
    };

    class AOs {
        // Static Bases
        class BASE {
            name = "Main Base";
            type = "MainBase";

            aaDefences[] = {
                "Base_AA"
            };

            reward_markers[] = {
                "smReward1", "smReward2", "smReward3", "smReward4",
                "smReward5", "smReward6", "smReward7", "smReward8",
                "smReward9", "smReward10", "smReward11", "smReward12",
                "smReward13", "smReward14", "smReward15", "smReward16",
                "smReward17", "smReward18", "smReward19", "smReward20",
                "smReward21", "smReward22", "smReward23", "smReward24",
                "smReward25", "smReward26", "smReward27", "smReward28",
                "smReward29", "smReward30", "smReward31", "smReward32",
                "smReward33", "smReward34", "smReward35", "smReward36"
            };

            class ServicePads {
                Air[] = {
                    {"main_air_service_1", {0, 0, 0}},
                    "main_air_service_2",
                    "main_air_service_3"
                };

                Ground[] = {
                    "main_ground_service_1"
                };
            };
        };

        class USS_Freedom {
            name = "USS Freedom";
            type = "Carrier";

            aaDefences[] = {
                "CVN_CIWS_1",
                "CVN_CIWS_2",
                "CVN_CIWS_3",
                "CVN_RAM",
                "CVN_SAM_2",
                "CVN_SAM_3"
            };

            jetspawn_markers[] = {
                "carrier_jetspawn_1",
                "carrier_jetspawn_2",
                "carrier_jetspawn_3",
                "carrier_jetspawn_4",
                "carrier_jetspawn_5"
            };

            class ServicePads {
                Air[] = {
                    "carrier_air_service_1"
                };
            };
        };

        // FOBs
        class Terminal {
            name =  "Terminal";
            type = "Military";
            nameAlt = "FOB Guardian";

            class ServicePads {
                Air[] = {
                    {"term_air_service_1", {1, 0, 0}},
                    {"term_air_service_2", {1, 1, 1}}
                };

                Ground[] = {
                    "term_ground_service_1",
                    {"term_ground_service_2", {1, 1, 1}}
                };
            };

            class Base {
                baseType = "FOB";
                spawn = "term_pl_res";
                marker = "FOB_Guardian";
                arsenal = "term_pl_arsenal";


                reward_markers[] = {
                    "term_reward01", "term_reward02", "term_reward03", "term_reward04",
                    "term_reward05", "term_reward06", "term_reward07", "term_reward08",
                    "term_reward09", "term_reward10", "term_reward11", "term_reward12",
                    "term_reward13", "term_reward14", "term_reward15", "term_reward16",
                    "term_reward17", "term_reward18"
                };

                vehicles[] = {
                    {"JET_CAP", "term_jet1", 1800},
                    {"RHS_C130J_Cargo", "term_jet2", 60},
                    {"HELI_LCAS", "term_heli1", 900},
                    {"HELI_MED", "term_heli2", 300},
                    {"UK3CB_BAF_Merlin_HC4_18_GPMG_DDPM", "term_heli3", 300},
                    {"RHS_UH60M", "term_heli4", 300},
                    {"RHS_MELB_MH6M", "term_heli5", 300},
                    {"ARMOR_IFV", "term_veh1", 900},
                    {"CAR_MRAP", "term_veh2", 120},
                    {"CAR_MRAP", "term_veh3", 120},
                    {"CAR_MRAP", "term_veh4", 120},
                    {"CAR_MRAP", "term_veh5", 120},
                    {"CAR_LSV", "term_veh7", 60},
                    {"CAR_LSV", "term_veh9", 60},
                    {"CAR_LSV", "term_veh8", 60},
                    {"CAR_LSV", "term_veh10", 60},
                    {"UK3CB_BAF_LandRover_Amb_FFR_Sand_A_DDPM", "term_veh11", 300},
                    {"C_Kart_01_F", "term_veh12", 300},
                    {"Land_Pod_Heli_Transport_04_fuel_black_F", "term_pod1", 900},
                    {"Land_Pod_Heli_Transport_04_ammo_black_F", "term_pod2", 900},
                    {"Land_Pod_Heli_Transport_04_repair_black_F", "term_pod3", 900},

                    {"rhsusf_mkvsoc", "term_boat1", 300},
                    {"rhsusf_mkvsoc", "term_boat2", 180},
                    {"UK3CB_BAF_RHIB_HMG", "term_boat3", 300},
                    {"UK3CB_BAF_RHIB_HMG", "term_boat4", 180},

                    {"B_Boat_Transport_01_F", "term_boat5", 120},
                    {"B_Boat_Transport_01_F", "term_boat6", 120},
                    {"B_Boat_Transport_01_F", "term_boat7", 120},

                    {"B_SDV_01_F", "term_boat8", 180},
                    {"B_SDV_01_F", "term_boat9", 180},

                    {"C_Boat_Civil_01_F", "term_boat10", 120},
                    {"C_Boat_Civil_01_F", "term_boat11", 120},

                    {"C_Scooter_Transport_01_F", "term_boat12", 60},
                    {"C_Scooter_Transport_01_F", "term_boat13", 60}
                };
            };
        };

        class AAC_Airfield {
            name =  "AAC Airfield";
            type = "Military";
            nameAlt = "FOB Martian";

            class ServicePads {
                Air[] = {};

                Ground[] = {
                    {"aac_ground_service_1", {1, 1, 1}}
                };
            };

            class Base {
                baseType = "FOB";
                spawn = "aac_pl_res";
                marker = "FOB_Martian";
                arsenal = "aac_pl_arsenal";

                vehicles[] = {
                    {"RHS_UH60M_ESSS_d", "aac_heli1", 600},
                    {"RHS_MELB_MH6M", "aac_heli2", 300},
                    {"HELI_BIG", "aac_heli3", 300},
                    {"UK3CB_BAF_Wildcat_AH1_CAS_8D_DDPM", "aac_heli4", 300},
                    {"RHS_M6", "aac_veh1", 1800},
                    {"ARMOR_IFV", "aac_veh2", 900},
                    {"CAR_MRAP", "aac_veh3", 120},
                    {"CAR_MRAP", "aac_veh4", 120},
                    {"CAR_LSV", "aac_veh5", 60},
                    {"CAR_LSV", "aac_veh6", 60},
                    {"rhsusf_M978A4_BKIT_usarmy_d", "aac_veh7", 300}
                };
            };
        };

        class Stadium {
            name =  "Stadium";
            type = "Military";
            nameAlt = "FOB Marathon";

            class ServicePads {
                Air[] = {};

                Ground[] = {
                    {"sdm_ground_service_1", {1, 1, 1}}
                };
            };

            class Base {
                baseType = "FOB";
                spawn = "sdm_pl_res";
                marker = "FOB_Marathon";
                arsenal = "sdm_pl_arsenal";

                vehicles[] = {
                    {"HELI_CAS", "sdm_heli1", 3600},
                    {"RHS_UH1Y_FFAR_d", "sdm_heli2", 300},
                    {"HELI_MED", "sdm_heli3", 300},
                    {"CAR_MRAP", "sdm_veh1", 120},
                    {"CAR_MRAP", "sdm_veh2", 120},
                    {"CAR_LSV", "sdm_veh3", 60},
                    {"CAR_LSV", "sdm_veh4", 60},
                    {"rhsusf_M978A4_BKIT_usarmy_d", "sdm_veh5", 120},
                    {"ARMOR_TANK", "sdm_veh6", 1800}
                };
            };
        };

        class Molos_Airfield {
            name =  "Molos Airfield";
            type = "Military";
            nameAlt = "FOB Last Stand";

            class ServicePads {
                Air[] = {
                    {"mol_air_service_1", {0, 0, 1}},
                    {"mol_air_service_2", {1, 1, 1}}
                };

                Ground[] = {
                    "mol_ground_service_1"
                };
            };

            class Base {
                baseType = "FOB";
                spawn = "mol_pl_res";
                marker = "FOB_Last_Stand";
                arsenal = "mol_pl_arsenal";

                vehicles[] = {
                    {"JET_CAS", "mol_jet_spawn", 3600},
                    {"HELI_BIG", "mol_heli1", 300},
                    {"HELI_LCAS", "mol_heli2", 900},
                    {"UK3CB_BAF_Wildcat_AH1_HEL_8A_DDPM", "mol_heli3", 300},
                    {"ARMOR_TANK", "mol_veh1", 1800},
                    {"CAR_MRAP", "mol_veh2", 120},
                    {"CAR_MRAP", "mol_veh3", 120},
                    {"CAR_LSV", "mol_veh4", 60},
                    {"CAR_LSV", "mol_veh5", 60},
                    {"rhsusf_M978A4_BKIT_usarmy_d", "mol_veh6", 300}
                };
            };
        };

        class AO_Abdera {
            name =  "Abdera";
            type = "Town";
            nameAlt = "FOB Mikael";

            class ServicePads {
                Air[] = {
                    {"mikael_air_service_1", {0, 0, 0}}

                };

                Ground[] = {
                    "mikael_ground_service_1"
                };
            };

            class Base {
                baseType = "FOB";
                spawn = "mikael_pl_res";
                marker = "FOB_Mikael";
                arsenal = "mikael_pl_arsenal";

                vehicles[] = {
                    {"RHS_MELB_MH6M", "mikael_heli_01", 300},
                    {"RHS_MELB_AH6M", "mikael_heli_02", 600},
                    {"UK3CB_BAF_Wildcat_HMA2_TRN_8A_DDPM", "mikael_heli_03", 300},
                    {"CAR_LSV", "mikael_car_01", 60},
                    {"CAR_LSV", "mikael_car_02", 60},
                    {"CAR_LSV", "mikael_car_03", 60},
                    {"CAR_LSV", "mikael_car_04", 60},
                    {"CAR_MRAP", "mikael_mrap_01", 120},
                    {"CAR_MRAP", "mikael_mrap_02", 120}
                };
            };

        };
        // AOs
        class AO_Cape_Makrinos {
            name =  "Cape Makrinos";
            type = "Coastline";
        };

        class AO_Castle_Ruins {
            name =  "Castle Ruins";
            type = "Hill";
        };

        class AO_Vikos_Outpost {
            name =  "Vikos Outpost";
            type = "Military";
        };

        class AO_Melanera_Bay {
            name =  "Melanera Bay";
            type = "Outpost";
        };

        class AO_Sfaka {
            name =  "Sfaka";
            type = "Outpost";
        };

        class AO_Zaros {
            name =  "Zaros";
            type = "Town";
        };

        class AO_Zaros_PowerPlant {
            name =  "Zaros Power Plant";
            type = "Outpost";
        };

        class AO_Edessa {
            name =  "Edessa";
            type = "Outpost";
        };

        class AO_Panochori {
            name =  "Panochori";
            type = "Town";
        };

        class AO_Panochori_Bay {
            name =  "Panochori Bay";
            type = "Outpost";
        };

        class AO_Athanos {
            name =  "Athanos";
            type = "Outpost";
        };

        class AO_Neri {
            name =  "Neri";
            type = "Outpost";
        };

        class AO_Kavala_Quarry {
            name =  "Kavala Quarry";
            type = "Outpost";
        };

        class AO_Dump {
            name =  "Dump";
            type = "Outpost";
        };

        class AO_Aggelochori_Outskirts {
            name =  "Aggelochori Outskirts";
            type = "Outpost";
        };

        class AO_Power_Plant {
            name =  "Power Plant";
            type = "Outpost";
        };

        class AO_Negades {
            name =  "Negades";
            type = "Town";
        };

        class AO_Kira {
            name =  "Kira";
            type = "Hill";
        };

        class AO_Agios_Konstantinos {
            name =  "Agios Konstantinos";
            type = "Outpost";
        };

        class AO_Agios_Konstantinos_Turbines {
            name =  "Agios Konstantinos Turbines";
            type = "Hill";
        };

        class AO_Oreokastro {
            name =  "Oreokastro";
            type = "Town";
        };

        class AO_Synneforos {
            name =  "Synneforos";
            type = "Outpost";
        };
        /* to close to fob
        class AO_Krya_Nera {
            name =  "Krya Nera";
            type = "Coastline";
        };
        */
        class AO_Livadi_Bay {
            name =  "Livadi Bay";
            type = "Outpost";
        };

        class AO_Ekali {
            name =  "Ekali";
            type = "Outpost";
        };

        class AO_Faronaki {
            name =  "Faronaki";
            type = "Outpost";
        };

        class AO_Pyrgos_Quarry {
            name =  "Pyrgos Quarry";
            type = "Outpost";
        };

        class AO_Aktinarki {
            name =  "Aktinarki";
            type = "Outpost";
        };

        class AO_Chalkeia {
            name =  "Chalkeia";
            type = "Town";
        };

        class AO_Pyrgos {
            name =  "Pyrgos";
            type = "Town";
        };
/*
        class AO_Chelonisi {
            name =  "Chelonisi";
            type = "Coastline";
        };
*/
        class AO_Dorida {
            name =  "Dorida";
            type = "Town";
        };

        class AO_Cape_Kategidis {
            name =  "Cape Kategidis";
            type = "Outpost";
        };

        class AO_Limni {
            name =  "Limni";
            type = "Outpost";
        };

        class AO_Cape_Thelos {
            name =  "Cape Thelos";
            type = "Coastline";
        };
/*
        class AO_Salt_Flats_South {
            name =  "Southern Salt Flats";
            type = "Outpost";
        };
*/
        class AO_Charkia {
            name =  "Charkia";
            type = "Town";
        };

        class AO_Charkia_Mine {
            name =  "Charkia Mine";
            type = "Outpost";
        };

        class AO_Kalochori {
            name =  "Kalochori";
            type = "Outpost";
        };

        class AO_Paros {
            name =  "Paros";
            type = "Outpost";
        };

        class AO_Rodopoli {
            name =  "Rodopoli";
            type = "Town";
        };

        class AO_Agios_Petros {
            name =  "Agios Petros";
            type = "Outpost";
        };

        class AO_Agios_Georgios {
            name =  "Agios Georgios";
            type = "Outpost";
        };

        class AO_Sofia {
            name =  "Sofia";
            type = "Town";
        };

        class AO_Sofia_Powerplant {
            name =  "Sofia Powerplant";
            type = "Outpost";
        };

        class AO_Gatolia {
            name =  "Gatolia";
            type = "Outpost";
        };

        class AO_Nidasos {
            name =  "Nidasos";
            type = "Outpost";
        };

        class AO_Molos {
            name =  "Molos";
            type = "Town";
        };

        class AO_Cape_Strigla {
            name =  "Cape Strigla";
            type = "Coastline";
        };

        class AO_Limnichori {
            name =  "Limnichori";
            type = "Coastline";
        };

        class AO_Agios_Andreas {
            name =  "Agios Andreas";
            type = "Outpost";
        };

        class AO_Nidasos_Hill {
            name =  "Nidasos Hill";
            type = "Military";
        };

        class AO_Hotel {
            name =  "Hotel";
            type = "Outpost";
        };

        class AO_Ioannina {
            name =  "Ioannina";
            type = "Outpost";
        };

        class AO_Delfinaki {
            name =  "Delfinaki";
            type = "Outpost";
        };

        class AO_Kalithea {
            name =  "Kalithea";
            type = "Coastline";
        };

        class AO_Cape_Zefyris {
            name =  "Cap Zefyris";
            type = "Coastline";
        };

        class AO_Anthrakia {
            name =  "Anthrakia";
            type = "Town";
        };

        class AO_Zeloran {
            name =  "Zeloran";
            type = "Coastline";
        };

        class AO_Agia_Trida {
            name =  "Agia Trida";
            type = "Outpost";
        };

        class AO_Nychi {
            name =  "Nychi";
            type = "Coastline";
        };

        class AO_Cape_Agrios {
            name =  "Cape Agrios";
            type = "Outpost";
        };

        class AO_Frini {
            name =  "Frini";
            type = "Town";
        };

        class AO_Frini_Woods {
            name =  "Frini Woods";
            type = "Outpost";
        };

        class AO_Tonos_Bay {
            name =  "Tonos Bay";
            type = "Outpost";
        };

        class AO_Hill_140 {
            name =  "Hill 140";
            type = "Hill";
        };

        class AO_Ifestiona {
            name =  "Ifestiona";
            type = "Outpost";
        };

        class AO_Katalaki_Penninsula {
            name =  "Katalaki Penninsula";
            type = "Coastline";
        };

        class AO_Katalaki {
            name =  "Katalaki";
            type = "Town";
        };

        class AO_Neochori {
            name =  "Neochori";
            type = "Town";
        };

        class AO_Other_Dump {
            name =  "Another dump";
            type = "Outpost";
        };

        class AO_Kore {
            name =  "Kore";
            type = "Town";
        };

        class AO_Xirolimni_Dam {
            name =  "Xirolimni Dam";
            type = "Outpost";
        };

        class AO_Agios_Dionysios {
            name =  "Agios Dionysios";
            type = "Town";
        };

        class AO_Syrta {
            name =  "Syrta";
            type = "Town";
        };

        class AO_Koroni {
            name =  "Koroni";
            type = "Outpost";
        };

        class AO_Orino {
            name =  "Orino";
            type = "Outpost";
        };

        class AO_Galati {
            name =  "Galati";
            type = "Outpost";
        };

        class AO_Athira {
            name =  "Athira";
            type = "Town";
        };

        class AO_Agia_Stemma {
            name =  "Agia Stemma";
            type = "Hill";
        };

        class AO_Topolia {
            name =  "Topolia";
            type = "Outpost";
        };

        class AO_Alikampos {
            name =  "Alikampos";
            type = "Outpost";
        };

        class AO_Lakka {
            name =  "Lakka";
            type = "Town";
        };

        class AO_Edoris {
            name =  "Edoris";
            type = "Coastline";
        };

        class AO_Pefkas_Research {
            name =  "Research Facility";
            type = "Military";
        };

        class AO_Nifi {
            name =  "Nifi";
            type = "Outpost";
        };

        class AO_Ammolofi_Hills {
            name =  "Ammolofi Hills";
            type = "Outpost";
        };
    };
};


class Cam_Lao_Nam {
    environment = "Lush";

    arsenalObjects[] = {
        "Quartermaster",
        "Quartermaster_1",
        "Quartermaster_2",
        "Quartermaster_3",
        "Quartermaster_4",
        "Quartermaster_5",
        "Quartermaster_6",
        "Quartermaster_7"
    };

    missionBlacklistPositions[] = {};

    class Missions {
        SubObjs[] = {
            "RadioTower",
            "TankSection"
        };

        Sides[] = {
            "Destroyer",
            "DestroyUrban",
            "MilitiaCamp",
            "PilotRescue",
            "SecureAsset",
            "LostConvoy"
        };

        Prios[] = {
            "Anti-Air",
            "Artillery"
        };
    };

    class Bases {
        staticBases[] = {
            "BASE",
            "USS_Freedom"
        };

        baseMarkers[] = {
            "sbb_pl_res",
            "ml_pl_res",
            "pp_pl_res",
            "dt_pl_res"
        };
    };

    class AOs {
        // Static Bases
        class BASE {
            name = "Main Base";
            type = "MainBase";

            aaDefences[] = {
                "Base_AA"
            };

            reward_markers[] = {
                "smReward1", "smReward2", "smReward3", "smReward4",
                "smReward5", "smReward6", "smReward7", "smReward8",
                "smReward9", "smReward10", "smReward11", "smReward12",
                "smReward13", "smReward14", "smReward15", "smReward16",
                "smReward17", "smReward18", "smReward19", "smReward20",
                "smReward21", "smReward22", "smReward23", "smReward24",
                "smReward25", "smReward26", "smReward27", "smReward28",
                "smReward29", "smReward30", "smReward31", "smReward32",
                "smReward33", "smReward34", "smReward35", "smReward36"
            };

            class ServicePads {
                Air[] = {
                    {"main_air_service_1", {0, 0, 0}}
                };

                Ground[] = {
                    "main_ground_service_1"
                };
            };
        };

        class USS_Freedom {
            name = "USS Freedom";
            type = "Carrier";

            aaDefences[] = {
                "CVN_CIWS_1",
                "CVN_CIWS_2",
                "CVN_CIWS_3",
                "CVN_RAM",
                "CVN_SAM_2",
                "CVN_SAM_3"
            };

            jetspawn_markers[] = {
                "carrier_jetspawn_1",
                "carrier_jetspawn_2",
                "carrier_jetspawn_3",
                "carrier_jetspawn_4",
                "carrier_jetspawn_5"
            };

            class ServicePads {
                Air[] = {
                    "carrier_air_service_1"
                };
            };
        };

        // FOBs
        class AO_SanBayBan {
            name = "San Bay Ban";
            type = "Military";
            nameAlt = "FOB Leopard";

            class ServicePads {
                Air[] = {
                    {"sbb_air_service_1", {0, 0, 0}}
                };

                Ground[] = {
                    "sbb_ground_service_1"
                };
            };

            class Base {
                baseType = "FOB";
                marker = "FOB_Leopard";
                spawn = "sbb_pl_res";
                arsenal = "sbb_pl_arsenal";

                vehicles[] = {
                    {"JET_CAS_PF", "sbb_jet1", 1800},
                    {"HELI_CAS_PF", "sbb_heli1", 900},
                    {"HELI_MED_PF", "sbb_heli2", 120},
                    {"HELI_BIG_PF", "sbb_heli3", 120},
                    {"vn_b_wheeled_m54_fuel", "sbb_veh1", 120},
                    {"TRANSPORT_LIGHT_PF", "sbb_veh2", 30},
                    {"TRANSPORT_LIGHT_PF", "sbb_veh3", 30},
                    {"SUPPORT_LIGHT_PF", "sbb_veh4", 30},
                    {"TRANSPORT_PF", "sbb_veh5", 30},
                    {"SUPPORT_PF", "sbb_veh6", 120},
                    {"SUPPORT_PF", "sbb_veh7", 120}
                };
            };
        };

        class AO_MaiLoc {
            name = "Mai Loc";
            type = "Military";
            nameAlt = "FOB Fox";

            class ServicePads {
                Ground[] = {
                    "ml_ground_service_1"
                };
            };

            class Base {
                baseType = "FOB";
                marker = "FOB_Fox";
                spawn = "ml_pl_res";
                arsenal = "ml_pl_arsenal";

                vehicles[] = {
                    {"HELI_GUNSHIP_PF", "ml_heli1", 900},
                    {"HELI_MED_PF", "ml_heli2", 120},
                    {"HELI_LCAS_PF", "ml_heli3", 120},
                    {"vn_b_wheeled_m54_fuel", "ml_veh1", 120},
                    {"TRANSPORT_LIGHT_PF", "ml_veh2", 30},
                    {"TRANSPORT_LIGHT_PF", "ml_veh3", 30},
                    {"TRANSPORT_LIGHT_PF", "ml_veh4", 30},
                    {"SUPPORT_LIGHT_PF", "ml_veh5", 30},
                    {"SUPPORT_PF", "ml_veh6", 120},
                    {"SUPPORT_PF", "ml_veh7", 120},
                    {"ARMOR_TANK_PF", "ml_veh8", 900}
                };
            };
        };

        class AO_PemPatBase {
            name = "Pem Pat Base";
            type = "Military";
            nameAlt = "FOB Crocodile";

            class ServicePads {
                Ground[] = {
                    "pp_ground_service_1"
                };
            };

            class Base {
                baseType = "FOB";
                marker = "FOB_Crocodile";
                spawn = "pp_pl_res";
                arsenal = "pp_pl_arsenal";

                vehicles[] = {
                    {"HELI_MED_PF", "pp_heli1", 30},
                    {"HELI_HCAS_PF", "pp_heli2", 300},
                    {"BOAT_PF", "pp_boat3", 30},
                    {"BOAT_PF", "pp_boat4", 30},
                    {"TRANSPORT_LIGHT_PF", "pp_veh1", 30},
                    {"SUPPORT_LIGHT_PF", "pp_veh2", 30},
                    {"TRANSPORT_PF", "pp_veh3", 30},
                    {"vn_b_wheeled_m54_fuel", "pp_veh4", 120},
                    {"ARMOR_TANK_PF", "pp_veh5", 900}
                };
            };
        };

        class AO_DaoTrai {
            name = "Dao Trai";
            type = "Military";
            nameAlt = "FOB Bear";

            class ServicePads {
                Ground[] = {
                    {"dt_ground_service_1", {1, 1, 1}}
                };
            };

            class Base {
                baseType = "FOB";
                marker = "FOB_Bear";
                spawn = "dt_pl_res";
                arsenal = "dt_pl_arsenal";

                vehicles[] = {
                    {"HELI_MED_PF", "dt_heli1", 30},
                    {"BOAT_PF", "dt_boat1", 30},
                    {"BOAT_PF", "dt_boat2", 30},
                    {"SUPPORT_PF", "dt_veh1", 30},
                    {"SUPPORT_LIGHT_PF", "dt_veh2", 30},
                    {"TRANSPORT_LIGHT_PF", "dt_veh3", 30},
                    {"vn_b_wheeled_m54_fuel", "dt_veh4", 120},
                    {"ARMOR_TANK_PF", "dt_veh5", 900}
                };
            };
        };

        class AO_PleikuBoatBase {
            name = "Pleiku Boat Base";
            type = "Military";
            nameAlt = "FOB Dolphin";

            class ServicePads {
                Ground[] = {
                    "pb_ground_service_1"
                };
            };

            class Base {
                baseType = "FOB";
                marker = "FOB_Dolphin";
                spawn = "pb_pl_res";
                arsenal = "pb_pl_arsenal";

                vehicles[] = {
                    {"HELI_MED_PF", "pb_heli1", 30},
                    {"HELI_CAS_PF", "pb_heli2", 300},
                    {"HELI_LCAS_PF", "pb_heli3", 120},
                    {"vn_b_wheeled_m54_fuel", "pb_veh1", 30},
                    {"SUPPORT_PF", "pb_veh2", 120},
                    {"TRANSPORT_LIGHT_PF", "pb_veh3", 30},
                    {"TRANSPORT_LIGHT_PF", "pb_veh5", 30},
                    {"SUPPORT_LIGHT_PF", "pb_veh4", 30},
                    {"BOAT_PF", "pb_boat1", 30},
                    {"BOAT_PF", "pb_boat2", 30},
                    {"BOAT_PF", "pb_boat3", 30},
                    {"BOAT_PF", "pb_boat4", 30}
                };
            };
        };

        // AOs
        class AO_BinhMinh {
            name = "Binh Minh";
            type = "Outpost";
        };

        class AO_DaNang {
            name = "Da Nang";
            type = "Town";
        };

        class AO_Ba_Ria {
            name = "Ba Ria North";
            type = "Field";
        };

        class AO_Ba_Ria_1 {
            name = "Ba Ria South";
            type = "Field";
        };

        class AO_Saigon {
            name = "Saigon";
            type = "Town";
        };

        class AO_BanMeThuot {
            name = "FOB Ban Me Thout";
            type = "Outpost";
        };

        class AO_HoNgocTao {
            name = "FOB Ho Ngoc Tao";
            type = "Outpost";
        };

        class AO_SaiPort {
            name = "Sai Port";
            type = "Coastline";
        };

        class AO_MarbleMtn {
            name = "Marble Mtn";
            type = "Town";
        };

        class AO_HoaLien {
            name = "Hoa Lien";
            type = "Town";
        };

        class AO_CauHai {
            name = "Cau Hai";
            type = "Coastline";
        };

        class AO_PhuBai {
            name = "Phu Bai";
            type = "Outpost";
        };

        class AO_PhuAn {
            name = "Hoa Lien";
            type = "Town";
        };

        class AO_BuioSang {
            name = "Buio Sang";
            type = "Town";
        };

        class AO_TamPep {
            name = "Tam Pep";
            type = "Town";
        };

        class AO_QuanBo {
            name = "QuanBo";
            type = "Town";
        };

        class AO_MekongDelta {
            name = "MekongDelta";
            type = "Town";
        };

        class AO_SocTrang {
            name = "Soc Trang";
            type = "Town";
        };

        class AO_NhenDen {
            name = "Nhen Den";
            type = "Town";
        };

        class AO_CuChi {
            name = "Cu Chi";
            type = "Town";
        };

        class AO_KonTum {
            name = "FOB Kon Tum";
            type = "Outpost";
        };

        class AO_Berchtesgadan {
            name = "FSB Berchtesgadan";
            type = "Outpost";
        };

        class AO_QuanLoi {
            name = "FOB Quan Loi";
            type = "Outpost";
        };

        class AO_GanSong {
            name = "Gan Song";
            type = "Town";
        };

        class AO_Mien {
            name = "Cau Hai";
            type = "Coastline";
        };

        class AO_LongHai {
            name = "Long Hai";
            type = "Coastline";
        };

        class AO_PhuQuocPort {
            name = "Phu Quoc Port";
            type = "Coastline";
        };

        class AO_PhuQuoc {
            name = "Phu Quoc";
            type = "Outpost";
        };

        class AO_NiemTin {
            name = "Niem Tin";
            type = "Outpost";
        };

        class AO_SegBegat {
            name = "Niem Tin";
            type = "Outpost";
        };

        class AO_Hue {
            name = "Hue";
            type = "Town";
        };

        class AO_HueCitadel {
            name = "Hue Citaled";
            type = "Town";
        };

        class AO_LhoBerroGhi {
            name = "Lho Berro Ghi";
            type = "Town";
        };

        class AO_NaLai {
            name = "Na Lai";
            type = "Town";
        };

        class AO_PleikuBaseSouth {
            name = "Pleiku Base South";
            type = "Outpost";
        };

        class AO_PleikuBaseNorth {
            name = "Pleiku Base North";
            type = "Outpost";
        };

        class AO_PleikuBaseSFCamp {
            name = "Pleiku Base SF Camp";
            type = "Outpost";
        };

        class AO_BoSong {
            name = "Bo Song";
            type = "Coastline";
        };

        class AO_NuocBun {
            name = "Nuoc Bun";
            type = "Coastline";
        };

        class AO_WestHanoi {
            name = "West Hanoi";
            type = "Town";
        };

        class AO_Hanoi {
            name = "Hanoi";
            type = "Town";
        };

        class AO_HanoiPort {
            name = "Hanoi Port";
            type = "Town";
        };

        class AO_HaiPhong {
            name = "Hai Phong";
            type = "Town";
        };

        class AO_DaKrong {
            name = "Hai Phong";
            type = "Town";
        };

        class AO_Lumphat {
            name = "Lumphat";
            type = "Town";
        };

        class AO_YenTinh {
            name = "Yen Tinh";
            type = "Town";
        };

        class AO_ThungLungCao {
            name = "Thung Lung Cao";
            type = "Town";
        };

        class AO_Sihanoukville {
            name = "Sihanoukville";
            type = "Coastline";
        };

        class AO_SihanoukvilleSouth {
            name = "Sihanoukville South";
            type = "Coastline";
        };

        class AO_BanhTrung {
            name = "Banh Trung";
            type = "Town";
        };

        class AO_LangMau {
            name = "Lang Mau";
            type = "Town";
        };

        class AO_XoXanh {
            name = "Xo Xanh";
            type = "Town";
        };

        class AO_BaiBienDep {
            name = "Bai Bien Dep";
            type = "Coastline";
        };

        class AO_PhoDuc {
            name = "Pho Duc";
            type = "Town";
        };

        class AO_NgaTu {
            name = "Nga Tu";
            type = "Town";
        };

        class AO_BinhYen {
            name = "Binh Yen";
            type = "Town";
        };

        class AO_ForestHidout {
            name = "Forest Hideout";
            type = "Town";
        };

        class AO_ForestTown {
            name = "Forest Town";
            type = "Town";
        };

        class AO_ThungLungCaoForestHideout {
            name = "Thung Lung Cao Forest Hidout";
            type = "Town";
        };

        class AO_Attapeu {
            name = "Attapeu";
            type = "Town";
        };

        class AO_NorthHanoi {
            name = "North Hanoi";
            type = "Town";
        };

        class AO_ALuoi {
            name = "North Hanoi";
            type = "Outpost";
        };

        class AO_DharmaDocks {
            name = "Dharma Docks";
            type = "Coastline";
        };

        class AO_MaxwellField {
            name = "Maxwell Field";
            type = "Outpost";
        };

        class AO_LaHot {
            name = "La Hot";
            type = "Town";
        };

        class AO_GiaLamAirbase {
            name = "Gio Lam Airbase";
            type = "Outpost";
        };

        class AO_HiddenHarbour {
            name = "Hidden harbour";
            type = "Outpost";
        };

        class AO_HaLongNavyBase {
            name = "Ha Long Navy Base";
            type = "Coastline";
        };

        class AO_BaiChai {
            name = "Bai Chai";
            type = "Town";
        };

        class AO_DoCon {
            name = "Do Con";
            type = "Coastline";
        };

        class AO_PatMep {
            name = "Pat Mep";
            type = "Coastline";
        };

        class AO_CayMo {
            name = "Cay Mo";
            type = "Town";
        };

        class AO_LacMy {
            name = "LacMy";
            type = "Town";
        };

        class AO_BachDang {
            name = "Bach Dang";
            type = "Town";
        };

        class AO_MSSLeghorn {
            name = "Mss Leghorn";
            type = "Outpost";
        };

        class AO_GiuaHo {
            name = "Giua Ho";
            type = "Town";
        };

        class AO_NongKhiaw {
            name = "Nong Khiaw";
            type = "Town";
        };

        class AO_TanDi {
            name = "Tan Di";
            type = "Town";
        };

        class AO_Bru {
            name = "Bru";
            type = "Town";
        };

        class AO_ALieng {
            name = "A Lieng";
            type = "Town";
        };

        class AO_RungCung {
            name = "Rung Cung";
            type = "Town";
        };

        class AO_VongXo {
            name = "Vong Xo";
            type = "Town";
        };

        class AO_ThudRidge {
            name = "Thud Ridge";
            type = "Town";
        };

        class AO_KetThuc {
            name = "Ket Thuc";
            type = "Town";
        };
    };
};


class SefrouRamal {
    arsenalObjects[] = {
        "Quartermaster",
        "Quartermaster_1",
        "Quartermaster_2",
        "Quartermaster_3",
        "Quartermaster_4",
        "Quartermaster_5",
        "Quartermaster_6",
        "Quartermaster_7"
    };

    missionBlacklistPositions[] = {
        {{14800, 16500}, 1200}, // Ramal Airbase
    };

    class Missions {
        SubObjs[] = {
            "AAA-Fort",
            "AA-Fort",
            //"Cache",
            "Command",
            "Comms",
            //"HQ",
            "Mobile-AAA",
            "Mortar",
            "RadioTower",
            "TankSection"
        };

        Sides[] = {
            "DestroyUrban",
            "FreeCivs",
            "HQ-Research",
            "MilitiaCamp",
            "PilotRescue",
            "PoliceProtection",
            "Prototype-Tank",
            "SecureAsset",
            "SecureIntel-Unit",
            "SecureIntel-Vehicle",
            "SecureRadar",
            "ViperIntel",
            "LostConvoy"
        };

        Prios[] = {
            "Anti-Air",
            "Artillery",
            "Depot",
            "Factory",
            "FARP",
            "MLRS",
            "SAM",
        };
    };

    class Bases {
        staticBases[] = {
            "BASE"
        };

        baseMarkers[] = {
            "Ramal_Airbase"
        };
    };

    class AOs {
        // Static Bases
        class BASE {
            name = "Sirocco Base";
            type = "MainBase";

            aaDefences[] = {
                "main_aaa_1",
                "main_aa_1",
                "main_aaa_2",
                "main_aa_2"
            };

            reward_markers[] = {
                "smReward1", "smReward2", "smReward3", "smReward4",
                "smReward5", "smReward6", "smReward7", "smReward8",
                "smReward9", "smReward10", "smReward11", "smReward12",
                "smReward13", "smReward14", "smReward15", "smReward16",
                "smReward17", "smReward18", "smReward19", "smReward20",
                "smReward21", "smReward22", "smReward23", "smReward24",
                "smReward25", "smReward26", "smReward27", "smReward28",
                "smReward29", "smReward30", "smReward31", "smReward32",
                "smReward33", "smReward34", "smReward35", "smReward36"
            };

            jetspawn_markers[] = {
                "main_jetspawn_1",
                "main_jetspawn_2",
                "main_jetspawn_3",
                "main_jetspawn_4",
                "main_jetspawn_5"
            };

            class ServicePads {
                Air[] = {
                    {"main_air_service_1", {0, 0, 1}},
                    "main_air_service_2",
                    "main_air_service_3"
                };

                Ground[] = {
                    "main_ground_service_1"
                };
            };
        };

        // FOBs
        class Ramal_Airbase {
            name =  "Ramal Airbase";
            type = "Military";
            nameAlt = "FOB Good Hope";

            class ServicePads {
                Air[] = {
                    {"Ramal_Airbase_air_service_1"},
                    {"Ramal_Airbase_air_service_2", {1, 1, 1}}
                };

                Ground[] = {
                    "Ramal_Airbase_ground_service_1"
                };
            };

            class Base {
                baseType = "FOB";
                spawn = "Ramal_Airbase_pl_res";
                marker = "FOB Good Hope";
                arsenal = "Ramal_Airbase_pl_arsenal";

                vehicles[] = {
                    {"JET_CAS_WS", "Ramal_Airbase_jet_spawn", 3600},
                    {"B_Plane_Fighter_01_Stealth_F", "Ramal_Airbase_cap_spawn", 3600},
                    {"B_UAV_05_F", "Ramal_Airbase_uav_spawn", 3600},
                    {"HELI_BIG", "Ramal_Airbase_heli1", 300},
                    {"HELI_LCAS_WS", "Ramal_Airbase_heli2", 900},
                    {"B_D_Heli_Transport_01_lxWS", "Ramal_Airbase_heli3", 300},
                    {"ARMOR_TANK_WS", "Ramal_Airbase_veh1", 1800},
                    {"CAR_MRAP_WS", "Ramal_Airbase_veh2", 120},
                    {"ARMOR_IFV_WS", "Ramal_Airbase_veh3", 120},
                    {"CAR_LSV_WS", "Ramal_Airbase_veh4", 60},
                    {"CAR_LSV_WS", "Ramal_Airbase_veh5", 60},
                    {"B_D_Truck_01_fuel_lxWS", "Ramal_Airbase_veh6", 300}
                };
            };
        };

        // AOs
        class AO_Ait_Ferhat {
            name = "Ait Ferhat";
            type = "Outpost";
        };

        class AO_Ait_Khammar {
            name = "Ait Khammar";
            type = "Outpost";
        };

        class AO_Ait_Oulad {
            name = "Ait Oulad";
            type = "Town";
        };

        class AO_Al_Mahbes {
            name = "Al Mahbes";
            type = "Town";
        };

        class AO_Bir_Dakhla {
            name = "Bir Dakhla";
            type = "Town";
        };

        class AO_Bir_Tiguisit {
            name = "Bir Tiguisit";
            type = "Outpost";
        };

        class AO_Checkpoint_North {
            name = "Checkpoint North";
            type = "Outpost";
        };

        class AO_Checkpoint_South {
            name = "Checkpoint South";
            type = "Outpost";
        };

        class AO_M_Semrir {
            name = "M'Semrir";
            type = "Town";
        };

        class AO_Meharrize {
            name = "Meharrize";
            type = "Outpost";
        };

        class AO_Mhamid {
            name = "Mhamid";
            type = "Town";
        };

        class AO_Quadane {
            name = "Quadane";
            type = "Town";
        };

        class AO_Quarry {
            name = "Quarry";
            type = "Outpost";
        };

        class AO_Rissani {
            name = "Rissani";
            type = "Town";
        };

        class AO_Sand_Sea {
            name = "Sand Sea";
            type = "Military";
        };

        class AO_Singing_Dunes {
            name = "Singing Dunes";
            type = "Outpost";
        };

        class AO_Surface_mine {
            name = "Surface mine";
            type = "Outpost";
        };

        class AO_Tazzarine {
            name = "Tazzarine";
            type = "Town";
        };

        class AO_Oasis {
            name = "Oasis";
            type = "Town";
        };

       class AO_North_Point {
            name = "North Point";
            type = "Military";
        };

        class AO_Toughza {
            name = "Toughza";
            type = "Town";
        };

        class AO_Wasteland {
            name = "Wasteland";
            type = "Outpost";
        };
    };
};


class Tanoa {
    environment = "Lush";

    arsenalObjects[] = {
        "Quartermaster",
        "Main_Quartermaster_1",
        "Main_Quartermaster_2",
        "Main_Steve_1",
        "ADT_Steve_1",
        "LRA_Steve_1"
    };

    missionBlacklistPositions[] = {
        {{13200, 5300}, 500},   // Ile Saint-George
        {{8550, 1300}, 500},    // Taudua Island
        {{1600, 800}, 600},     // Imuri Island
        {{6400, 6500}, 600},    // Yani Islets
        {{3200, 9300}, 1000},   // Yasa Island(s)
        {{900, 11300}, 500},    // Ile Douen
        {{12700, 14100}, 800},  // Ravi-ta Island
        {{11050, 14550}, 700}   // Left of Ravi-ta Island
    };

    randomFactions[] = {
        "CSAT_T",
        "AAF"
    };

    class Bridges {
        class Moddergat_Savaka {
            startMarker = "InA_Bridge_1";
            bridgeMarker = "[7972,4102,0]";
            bridgePieces[] = {
                "rampDown+",
                "ramp+_4",
                "rampUp+_lampR",
                "flat_22_lampR",
                "rampUp-_lampR",
                "ramp-_5",
                "rampDown-"
            };
        };

        class Balavu_RailwayDepot {
            startMarker = "InA_Bridge_2";
            bridgeMarker = "[3545,7832,0]";
            bridgePieces[] = {
                "rampDown+",
                "ramp+_4",
                "rampUp+_lampR",
                "flat_26_lampR",
                "rampUp-_lampR",
                "ramp-_4",
                "rampDown-"
            };
        };

        class Leqa_Nani {
            startMarker = "InA_Bridge_3";
            bridgeMarker = "[4318,11310,0]";
            bridgePieces[] = {
                "rampDown+",
                "ramp+_4",
                "rampUp+_lampR",
                "flat_8_45_lampL",
                "flat_6_lampR",
                "flat_8_68_lampL",
                "flat_8_lampR",
                "rampDown+",
                "ramp+_3_lampL",
                "rampUp+",
                "flat_1_lampR",
                "rampUp-"
            };
        };

        class SaintJulien_Belfort {
            startMarker = "InA_Bridge_4";
            bridgeMarker = "[2256,9668,0]";
            bridgePieces[] = {
                "rampDown+",
                "ramp+_4_-20",
                "rampUp+_lampR",
                "flat_8_-40_lampR",
                "flat_30_lampL",
                "flat_4_-5_lampR",
                "rampUp-",
                "ramp-_4_-5_lampL",
                "rampDown-"
            };
        };
    };

    class Missions {
        SubObjs[] = {
            "AAA-Fort",
            "AA-Fort",
            //"Cache",
            "Command",
            "Comms",
            //"HQ",
            "Mobile-AAA",
            "Mortar",
            "RadioTower",
            "TankSection"
        };

        Sides[] = {
            "CBRN-Radiological",
            "Destroyer",
            "DestroyUrban",
            "FreeCivs",
            "HQ-Coast",
            "HQ-Research",
            "MilitiaCamp",
            "PilotRescue",
            "PoliceProtection",
            "Prototype-Tank",
            "SecureAsset",
            "SecureIntel-Unit",
            "SecureIntel-Vehicle",
            "SecureRadar",
            "ViperIntel",
            "LostConvoy"
        };

        Prios[] = {
            "Anti-Air",
            "Artillery",
            "Depot",
            "Factory",
            "FARP",
            "MLRS",
            "SAM",
            "ShoreBombardmentRelay"
        };
    };

    class Bases {
        staticBases[] = {
            "BASE",
            "USS_Freedom"
        };

        baseMarkers[] = {
            "adt_spawn",
            "lra_spawn"
        };
    };

    class AOs {
        // Static Bases
        class BASE {
            name = "Main Base";
            type = "MainBase";

            spawnVehicles[] = {
                {"CAR_LSV", "main_lsv1", 60},
                {"CAR_LSV", "main_lsv2", 60},
                {"CAR_LSV", "main_lsv3", 60},
                {"CAR_LSV", "main_lsv4", 60},
                {"CAR_LSV", "main_lsv5", 60},
                {"CAR_LSV", "main_lsv6", 60},
                {"B_T_VTOL_01_vehicle_F", "main_vtol1", 300}
            };

            reward_markers[] = {
                "main_reward_1", "main_reward_2", "main_reward_3", "main_reward_4",
                "main_reward_5", "main_reward_6", "main_reward_7", "main_reward_8",
                "main_reward_9", "main_reward_10", "main_reward_11", "main_reward_12"
            };

            aaDefences[] = {
                "Base_AA",
                "Base_AAA"
            };

            class ServicePads {
                Air[] = {
                    "main_service_air_1",
                    "main_service_air_2"
                };

                Ground[] = {
                    {"main_service_ground_1", {1, 1, 1}},
                    {"main_service_ground_2", {0, 1, 0}}
                };
            };
        };

        class USS_Freedom {
            name = "USS Freedom";
            type = "Carrier";

            aaDefences[] = {
                "CVN_CIWS_1",
                "CVN_CIWS_2",
                "CVN_CIWS_3",
                "CVN_RAM",
                "CVN_SAM_2",
                "CVN_SAM_3"
            };

            jetspawn_markers[] = {
                "carrier_jetspawn_1",
                "carrier_jetspawn_2",
                "carrier_jetspawn_3",
                "carrier_jetspawn_4",
                "carrier_jetspawn_5"
            };

            class ServicePads {
                Air[] = {
                    "carrier_air_service_1"
                };
            };
        };

        // FOBs
        class AO_Lifou {
            name =  "Lifou";
            type = "Town";
            nameAlt = "FOB Stronghold";

            class ServicePads {
                Air[] = {
                    "adt_service_air_1",
                    "adt_service_air_2",
                    {"adt_service_air_3", {1, 1, 1}}
                };

                Ground[] = {
                    "adt_service_ground_1",
                    {"adt_service_ground_2", {1, 1, 1}}
                };
            };

            class Base {
                baseType = "FOB";
                marker = "FOB_Stronghold";
                spawn = "adt_spawn";
                arsenal = "adt_arsenal";

                reward_markers[] = {
                    "adt_reward_1", "adt_reward_2", "adt_reward_3", "adt_reward_4",
                    "adt_reward_5", "adt_reward_6", "adt_reward_7", "adt_reward_8"
                };

                vehicles[] = {
                    {"B_Heli_Light_01_F", "adt_heli_1", 300},
                    {"B_Heli_Transport_01_F", "adt_heli_2", 300},
                    {"B_Heli_Transport_01_F", "adt_heli_3", 300},
                    {"HELI_MED", "adt_heli_4", 300},
                    {"O_Heli_Transport_04_black_F", "adt_heli_5", 300},

                    {"HELI_CAS", "adt_heli_cas_1", 3600},
                    {"JET_CAP", "adt_jet_cap_1", 1800},

                    {"CAR_LSV", "adt_lsv_1", 60},
                    {"CAR_LSV", "adt_lsv_2", 60},
                    {"CAR_LSV", "adt_lsv_3", 60},
                    {"CAR_LSV", "adt_lsv_4", 60},
                    {"CAR_LSV", "adt_lsv_5", 60},
                    {"CAR_MRAP", "adt_mrap_1", 120},
                    {"CAR_MRAP", "adt_mrap_2", 120},
                    {"CAR_MRAP", "adt_mrap_3", 120},
                    {"CAR_MRAP", "adt_mrap_4", 120},
                    {"CAR_MRAP", "adt_mrap_5", 120},

                    {"ARMOR_IFV", "adt_ifv_1", 900},
                    {"ARMOR_TANK", "adt_tank_1", 1800}
                };
            };
        };

        class AO_Aerodrome {
            name =  "La Rochelle Aerodrome";
            type = "Military";
            nameAlt = "FOB Copperhead";

            class ServicePads {
                Air[] = {
                    "lra_service_air_1",
                    "lra_service_air_2",
                    {"lra_service_air_3", {1, 1, 1}}
                };

                Ground[] = {
                    {"lra_service_ground_1", {1, 1, 1}},
                    "lra_service_ground_2"
                };
            };

            class Base {
                baseType = "FOB";
                marker = "FOB_Copperhead";
                spawn = "lra_spawn";
                arsenal = "lra_arsenal";

                reward_markers[] = {
                    "lra_reward_1", "lra_reward_2", "lra_reward_3", "lra_reward_4",
                    "lra_reward_5", "lra_reward_6", "lra_reward_7", "lra_reward_8"
                };

                vehicles[] = {
                    {"B_Heli_Light_01_F", "lra_heli_1", 300},
                    {"B_Heli_Transport_01_F", "lra_heli_2", 300},
                    {"B_Heli_Transport_01_F", "lra_heli_3", 300},
                    {"HELI_MED", "lra_heli_4", 300},

                    {"HELI_LCAS", "lra_heli_lcas_1", 900},
                    {"JET_CAS", "lra_jet_cas_1", 3600},

                    {"CAR_LSV", "lra_lsv_1", 60},
                    {"CAR_LSV", "lra_lsv_2", 60},
                    {"CAR_LSV", "lra_lsv_3", 60},
                    {"CAR_LSV", "lra_lsv_4", 60},
                    {"CAR_MRAP", "lra_mrap_1", 120},
                    {"CAR_MRAP", "lra_mrap_2", 120},
                    {"CAR_MRAP", "lra_mrap_3", 120},
                    {"CAR_MRAP", "lra_mrap_4", 120},

                    {"ARMOR_IFV", "lra_ifv_1", 900},
                    {"ARMOR_TANK", "lra_tank_1", 1800}
                };
            };
        };

        // AOs
        class AO_Balavu {
            name =  "Balavu";
            type = "Town";
        };

        class AO_BluePearlPort {
            name =  "Blue Pearl Industrial Port";
            type = "Town";
        };

        class AO_DieselPowerplant {
            name =  "Diesel Powerplant";
            type = "Town";
        };

        class AO_Georgetown {
            name =  "Georgetown";
            type = "Town";
        };

        class AO_Harcourt {
            name =  "Harcourt";
            type = "Town";
        };

        class AO_Katkoula {
            name =  "Katkoula";
            type = "Town";
        };

        class AO_Lami {
            name =  "Lami";
            type = "Town";
        };

        class AO_LaRochelle {
            name =  "La Rochelle";
            type = "Town";
        };

        class AO_Lobaka {
            name =  "Lobaka";
            type = "Town";
        };

        class AO_Luganville {
            name =  "Luganville";
            type = "Town";
        };

        class AO_Moddergat {
            name =  "Moddergat";
            type = "Town";
        };

        class AO_MontTanoa {
            name =  "Mont Tanoa";
            type = "Outpost";
        };

        class AO_Nandai {
            name =  "Nandai";
            type = "Town";
        };

        class AO_Nicolet {
            name =  "Nicolet";
            type = "Town";
        };

        class AO_Oumere {
            name =  "Ouméré";
            type = "Town";
        };

        class AO_Plantation {
            name =  "Plantation";
            type = "Outpost";
        };

        class AO_RailwayDepot {
            name =  "Railway Depot";
            type = "Outpost";
        };

        class AO_Rautake {
            name =  "Rautake";
            type = "Town";
        };

        class AO_RedspringMine {
            name =  "Red Spring Surface Mine";
            type = "Outpost";
        };

        class AO_Regina {
            name =  "Regina";
            type = "Town";
        };

        class AO_Tanouka {
            name =  "Tanouka";
            type = "Town";
        };

        class AO_TuvanakaAirbase {
            name =  "Tuvanaka Airbase";
            type = "Military";
        };

        class AO_Tavu {
            name =  "Tavu";
            type = "Town";
        };

        class AO_Tuvanaka {
            name =  "Tuvanaka";
            type = "Town";
        };

        class AO_Vagalala {
            name =  "Vagalala";
            type = "Town";
        };

        class AO_Yanukka {
            name =  "Yanukka";
            type = "Town";
        };

        class AO_Kotomo {
            name =  "Kotomo";
            type = "Town";
        };

        class AO_SaintJulien {
            name =  "Saint-Julien";
            type = "Town";
        };
    };
};


class Malden {
    arsenalObjects[] = {
        "Quartermaster",
        "Quartermaster_1",
        "Quartermaster_2",
        "Quartermaster_3"
    };

    missionBlacklistPositions[] = {};

    randomFactions[] = {
        "CSAT",
        "AAF"
    };

    class Missions {
        SubObjs[] = {
            "RadioTower",
            "TankSection"
        };

        Sides[] = {
            "Destroyer",
            "DestroyUrban",
            "MilitiaCamp",
            "PilotRescue",
            "SecureAsset",
            "LostConvoy"
        };

        Prios[] = {
            "Anti-Air",
            "Artillery"
        };
    };

    class Bases {
        staticBases[] = {
            "BASE",
            "USS_Freedom"
        };

        baseMarkers[] = {
            "mikael_pl_res"
        };
    };

    class AOs {
        // Static Bases
        class BASE {
            name = "Main Base";
            type = "MainBase";

            aaDefences[] = {
                "Base_AA"
            };

            reward_markers[] = {
                "smReward_01", "smReward_02", "smReward_03", "smReward_04",
                "smReward_05", "smReward_06", "smReward_07", "smReward_08",
                "smReward_09", "smReward_10", "smReward_11", "smReward_12",
                "smReward_13", "smReward_14", "smReward_15", "smReward_16",
                "smReward_17", "smReward_18", "smReward_19", "smReward_20",
                "smReward_21", "smReward_22", "smReward_23", "smReward_24",
                "smReward_25", "smReward_26", "smReward_27", "smReward_28",
                "smReward_29", "smReward_30", "smReward_31", "smReward_32",
                "smReward_33", "smReward_34", "smReward_35", "smReward_36"
            };

            class ServicePads {
                
                Air[] = {
                    {"main_air_service_1", {0, 0, 0}}
                };

                Ground[] = {
                    "main_ground_service_1"
                };
            };
        };

        class USS_Freedom {
            name = "USS Freedom";
            type = "Carrier";
               
            aaDefences[] = {
                "CVN_CIWS_1",
                "CVN_CIWS_2",
                "CVN_CIWS_3",
                "CVN_RAM",
                "CVN_SAM_2",
                "CVN_SAM_3"
            };
             
            jetspawn_markers[] = {
                "carrier_jetspawn_1",
                "carrier_jetspawn_2",
                "carrier_jetspawn_3",
                "carrier_jetspawn_4",
                "carrier_jetspawn_5"
            };

            class ServicePads {
                Air[] = {
                    "carrier_air_service_01"
                };
            };
        };

        // FOBs
        class AO_Airport {
            name =  "Airport";
            type = "Military";
            nameAlt = "FOB Mikael";

            class ServicePads {
                Air[] = {
                    {"mikael_air_service_01", {0, 0, 0}},
                    {"mikael_air_service_02", {0, 0, 0}},
                    {"mikael_air_service_03", {0, 0, 0}}
                };

                Ground[] = {
                    "mikael_ground_service_01"
                };
            };

            class Base {
                baseType = "FOB";
                spawn = "mikael_pl_res";
                marker = "FOB_Mikael";
                arsenal = "mikael_pl_arsenal";

                reward_markers[] = {
                    "mikael_rewards_01", "mikael_rewards_02", "mikael_rewards_03", "mikael_rewards_04",
                    "mikael_rewards_05", "mikael_rewards_06", "mikael_rewards_07", "mikael_rewards_08",
                    "mikael_rewards_09", "mikael_rewards_10", "mikael_rewards_11", "mikael_rewards_12",
                    "mikael_rewards_13", "mikael_rewards_14", "mikael_rewards_15", "mikael_rewards_16",
                    "mikael_rewards_17", "mikael_rewards_18", "mikael_rewards_19", "mikael_rewards_20",
                    "mikael_rewards_21", "mikael_rewards_22", "mikael_rewards_23", "mikael_rewards_24"
                };

                vehicles[] = {
                    {"JET_CAP", "mikael_cap_01", 1800},
                    {"JET_CAS", "mikael_cas_01", 3600},
                    {"B_Heli_Light_01_F", "mikael_heli_01", 300},
                    {"HELI_MED", "mikael_heli_02", 300},
                    {"HELI_MED", "mikael_heli_03", 300},
                    {"HELI_BIG", "mikael_heli_04", 300},
                    {"HELI_LCAS", "mikael_heli_05", 900},
                    {"HELI_CAS", "mikael_heli_06", 3600},
                    {"CAR_LSV", "mikael_car_01", 60},
                    {"CAR_LSV", "mikael_car_02", 60},
                    {"CAR_LSV", "mikael_car_03", 60},
                    {"CAR_LSV", "mikael_car_04", 60},
                    {"CAR_LSV",  "mikael_car_05", 60},
                    {"CAR_LSV",  "mikael_car_06", 60},
                    {"CAR_MRAP", "mikael_mrap_01", 120},
                    {"CAR_MRAP", "mikael_mrap_02", 120},
                    {"CAR_MRAP", "mikael_mrap_03", 120},
                    {"CAR_MRAP", "mikael_mrap_04", 120},
                    {"CAR_MRAP", "mikael_mrap_05", 120},
                    {"CAR_MRAP", "mikael_mrap_06", 120},
                    {"ARMOR_TANK", "mikael_tank_01", 1800}
                };
            };
        };

        // AOs
        class AO_Arette {
            name = "Arette";
            type = "Coastline";
        };

        class AO_Arudy {
            name = "Arudy";
            type = "Town";
        };

        class AO_Cancon {
            name = "Cancon";
            type = "Town";
        };

        class AO_Chapoi {
            name = "Chapoi";
            type = "Town";
        };

        class AO_Corton {
            name = "Corton";
            type = "Field";
        };

        class AO_Dourdan {
            name = "Dourdan";
            type = "Town";
        };

        class AO_Faro {
            name = "Faro";
            type = "Field";
        };

        class AO_Goisse {
            name = "Goisse";
            type = "Town";
        };

        class AO_Houdan {
            name = "Houdan";
            type = "Town";
        };

        class AO_La_Pessagne {
            name = "La Pessagne";
            type = "Town";
        };

        class AO_La_Riviere {
            name = "La Riviere";
            type = "Town";
        };

        class AO_La_Trinite {
            name = "La Trinite";
            type = "Town";
        };

        class AO_Larche {
            name = "Larche";
            type = "Town";
        };

        class AO_Lavalle {
            name = "Larche";
            type = "Town";
        };

        class AO_Le_Port {
            name = "Le Port";
            type = "Town";
        };    

        class AO_Lolisse {
            name = "Lolisse";
            type = "Town";
        };      

        class AO_Military_Base {
            name = "Military Base";
            type = "Military";
        };   

        class AO_Mount_Chauve {
            name = "Mount Chauve";
            type = "Field";
        };    

        class AO_Pic_de_Feas {
            name = "Pic de Feas";
            type = "Field";
        };  

        class AO_Power_Plant {
            name = "Le Port Power Plant";
            type = "Coastline";
        }; 

        class AO_Radio_Station {
            name = "Radio Station";
            type = "Military";
        };   

        class AO_Saint_Jean {
            name = "Saint Jean";
            type = "Field";
        };  

        class AO_Saint_Louis {
            name = "Saint Louis";
            type = "Town";
        };  

        class AO_Saint_Martin {
            name = "Saint Martin";
            type = "Field";
        };   

        class AO_Sainte_Marie {
            name = "Sainte Marie";
            type = "Town";
        };
    };
};
