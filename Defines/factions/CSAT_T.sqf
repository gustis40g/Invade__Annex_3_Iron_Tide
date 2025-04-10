////////////////
//// CSAT_T ////
////////////////

private _infSquads = [];
private _infTeams = [];
private _sfSquads = [];
private _vpSquads = [];
private _sfTeams = [];
private _vpTeams = [];
private _atTeams = [];
private _aaTeams = [];
private _srTeams = [];

private _vehMRAPs = [];
private _vehIFVs = [];
private _vehSPAAs = [];
private _vehMBTs = [];
private _vehHelis = [];
private _vehHeliCAS = [];
private _vehJets = [];

private _factionMapping = createHashMap;
private _infantryMappings = createHashMap;
private _vehicleMappings = createHashMap;

_factionMapping insert [
    ["#name", "CSAT_T"],
    ["#side", east],
    ["#aux_factions", ["SYND", "FIA"]],
    ["#aux_faction_weights", [1, 0.7]],
    ["#indep_factions", ["AAF"]],
    ["#guer_factions", ["SYND"]]
];


//// Infantry ////

// Units
_infantryMappings insert [
    ["#officers", ["O_T_Officer_F"]],
    ["#squadleaders", ["O_T_Soldier_SL_F"]],
    ["#teamleaders", ["O_T_Soldier_TL_F"]],
    ["#riflemen", ["O_T_Soldier_F"]],
    ["#lats", ["O_T_Soldier_LAT_F"]],
    ["#grenadiers", ["O_T_Soldier_GL_F"]],
    ["#machinegunners", ["O_T_Soldier_AR_F"]],
    ["#heavygunners", ["O_T_Soldier_AR_F"]],
    ["#marksmen", ["O_T_Soldier_M_F"]],
    ["#sharpshooters", ["O_T_Soldier_M_F"]],
    ["#snipers", ["O_T_Sniper_F"]],
    ["#spotters", ["O_T_Spotter_F"]],
    ["#ats", ["O_T_Soldier_AT_F"]],
    ["#hats", ["O_T_Soldier_HAT_F"]],
    ["#aas", ["O_T_Soldier_AA_F"]],
    ["#medics", ["O_T_Medic_F"]],
    ["#demos", ["O_T_Soldier_Exp_F"]],
    ["#engineers", ["O_T_Engineer_F"]],
    ["#paras", ["O_T_Soldier_PG_F"]],
    ["#crews", ["O_T_Crew_F"]],
    ["#heli_pilots", ["O_T_Helipilot_F"]],
    ["#heli_crews", ["O_T_Helicrew_F"]],
    ["#pilots", ["O_T_Pilot_F"]],
    ["#repair", ["O_T_Soldier_Repair_F"]],
    ["#ammos", ["O_T_Soldier_A_F"]],
    ["#aats", ["O_T_Soldier_AAT_F"]],
    ["#aaas", ["O_T_Soldier_AAA_F"]],
    ["#ahats", ["O_T_Soldier_AHAT_F"]],

    ["#civs", [
        "C_Man_casual_1_F_tanoan", "C_Man_casual_3_F_tanoan", "C_Man_casual_5_v2_F_tanoan", "C_Man_casual_7_F_tanoan",
        "C_man_sport_1_F_tanoan", "C_man_sport_2_F_tanoan", "C_man_sport_3_F_tanoan", "C_Man_casual_5_F_tanoan",
        "C_Man_casual_4_F_tanoan", "C_Man_casual_6_F_tanoan", "C_man_polo_1_F", "C_man_polo_2_F", "C_man_polo_5_F"
    ]]
];

