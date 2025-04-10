//////////////
//// CSAT ////
//////////////

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
    ["#name", "CSAT"],
    ["#side", east],
    ["#aux_factions", ["AAF", "FIA", "SYND"]],
    ["#aux_faction_weights", [1, 1.5, 1.5]],
    ["#indep_factions", ["AAF"]],
    ["#guer_factions", ["FIA", "SYND"]]
];


//// Infantry ////

// Units
_infantryMappings insert [
    ["#officers", ["O_officer_F"]],
    ["#squadleaders", ["O_Soldier_SL_F", "O_SoldierU_SL_F"]],
    ["#teamleaders", ["O_Soldier_TL_F", "O_soldierU_TL_F"]],
    ["#riflemen", ["O_Soldier_F", "O_soldierU_F"]],
    ["#lats", ["O_Soldier_LAT_F", "O_soldierU_LAT_F"]],
    ["#grenadiers", ["O_Soldier_GL_F", "O_SoldierU_GL_F"]],
    ["#machinegunners", ["O_Soldier_AR_F", "O_soldierU_AR_F"]],
    ["#heavygunners", ["O_HeavyGunner_F", "O_Urban_HeavyGunner_F"]],
    ["#marksmen", ["O_soldier_M_F", "O_soldierU_M_F"]],
    ["#sharpshooters", ["O_Sharpshooter_F", "O_Urban_Sharpshooter_F"]],
    ["#snipers", ["O_sniper_F"]],
    ["#spotters", ["O_spotter_F"]],
    ["#ats", ["O_Soldier_AT_F", "O_soldierU_AT_F"]],
    ["#hats", ["O_Soldier_HAT_F"]],
    ["#aas", ["O_Soldier_AA_F", "O_soldierU_AA_F"]],
    ["#medics", ["O_medic_F", "O_soldierU_medic_F"]],
    ["#demos", ["O_soldier_exp_F", "O_soldierU_exp_F"]],
    ["#engineers", ["O_engineer_F", "O_engineer_U_F"]],
    ["#paras", ["O_soldier_PG_F"]],
    ["#crews", ["O_crew_F"]],
    ["#heli_pilots", ["O_helipilot_F"]],
    ["#heli_crews", ["O_helicrew_F"]],
    ["#pilots", ["O_Pilot_F"]],
    ["#repair", ["O_soldier_repair_F", "O_soldierU_repair_F"]],
    ["#ammos", ["O_Soldier_A_F",  "O_soldierU_A_F"]],
    ["#aats", ["O_Soldier_AAT_F",  "O_soldierU_AAT_F"]],
    ["#aaas", ["O_Soldier_AAA_F",  "O_soldierU_AAA_F"]],
    ["#ahats", ["O_Soldier_AHAT_F"]],

    ["#civs", ["C_man_1","C_man_polo_1_F_euro","C_man_polo_2_F_euro","C_man_polo_2_F","C_man_polo_3_F","C_man_polo_4_F","C_man_polo_6_F","C_man_shorts_4_F_asia"]]
];

// Squads
_infSquads = [
    ["O_Soldier_SL_F", "O_medic_F", "O_Soldier_AR_F", "O_Soldier_GL_F", "O_Soldier_LAT_F", "O_Soldier_TL_F", "O_engineer_F", "O_soldier_M_F"],                  2,
    ["O_Soldier_SL_F", "O_medic_F", "O_HeavyGunner_F", "O_Sharpshooter_F", "O_Soldier_LAT_F", "O_Soldier_TL_F", "O_Soldier_GL_F"],                              1.75,

    ["O_Soldier_TL_F", "O_medic_F", "O_Soldier_AR_F", "O_Soldier_GL_F", "O_Soldier_LAT_F", "O_soldier_M_F"],                                                    2.5,
    ["O_Soldier_TL_F", "O_medic_F", "O_HeavyGunner_F", "O_Sharpshooter_F", "O_Soldier_LAT_F", "O_Soldier_GL_F"],                                                2.25,

    ["O_Soldier_TL_F", "O_medic_F", "O_Soldier_AR_F", "O_Soldier_GL_F", "O_Soldier_LAT_F"],                                                                     2.6,
    ["O_Soldier_TL_F", "O_medic_F", "O_HeavyGunner_F", "O_Sharpshooter_F", "O_Soldier_LAT_F"],                                                                  2.3,

    ["O_SoldierU_SL_F", "O_soldierU_medic_F", "O_soldierU_AR_F", "O_SoldierU_GL_F", "O_soldierU_LAT_F", "O_soldierU_TL_F", "O_engineer_U_F", "O_soldierU_M_F"], 2,
    ["O_SoldierU_SL_F", "O_soldierU_medic_F", "O_Urban_HeavyGunner_F", "O_Urban_Sharpshooter_F", "O_soldierU_LAT_F", "O_soldierU_TL_F", "O_SoldierU_GL_F"],     1.75,

    ["O_soldierU_TL_F", "O_soldierU_medic_F", "O_soldierU_AR_F", "O_SoldierU_GL_F", "O_soldierU_LAT_F", "O_soldierU_M_F"],                                      2.5,
    ["O_soldierU_TL_F", "O_soldierU_medic_F", "O_Urban_HeavyGunner_F", "O_Urban_Sharpshooter_F", "O_soldierU_LAT_F", "O_SoldierU_GL_F"],                        2.25,

    ["O_soldierU_TL_F", "O_soldierU_medic_F", "O_soldierU_AR_F", "O_soldierU_LAT_F", "O_soldierU_M_F"],                                                         2.6,
    ["O_soldierU_TL_F", "O_soldierU_medic_F", "O_Urban_HeavyGunner_F", "O_Urban_Sharpshooter_F", "O_soldierU_LAT_F"],                                           2.3
];

