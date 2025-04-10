/////////////
//// AAF ////
/////////////

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
    ["#name", "AAF"],
    ["#side", independent],
    ["#aux_factions", ["CSAT", "FIA", "SYND"]],
    ["#aux_faction_weights", [1, 1.5, 1.5]],
    ["#indep_factions", ["CSAT"]],
    ["#guer_factions", ["FIA", "SYND"]]
];


//// Infantry ////

// Units
_infantryMappings insert [
    ["#officers", ["I_officer_F"]],
    ["#squadleaders", ["I_Soldier_SL_F"]],
    ["#teamleaders", ["I_Soldier_TL_F"]],
    ["#riflemen", ["I_soldier_F"]],
    ["#lats", ["I_Soldier_LAT_F", "I_Soldier_LAT2_F"]],
    ["#grenadiers", ["I_Soldier_GL_F"]],
    ["#machinegunners", ["I_Soldier_AR_F"]],
    ["#heavygunners", ["I_Soldier_AR_F"]],
    ["#marksmen", ["I_Soldier_M_F"]],
    ["#sharpshooters", ["I_Soldier_M_F"]],
    ["#snipers", ["I_Sniper_F"]],
    ["#spotters", ["I_Spotter_F"]],
    ["#ats", ["I_Soldier_AT_F"]],
    ["#aas", ["I_Soldier_AA_F"]],
    ["#medics", ["I_medic_F"]],
    ["#demos", ["I_Soldier_exp_F"]],
    ["#engineers", ["I_engineer_F"]],
    ["#paras", ["I_soldier_F"]],
    ["#crews", ["I_crew_F"]],
    ["#heli_pilots", ["I_helipilot_F"]],
    ["#heli_crews", ["I_helicrew_F"]],
    ["#pilots", ["I_pilot_F"]],
    ["#repair", ["I_Soldier_repair_F"]],
    ["#ammos", ["I_Soldier_A_F"]],
    ["#aats", ["I_Soldier_AAT_F"]],
    ["#aaas", ["I_Soldier_AAA_F"]],
    ["#ahats", ["I_Soldier_AAT_F"]],

    ["#civs", ["C_man_1","C_man_polo_1_F_euro","C_man_polo_2_F_euro","C_man_polo_2_F","C_man_polo_3_F","C_man_polo_4_F","C_man_polo_6_F","C_man_shorts_4_F_asia"]]
];

// Squads
_infSquads = [
    ["I_Soldier_SL_F", "I_medic_F", "I_Soldier_AR_F", "I_Soldier_GL_F", "I_Soldier_LAT_F", "I_Soldier_TL_F", "I_engineer_F", "I_Soldier_M_F"],      2,
    ["I_Soldier_SL_F", "I_medic_F", "I_Soldier_exp_F", "I_Soldier_A_F", "I_Soldier_LAT2_F", "I_Soldier_TL_F", "I_Soldier_repair_F", "I_soldier_F"], 2,

    ["I_Soldier_TL_F", "I_medic_F", "I_Soldier_AR_F", "I_Soldier_LAT_F", "I_engineer_F", "I_Soldier_M_F"],                                          2.5,
    ["I_Soldier_TL_F", "I_medic_F", "I_Soldier_exp_F", "I_Soldier_A_F", "I_Soldier_LAT2_F", "I_Soldier_repair_F"],                                  2.5,

    ["I_Soldier_TL_F", "I_medic_F", "I_Soldier_AR_F", "I_Soldier_LAT_F", "I_Soldier_M_F"],                                                          2.25,
    ["I_Soldier_TL_F", "I_medic_F", "I_Soldier_exp_F", "I_Soldier_LAT2_F", "I_soldier_F"],                                                          2.25
];

_sfSquads = _infSquads;
_vpSquads = _sfSquads;

// Teams
_infTeams = [
    ["I_Soldier_TL_F", "I_medic_F", "I_Soldier_AR_F", "I_Soldier_M_F"],         1,
    ["I_Soldier_TL_F", "I_medic_F", "I_Soldier_exp_F", "I_engineer_F"],         1,
    ["I_Soldier_TL_F", "I_medic_F", "I_Soldier_LAT_F", "I_Soldier_repair_F"],   1,
    ["I_Soldier_TL_F", "I_medic_F", "I_Soldier_LAT2_F", "I_Soldier_A_F"],       1
];

_sfTeams = _infTeams;
_vpTeams = [];

_atTeams = [
    ["I_Soldier_TL_F", "I_Soldier_AT_F", "I_Soldier_AT_F", "I_Soldier_AAT_F"],      1,
    ["I_Soldier_TL_F", "I_Soldier_LAT2_F", "I_Soldier_LAT2_F", "I_Soldier_A_F"],    1
];

_aaTeams = [
    ["I_Soldier_TL_F", "I_Soldier_AA_F", "I_Soldier_AA_F", "I_Soldier_AAA_F"], 1
];

_srTeams = [
    ["I_Sniper_F", "I_Spotter_F"], 1
];

_infantryMappings insert [["#squads", _infSquads]];
_infantryMappings insert [["#specop_squads", _sfSquads]];
_infantryMappings insert [["#viper_squads", _vpSquads]];
_infantryMappings insert [["#teams", _infTeams]];
_infantryMappings insert [["#specop_teams", _sfTeams]];
_infantryMappings insert [["#viper_teams", _vpTeams]];
_infantryMappings insert [["#at_teams", _atTeams]];
_infantryMappings insert [["#aa_teams", _aaTeams]];
_infantryMappings insert [["#sniper_teams", _srTeams]];


//// Vehicles ////

// MRAPs
_vehMRAPs = [
    "I_MRAP_03_hmg_F",          1,
    "I_MRAP_03_gmg_F",          1,
    "O_G_Offroad_01_armed_F",   1
];

// IFVs
_vehIFVs = [
    "I_APC_tracked_03_cannon_F",    1.5,
    "I_APC_Wheeled_03_cannon_F",    1.5,
    "I_LT_01_AT_F",                 1.25,
    "I_LT_01_cannon_F",             1,
    "O_APC_Wheeled_02_rcws_v2_F",   0.75,
    "O_APC_Tracked_02_cannon_F",    0.75
];

// AAs
_vehSPAAs = [
    "I_LT_01_AA_F",             2,
    "O_APC_Tracked_02_AA_F",    1
];

// MBTs
_vehMBTs = [
    "I_MBT_03_cannon_F",    1.25,
    "O_MBT_02_cannon_F",    0.75,
    "O_MBT_04_cannon_F",    0.75,
    "O_MBT_04_command_F",   0.5
];

// Helis
_vehHelis = [
    "I_Heli_light_03_dynamicLoadout_F", 0.75,
    "I_Heli_Transport_02_F",            1,
    "I_Heli_light_03_unarmed_F",        1
];

// Heli CAS
_vehHeliCAS = [
    "I_Heli_light_03_dynamicLoadout_F", 1
];

// Jets
_vehJets = [
    "I_Plane_Fighter_03_dynamicLoadout_F",  2,
    "I_Plane_Fighter_04_F",                 1.5
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

InA_FactionMappings insert [["AAF", _factionMapping]];