// Squads
_infSquads = [
    ["O_T_Soldier_SL_F", "O_T_Medic_F", "O_T_Soldier_Exp_F", "O_T_soldier_mine_F", "O_T_Soldier_A_F", "O_T_Soldier_F", "O_T_Soldier_AR_F"],                     1.75,
    ["O_T_Soldier_SL_F", "O_T_Medic_F", "O_T_Soldier_AR_F", "O_T_Soldier_GL_F", "O_T_Soldier_LAT_F", "O_T_Soldier_TL_F", "O_T_Engineer_F", "O_T_Soldier_M_F"],  2,

    ["O_T_Soldier_TL_F", "O_T_Medic_F", "O_T_Soldier_Exp_F", "O_T_soldier_mine_F", "O_T_Soldier_A_F", "O_T_Soldier_AR_F"],                                      2.5,
    ["O_T_Soldier_TL_F", "O_T_Medic_F", "O_T_Soldier_AR_F", "O_T_Soldier_LAT_F", "O_T_Engineer_F", "O_T_Soldier_M_F"],                                          2.25,

    ["O_T_Soldier_TL_F", "O_T_Medic_F", "O_T_Soldier_Exp_F", "O_T_Soldier_A_F", "O_T_Soldier_AR_F"],                                                            2.6,
    ["O_T_Soldier_TL_F", "O_T_Medic_F", "O_T_Soldier_AR_F", "O_T_Soldier_LAT_F", "O_T_Soldier_M_F"],                                                            2.3
];

_sfSquads = [
    ["O_T_Recon_TL_F", "O_T_Recon_Medic_F", "O_T_Recon_F", "O_T_Recon_Exp_F", "O_T_Recon_LAT_F", "O_T_Recon_JTAC_F", "O_T_Recon_M_F"],  1.25,
    ["O_T_Recon_TL_F", "O_T_Recon_Medic_F", "O_T_Recon_F", "O_T_Recon_Exp_F", "O_T_Recon_JTAC_F", "O_T_Recon_M_F"],                     1.5
];

_vpSquads = [
    ["O_V_Soldier_TL_ghex_F", "O_V_Soldier_Medic_ghex_F", "O_V_Soldier_JTAC_ghex_F", "O_V_Soldier_M_ghex_F", "O_V_Soldier_LAT_ghex_F", "O_V_Soldier_Exp_ghex_F"], 1
];

// Teams
_infTeams = [
    ["O_T_Soldier_TL_F", "O_T_Medic_F", "O_T_Soldier_AR_F", "O_T_Soldier_LAT_F"],                   2,
    ["O_T_Soldier_TL_F", "O_T_Medic_F", "O_T_Soldier_GL_F", "O_T_Soldier_M_F"],                     2,
    ["O_T_Soldier_TL_F", "O_T_Medic_F", "O_T_Soldier_Exp_F", "O_T_soldier_mine_F"],                 1.75
];

_sfTeams = [
    ["O_T_Recon_TL_F", "O_T_Recon_Medic_F", "O_T_Recon_LAT_F", "O_T_Recon_M_F"],    1.25,
    ["O_T_Recon_TL_F", "O_T_Recon_Medic_F", "O_T_Recon_F", "O_T_Recon_JTAC_F"],     1.25,
    ["O_T_Recon_TL_F", "O_T_Recon_Medic_F", "O_T_Recon_Exp_F", "O_T_Recon_F"],      1.25
];

_vpTeams = [
    ["O_V_Soldier_TL_ghex_F", "O_V_Soldier_Medic_ghex_F", "O_V_Soldier_LAT_ghex_F", "O_V_Soldier_Exp_ghex_F"],  1,
    ["O_V_Soldier_TL_ghex_F", "O_V_Soldier_Medic_ghex_F", "O_V_Soldier_JTAC_ghex_F", "O_V_Soldier_M_ghex_F"],   1
];

_atTeams = [
    ["O_T_Soldier_TL_F", "O_T_Soldier_AT_F", "O_T_Soldier_AT_F", "O_T_Soldier_AAT_F"],      1.5,
    ["O_T_Soldier_TL_F", "O_T_Soldier_HAT_F", "O_T_Soldier_HAT_F", "O_T_Soldier_AHAT_F"],   1.25
];

