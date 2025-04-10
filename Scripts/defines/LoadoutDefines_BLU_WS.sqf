params [["_unit", objNull]];

if (isNull _unit) exitWith {};

removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

private _radioItem = "ItemRadio";

if (isClass (configFile >> "CfgPatches" >> "task_force_radio")) then {
    _radioItem = "TFAR_anprc152";
};

private _loadout = [_unit] call AW_fnc_persistentLoadoutGet;

if (_loadout isNotEqualTo []) exitWith {
    _unit setUnitLoadout _loadout;
    [true] call AW_fnc_cleanInventory;
    missionNamespace setVariable ["InA_PlayerLoadout", (getUnitLoadout player)];
};

private _unitType = (typeOf _unit);

switch (_unitType) do {
    case "B_Soldier_SL_F": {
        _loadout = [
            ["arifle_MX_GL_Black_F", "", "acc_pointer_IR", "optic_Hamr", ["30Rnd_65x39_caseless_black_mag", 30], ["1Rnd_HE_Grenade_shell", 1], ""],
            [],
            ["hgun_P07_F", "", "", "", ["16Rnd_9x21_Mag", 17], [], ""],
            ["U_B_CombatUniform_mcam", [
                ["FirstAidKit", 2],
                ["SmokeShellBlue", 2, 1],
                ["HandGrenade", 1, 1],
                ["Laserbatteries", 1, 1]
            ]],
            ["V_PlateCarrier2_rgr", [
                ["30Rnd_65x39_caseless_black_mag", 4, 30],
                ["30Rnd_65x39_caseless_black_mag_Tracer", 1, 30],
                ["16Rnd_9x21_Mag", 3, 17],
                ["1Rnd_HE_Grenade_shell", 3, 1],
                ["1Rnd_SmokeBlue_Grenade_shell", 3, 1],
                ["1Rnd_SmokeOrange_Grenade_shell", 2, 1],
                ["1Rnd_SmokePurple_Grenade_shell", 2, 1],
                ["1Rnd_SmokeYellow_Grenade_shell", 2, 1],
                ["1Rnd_SmokeGreen_Grenade_shell", 2, 1],
                ["1Rnd_Smoke_Grenade_shell", 2, 1]
            ]],
            [],
            "H_HelmetB_light","",
            ["Laserdesignator", "", "", "", ["Laserbatteries", 1], [], ""],
            ["ItemMap", "ItemGPS", _radioItem, "ItemCompass", "ItemWatch", "NVGoggles"]
        ];
    };

    case "B_medic_F": {
        _loadout = [
            ["arifle_MX_Black_F", "", "acc_pointer_IR", "optic_Hamr", ["30Rnd_65x39_caseless_black_mag", 30], [], ""],
            [],
            ["hgun_P07_F", "", "", "", ["16Rnd_9x21_Mag", 17], [], ""],
            ["U_B_CombatUniform_mcam",[
                ["FirstAidKit", 2],
                ["SmokeShellBlue", 2, 1],
                ["HandGrenade", 1, 1]
            ]],
            ["V_TacVestIR_blk", [
                ["30Rnd_65x39_caseless_black_mag", 4, 30],
                ["30Rnd_65x39_caseless_black_mag_Tracer", 1, 30],
                ["16Rnd_9x21_Mag", 3, 17],
                ["SmokeShellBlue", 2, 1]
            ]],
            ["B_AssaultPack_rgr", [
                ["Medikit", 1],
                ["FirstAidKit", 20]
            ]],
            "H_HelmetB_light",
            "",
            [],
            ["ItemMap", "ItemGPS", _radioItem, "ItemCompass", "ItemWatch", "NVGoggles"]
        ];
    };

    case "B_soldier_repair_F": {
        _loadout = [
            ["arifle_MX_Black_F", "", "acc_pointer_IR", "optic_Hamr", ["30Rnd_65x39_caseless_black_mag", 30], [], ""],
            [],
            ["hgun_P07_F", "", "", "", ["16Rnd_9x21_Mag", 17], [], ""],
            ["U_B_CombatUniform_mcam", [
                ["FirstAidKit", 2],
                ["HandGrenade", 1, 1],
                ["SmokeShellBlue", 2, 1]
            ]],
            ["V_PlateCarrier1_rgr", [
                ["30Rnd_65x39_caseless_black_mag", 4, 30],
                ["30Rnd_65x39_caseless_black_mag_Tracer", 1, 30],
                ["16Rnd_9x21_Mag", 3, 17]
            ]],
            ["B_AssaultPack_khk", [
                ["ToolKit", 1]
            ]],
            "H_HelmetB_light_desert",
            "",
            [],
            ["ItemMap", "", _radioItem, "ItemCompass", "ItemWatch", "NVGoggles"]
        ];
    };

    case "B_soldier_AR_F": {
        _loadout = [
            ["LMG_Mk200_F", "", "acc_pointer_IR", "optic_Hamr", ["200Rnd_65x39_cased_Box", 200], [], "bipod_01_F_blk"],
            [],
            ["hgun_P07_F", "", "", "", ["16Rnd_9x21_Mag", 17], [], ""],
            ["U_B_CombatUniform_mcam", [
                ["FirstAidKit", 2],
                ["HandGrenade", 1, 1],
                ["SmokeShellBlue", 2, 1]
            ]],
            ["V_Chestrig_rgr", [
                ["200Rnd_65x39_cased_Box", 2, 200],
                ["16Rnd_9x21_Mag", 3, 17]
            ]],
            ["B_AssaultPack_khk", [
                ["200Rnd_65x39_cased_Box_Tracer", 2, 200]
            ]],
            "H_HelmetB_light_snakeskin",
            "",
            ["Binocular", "", "", "", [], [], ""],
            ["ItemMap", "", _radioItem, "ItemCompass", "ItemWatch", "NVGoggles"]
        ];
    };

    case "B_Soldier_GL_F": {
        _loadout = [
            ["arifle_MX_GL_Black_F", "", "acc_pointer_IR", "optic_Hamr", ["30Rnd_65x39_caseless_black_mag", 30], ["1Rnd_HE_Grenade_shell", 1], ""],
            [],
            ["hgun_P07_F", "", "", "", ["16Rnd_9x21_Mag", 17], [], ""],
            ["U_B_CombatUniform_mcam", [
                ["FirstAidKit", 2],
                ["SmokeShellBlue", 2, 1],
                ["HandGrenade", 1, 1],
                ["Laserbatteries", 1, 1]
            ]],
            ["V_PlateCarrierIAGL_oli", [
                ["30Rnd_65x39_caseless_black_mag", 4, 30],
                ["30Rnd_65x39_caseless_black_mag_Tracer", 1, 30],
                ["16Rnd_9x21_Mag", 3, 17]
            ]],
            ["B_AssaultPack_khk", [
                ["1Rnd_HE_Grenade_shell", 10, 1],
                ["1Rnd_Smoke_Grenade_shell", 2, 1],
                ["1Rnd_SmokeBlue_Grenade_shell", 3, 1],
                ["1Rnd_SmokeOrange_Grenade_shell", 2, 1],
                ["1Rnd_SmokePurple_Grenade_shell", 2, 1],
                ["1Rnd_SmokeYellow_Grenade_shell", 2, 1],
                ["1Rnd_SmokeGreen_Grenade_shell", 2, 1]
            ]],
            "H_HelmetSpecB_snakeskin",
            "",
            ["Laserdesignator", "", "", "", ["Laserbatteries", 1], [], ""],
            ["ItemMap", "ItemGPS", _radioItem, "ItemCompass", "ItemWatch", "NVGoggles"]
        ];
    };

    case "B_soldier_M_F": {
        _loadout = [
            ["srifle_EBR_F", "", "acc_pointer_IR", "optic_DMS", ["20Rnd_762x51_Mag", 20], [], "bipod_01_F_blk"],
            [],
            [],
            ["U_B_CombatUniform_mcam", [
                ["FirstAidKit", 2],
                ["HandGrenade", 1, 1],
                ["SmokeShellBlue", 2, 1],
                ["Laserbatteries", 1, 1]
            ]],
            ["V_PlateCarrier1_rgr", [
                ["20Rnd_762x51_Mag", 7, 20],
                ["16Rnd_9x21_Mag", 3, 17]
            ]],
            [],
            "H_HelmetB_camo",
            "",
            ["Laserdesignator", "", "", "", ["Laserbatteries", 1], [], ""],
            ["ItemMap", "", _radioItem, "ItemCompass", "ItemWatch", "NVGoggles"]
        ];
    };

    case "B_soldier_AT_F": {
        _loadout = [
            ["arifle_MXC_Black_F", "", "acc_pointer_IR", "optic_Hamr", ["30Rnd_65x39_caseless_black_mag", 30], [], ""],
            ["launch_B_Titan_short_F", "", "", "", ["Titan_AT", 1], [], ""],
            ["hgun_P07_F", "", "", "", ["16Rnd_9x21_Mag", 17], [], ""],
            ["U_B_CombatUniform_mcam", [
                ["FirstAidKit", 2],
                ["HandGrenade", 1, 1],
                ["SmokeShellBlue", 2, 1]
            ]],
            ["V_PlateCarrier1_rgr", [
                ["30Rnd_65x39_caseless_black_mag", 5, 30],
                ["16Rnd_9x21_Mag", 3, 17]
            ]],
            ["B_Kitbag_rgr", [
                ["Titan_AT", 2, 1],
                ["Titan_AP", 1, 1]
            ]],
            "H_HelmetB_light",
            "",
            [],
            ["ItemMap", "", _radioItem, "ItemCompass", "ItemWatch", "NVGoggles"]
        ];
    };

    case "B_soldier_LAT_F": {
        _loadout = [
            ["arifle_MX_Black_F", "", "acc_pointer_IR", "optic_Hamr", ["30Rnd_65x39_caseless_black_mag", 30], [], ""],
            ["launch_NLAW_F", "", "", "", ["NLAW_F", 1], [], ""],
            ["hgun_P07_F", "", "", "", ["16Rnd_9x21_Mag", 17], [], ""],
            ["U_B_CombatUniform_mcam", [
                ["FirstAidKit", 2],
                ["SmokeShellBlue", 2, 1],
                ["HandGrenade", 1, 1]
            ]],
            ["V_PlateCarrier2_rgr", [
                ["30Rnd_65x39_caseless_black_mag", 5, 30],
                ["16Rnd_9x21_Mag", 3, 17]
            ]],
            ["B_Kitbag_rgr", [
                ["NLAW_F", 2, 1]
            ]],
            "H_HelmetB_light",
            "",
            [],
            ["ItemMap", "", _radioItem, "ItemCompass", "ItemWatch", "NVGoggles"]
        ];
    };

    case "B_Soldier_TL_F": {
        _loadout = [
            ["arifle_MX_GL_Black_F", "", "acc_pointer_IR", "optic_Hamr", ["30Rnd_65x39_caseless_black_mag", 30], ["1Rnd_HE_Grenade_shell", 1], ""],
            [],
            ["hgun_P07_F", "", "", "", ["16Rnd_9x21_Mag", 17], [], ""],
            ["U_B_CombatUniform_mcam", [
                ["FirstAidKit", 2],
                ["SmokeShellBlue", 2, 1],
                ["HandGrenade", 1, 1],
                ["Laserbatteries", 1, 1]
            ]],
            ["V_PlateCarrier1_rgr", [
                ["DemoCharge_Remote_Mag", 2, 1],
                ["30Rnd_65x39_caseless_black_mag", 5, 30],
                ["16Rnd_9x21_Mag", 3, 17]
            ]],
            ["B_AssaultPack_khk", [
                ["1Rnd_HE_Grenade_shell", 8, 1],
                ["1Rnd_Smoke_Grenade_shell", 2, 1],
                ["1Rnd_SmokeGreen_Grenade_shell", 2, 1],
                ["1Rnd_SmokeBlue_Grenade_shell", 2, 1]
            ]],
            "H_HelmetB_light",
            "",
            ["Laserdesignator", "", "", "", ["Laserbatteries", 1], [], ""],
            ["ItemMap", "ItemGPS", _radioItem, "ItemCompass", "ItemWatch", "NVGoggles"]
        ];
    };

    case "B_engineer_F": {
        _loadout = [
            ["arifle_MX_Black_F", "", "acc_pointer_IR", "optic_Hamr", ["30Rnd_65x39_caseless_black_mag", 30], [], ""],
            [],
            ["hgun_P07_F", "", "", "", ["16Rnd_9x21_Mag", 17], [], ""],
            ["U_B_CombatUniform_mcam", [
                ["FirstAidKit", 2],
                ["HandGrenade", 1, 1],
                ["SmokeShellBlue", 2, 1]
            ]],
            ["V_PlateCarrier2_rgr", [
                ["MineDetector", 1],
                ["30Rnd_65x39_caseless_black_mag", 5, 30],
                ["16Rnd_9x21_Mag", 3, 17]
            ]],
            ["B_AssaultPack_khk", [
                ["ToolKit", 1],
                ["DemoCharge_Remote_Mag", 2, 1],
                ["ClaymoreDirectionalMine_Remote_Mag", 2, 1]
            ]],
            "H_HelmetSpecB_snakeskin",
            "",
            [],
            ["ItemMap", "ItemGPS", _radioItem, "ItemCompass", "ItemWatch", "NVGoggles"]
        ];
    };

    case "B_soldier_exp_F": {
        _loadout = [
            ["arifle_MX_Black_F", "", "acc_pointer_IR", "optic_Hamr", ["30Rnd_65x39_caseless_black_mag", 30], [], ""],
            [],
            ["hgun_P07_F", "", "", "", ["16Rnd_9x21_Mag", 17], [], ""],
            ["U_B_CombatUniform_mcam", [
                ["FirstAidKit", 2],
                ["HandGrenade", 1, 1],
                ["SmokeShellBlue", 2, 1]
            ]],
            ["V_PlateCarrierIAGL_oli", [
                ["MineDetector", 1],
                ["30Rnd_65x39_caseless_black_mag", 5, 30],
                ["16Rnd_9x21_Mag", 3, 17]
            ]],
            ["B_Kitbag_rgr", [
                ["ToolKit", 1],
                ["DemoCharge_Remote_Mag", 4, 1],
                ["ClaymoreDirectionalMine_Remote_Mag", 2, 1],
                ["APERSTripMine_Wire_Mag", 2, 1],
                ["APERSBoundingMine_Range_Mag", 2, 1]
            ]],
            "H_HelmetSpecB_snakeskin",
            "",
            [],
            ["ItemMap", "", _radioItem, "ItemCompass", "ItemWatch", "NVGoggles"]
        ];
    };

    case "B_sniper_F": {
        _loadout = [
            ["srifle_LRR_camo_F", "", "", "optic_LRPS", ["7Rnd_408_Mag", 7], [], ""],
            [],
            ["hgun_P07_F", "", "", "", ["16Rnd_9x21_Mag", 17], [], ""],
            ["U_B_FullGhillie_ard", [
                ["FirstAidKit", 2],
                ["SmokeShellBlue", 2, 1],
                ["HandGrenade", 1, 1]
            ]],
            ["V_PlateCarrier1_rgr", [
                ["7Rnd_408_Mag", 7, 7],
                ["16Rnd_9x21_Mag", 3, 17]
            ]],
            [],
            "",
            "",
            ["Laserdesignator", "", "", "", ["Laserbatteries", 1], [], ""],
            ["ItemMap", "ItemGPS", _radioItem, "ItemCompass", "ItemWatch", "NVGoggles"]
        ];
    };

    case "B_spotter_F": {
        _loadout = [
            ["arifle_MX_Black_F", "", "acc_pointer_IR", "optic_Hamr", [], [], ""],
            [],
            ["hgun_P07_F", "", "", "", ["16Rnd_9x21_Mag", 17], [], ""],
            ["U_B_FullGhillie_ard", [
                ["FirstAidKit", 2],
                ["SmokeShellBlue", 2, 1],
                ["HandGrenade", 1, 1],
                ["Laserbatteries", 1, 1]
            ]],
            ["V_PlateCarrier2_rgr", [
                ["30Rnd_65x39_caseless_black_mag", 4, 30],
                ["30Rnd_65x39_caseless_black_mag_Tracer", 1, 30],
                ["16Rnd_9x21_Mag", 3, 17]
            ]],
            [],
            "",
            "",
            ["Laserdesignator", "", "", "", ["Laserbatteries", 1], [], ""],
            ["ItemMap", "ItemGPS", _radioItem, "ItemCompass", "ItemWatch", "NVGoggles"]
        ];
    };

    case "B_support_Mort_F": {
        _loadout = [
            ["arifle_MXC_Black_F", "", "acc_pointer_IR", "optic_Aco", ["30Rnd_65x39_caseless_black_mag", 30], [], ""],
            [],
            ["hgun_P07_F", "", "", "", ["16Rnd_9x21_Mag", 17], [], ""],
            ["U_B_CombatUniform_mcam", [
                ["FirstAidKit", 2],
                ["SmokeShellBlue", 2, 1],
                ["HandGrenade", 1, 1],
                ["Laserbatteries", 1, 1]
            ]],
            ["V_PlateCarrier1_rgr", [
                ["30Rnd_65x39_caseless_black_mag", 4, 30],
                ["30Rnd_65x39_caseless_black_mag_Tracer", 1, 30],
                ["16Rnd_9x21_Mag", 3, 17]
            ]],
            ["B_Mortar_01_weapon_F", []],
            "H_HelmetB_light",
            "",
            ["Laserdesignator", "", "", "", ["Laserbatteries", 1], [], ""],
            ["ItemMap", "ItemGPS", _radioItem, "ItemCompass", "ItemWatch", "NVGoggles"]
        ];
    };

    case "B_soldier_UAV_F": {
        _loadout = [
            ["arifle_MXC_Black_F", "", "acc_pointer_IR", "optic_Aco", ["30Rnd_65x39_caseless_black_mag", 30], [], ""],
            [],
            ["hgun_P07_F", "", "", "", ["16Rnd_9x21_Mag", 17], [], ""],
            ["U_B_CombatUniform_mcam", [
                ["FirstAidKit", 2],
                ["Laserbatteries", 1, 1],
                ["SmokeShellBlue", 2, 1],
                ["HandGrenade", 1, 1]
            ]],
            ["V_PlateCarrier1_rgr", [
                ["30Rnd_65x39_caseless_black_mag", 4, 30],
                ["30Rnd_65x39_caseless_black_mag_Tracer", 1, 30],
                ["16Rnd_9x21_Mag", 3, 17]
            ]],
            ["B_UAV_01_backpack_F", []],
            "H_HelmetB_light",
            "",
            ["Laserdesignator", "", "", "", ["Laserbatteries", 1], [], ""],
            ["ItemMap", "B_UavTerminal", _radioItem, "ItemCompass", "ItemWatch", "NVGoggles"]
        ];
    };

    case "B_Helipilot_F": {
        _loadout = [
            ["SMG_01_F", "", "", "", ["30Rnd_45ACP_Mag_SMG_01", 25], [], ""],
            [],
            [],
            ["U_B_HeliPilotCoveralls", [
                ["FirstAidKit", 2],
                ["SmokeShellBlue", 2, 1],
                ["SmokeShellGreen", 2, 1],
                ["Chemlight_blue", 2, 1],
                ["Chemlight_green", 2, 1],
                ["B_IR_Grenade", 1, 1]
            ]],
            ["V_TacVest_blk", [
                ["ToolKit", 1],
                ["30Rnd_45ACP_Mag_SMG_01", 2, 25]
            ]],
            [],
            "H_CrewHelmetHeli_B",
            "G_Bandanna_oli",
            ["Binocular", "", "", "", [], [], ""],
            ["ItemMap", "ItemGPS", _radioItem, "ItemCompass", "ItemWatch", "NVGoggles_OPFOR"]
        ];
    };

    case "B_recon_TL_F": {
        _loadout = [
            ["arifle_MX_GL_Black_F", "muzzle_snds_65_TI_blk_F", "acc_pointer_IR","optic_Nightstalker", ["30Rnd_65x39_caseless_black_mag", 30], ["1Rnd_HE_Grenade_shell", 1], ""],
            [],
            ["hgun_Pistol_heavy_01_F", "muzzle_snds_acp", "acc_flashlight_pistol", "", ["11Rnd_45ACP_Mag", 15], [], ""],
            ["U_B_CTRG_3", [
                ["FirstAidKit", 2],
                ["SmokeShellBlue", 2, 1],
                ["HandGrenade", 1, 1],
                ["Laserbatteries", 1, 1]
            ]],
            ["V_PlateCarrierL_CTRG", [
                ["DemoCharge_Remote_Mag", 2, 1],
                ["30Rnd_65x39_caseless_black_mag", 5, 30],
                ["11Rnd_45ACP_Mag", 3, 15],
                ["1Rnd_HE_Grenade_shell", 5, 1]
            ]],
            [],
            "H_Booniehat_khk_hs",
            "G_Tactical_Clear",
            ["Laserdesignator", "", "", "", ["Laserbatteries", 1], [], ""],
            ["ItemMap", "ItemGPS", _radioItem, "ItemCompass", "ItemWatch", "NVGoggles_OPFOR"]
        ];
    };

    case "B_recon_LAT_F": {
         _loadout = [
            ["arifle_MX_Black_F", "muzzle_snds_65_TI_blk_F", "acc_pointer_IR", "optic_Nightstalker", ["30Rnd_65x39_caseless_black_mag", 30], [], ""],
            ["launch_I_Titan_short_F", "", "", "", ["Titan_AT", 1], [], ""],
            ["hgun_Pistol_heavy_01_F", "muzzle_snds_acp", "acc_flashlight_pistol", "optic_MRD", ["11Rnd_45ACP_Mag", 15], [], ""],
            ["U_B_CTRG_3", [
                ["FirstAidKit", 2],
                ["SmokeShellBlue", 2, 1],
                ["HandGrenade", 1, 1],
                ["Laserbatteries", 1, 1]
            ]],
            ["V_PlateCarrierL_CTRG", [
                ["30Rnd_65x39_caseless_black_mag", 5, 30],
                ["11Rnd_45ACP_Mag", 3, 15]
            ]],
            ["B_Kitbag_rgr", [
                ["Titan_AT", 2, 1]
            ]],
            "H_Booniehat_khk_hs",
            "G_Tactical_Clear",
            ["Laserdesignator", "", "", "", ["Laserbatteries", 1], [], ""],
            ["ItemMap", "ItemGPS", _radioItem, "ItemCompass", "ItemWatch", "NVGoggles_OPFOR"]
        ];
    };

    case "B_recon_M_F": {
         _loadout = [
            ["arifle_MXM_Black_F", "muzzle_snds_65_TI_blk_F", "acc_pointer_IR", "optic_Nightstalker", ["30Rnd_65x39_caseless_black_mag", 30], [], ""],
            [],
            ["hgun_Pistol_heavy_01_F", "muzzle_snds_acp", "acc_flashlight_pistol", "optic_MRD", ["11Rnd_45ACP_Mag", 15], [], ""],
            ["U_B_CTRG_3", [
                ["FirstAidKit", 2],
                ["SmokeShellBlue", 2, 1],
                ["HandGrenade", 1, 1],
                ["Laserbatteries", 1, 1]
            ]],
            ["V_PlateCarrierL_CTRG", [
                ["30Rnd_65x39_caseless_black_mag", 7, 30],
                ["11Rnd_45ACP_Mag", 3, 15]
            ]],
            [],
            "H_Booniehat_khk_hs",
            "G_Tactical_Clear",
            ["Laserdesignator", "", "", "", ["Laserbatteries", 1], [], ""],
            ["ItemMap", "ItemGPS", _radioItem, "ItemCompass", "ItemWatch", "NVGoggles_OPFOR"]
        ];
    };

    case "B_recon_medic_F": {
         _loadout = [
            ["arifle_MX_Black_F", "muzzle_snds_65_TI_blk_F", "acc_pointer_IR", "optic_Nightstalker", ["30Rnd_65x39_caseless_black_mag", 30], [], ""],
            [],
            ["hgun_Pistol_heavy_01_F", "muzzle_snds_acp", "acc_flashlight_pistol", "optic_MRD", ["11Rnd_45ACP_Mag", 15], [], ""],
            ["U_B_CTRG_3", [
                ["SmokeShellBlue", 2, 1],
                ["HandGrenade", 1, 1],
                ["Laserbatteries", 1, 1]
            ]],
            ["V_PlateCarrierL_CTRG", [
                ["30Rnd_65x39_caseless_black_mag", 5, 30],
                ["11Rnd_45ACP_Mag", 3, 15],
                ["SmokeShellYellow", 8, 1]
            ]],
            ["B_AssaultPack_rgr", [
                ["Medikit", 1],
                ["FirstAidKit", 8]
            ]],
            "H_Booniehat_khk_hs",
            "G_Tactical_Clear",
            ["Laserdesignator", "", "", "", ["Laserbatteries", 1], [], ""],
            ["ItemMap", "ItemGPS", _radioItem, "ItemCompass", "ItemWatch", "NVGoggles_OPFOR"]
        ];
    };

    case "B_recon_exp_F": {
         _loadout = [
            ["arifle_MX_Black_F", "muzzle_snds_65_TI_blk_F", "acc_pointer_IR", "optic_Nightstalker", ["30Rnd_65x39_caseless_black_mag", 30], [], ""],
            [],
            ["hgun_Pistol_heavy_01_F", "muzzle_snds_acp", "acc_flashlight_pistol", "optic_MRD", ["11Rnd_45ACP_Mag", 15], [], ""],
            ["U_B_CTRG_3", [
                ["SmokeShellBlue", 2, 1],
                ["HandGrenade", 1, 1],
                ["Laserbatteries", 1, 1]
            ]],
            ["V_PlateCarrierL_CTRG", [
                ["30Rnd_65x39_caseless_black_mag", 5, 30],
                ["11Rnd_45ACP_Mag", 3, 15],
                ["SmokeShellYellow", 8, 1],
                ["MineDetector", 1]
            ]],
            ["B_Kitbag_rgr", [
                ["ToolKit", 1],
                ["DemoCharge_Remote_Mag", 2, 1],
                ["SatchelCharge_Remote_Mag", 1, 1],
                ["ClaymoreDirectionalMine_Remote_Mag", 2, 1],
                ["SLAMDirectionalMine_Wire_Mag", 2, 1]
            ]],
            "H_Booniehat_khk_hs",
            "G_Tactical_Clear",
            ["Laserdesignator", "", "", "", ["Laserbatteries", 1], [], ""],
            ["ItemMap", "ItemGPS", _radioItem, "ItemCompass", "ItemWatch", "NVGoggles_OPFOR"]
         ];
    };

    case "B_recon_JTAC_F": {
         _loadout = [
            ["arifle_MX_GL_Black_F", "muzzle_snds_65_TI_blk_F", "acc_pointer_IR","optic_Nightstalker", ["30Rnd_65x39_caseless_black_mag", 30], ["1Rnd_HE_Grenade_shell", 1], ""],
            [],
            ["hgun_Pistol_heavy_01_F", "muzzle_snds_acp", "acc_flashlight_pistol", "optic_MRD", ["11Rnd_45ACP_Mag", 15], [], ""],
            ["U_B_CTRG_3", [
                ["SmokeShellBlue", 2, 1],
                ["HandGrenade", 1, 1],
                ["Laserbatteries", 1, 1]
            ]],
            ["V_PlateCarrierL_CTRG", [
                ["30Rnd_65x39_caseless_black_mag", 5, 30],
                ["11Rnd_45ACP_Mag", 3, 15],
                ["1Rnd_HE_Grenade_shell", 7, 1]
            ]],
            ["B_Kitbag_rgr", [
                ["1Rnd_SmokeRed_Grenade_shell", 8, 1],
                ["UGL_FlareGreen_F", 4, 1],
                ["UGL_FlareWhite_F", 4, 1],
                ["UGL_FlareYellow_F", 4, 1],
                ["1Rnd_SmokeYellow_Grenade_shell", 4, 1],
                ["1Rnd_SmokeBlue_Grenade_shell", 4, 1],
                ["1Rnd_SmokeGreen_Grenade_shell", 4, 1]
            ]],
            "H_Booniehat_khk_hs",
            "G_Tactical_Clear",
            ["Laserdesignator", "", "", "", ["Laserbatteries", 1], [], ""],
            ["ItemMap", "ItemGPS", _radioItem, "ItemCompass", "ItemWatch", "NVGoggles_OPFOR"]
         ];
    };

    default {
        _loadout = (getUnitLoadout _unitType);
    };
};

_unit setUnitLoadout _loadout;
[true] call AW_fnc_cleanInventory;
missionNamespace setVariable ["InA_PlayerLoadout", (getUnitLoadout player)];
