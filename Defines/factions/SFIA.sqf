//////////////
//// SFIA ////
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
    ["#name", "SFIA"],
    ["#side", east],
    ["#aux_factions", ["TURA", "SYND"]],
    ["#aux_faction_weights", [1.5, 1]],
    ["#indep_factions", ["TURA"]],
    ["#guer_factions", ["TURA"]],
    ["#addons", ["data_f_lxWS_Loadorder"]]
];


//// Infantry ////

// Units
_infantryMappings insert [
    ["#officers", ["O_SFIA_officer_lxWS"]],
    ["#squadleaders", ["O_SFIA_Soldier_TL_lxWS"]],
    ["#teamleaders", ["O_SFIA_Soldier_TL_lxWS"]],
    ["#riflemen", ["O_SFIA_soldier_lxWS"]],
    ["#lats", ["O_SFIA_soldier_at_lxWS"]],
    ["#grenadiers", ["O_SFIA_Soldier_GL_lxWS"]],
    ["#machinegunners", ["O_SFIA_Soldier_AR_lxWS"]],
    ["#heavygunners", ["O_SFIA_HeavyGunner_lxWS"]],
    ["#marksmen", ["O_SFIA_sharpshooter_lxWS"]],
    ["#sharpshooters", ["O_SFIA_sharpshooter_lxWS"]],
    ["#snipers", ["O_SFIA_sharpshooter_lxWS"]],
    ["#spotters", ["O_SFIA_Soldier_TL_lxWS"]],
    ["#ats", ["O_SFIA_soldier_aa_lxWS"]],
    ["#aas", ["O_SFIA_soldier_aa_lxWS"]],
    ["#medics", ["O_SFIA_medic_lxWS"]],
    ["#demos", ["O_SFIA_exp_lxWS"]],
    ["#engineers", ["O_SFIA_repair_lxWS"]],
    ["#paras", ["O_SFIA_soldier_lxWS"]],
    ["#crews", ["O_SFIA_crew_lxWS"]],
    ["#heli_pilots", ["O_SFIA_pilot_lxWS"]],
    ["#heli_crews", ["O_SFIA_pilot_lxWS"]],
    ["#pilots", ["O_SFIA_pilot_lxWS"]],
    ["#repair", ["O_SFIA_repair_lxWS"]],
    ["#ammos", ["O_SFIA_soldier_lite_lxWS"]],
    ["#aats", ["O_SFIA_Soldier_AAT_lxWS"]],
    ["#aaas", ["O_SFIA_Soldier_AAA_lxWS"]],
    ["#ahats", ["O_SFIA_Soldier_AAT_lxWS"]],

    ["#civs", ["C_Djella_01_lxWS", "C_Tak_02_A_lxWS", "C_Tak_03_A_lxWS", "C_Djella_02_lxWS", "C_Tak_02_B_lxWS", "C_Tak_03_B_lxWS", "C_Djella_03_lxWS", "C_Tak_02_C_lxWS"]]
];

