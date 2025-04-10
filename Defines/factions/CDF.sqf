/////////////
//// CDF ////
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
    ["#name", "CDF"],
    ["#side", independent],
    ["#aux_factions", ["AFRF", "RACS"]],
    ["#aux_faction_weights", [1.5, 1]],
    ["#indep_factions", ["AFRF", "RACS"]]
];


//// Infantry ////

// Units
_infantryMappings insert [
    ["#officers", ["rhsgref_cdf_reg_officer"]],
    ["#squadleaders", ["rhsgref_cdf_reg_squadleader"]],
    ["#teamleaders", ["rhsgref_cdf_reg_squadleader"]],
    ["#riflemen", ["rhsgref_cdf_reg_rifleman"]],
    ["#lats", ["rhsgref_cdf_reg_rifleman_rpg75"]],
    ["#grenadiers", ["rhsgref_cdf_reg_grenadier"]],
    ["#machinegunners", ["rhsgref_cdf_reg_arifleman_rpk"]],
    ["#heavygunners", ["rhsgref_cdf_reg_machinegunner"]],
    ["#marksmen", ["rhsgref_cdf_reg_marksman"]],
    ["#sharpshooters", ["rhsgref_cdf_reg_marksman"]],
    ["#snipers", ["rhsgref_cdf_para_marksman"]],
    ["#spotters", ["rhsgref_cdf_para_rifleman_lite"]],
    ["#ats", ["rhsgref_cdf_reg_grenadier_rpg"]],
    ["#aas", ["rhsgref_cdf_reg_specialist_aa"]],
    ["#medics", ["rhsgref_cdf_reg_medic"]],
    ["#demos", ["rhsgref_cdf_reg_engineer"]],
    ["#engineers", ["rhsgref_cdf_reg_engineer"]],
    ["#paras", ["rhsgref_cdf_para_rifleman"]],
    ["#crews", ["rhsgref_cdf_reg_crew_commander", "rhsgref_cdf_reg_crew"]],
    ["#heli_pilots", ["rhsgref_cdf_air_pilot"]],
    ["#heli_crews", ["rhsgref_cdf_air_pilot"]],
    ["#pilots", ["rhsgref_cdf_air_pilot"]],
    ["#repair", ["rhsgref_cdf_reg_engineer"]],
    ["#ammos", ["rhsgref_cdf_reg_arifleman_rpk"]],
    ["#aats", ["rhsgref_cdf_reg_rifleman_rpg75"]],
    ["#aaas", ["rhsgref_cdf_reg_rifleman_rpg75"]],
    ["#ahats", ["rhsgref_cdf_reg_rifleman_rpg75"]],

    ["#civs", ["C_man_1","C_man_polo_1_F_euro","C_man_polo_2_F_euro","C_man_polo_2_F","C_man_polo_3_F","C_man_polo_4_F","C_man_polo_6_F","C_man_shorts_4_F_asia"]]
];

// Squads
_infSquads = [
    ["rhsgref_cdf_reg_squadleader", "rhsgref_cdf_reg_medic", "rhsgref_cdf_reg_machinegunner", "rhsgref_cdf_reg_grenadier", "rhsgref_cdf_reg_rifleman_rpg75", "rhsgref_cdf_reg_squadleader", "rhsgref_cdf_reg_engineer", "rhsgref_cdf_reg_marksman"], 2,
    ["rhsgref_cdf_reg_squadleader", "rhsgref_cdf_reg_medic", "rhsgref_cdf_reg_engineer", "rhsgref_cdf_reg_arifleman_rpk", "rhsgref_cdf_reg_rifleman_rpg75", "rhsgref_cdf_reg_squadleader", "rhsgref_cdf_reg_engineer", "rhsgref_cdf_reg_rifleman"], 2,

    ["rhsgref_cdf_reg_squadleader", "rhsgref_cdf_reg_medic", "rhsgref_cdf_reg_arifleman_rpk", "rhsgref_cdf_reg_rifleman_rpg75", "rhsgref_cdf_reg_engineer", "rhsgref_cdf_reg_marksman"], 2.5,
    ["rhsgref_cdf_reg_squadleader", "rhsgref_cdf_reg_medic", "rhsgref_cdf_reg_engineer", "rhsgref_cdf_reg_arifleman_rpk", "rhsgref_cdf_reg_rifleman_rpg75", "rhsgref_cdf_reg_engineer"], 2.5,

    ["rhsgref_cdf_reg_squadleader", "rhsgref_cdf_reg_medic", "rhsgref_cdf_reg_machinegunner", "rhsgref_cdf_reg_rifleman_rpg75", "rhsgref_cdf_reg_marksman"], 2.25,
    ["rhsgref_cdf_reg_squadleader", "rhsgref_cdf_reg_medic", "rhsgref_cdf_reg_engineer", "rhsgref_cdf_reg_rifleman_rpg75", "rhsgref_cdf_reg_rifleman"], 2.25
];

