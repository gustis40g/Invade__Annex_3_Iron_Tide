/*
 * Author: Whigital
 * Description:
 * Defines vehicle apperance hashtables variables containing
 * skin/texture/component data for different environments
 *
 */

if (!isServer) exitWith {};

if (isNil "InA_Server_VehicleApperanceDefined") then {
    InA_Server_VehicleApperanceDefined = false;
};

if (InA_Server_VehicleApperanceDefined) exitWith {};


// Get map environment type
if (isNil "InA_Server_MapEnvType") then {
    InA_Server_MapEnvType = (call {
        private _env = ((missionConfigFile >> worldName >> "environment") call BIS_fnc_getCfgData);

        if (!isNil "_env") then {
            _env
        } else {
            "Default"
        }
    });
};


// Setup HashMaps for vehicle apperance data
InA_Server_VehicleApperanceHash = createHashMap;
InA_Server_VehicleApperanceOPFHash = createHashMap;

// BLUFOR apperance definitions
InA_Server_VehicleApperanceHash insert [
    // F/A-181 Black Wasp II
    ["B_Plane_Fighter_01_F", createHashMapFromArray [
        ["Default", ["DarkGrey", "DarkGreyCamo"]]
    ]],

    // F/A-181 Black Wasp II (Stealth)
    ["B_Plane_Fighter_01_Stealth_F", createHashMapFromArray [
        ["Default", ["DarkGrey", "DarkGreyCamo"]]
    ]],

    // A-149 Gryphon
    ["I_Plane_Fighter_04_F", createHashMapFromArray [
        ["Default", ["CamoGrey", "DigitalCamoGrey"]]
    ]],

    // To-201 Shikra
    ["O_Plane_Fighter_02_F", createHashMapFromArray [
        ["Default", ["CamoGreyHex"]]
    ]],

    // To-201 Shikra (Stealth)
    ["O_Plane_Fighter_02_Stealth_F", createHashMapFromArray [
        ["Default", ["CamoGreyHex"]]
    ]],

    // A-143 Buzzard
    ["I_Plane_Fighter_03_dynamicLoadout_F", createHashMapFromArray [
        ["Default", ["Grey"]]
    ]],

    // UCAV Sentinel
    ["B_UAV_05_F", createHashMapFromArray [
        ["#components", ["wing_fold_l", 1]],

        ["Default", ["DarkGrey", "DarkGreyCamo"]]
    ]],

    // MQ-4A Greyhawk
    ["B_UAV_02_dynamicLoadout_F", createHashMapFromArray [
        ["Default", ["Blufor", "Indep"]]
    ]],

    // AR-2 Darter
    ["B_UAV_01_F", createHashMapFromArray [
        ["Default", ["Blufor", "Indep", "EAF"]]
    ]],

    // AL-6 Pelican
    ["B_UAV_06_F", createHashMapFromArray [
        ["Default", ["Blufor", "Civ", "EAF"]]
    ]],

    // AL-6 Pelican (Medical)
    ["B_UAV_06_medical_F", createHashMapFromArray [
        ["Default", ["Blufor", "Indfor", "EAF"]]
    ]],

    // AH-99 Blackfoot
    ["B_Heli_Attack_01_dynamicLoadout_F", createHashMapFromArray [
        ["Default", [
            ["A3\Air_F_Beta\heli_attack_01\data\heli_attack_01_co.paa"],
            ["A3\Air_F\Heli_Light_02\Data\heli_light_02_common_co.paa"]
        ]]
    ]],

    // AH-9 Pawnee
    ["B_Heli_Light_01_dynamicLoadout_F", createHashMapFromArray [
        ["Default", [
            ["A3\Air_F\Heli_Light_01\Data\Heli_Light_01_ext_BLUFOR_CO.paa"],
            ["A3\Air_F\Heli_Light_01\Data\Heli_Light_01_ext_ION_CO.paa"]
        ]]
    ]],

    // WY-55 Hellcat
    ["I_Heli_light_03_dynamicLoadout_F", createHashMapFromArray [
        ["Default", ["Green"]]
    ]],

    // PO-30 Orca
    ["O_Heli_Light_02_dynamicLoadout_F", createHashMapFromArray [
        ["Default", ["Black"]]
    ]],

    // V-44 X Blackfish (Armed)
    ["B_T_VTOL_01_armed_F", createHashMapFromArray [
        ["Default", ["Olive", "Blue"]]
    ]],

    // Y-32 Xi'an (Infantry transport)
    ["O_T_VTOL_02_infantry_dynamicLoadout_F", createHashMapFromArray [
        ["Default", [
            [
                "\A3\Air_F_Exp\VTOL_02\Data\VTOL_02_EXT01_CO.paa",
                "\A3\Air_F_Exp\VTOL_02\Data\VTOL_02_EXT02_CO.paa",
                "\A3\Air_F_Exp\VTOL_02\Data\VTOL_02_EXT03_L_CO.paa",
                "\A3\Air_F_Exp\VTOL_02\Data\VTOL_02_EXT03_R_CO.paa"
            ]
        ]]
    ]],

    // Y-32 Xi'an (Vehicle transport)
    ["O_T_VTOL_02_vehicle_dynamicLoadout_F", createHashMapFromArray [
        ["Default", [
            [
                "\A3\Air_F_Exp\VTOL_02\Data\VTOL_02_EXT01_CO.paa",
                "\A3\Air_F_Exp\VTOL_02\Data\VTOL_02_EXT02_CO.paa",
                "\A3\Air_F_Exp\VTOL_02\Data\VTOL_02_EXT03_L_CO.paa",
                "\A3\Air_F_Exp\VTOL_02\Data\VTOL_02_EXT03_R_CO.paa"
            ]
        ]]
    ]],

    // MH-9 Hummingbird
    ["B_Heli_Light_01_F", createHashMapFromArray [
        ["Default", [
            ["A3\Air_F\Heli_Light_01\Data\Heli_Light_01_ext_BLUFOR_CO.paa"],
            ["A3\Air_F\Heli_Light_01\Data\Heli_Light_01_ext_ION_CO.paa"]
        ]]
    ]],

    // UH-80 Ghosthawk
    ["B_Heli_Transport_01_F", createHashMapFromArray [
        ["Default", ["Black", "Green", "Olive", "Sand"]]
    ]],

    // CH-67 Huron (Unarmed)
    ["B_Heli_Transport_03_unarmed_F", createHashMapFromArray [
        ["Default", ["Black", "Green"]]
    ]],

    // CH-49 Mohawk
    ["I_Heli_Transport_02_F", createHashMapFromArray [
        ["Default", [
            [
                "#(argb,16,16,1)color(0.08,0.095,0.08,1)",
                "#(argb,16,16,1)color(0.08,0.095,0.08,1)",
                "#(argb,16,16,1)color(0.08,0.095,0.08,1)"
            ],
            [
                "#(argb,16,16,1)color(0.08,0.08,0.085,1)",
                "#(argb,16,16,1)color(0.08,0.08,0.085,1)",
                "#(argb,16,16,1)color(0.08,0.08,0.085,1)"
            ]
        ]]
    ]],

    // Praetorian 1C
    ["B_AAA_System_01_F", createHashMapFromArray [
        ["Default", ["Sand"]],
        ["Lush", ["Green"]]
    ]],

    // Mk49 Spartan
    ["B_SAM_System_01_F", createHashMapFromArray [
        ["Default", ["Sand"]],
        ["Lush", ["Green"]]
    ]],

    // Mk21 Centurion
    ["B_SAM_System_02_F", createHashMapFromArray [
        ["Default", ["Sand"]],
        ["Lush", ["Green"]]
    ]],

    // T-140K Angara
    ["O_MBT_04_command_F", createHashMapFromArray [
        ["#components", ["showCamonetHull", 0.5, "showCamonetTurret", 0.5]],

        ["Default", ["Jungle", "Grey"]]
    ]],

    // T-140 Angara
    ["O_MBT_04_cannon_F", createHashMapFromArray [
        ["#components", ["showCamonetHull", 0.5, "showCamonetTurret", 0.5]],

        ["Default", ["Jungle", "Grey"]]
    ]],

    // M2A4 Slammer
    ["B_MBT_01_cannon_F", createHashMapFromArray [
        ["#components", ["showBags", 0, "showCamonetTurret", 0.5, "showCamonetHull", 0.5]],

        ["Default", ["Sand"]],
        ["Lush", ["Olive"]]
    ]],

    // M2A4 Slammer (Urban Purpose)
    ["B_MBT_01_TUSK_F", createHashMapFromArray [
        ["#components", ["showBags", 0, "showCamonetTurret", 0.5, "showCamonetHull", 0.5]],

        ["Default", ["Sand"]],
        ["Lush", ["Olive"]]
    ]],

    // MBT-52 Kuma
    ["I_MBT_03_cannon_F", createHashMapFromArray [
        ["#components", ["HideTurret", 1, "HideHull", 1, "showCamonetHull", 1, "showCamonetTurret", 1]],

        ["Default", [
            [
                "#(argb,16,16,1)color(0.08,0.088,0.075,1)",
                "#(argb,16,16,1)color(0.095,0.09,0.085,1)",
                "#(argb,16,16,1)color(0.07,0.075,0.07,1)",
                "a3\Armor_F\Data\camonet_NATO_Green_CO.paa"
            ]
        ]]
    ]],

    // T-100 Varsuk
    ["O_MBT_02_cannon_F", createHashMapFromArray [
        ["#components", ["showCamonetHull", 1, "showCamonetTurret", 1, "showLog", 0.5]],

        ["Default", [
            [
                "#(argb,16,16,1)color(0.076,0.084,0.076,1)",
                "#(argb,16,16,1)color(0.0828,0.081,0.072,1)",
                "#(argb,16,16,1)color(0.0828,0.081,0.072,1)",
                "a3\armor_f\Data\camonet_AAF_stripe_green_CO.paa"
            ]
        ]]
    ]],

    // AFV-4 Gorgon
    ["I_APC_Wheeled_03_cannon_F", createHashMapFromArray [
        ["#components", ["showCamonetHull", 0.5, "showBags", 0, "showBags2", 0, "showTools", 0, "showSLATHull", 0.5]],

        ["Default", ["Guerilla_02", "#TEX#_NATO"]],
        ["Lush", ["Guerilla_01", "Guerilla_03"]],

        ["#TEX#_NATO", [
            [
                "A3\Armor_F_Gamma\APC_Wheeled_03\Data\apc_wheeled_03_ext_co.paa",
                "A3\Armor_F_Gamma\APC_Wheeled_03\Data\apc_wheeled_03_ext2_co.paa",
                "A3\Armor_F_Gamma\APC_Wheeled_03\Data\rcws30_co.paa",
                "A3\Armor_F_Gamma\APC_Wheeled_03\Data\apc_wheeled_03_ext_alpha_co.paa",
                "a3\Armor_F\Data\camonet_NATO_Desert_CO.paa",
                "a3\Armor_F\Data\cage_sand_CO.paa"
            ]
        ]]
    ]],

    // AWC 301 Nyx (AT)
    ["I_LT_01_AT_F", createHashMapFromArray [
        ["#components", ["showTools", 0, "showCamonetHull", 0.5, "showBags", 0, "showSLATHull", 0.5]],

        ["Default", ["Indep_Olive"]]
    ]],

    // AWC 303 Nyx (Recon)
    ["I_LT_01_scout_F", createHashMapFromArray [
        ["#components", ["showTools", 0, "showCamonetHull", 0.5, "showBags", 0, "showSLATHull", 0.5]],

        ["Default", ["Indep_Olive"]]
    ]],

    // AWC 302 Nyx (AA)
    ["I_LT_01_AA_F", createHashMapFromArray [
        ["#components", ["showTools", 0, "showCamonetHull", 0.5, "showBags", 0, "showSLATHull", 0.5]],

        ["Default", ["Indep_Olive"]]
    ]],

    // AWC 304 Nyx (Autocannon)
    ["I_LT_01_cannon_F", createHashMapFromArray [
        ["#components", ["showTools", 0, "showCamonetHull", 0.5, "showBags", 0, "showSLATHull", 0.5]],

        ["Default", ["Indep_Olive"]]
    ]],

    // FV-720 Mora
    ["I_APC_tracked_03_cannon_F", createHashMapFromArray [
        ["#components", ["showBags", 0, "showBags2", 0, "showCamonetHull", 0.5, "showCamonetTurret", 1, "showTools", 0, "showSLATHull", 0.5, "showSLATTurret", 0.5]],

        ["Default", ["EAF_01"]]
    ]],

    // BTR-K Kamysh
    ["O_APC_Tracked_02_cannon_F", createHashMapFromArray [
        ["#components", ["showTracks", 0, "showCamonetHull", 1, "showBags", 0, "showSLATHull", 0.5]],

        ["Default", [
            [
                "#(argb,16,16,1)color(0.08,0.095,0.08,1)",
                "#(argb,16,16,1)color(0.08,0.08,0.085,1)",
                "#(argb,16,16,1)color(0.0875,0.0875,0.0875,1)",
                "a3\armor_f\Data\camonet_AAF_stripe_desert_CO.paa",
                "a3\armor_f\Data\cage_sand_CO.paa"
            ]
        ]]
    ]],

    // AMV-7 Marshall
    ["B_APC_Wheeled_01_cannon_F", createHashMapFromArray [
        ["#components", ["showBags", 1, "showCamonetHull", 0.5, "showCamonetTurret", 1, "showSLATHull", 0.5, "showSLATTurret", 0.5]],

        ["Default", ["Sand"]],
        ["Lush", ["Olive"]]
    ]],

    // ZSU-39 Tigris
    ["O_APC_Tracked_02_AA_F", createHashMapFromArray [
        ["#components", ["showTracks", 0, "showCamonetHull", 1, "showCamonetTurret", 0.5, "showSLATHull", 0.5]],

        ["Default", [
            [
                "#(argb,16,16,1)color(0.09075,0.09375,0.09075,1)",
                "#(argb,16,16,1)color(0.09075,0.09375,0.09075,1)",
                "#(argb,16,16,1)color(0.085,0.098,0.085,1)",
                "a3\armor_f\Data\camonet_greenbeige_co.paa",
                "a3\armor_f\Data\cage_G1_CO.paa"
            ]
        ]]
    ]],

    // IFV-6a Cheetah
    ["B_APC_Tracked_01_AA_F", createHashMapFromArray [
        ["#components", ["showCamonetTurret", 0.5, "showCamonetHull", 0.5, "showBags", 0]],

        ["Default", ["Sand"]],
        ["Lush", ["Olive"]]
    ]],

    // MSE-3 Marid
    ["O_APC_Wheeled_02_rcws_v2_F", createHashMapFromArray [
        ["#components", ["showBags", 0, "showCanisters", 0, "showTools", 0, "showCamonetHull", 1, "showSLATHull", 0.5]],

        ["Default", [
            [
                "#(argb,16,16,1)color(0.08,0.09,0.08,1)",
                "#(argb,16,16,1)color(0.0875,0.0875,0.0875,1)",
                "#(argb,16,16,1)color(0.0875,0.0875,0.0975,1)",
                "a3\armor_f\Data\camonet_AAF_stripe_green_CO.paa",
                "a3\armor_f\Data\cage_G1_CO.paa"
            ]
        ]]
    ]],

    // Rhino MGS
    ["B_AFV_Wheeled_01_cannon_F", createHashMapFromArray [
        ["#components", ["showCamonetHull", 0.5, "showCamonetTurret", 1, "showSLATHull", 0.5]],

        ["Default", ["Sand"]],
        ["Lush", ["Green"]]
    ]],

    // Rhino MGS (Urban Purpose)
    ["B_AFV_Wheeled_01_up_cannon_F", createHashMapFromArray [
        ["#components", ["showCamonetHull", 0.5, "showCamonetTurret", 1, "showSLATHull", 0.5]],

        ["Default", ["Sand"]],
        ["Lush", ["Green"]]
    ]],

    // CRV-6e Bobcat
    ["B_APC_Tracked_01_CRV_F", createHashMapFromArray [
        ["#components", ["showAmmobox", 1, "showWheels", 1, "showCamonetHull", 0.5, "showBags", 1]],

        ["Default", ["Sand"]],
        ["Lush", ["Olive"]]
    ]],

    // HEMTT (Ammo)
    ["B_Truck_01_ammo_F", createHashMapFromArray [
        ["Default", ["Blufor"]],
        ["Lush", ["Olive"]]
    ]],

    // HEMTT (Fuel)
    ["B_Truck_01_fuel_F", createHashMapFromArray [
        ["Default", ["Blufor"]],
        ["Lush", ["Olive"]]
    ]],

    // HEMTT (Repair)
    ["B_Truck_01_Repair_F", createHashMapFromArray [
        ["Default", ["Blufor"]],
        ["Lush", ["Olive"]]
    ]],

    // HEMTT (Medical)
    ["B_Truck_01_medical_F", createHashMapFromArray [
        ["Default", ["Blufor"]],
        ["Lush", ["Olive"]]
    ]],

    // Strider HMG
    ["I_MRAP_03_F", createHashMapFromArray [
        ["Default", ["Blufor"]],
        ["Lush", ["Indep"]]
    ]],

    // Strider HMG
    ["I_MRAP_03_hmg_F", createHashMapFromArray [
        ["Default", ["Blufor"]],
        ["Lush", ["Indep"]]
    ]],

    // Strider GMG
    ["I_MRAP_03_gmg_F", createHashMapFromArray [
        ["Default", ["Blufor"]],
        ["Lush", ["Indep"]]
    ]],

    // Hunter
    ["B_MRAP_01_F", createHashMapFromArray [
        ["Default", ["Blufor"]],
        ["Lush", ["Olive"]]
    ]],

    // Hunter HMG
    ["B_MRAP_01_hmg_F", createHashMapFromArray [
        ["Default", ["Blufor"]],
        ["Lush", ["Olive"]]
    ]],

    // Hunter GMG
    ["B_MRAP_01_gmg_F", createHashMapFromArray [
        ["Default", ["Blufor"]],
        ["Lush", ["Olive"]]
    ]],

    // Qilin (AT)
    ["O_LSV_02_AT_F", createHashMapFromArray [
        ["Default", ["Black"]]
    ]],

    // Qilin (Minigun)
    ["O_LSV_02_armed_F", createHashMapFromArray [
        ["Default", ["Black"]]
    ]],

    // Offroad (HMG)
    ["B_G_Offroad_01_armed_F", createHashMapFromArray [
        ["#components", ["HideDoor1", 0, "HideDoor2", 0, "HideDoor3", 0, "HideBackpacks", 0.5, "HideBumper1", 0, "HideBumper2", 1, "HideConstruction", 0.5]],

        ["Default", ["Guerilla_02", "Guerilla_03", "Guerilla_07", "Guerilla_12"]],
        ["Lush", ["Guerilla_01", "Guerilla_04", "Guerilla_08", "Guerilla_09"]]
    ]],

    // Offroad
    ["B_G_Offroad_01_F", createHashMapFromArray [
        ["#components", ["HideDoor1", 0, "HideDoor2", 0, "HideDoor3", 0, "HideBackpacks", 0.5, "HideBumper1", 0, "HideBumper2", 1, "HideConstruction", 0.5]],

        ["Default", ["Guerilla_02", "Guerilla_03", "Guerilla_07", "Guerilla_12"]],
        ["Lush", ["Guerilla_01", "Guerilla_04", "Guerilla_08", "Guerilla_09"]]
    ]],

    // Offroad (Repair)
    ["B_G_Offroad_01_repair_F", createHashMapFromArray [
        ["#components", ["BeaconsServicesStart", 0, "HideDoor1", 0, "HideDoor2", 0, "HideDoor3", 0.5]],

        ["Default", ["Guerilla_02", "Guerilla_03", "Guerilla_07", "Guerilla_12"]],
        ["Lush", ["Guerilla_01", "Guerilla_04", "Guerilla_08", "Guerilla_09"]]
    ]],

    // Offroad (AT)
    ["B_G_Offroad_01_AT_F", createHashMapFromArray [
        ["#components", ["HideDoor1", 0, "HideDoor2", 0, "HideDoor3", 0, "HideBackpacks", 0.5, "HideBumper1", 0, "HideBumper2", 1, "HideConstruction", 0.5]],

        ["Default", ["Guerilla_02", "Guerilla_03", "Guerilla_07", "Guerilla_12"]],
        ["Lush", ["Guerilla_01", "Guerilla_04", "Guerilla_08", "Guerilla_09"]]
    ]],

    // MB 4WD (AT)
    ["I_C_Offroad_02_AT_F", createHashMapFromArray [
        ["#components", ["hideLeftDoor", 0, "hideRightDoor", 0, "hideRearDoor", 0.5, "hideFenders", 0, "hideHeadSupportFront", 0, "hideSpareWheel", 0.5]],

        ["Default", ["Black", "Brown", "Green", "Olive"]]
    ]],

    // MB 4WD (LMG)
    ["I_C_Offroad_02_LMG_F", createHashMapFromArray [
        ["#components", ["hideLeftDoor", 0, "hideRightDoor", 0, "hideRearDoor", 0.5, "hideFenders", 0, "hideHeadSupportFront", 0, "hideSpareWheel", 0.5]],

        ["Default", ["Black", "Brown", "Green", "Olive"]]
    ]],

    // Van (Services)
    ["C_Van_02_service_F", createHashMapFromArray [
        ["#components", ["Door_1_source", 0, "Door_2_source", 0, "Door_3_source", 0, "Door_4_source", 0, "Hide_Door_1_source", 0, "Hide_Door_2_source", 0, "Hide_Door_3_source", 0, "Hide_Door_4_source", 0, "lights_em_hide", 0, "ladder_hide", 1, "spare_tyre_holder_hide", 1, "spare_tyre_hide", 1, "reflective_tape_hide", 1, "roof_rack_hide", 1, "LED_lights_hide", 0, "sidesteps_hide", 0, "rearsteps_hide", 0, "side_protective_frame_hide", 1, "front_protective_frame_hide", 1, "beacon_front_hide", 0, "beacon_rear_hide", 0]],

        ["Default", ["Black", "Green", "FIA1", "FIA2"]]
    ]],

    // Van (Ambulance)
    ["C_Van_02_medevac_F", createHashMapFromArray [
        ["#components", ["Door_1_source", 0, "Door_2_source", 0, "Door_3_source", 0, "Door_4_source", 0, "Hide_Door_1_source", 0, "Hide_Door_2_source", 0, "Hide_Door_3_source", 0, "Hide_Door_4_source", 0, "lights_em_hide", 0, "ladder_hide", 1, "spare_tyre_holder_hide", 1, "spare_tyre_hide", 1, "reflective_tape_hide", 0, "roof_rack_hide", 1, "LED_lights_hide", 0, "sidesteps_hide", 0, "rearsteps_hide", 0, "side_protective_frame_hide", 1, "front_protective_frame_hide", 1, "beacon_front_hide", 0, "beacon_rear_hide", 0]],

        ["Default", ["CivAmbulance", "IdapAmbulance"]]
    ]],

    // Prowler (Light)
    ["B_CTRG_LSV_01_light_F", createHashMapFromArray [
        ["#components", ["HideDoor1", 1, "HideDoor2", 1, "HideDoor3", 1, "HideDoor4", 1]],

        ["Default", ["Black", "Sand"]],
        ["Lush", ["Black", "Olive", "Dazzle"]]
    ]],

    // Prowler (Unarmed)
    ["B_LSV_01_unarmed_F", createHashMapFromArray [
        ["#components", ["HideDoor1", 0, "HideDoor2", 1, "HideDoor3", 0, "HideDoor4", 1]],

        ["Default", ["Black", "Sand"]],
        ["Lush", ["Black", "Olive", "Dazzle"]]
    ]],

    // Prowler (HMG)
    ["B_LSV_01_armed_F", createHashMapFromArray [
        ["#components", ["HideDoor1", 0, "HideDoor2", 0, "HideDoor3", 0, "HideDoor4", 0]],

        ["Default", ["Black", "Sand"]],
        ["Lush", ["Black", "Olive", "Dazzle"]]
    ]],

    // Prowler (AT)
    ["B_LSV_01_AT_F", createHashMapFromArray [
        ["#components", ["HideDoor1", 1, "HideDoor2", 0, "HideDoor3", 1, "HideDoor4", 0]],

        ["Default", ["Black", "Sand"]],
        ["Lush", ["Black", "Olive", "Dazzle"]]
    ]],

    // Quadbike
    ["B_Quadbike_01_F", createHashMapFromArray [
        ["Default", ["Black", "Blufor", "Guerrilla_01"]],
        ["Lush", ["Black", "Olive"]]
    ]],

    // Kart
    ["C_Kart_01_F", createHashMapFromArray [
        ["Default", ["Black", "Green", "Orange", "Red", "Yellow"]]
    ]],

    // Speedboat Minigun
    ["B_Boat_Armed_01_minigun_F", createHashMapFromArray [
        ["Default", ["Blufor", "Indep"]]
    ]],

    // Assault Boat
    ["B_Boat_Transport_01_F", createHashMapFromArray [
        ["Default", ["Black", "Digital"]]
    ]],

    // Motorboat
    ["C_Boat_Civil_01_F", createHashMapFromArray [
        ["Default", ["Civilian", "Rescue"]]
    ]],

    // Water Scooter
    ["C_Scooter_Transport_01_F", createHashMapFromArray [
        ["Default", ["Grey", "Lime", "Blue", "White"]]
    ]],

    // SDV
    ["B_SDV_01_F", createHashMapFromArray [
        ["Default", [
            ["\A3\boat_f_beta\SDV_01\data\SDV_ext_CO.paa"],
            ["\A3\boat_f_beta\SDV_01\data\SDV_ext_INDP_CO.paa"]
        ]]
    ]]
];