_aaTeams = [
    ["O_T_Soldier_TL_F", "O_T_Soldier_AA_F", "O_T_Soldier_AA_F", "O_T_Soldier_AAA_F"], 1.5
];

_srTeams = [
    ["O_T_Sniper_F", "O_T_Spotter_F"], 0.75
];

_infantryMappings insert [["#squads", _infSquads]];
_infantryMappings insert [["#specop_squads", _sfSquads]];
_infantryMappings insert [["#viper_squads", _vpSquads]];
_infantryMappings insert [["#teams", _infTeams]];
_infantryMappings insert [["#specop_teams", (_sfTeams + _vpTeams)]];
_infantryMappings insert [["#viper_teams", _vpTeams]];
_infantryMappings insert [["#at_teams", _atTeams]];
_infantryMappings insert [["#aa_teams", _aaTeams]];
_infantryMappings insert [["#sniper_teams", _srTeams]];


//// Vehicles ////

// MRAPs
_vehMRAPs = [
    "O_MRAP_02_hmg_F",          3,
    "O_MRAP_02_gmg_F",          2.25,
    "O_LSV_02_armed_F",         2.75,
    "O_G_Offroad_01_armed_F",   2.5
];

// IFVs
_vehIFVs = [
    "O_APC_Wheeled_02_rcws_v2_F",   1.75,
    "O_APC_Tracked_02_cannon_F",    2,
    "I_APC_tracked_03_cannon_F",    1.75,
    "I_APC_Wheeled_03_cannon_F",    2,
    "I_LT_01_AT_F",                 1.5,
    "I_LT_01_cannon_F",             1.5
];

// AAs
_vehSPAAs = [
    "O_APC_Tracked_02_AA_F",    2,
    "I_LT_01_AA_F",             0.5
];

// MBTs
_vehMBTs = [
    "O_MBT_02_cannon_F",    1,
    "O_MBT_04_cannon_F",    0.85,
    "O_MBT_04_command_F",   0.75,
    "I_MBT_03_cannon_F",    0.5
];

// Helis
_vehHelis = [
    "O_Heli_Attack_02_dynamicLoadout_F",    0.5,
    "O_Heli_Light_02_dynamicLoadout_F",     0.75,
    "I_Heli_light_03_dynamicLoadout_F",     0.75,
    "I_Heli_Transport_02_F",                1,
    "O_Heli_Light_02_unarmed_F",            1,
    "I_Heli_light_03_unarmed_F",            1,
    "O_Heli_Transport_04_bench_F",          1,
    "O_Heli_Transport_04_covered_F",        1
];

// Heli CAS
_vehHeliCAS = [
    "O_Heli_Attack_02_dynamicLoadout_F",    0.5,
    "O_Heli_Light_02_dynamicLoadout_F",     1,
    "I_Heli_light_03_dynamicLoadout_F",     1
];

// Jets
_vehJets = [
    "O_Plane_CAS_02_dynamicLoadout_F",      3,
    "I_Plane_Fighter_03_dynamicLoadout_F",  3,
    "I_Plane_Fighter_04_F",                 2,
    "O_Plane_Fighter_02_F",                 1,
    "O_Plane_Fighter_02_Stealth_F",         1
];


_vehicleMappings insert [["#mraps", _vehMRAPs]];
_vehicleMappings insert [["#ifvs", _vehIFVs]];
_vehicleMappings insert [["#spaas", _vehSPAAs]];
_vehicleMappings insert [["#mbts", _vehMBTs]];
_vehicleMappings insert [["#helis", _vehHelis]];
_vehicleMappings insert [["#cas_helis", _vehHeliCAS]];
_vehicleMappings insert [["#jets", _vehJets]];


_factionMapping insert [
    ["#infantry", _infantryMappings],
    ["#vehicles", _vehicleMappings]
];

InA_FactionMappings insert [["CSAT_T", _factionMapping]];