_sfSquads = _infSquads;
_vpSquads = _sfSquads;

// Teams
_infTeams = [
    ["rhsgref_cdf_reg_squadleader", "rhsgref_cdf_reg_medic", "rhsgref_cdf_reg_arifleman_rpk", "rhsgref_cdf_reg_marksman"], 1,
    ["rhsgref_cdf_reg_squadleader", "rhsgref_cdf_reg_medic", "rhsgref_cdf_reg_engineer", "rhsgref_cdf_reg_engineer"], 1,
    ["rhsgref_cdf_reg_squadleader", "rhsgref_cdf_reg_medic", "rhsgref_cdf_reg_rifleman_rpg75", "rhsgref_cdf_reg_engineer"], 1,
    ["rhsgref_cdf_reg_squadleader", "rhsgref_cdf_reg_medic", "rhsgref_cdf_reg_rifleman_rpg75", "rhsgref_cdf_reg_arifleman_rpk"], 1
];

_sfTeams = _infTeams;
_vpTeams = [];

_atTeams = [
    ["rhsgref_cdf_reg_squadleader", "rhsgref_cdf_reg_grenadier_rpg", "rhsgref_cdf_reg_grenadier_rpg", "rhsgref_cdf_reg_rifleman_rpg75"], 1,
    ["rhsgref_cdf_reg_squadleader", "rhsgref_cdf_reg_rifleman_rpg75", "rhsgref_cdf_reg_rifleman_rpg75", "rhsgref_cdf_reg_arifleman_rpk"], 1
];

_aaTeams = [
    ["rhsgref_cdf_reg_squadleader", "rhsgref_cdf_reg_specialist_aa", "rhsgref_cdf_reg_specialist_aa", "rhsgref_cdf_reg_rifleman_rpg75"], 1
];

_srTeams = [
    ["rhsgref_cdf_para_marksman", "rhsgref_cdf_para_rifleman_lite"], 1
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
    "rhsgref_cdf_reg_uaz_dshkm", 1,
    "rhsgref_cdf_reg_uaz_ags", 1,
    "rhsgref_cdf_reg_uaz_spg9", 0.75
];

// IFVs
_vehIFVs = [
    "rhsgref_cdf_bmp2k", 1.5,
    "rhsgref_cdf_bmp2d", 1.5,
    "rhsgref_cdf_bmd2k", 1.25,
    "rhsgref_cdf_bmd2", 1,
    "rhsgref_cdf_bmp1p", 0.75,
    "rhsgref_cdf_bmd1p", 0.75
];

// AAs
_vehSPAAs = [
    "rhsgref_cdf_zsu234", 2,
    "PRACS_SLA_2S6M_Tunguska", 1,
    "PRACS_SLA_SA13", 1,
    "PRACS_SLA_SA9", 1
];

// MBTs
_vehMBTs = [
    "rhsgref_cdf_t80uk_tv", 1,
    "rhsgref_cdf_t80u_tv", 0.75,
    "rhsgref_cdf_t72bb_tv", 0.75,
    "rhsgref_cdf_t80bv_tv", 0.5
];

// Helis
_vehHelis = [
    "rhsgref_cdf_Mi35", 0.5,
    "rhsgref_cdf_reg_Mi17Sh", 1,
    "rhsgref_cdf_reg_Mi8amt", 1
];

// Heli CAS
_vehHeliCAS = [
    "rhsgref_mi24g_CAS", 1
];

// Jets
_vehJets = [
    "rhsgref_cdf_su25", 2,
    "rhsgref_cdf_mig29s", 1.5,
    "rhs_l39_cdf", 1
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

InA_FactionMappings insert [["CDF", _factionMapping]];