_sfSquads = [
    ["O_recon_TL_F", "O_recon_medic_F", "O_Pathfinder_F", "O_recon_exp_F", "O_recon_LAT_F", "O_recon_M_F", "O_recon_JTAC_F"],           1.25,
    ["O_recon_TL_F", "O_recon_medic_F", "O_Pathfinder_F", "O_recon_exp_F", "O_recon_M_F", "O_recon_JTAC_F"],                            1.5
];

_vpSquads = [
    ["O_V_Soldier_TL_hex_F", "O_V_Soldier_Medic_hex_F", "O_V_Soldier_JTAC_hex_F", "O_V_Soldier_M_hex_F", "O_V_Soldier_LAT_hex_F", "O_V_Soldier_Exp_hex_F"],         1
];

// Teams
_infTeams = [
    ["O_Soldier_TL_F", "O_medic_F", "O_Soldier_AR_F", "O_Soldier_LAT_F"],                           2,
    ["O_Soldier_TL_F", "O_medic_F", "O_Soldier_GL_F", "O_soldier_M_F"],                             2,
    ["O_Soldier_TL_F", "O_medic_F", "O_HeavyGunner_F", "O_Sharpshooter_F"],                         1.75,
    ["O_soldierU_TL_F", "O_soldierU_medic_F", "O_soldierU_AR_F", "O_soldierU_LAT_F"],               2,
    ["O_soldierU_TL_F", "O_soldierU_medic_F", "O_SoldierU_GL_F", "O_soldierU_M_F"],                 2,
    ["O_soldierU_TL_F", "O_soldierU_medic_F", "O_Urban_HeavyGunner_F", "O_Urban_Sharpshooter_F"],   1.75
];

_sfTeams = [
    ["O_recon_TL_F", "O_recon_medic_F", "O_Pathfinder_F", "O_recon_M_F"],           1.25,
    ["O_recon_TL_F", "O_recon_medic_F", "O_recon_exp_F", "O_recon_LAT_F"],          1.25,
    ["O_recon_TL_F", "O_recon_medic_F", "O_recon_JTAC_F", "O_recon_exp_F"],         1.25
];

_vpTeams = [
    ["O_V_Soldier_TL_hex_F", "O_V_Soldier_Medic_hex_F", "O_V_Soldier_LAT_hex_F", "O_V_Soldier_Exp_hex_F"],      1,
    ["O_V_Soldier_TL_hex_F", "O_V_Soldier_Medic_hex_F", "O_V_Soldier_JTAC_hex_F", "O_V_Soldier_M_hex_F"],       1
];

_atTeams = [
    ["O_Soldier_TL_F", "O_Soldier_AT_F", "O_Soldier_AT_F", "O_Soldier_AAT_F"],              1.5,
    ["O_Soldier_TL_F", "O_Soldier_HAT_F", "O_Soldier_HAT_F", "O_Soldier_AHAT_F"],           1.25,
    ["O_soldierU_TL_F", "O_soldierU_AT_F", "O_soldierU_AT_F", "O_soldierU_AAT_F"],          1.5
];

_aaTeams = [
    ["O_Soldier_TL_F", "O_Soldier_AA_F", "O_Soldier_AA_F", "O_Soldier_AAA_F"],          1.5,
    ["O_soldierU_TL_F", "O_soldierU_AA_F", "O_soldierU_AA_F", "O_soldierU_AAA_F"],      1.5
];

_srTeams = [
    ["O_sniper_F", "O_spotter_F"], 0.75
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

InA_FactionMappings insert [["CSAT", _factionMapping]];