// OPFOR apperance definitions
InA_Server_VehicleApperanceOPFHash insert [
    // To-201 Shikra
    ["O_Plane_Fighter_02_F", createHashMapFromArray [
        ["Default", ["CamoAridHex", "CamoBlue"]]
    ]],

    // To-201 Shikra (Stealth)
    ["O_Plane_Fighter_02_Stealth_F", createHashMapFromArray [
        ["Default", ["CamoAridHex", "CamoBlue"]]
    ]],

    // A-143 Buzzard (CAS)
    ["I_Plane_Fighter_03_dynamicLoadout_F", createHashMapFromArray [
        ["Default", [
            [
                "A3\Air_F_Gamma\Plane_Fighter_03\Data\Plane_Fighter_03_body_1_brownhex_CO.paa",
                "A3\Air_F_Gamma\Plane_Fighter_03\Data\Plane_Fighter_03_body_2_brownhex_CO.paa"
            ]
        ]],
        ["Lush", [
            [
                "A3\Air_F_Gamma\Plane_Fighter_03\Data\Plane_Fighter_03_body_1_INDP_co.paa",
                "A3\Air_F_Gamma\Plane_Fighter_03\Data\Plane_Fighter_03_body_2_INDP_co.paa"
            ]
        ]]
    ]],

    // PO-30 Orca
    ["O_Heli_Light_02_dynamicLoadout_F", createHashMapFromArray [
        ["Default", [["A3\Air_F\Heli_Light_02\Data\Heli_Light_02_ext_OPFOR_CO.paa"]]],
        ["Lush", [["A3\air_f\Heli_Light_02\Data\heli_light_02_ext_indp_co.paa"]]]
    ]],

    // Y-32 Xi'an (Infantry Transport)
    ["O_T_VTOL_02_infantry_dynamicLoadout_F", createHashMapFromArray [
        ["Default", ["Hex"]],
        ["Lush", ["GreenHex"]]
    ]],

    // PO-30 Orca (Unarmed)
    ["O_Heli_Light_02_unarmed_F", createHashMapFromArray [
        ["Default", [["A3\Air_F\Heli_Light_02\Data\Heli_Light_02_ext_OPFOR_CO.paa"]]],
        ["Lush", [["A3\air_f\Heli_Light_02\Data\heli_light_02_ext_indp_co.paa"]]]
    ]],

    // WY-55 Hellcat (Unarmed)
    ["I_Heli_light_03_unarmed_F", createHashMapFromArray [
        ["Default", ["Indep"]]
    ]],

    // Qilin (Minigun)
    ["O_LSV_02_armed_F", createHashMapFromArray [
        ["#components", ["Unarmed_Doors_Hide", 0.5]],

        ["Default", ["Arid"]],
        ["Lush", ["GreenHex"]]
    ]],

    // Ifrit HMG
    ["O_MRAP_02_hmg_F", createHashMapFromArray [
        ["Default", ["Hex"]],
        ["Lush", ["GreenHex"]]
    ]],

    // Ifrit GMG
    ["O_MRAP_02_gmg_F", createHashMapFromArray [
        ["Default", ["Hex"]],
        ["Lush", ["GreenHex"]]
    ]],

    // Offroad (HMG)
    ["O_G_Offroad_01_armed_F", createHashMapFromArray [
        ["#components", ["Hide_Shield", 0.5, "Hide_Rail", 1, "HideDoor1", 0, "HideDoor2", 0, "HideDoor3", 0.5, "HideBackpacks", 0.5, "HideBumper1", 0, "HideBumper2", 1, "HideConstruction", 0.5]],

        ["Default", ["Guerilla_06", "Guerilla_10", "Guerilla_11"]],
        ["Lush", ["Green", "Guerilla_01", "Guerilla_05", "EAF"]]
    ]],

    // Tempest Transport
    ["O_Truck_03_transport_F", createHashMapFromArray [
        ["Default", ["Hex"]],
        ["Lush", ["GreenHex"]]
    ]],

    // Tempest Ammo
    ["O_Truck_03_ammo_F", createHashMapFromArray [
        ["Default", ["Hex"]],
        ["Lush", ["GreenHex"]]
    ]],

    // Zamak Ammo
    ["O_Truck_02_Ammo_F", createHashMapFromArray [
        ["Default", ["Opfor"]],
        ["Lush", ["GreenHex"]]
    ]],

    // AWC 301 Nyx (AT)
    ["I_LT_01_AT_F", createHashMapFromArray [
        ["#components", ["showTools", 0, "showCamonetHull", 0.5, "showBags", 0, "showSLATHull", 0.5]],

        ["Default", ["Indep_01", "Indep_03"]],
        ["Lush", ["Indep_02"]]
    ]],

    // AWC 302 Nyx (AA)
    ["I_LT_01_AA_F", createHashMapFromArray [
        ["#components", ["showTools", 0, "showCamonetHull", 0.5, "showBags", 0, "showSLATHull", 0.5]],

        ["Default", ["Indep_01", "Indep_03"]],
        ["Lush", ["Indep_02"]]
    ]],

    // AWC 304 Nyx (Autocannon)
    ["I_LT_01_cannon_F", createHashMapFromArray [
        ["#components", ["showTools", 0, "showCamonetHull", 0.5, "showBags", 0, "showSLATHull", 0.5]],

        ["Default", ["Indep_01", "Indep_03"]],
        ["Lush", ["Indep_02"]]
    ]],

    // MSE-3 Marid
    ["O_APC_Wheeled_02_rcws_v2_F", createHashMapFromArray [
        ["#components", ["showBags", 0, "showCanisters", 0.5, "showTools", 0, "showCamonetHull", 0.5, "showSLATHull", 0.5]],

        ["Default", ["Hex"]],
        ["Lush", ["GreenHex"]]
    ]],

    // MSE-3 Marid (HMG)
    ["O_SFIA_APC_Wheeled_02_hmg_lxWS", createHashMapFromArray [
        ["#components", ["mg_hide_armor_front", 0.5, "mg_hide_armor_rear", 0.5, "mg_Hide_Rail", 0, "showBags", 0, "showCanisters", 0.5, "showTools", 0, "showCamonetHull", 0.5, "showSLATHull", 0.5]]
    ]],

    // BTR-K Kamysh
    ["O_APC_Tracked_02_cannon_F", createHashMapFromArray [
        ["#components", ["showBags", 0, "showCanisters", 0.5, "showTools", 0, "showCamonetHull", 0.5, "showSLATHull", 0.5]],

        ["Default", ["Hex"]],
        ["Lush", ["GreenHex"]]
    ]],

    ["O_SFIA_APC_Tracked_02_cannon_lxWS", createHashMapFromArray [
        ["#components", ["showTracks", 0.5, "showCamonetHull", 0.5, "showBags", 0, "showSLATHull", 0.5]]
    ]],

    // BTR-T Iskatel
    ["O_SFIA_APC_Tracked_02_30mm_lxWS", createHashMapFromArray [
        ["#components", ["showTracks", 0.5, "showCamonetHull", 0.5, "showBags", 0, "showSLATHull", 0.5]]
    ]],

    // FV-720 Mora
    ["I_APC_tracked_03_cannon_F", createHashMapFromArray [
        ["#components", ["showBags", 0, "showBags2", 0.5, "showCamonetHull", 0.5, "showCamonetTurret", 0.5, "showTools", 0, "showSLATHull", 0.5, "showSLATTurret", 0.5]],

        ["Default", ["Indep_01", "Indep_03"]],
        ["Lush", ["Indep_02"]]
    ]],

    // AFV-4 Gorgon
    ["I_APC_Wheeled_03_cannon_F", createHashMapFromArray [
        ["#components", ["showCamonetHull", 0.5, "showBags", 0, "showBags2", 0, "showTools", 0, "showSLATHull", 0.5]],

        ["Default", ["Indep", "Indep_03"]],
        ["Lush", ["Indep_02"]]
    ]],

    // ZSU-39 Tigris
    ["O_APC_Tracked_02_AA_F", createHashMapFromArray [
        ["#components", ["showTracks", 0.5, "showCamonetHull", 0.5, "showCamonetTurret", 0.5, "showSLATHull", 0.5]],

        ["Default", ["Hex"]],
        ["Lush", ["GreenHex"]]
    ]],

    ["O_SFIA_APC_Tracked_02_AA_lxWS", createHashMapFromArray [
        ["#components", ["showTracks", 0.5, "showCamonetHull", 0.5, "showCamonetTurret", 0.5, "showSLATHull", 0.5]]
    ]],

    // Zamak (Zu23-2)
    ["O_SFIA_Truck_02_aa_lxWS", createHashMapFromArray [
        ["#components", ["shield_hide", 0.5, "hideCrates", 0.5, "hideSpareWheel", 0.5, "hideRoofRack", 1, "hideBeacon_1", 0, "hideBumper", 0.5, "hideWindowProtector", 0.5]]
    ]],

    // 2S9 Sochor
    ["O_MBT_02_arty_F", createHashMapFromArray [
        ["#components", ["showAmmobox", 1, "showCanisters", 0.5, "showCamonetTurret", 0.5, "showCamonetHull", 0.5, "showLog", 0]],

        ["Default", ["Hex"]],
        ["Lush", ["GreenHex"]]
    ]],

    // Zamak MRL
    ["I_Truck_02_MRL_F", createHashMapFromArray [
        ["Default", ["Opfor"]],
        ["Lush", ["GreenHex"]]
    ]],

    // T-100 Varsuk
    ["O_MBT_02_cannon_F", createHashMapFromArray [
        ["#components", ["showCamonetHull", 0.5, "showCamonetTurret", 0.5 , "showLog", 0.5]],

        ["Default", ["Hex"]],
        ["Lush", ["GreenHex"]]
    ]],

    ["O_SFIA_MBT_02_cannon_lxWS", createHashMapFromArray [
        ["#components", ["showCamonetHull", 0.5, "showCamonetTurret", 0.5 , "showLog", 0.5]]
    ]],

    // T-140 Angara
    ["O_MBT_04_cannon_F", createHashMapFromArray [
        ["#components", ["showCamonetHull", 0.5, "showCamonetTurret", 0.5]],

        ["Default", ["Hex"]],
        ["Lush", ["GreenHex"]]
    ]],

    // T-140K Angara
    ["O_MBT_04_command_F", createHashMapFromArray [
        ["#components", ["showCamonetHull", 0.5, "showCamonetTurret", 0.5]],

        ["Default", ["Hex"]],
        ["Lush", ["GreenHex"]]
    ]],

    // MBT-52 Kuma
    ["I_MBT_03_cannon_F", createHashMapFromArray [
        ["#components", ["HideTurret", 0.5, "HideHull", 0.5, "showCamonetHull", 0.5, "showCamonetTurret", 0.5]],

        ["Default", ["Indep_01", "Indep_03"]],
        ["Lush", ["Indep_02"]]
    ]],

    // R-750 Cronus Radar
    ["O_Radar_System_02_F", createHashMapFromArray [
        ["Default", ["Hex"]],
        ["Lush", ["GreenHex"]]
    ]],

    // S-750 Rhea
    ["O_SAM_System_04_F", createHashMapFromArray [
        ["Default", ["AridHex"]],
        ["Lush", ["JungleHex"]]
    ]]
];


InA_Server_VehicleApperanceDefined = true;