// Squads
_infSquads = [
    ["O_SFIA_Soldier_TL_lxWS", "O_SFIA_medic_lxWS", "O_SFIA_Soldier_AR_lxWS", "O_SFIA_Soldier_GL_lxWS", "O_SFIA_soldier_at_lxWS", "O_SFIA_Soldier_TL_lxWS", "O_SFIA_repair_lxWS", "O_SFIA_sharpshooter_lxWS"],  2,
    ["O_SFIA_Soldier_TL_lxWS", "O_SFIA_medic_lxWS", "O_SFIA_exp_lxWS", "O_SFIA_soldier_lite_lxWS", "O_SFIA_soldier_at_lxWS", "O_SFIA_Soldier_TL_lxWS", "O_SFIA_repair_lxWS", "O_SFIA_soldier_lxWS"],            2,

    ["O_SFIA_Soldier_TL_lxWS", "O_SFIA_medic_lxWS", "O_SFIA_HeavyGunner_lxWS", "O_SFIA_soldier_at_lxWS", "O_SFIA_repair_lxWS", "O_SFIA_sharpshooter_lxWS"],                                                     2.5,
    ["O_SFIA_Soldier_TL_lxWS", "O_SFIA_medic_lxWS", "O_SFIA_exp_lxWS", "O_SFIA_soldier_lite_lxWS", "O_SFIA_soldier_at_lxWS", "O_SFIA_repair_lxWS"],                                                             2.5,

    ["O_SFIA_Soldier_TL_lxWS", "O_SFIA_medic_lxWS", "O_SFIA_HeavyGunner_lxWS", "O_SFIA_soldier_at_lxWS", "O_SFIA_sharpshooter_lxWS"],                                                                           2.25,
    ["O_SFIA_Soldier_TL_lxWS", "O_SFIA_medic_lxWS", "O_SFIA_exp_lxWS", "O_SFIA_soldier_at_lxWS", "O_SFIA_soldier_lxWS"],                                                                                        2.25
];

_sfSquads = _infSquads;
_vpSquads = _sfSquads;

// Teams
_infTeams = [
    ["O_SFIA_Soldier_TL_lxWS", "O_SFIA_medic_lxWS", "O_SFIA_Soldier_AR_lxWS", "O_SFIA_sharpshooter_lxWS"],  1,
    ["O_SFIA_Soldier_TL_lxWS", "O_SFIA_medic_lxWS", "O_SFIA_exp_lxWS", "O_SFIA_repair_lxWS"],               1,
    ["O_SFIA_Soldier_TL_lxWS", "O_SFIA_medic_lxWS", "O_SFIA_soldier_at_lxWS", "O_SFIA_repair_lxWS"],        1,
    ["O_SFIA_Soldier_TL_lxWS", "O_SFIA_medic_lxWS", "O_SFIA_soldier_at_lxWS", "O_SFIA_soldier_lite_lxWS"],  1
];

_sfTeams = _infTeams;
_vpTeams = [];

_atTeams = [
    ["O_SFIA_Soldier_TL_lxWS", "O_SFIA_soldier_at_lxWS", "O_SFIA_soldier_at_lxWS", "O_SFIA_Soldier_AAT_lxWS"], 1
];

_aaTeams = [
    ["O_SFIA_Soldier_TL_lxWS", "O_SFIA_soldier_aa_lxWS", "O_SFIA_soldier_aa_lxWS", "O_SFIA_Soldier_AAA_lxWS"], 1
];

_srTeams = [
    ["O_SFIA_sharpshooter_lxWS", "O_SFIA_Soldier_TL_lxWS"], 1
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
    "O_SFIA_Offroad_armed_lxWS",    1,
    "O_SFIA_Offroad_AT_lxWS",       1,
    "O_G_Offroad_01_armed_F",       1
];

// IFVs
_vehIFVs = [
    "O_SFIA_APC_Tracked_02_cannon_lxWS",    1.5,
    "O_SFIA_APC_Tracked_02_30mm_lxWS",      1.5,
    "O_SFIA_APC_Wheeled_02_hmg_lxWS",       1.25
];

// AAs
_vehSPAAs = [
    "O_SFIA_Truck_02_aa_lxWS",          2,
    "O_SFIA_APC_Tracked_02_AA_lxWS",    1
];

// MBTs
_vehMBTs = [
    "O_SFIA_MBT_02_cannon_lxWS", 1.25
];

// Helis
_vehHelis = [
    "O_Heli_Light_02_dynamicLoadout_F", 0.75,
    "O_Heli_Light_02_unarmed_F",        1,
    "O_Heli_Transport_04_bench_F",      1,
    "O_Heli_Transport_04_covered_F",    1
];

// Heli CAS
_vehHeliCAS = [
    "O_SFIA_Heli_Attack_02_dynamicLoadout_lxWS", 1
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

InA_FactionMappings insert [["SFIA", _factionMapping]];
