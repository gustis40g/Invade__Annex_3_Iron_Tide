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

private _radioItem = "vn_b_item_radio_urc10";

if (isClass (configFile >> "CfgPatches" >> "task_force_radio")) then {
    _radioItem = "TFAR_anprc152";
};

private _loadout = [_unit] call AW_fnc_persistentLoadoutGet;

if (!(_loadout isEqualTo [])) exitWith {
    _unit setUnitLoadout _loadout;
    [true] call AW_fnc_cleanInventory;
    missionNamespace setVariable ["InA_PlayerLoadout", (getUnitLoadout player)];
};

private _unitType = (typeOf _unit);
private _roleDesc = (roleDescription _unit);
private _isRecon = ((_roleDesc find "Recon") != -1) || ((_roleDesc find "MACV-SOG") != -1);

switch (_unitType) do {
    case "vn_b_men_sog_04": { //SL & TL
        _loadout = [
            ["vn_m1928a1_tommy","","","",["vn_m1a1_30_mag",30],[],""],
            [],
            ["vn_m1911","","","",["vn_m1911_mag",7],[],""],
            ["vn_b_uniform_macv_06_01",[["vn_b_item_firstaidkit",4],["vn_m18_white_mag",2,1],["vn_m67_grenade_mag",1,1]]],
            ["vn_b_vest_usarmy_09",[["vn_m1a1_30_mag",6,30]]],
            ["vn_b_pack_01",[["vn_m1a1_30_mag",2,30],["vn_m1911_mag",2,7],["vn_m67_grenade_mag",1,1],["vn_m18_yellow_mag",2,1],["vn_m18_red_mag",2,1],["vn_m18_purple_mag",2,1],["vn_m1a1_30_t_mag",2,30]]],
            "vn_b_boonie_02_01",
            "G_Aviator",
            ["vn_m19_binocs_grey","","","",[],[],""],
            ["vn_b_item_map","","vn_b_item_radio_urc10","vn_b_item_compass_sog","vn_b_item_watch",""]
        ];

        if (_isRecon) then {
            _loadout = [["vn_type56","","","",["vn_type56_mag",30],[],""],[],["vn_welrod","","","",["vn_welrod_mag",8],[],""],["vn_b_uniform_macv_01_03",[["vn_b_item_firstaidkit",4],["vn_m18_white_mag",2,1],["vn_m67_grenade_mag",1,1]]],["vn_b_vest_sog_01",[["vn_type56_mag",8,30],["vn_type56_t_mag",2,30],["vn_welrod_mag",2,8],["vn_m18_purple_mag",2,1],["vn_m18_red_mag",2,1],["vn_m18_yellow_mag",2,1]]],[],"vn_b_beret_01_02","G_Aviator",["vn_m19_binocs_grey","","","",[],[],""],["vn_b_item_map","","vn_b_item_radio_urc10","vn_b_item_compass_sog","vn_b_item_watch",""]];
        };
    };

    case "vn_b_men_sog_05": { //JTAC
        if (_isRecon) then {
            _loadout = [["vn_type56","","","",["vn_type56_mag",30],[],""],[],["vn_welrod","","","",["vn_welrod_mag",8],[],""],["vn_b_uniform_macv_01_03",[["vn_b_item_firstaidkit",4],["vn_m18_white_mag",2,1],["vn_m67_grenade_mag",1,1]]],["vn_b_vest_sog_06",[["vn_type56_mag",8,30],["vn_type56_t_mag",2,30],["vn_welrod_mag",2,8],["vn_m18_purple_mag",2,1],["vn_m18_red_mag",2,1],["vn_m18_yellow_mag",2,1]]],["vn_b_pack_prc77_01",[]],"vn_b_beret_01_02","G_Aviator",["vn_m19_binocs_grey","","","",[],[],""],["vn_b_item_map","","vn_b_item_radio_urc10","vn_b_item_compass_sog","vn_b_item_watch",""]];
        };
    };

    case "vn_b_men_sog_10": { //Medic
        _loadout = [
            ["vn_m45_fold","","","",["vn_m45_mag",36],[],""],
            [],
            ["vn_m1911","","","",["vn_m1911_mag",7],[],""],
            ["vn_b_uniform_macv_06_06",[["vn_b_item_firstaidkit",4],["vn_m18_white_mag",2,1],["vn_m67_grenade_mag",1,1]]],
            ["vn_b_vest_usarmy_07",[["vn_m45_mag",4,36]]],
            ["vn_b_pack_lw_07",[["vn_b_item_medikit_01",1],["vn_b_item_firstaidkit",10],["vn_m45_mag",4,36],["vn_m45_t_mag",2,36],["vn_m18_purple_mag",4,1],["vn_m18_white_mag",2,1]]],
            "vn_b_bandana_04",
            "vn_b_acc_towel_01",
            [],
            ["vn_b_item_map","","vn_b_item_radio_urc10","vn_b_item_compass_sog","vn_b_item_watch",""]
        ];

        if (_isRecon) then {
            _loadout = [["vn_pps43","","","",["vn_pps_mag",35],[],""],[],["vn_welrod","","","",["vn_welrod_mag",8],[],""],["vn_b_uniform_macv_01_03",[["vn_b_item_firstaidkit",4],["vn_m18_white_mag",2,1],["vn_m67_grenade_mag",1,1]]],["vn_b_vest_sog_04",[["vn_welrod_mag",2,8],["vn_m18_purple_mag",2,1],["vn_pps_mag",12,35]]],["vn_b_pack_01_02",[["vn_b_item_medikit_01",1],["vn_b_item_firstaidkit",10]]],"vn_b_boonie_02_03","vn_b_scarf_01_03",["vn_m19_binocs_grey","","","",[],[],""],["vn_b_item_map","","vn_b_item_radio_urc10","vn_b_item_compass_sog","vn_b_item_watch",""]];
        };
    };

    case "vn_b_men_sog_08": { //repair spec & engineer & explo spec
        _loadout = [
            ["vn_m1897","","vn_b_m1897","",["vn_m1897_fl_mag",6],[],""],
            [],
            ["vn_m1911","","","",["vn_m1911_mag",7],[],""],
            ["vn_b_uniform_macv_05_01",[["vn_b_item_firstaidkit",4],["vn_m18_white_mag",2,1],["vn_m67_grenade_mag",1,1]]],
            ["vn_b_vest_sog_03",[["vn_m1897_fl_mag",6,6],["vn_m1897_buck_mag",6,6],["vn_m1911_mag",4,7]]],
            ["vn_b_pack_lw_04",[["vn_b_item_toolkit",1],["vn_b_item_trapkit",1],["vn_mine_satchel_remote_02_mag",1,1],["vn_mine_m18_mag",4,1],["vn_mine_m112_remote_mag",4,1],["vn_m14_early_grenade_mag",4,1],["vn_m67_grenade_mag",3,1]]],
            "vn_i_helmet_m1_02_01",
            "vn_b_scarf_01_01",
            [],
            ["vn_b_item_map","","vn_b_item_radio_urc10","vn_b_item_compass_sog","vn_b_item_watch",""]
        ];

        if (_isRecon) then {
            _loadout = [["vn_type56","","","",["vn_type56_mag",30],[],""],[],["vn_welrod","","","",["vn_welrod_mag",8],[],""],["vn_b_uniform_macv_01_03",[["vn_b_item_firstaidkit",4],["vn_m18_white_mag",2,1],["vn_m67_grenade_mag",1,1]]],["vn_b_vest_sog_01",[["vn_type56_mag",10,30],["vn_type56_t_mag",2,30],["vn_welrod_mag",2,8],["vn_m14_early_grenade_mag",4,1]]],["B_LegStrapBag_black_F",[["vn_mine_satchel_remote_02_mag",1,1],["vn_mine_m18_mag",4,1],["vn_mine_m112_remote_mag",2,1],["vn_m67_grenade_mag",1,1]]],"H_HeadBandage_stained_F","vn_b_scarf_01_03",["vn_m19_binocs_grey","","","",[],[],""],["vn_b_item_map","","vn_b_item_radio_urc10","vn_b_item_compass_sog","vn_b_item_watch",""]];
        };
    };

    case "vn_b_men_sog_06": { //AR
        _loadout = [
            ["vn_m63a_cdo","","","",["vn_m63a_150_mag",150],[],""],
            [],
            ["vn_m1911","","","",["vn_m1911_mag",7],[],""],
            ["vn_b_uniform_macv_06_01",[["vn_b_item_firstaidkit",4],["vn_m18_white_mag",2,1],["vn_m67_grenade_mag",1,1]]],
            ["vn_b_vest_usarmy_06",[["vn_m63a_150_mag",1,150],["vn_m1911_mag",1,7]]],
            ["vn_b_pack_02",[["vn_m63a_150_mag",3,150],["vn_m1911_mag",1,7]]],
            "vn_b_headband_01",
            "vn_b_acc_towel_02",
            [],
            ["vn_b_item_map","","vn_b_item_radio_urc10","vn_b_item_compass_sog","vn_b_item_watch",""]
        ];
    };

    case "vn_b_men_sf_07": { //GL
        _loadout = [
            ["vn_xm16e1_xm148","","","",["vn_m16_30_mag",28],["vn_40mm_m381_he_mag",1],""],
            [],
            ["vn_m1911","","","",["vn_m1911_mag",7],[],""],
            ["vn_b_uniform_macv_06_01",[["vn_b_item_firstaidkit",4],["vn_m18_white_mag",2,1],["vn_m67_grenade_mag",1,1]]],
            ["vn_b_vest_usarmy_04",[["vn_m16_30_mag",6,28],["vn_m1911_mag",1,7]]],
            ["vn_b_pack_lw_03",[["vn_40mm_m381_he_mag",10,1],["vn_m16_30_t_mag",2,28],["vn_40mm_m397_ab_mag",2,1],["vn_40mm_m433_hedp_mag",4,1],["vn_40mm_m680_smoke_w_mag",2,1],["vn_40mm_m717_smoke_p_mag",2,1],["vn_40mm_m576_buck_mag",2,1],["vn_40mm_m406_he_mag",4,1],["vn_m67_grenade_mag",1,1],["vn_m14_early_grenade_mag",2,1]]],
            "vn_b_boonie_02_01",
            "",
            [],
            ["vn_b_item_map","","vn_b_item_radio_urc10","vn_b_item_compass_sog","vn_b_item_watch",""]
        ];
    };

    case "vn_b_men_sog_12";
    case "vn_b_men_sf_12": { //marksman
        _loadout = [
            ["vn_m14_camo","","vn_b_m14","vn_o_9x_m14",["vn_m14_mag",20],[],"vn_b_camo_m14"],
            [],
            ["vn_m1911","","","",["vn_m1911_mag",7],[],""],
            ["vn_b_uniform_macv_06_01",[["vn_b_item_firstaidkit",4],["vn_m18_white_mag",2,1],["vn_m67_grenade_mag",1,1]]],
            ["vn_b_vest_usarmy_08",[["vn_m14_mag",5,20]]],["vn_b_pack_04",[["vn_m14_mag",3,20],["vn_m14_t_mag",2,20],["vn_m1911_mag",2,7],["vn_m67_grenade_mag",1,1]]],
            "vn_b_bandana_01",
            "vn_b_acc_towel_01",
            ["vn_m19_binocs_grn","","","",[],[],""],
            ["vn_b_item_map","","vn_b_item_radio_urc10","vn_b_item_compass_sog","vn_b_item_watch",""]
        ];

        if (_isRecon) then {
            _loadout = [["vn_m14_camo","vn_s_m14","","vn_o_9x_m14",["vn_m14_mag",20],[],""],[],["vn_welrod","","","",["vn_welrod_mag",8],[],""],["vn_b_uniform_macv_01_03",[["vn_b_item_firstaidkit",4],["vn_m18_white_mag",2,1],["vn_m67_grenade_mag",1,1],["vn_welrod_mag",2,8]]],["vn_b_vest_sog_04",[["vn_type56_t_mag",2,30],["vn_m18_purple_mag",2,1],["vn_m18_red_mag",2,1],["vn_m18_yellow_mag",2,1],["vn_m14_mag",6,20]]],["B_LegStrapBag_black_F",[["vn_m14_mag",4,20],["vn_m14_t_mag",2,20]]],"vn_b_bandana_03","vn_o_bandana_b",["vn_m19_binocs_grey","","","",[],[],""],["vn_b_item_map","","vn_b_item_radio_urc10","vn_b_item_compass_sog","vn_b_item_watch",""]];
        };
    };

    case "vn_b_men_army_12": { //AT & Light AT
        _loadout = [["vn_m2carbine","","vn_b_carbine","",["vn_carbine_30_mag",30],[],""],["vn_m72","","","",["vn_m72_mag",1],[],""],["vn_m1911","","","",["vn_m1911_mag",7],[],""],["vn_b_uniform_macv_06_05",[["vn_b_item_firstaidkit",4],["vn_m18_white_mag",2,1],["vn_m67_grenade_mag",1,1]]],["vn_b_vest_usarmy_02",[["vn_carbine_30_mag",6,30]]],["vn_b_pack_lw_01",[["vn_carbine_30_mag",4,30],["vn_m14_early_grenade_mag",6,1],["vn_m67_grenade_mag",1,1],["vn_m1911_mag",2,7]]],"vn_b_boonie_01_01","",[],["vn_b_item_map","","vn_b_item_radio_urc10","vn_b_item_compass_sog","vn_b_item_watch",""]];

        if (_isRecon) then {
            _loadout = [["vn_type56","","","",["vn_type56_mag",30],[],""],["vn_m72","","","",["vn_m72_mag",1],[],""],["vn_welrod","","","",["vn_welrod_mag",8],[],""],["vn_b_uniform_macv_01_03",[["vn_b_item_firstaidkit",4],["vn_m18_white_mag",2,1],["vn_m67_grenade_mag",1,1]]],["vn_b_vest_sog_01",[["vn_type56_mag",10,30],["vn_type56_t_mag",2,30],["vn_welrod_mag",2,8],["vn_m18_purple_mag",2,1]]],["B_LegStrapBag_black_F",[["vn_m14_early_grenade_mag",8,1]]],"vn_b_boonie_01_03","G_Bandanna_aviator",["vn_m19_binocs_grey","","","",[],[],""],["vn_b_item_map","","vn_b_item_radio_urc10","vn_b_item_compass_sog","vn_b_item_watch",""]];
        };
    };

    case "vn_b_men_army_11": { //Sniper
        _loadout = [["vn_m40a1_camo","vn_s_m14","","vn_o_9x_m40a1",["vn_m40a1_mag",5],[],"vn_b_camo_m40a1"],[],["vn_m1911","","","",["vn_m1911_mag",7],[],""],["vn_b_uniform_macv_02_05",[["vn_b_item_firstaidkit",4],["vn_m18_white_mag",2,1],["vn_m67_grenade_mag",1,1],["vn_m40a1_mag",3,5]]],["vn_b_vest_usarmy_08",[["vn_m1911_mag",2,7],["vn_m40a1_mag",12,5]]],["B_LegStrapBag_coyote_F",[["vn_m14_t_mag",2,20],["vn_m67_grenade_mag",1,1],["vn_m40a1_t_mag",2,5],["vn_m18_white_mag",2,1],["vn_m18_purple_mag",2,1]]],"vn_b_bandana_05","vn_b_scarf_01_01",["vn_m19_binocs_grey","","","",[],[],""],["vn_b_item_map","","vn_b_item_radio_urc10","vn_b_item_compass_sog","vn_b_item_watch",""]];
    };

    case "vn_b_men_sog_19": { //spotter
        _loadout = [["vn_m14a1","vn_s_m14","","",["vn_m14_mag",20],[],"vn_b_camo_m14a1"],[],["vn_m1911","","","",["vn_m1911_mag",7],[],""],["vn_b_uniform_macv_02_05",[["vn_b_item_firstaidkit",4],["vn_m18_white_mag",2,1],["vn_m67_grenade_mag",1,1]]],["vn_b_vest_usarmy_08",[["vn_m1911_mag",2,7],["vn_m14_mag",4,20]]],["B_LegStrapBag_coyote_F",[["vn_m14_mag",4,20],["vn_m14_t_mag",2,20],["vn_m67_grenade_mag",1,1]]],"vn_b_bandana_05","vn_b_scarf_01_01",["vn_m19_binocs_grey","","","",[],[],""],["vn_b_item_map","","vn_b_item_radio_urc10","vn_b_item_compass_sog","vn_b_item_watch",""]];
    };

    case "vn_b_men_sf_06": { //FSG assistant
        _loadout = [["vn_m3a1","","","",["vn_m3a1_mag",30],[],""],[],[],["vn_b_uniform_macv_06_07",[["vn_b_item_firstaidkit",3],["vn_m18_white_mag",2,1],["vn_m67_grenade_mag",2,1]]],["vn_b_vest_usarmy_02",[["vn_m3a1_mag",5,30],["vn_m3a1_t_mag",1,30]]],["vn_b_pack_static_m29_01",[]],"vn_b_helmet_m1_01_01","vn_b_acc_towel_01",["vn_m19_binocs_grey","","","",[],[],""],["vn_b_item_map","","vn_b_item_radio_urc10","vn_b_item_compass_sog","vn_b_item_watch",""]];
    };

    case "vn_b_men_army_21": { //FSG gunner
        _loadout = [["vn_m3a1","","","",["vn_m3a1_mag",30],[],""],[],[],["vn_b_uniform_macv_06_07",[["vn_b_item_firstaidkit",3],["vn_m18_white_mag",2,1],["vn_m67_grenade_mag",2,1]]],["vn_b_vest_usarmy_02",[["vn_m3a1_mag",5,30],["vn_m3a1_t_mag",1,30]]],["vn_b_pack_static_base_01",[]],"vn_b_helmet_m1_01_01","vn_b_acc_towel_01",["vn_m19_binocs_grey","","","",[],[],""],["vn_b_item_map","","vn_b_item_radio_urc10","vn_b_item_compass_sog","vn_b_item_watch",""]];
    };

    case "vn_b_men_aircrew_05": { //Pilot
        _loadout = [["vn_sten","","","",["vn_sten_mag",32],[],""],[],[],["vn_b_uniform_heli_01_01",[["vn_b_item_firstaidkit",4],["vn_m18_white_mag",4,1]]],["vn_b_vest_aircrew_01",[["vn_sten_mag",5,32]]],[],"vn_b_helmet_svh4_02_06","G_Bandanna_beast",[],["vn_b_item_map","","vn_b_item_radio_urc10","vn_b_item_compass_sog","vn_b_item_watch",""]];
    };

    case "B_recon_TL_F": {
        _loadout = [
        ];
    };

    default {
        _loadout = (getUnitLoadout _unitType);
        hint "No default loadouts was found for your unit type, please report this in the feedback thread on forums.ahoyworld.net.";
    };
};

_unit setUnitLoadout _loadout;
[true] call AW_fnc_cleanInventory;
missionNamespace setVariable ["InA_PlayerLoadout", (getUnitLoadout player)];
