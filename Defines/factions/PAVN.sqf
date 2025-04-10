//////////////
//// PAVN ////
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
    ["#name", "PAVN"],
    ["#side", east],
    ["#aux_factions", ["VC_M", "VC_L"]],
    ["#aux_faction_weights", [1.25, 1.5]],
    ["#indep_factions", ["VC_M"]],
    ["#guer_factions", ["VC_L"]],
    ["#addons", ["loadorder_f_vietnam"]]
];


//// Infantry ////

// Units
_infantryMappings insert [
    ["#officers", ["vn_o_men_nva_01"]],
    ["#squadleaders", ["vn_o_men_nva_01"]],
    ["#teamleaders", ["vn_o_men_nva_01"]],
    ["#riflemen", ["vn_o_men_nva_05"]],
    ["#lats", ["vn_o_men_nva_14"]],
    ["#grenadiers", ["vn_o_men_nva_07"]],
    ["#machinegunners", ["vn_o_men_nva_11"]],
    ["#heavygunners", ["vn_o_men_nva_11"]],
    ["#marksmen", ["vn_o_men_nva_10"]],
    ["#sharpshooters", ["vn_o_men_nva_10"]],
    ["#snipers", ["vn_o_men_nva_10"]],
    ["#spotters", ["vn_o_men_nva_12"]],
    ["#ats", ["vn_o_men_nva_14"]],
    ["#hats", ["vn_o_men_nva_14"]],
    ["#aas", ["vn_o_men_nva_43"]],
    ["#medics", ["vn_o_men_nva_08"]],
    ["#demos", ["vn_o_men_nva_05"]],
    ["#engineers", ["vn_o_men_nva_09"]],
    ["#paras", ["vn_o_men_nva_05"]],

    ["#civs", ["vn_c_men_01","vn_c_men_02","vn_c_men_03","vn_c_men_04","vn_c_men_05","vn_c_men_06","vn_c_men_07","vn_c_men_08","vn_c_men_09","vn_c_men_10"]]
];

// Squads
_infSquads = [
    ["vn_o_men_nva_01", "vn_o_men_nva_08", "vn_o_men_nva_11", "vn_o_men_nva_07", "vn_o_men_nva_14", "vn_o_men_nva_01", "vn_o_men_nva_09", "vn_o_men_nva_10"],   1,
    ["vn_o_men_nva_01", "vn_o_men_nva_09", "vn_o_men_nva_10", "vn_o_men_nva_14", "vn_o_men_nva_01", "vn_o_men_nva_05", "vn_o_men_nva_08", "vn_o_men_nva_11"],   0.9,

    ["vn_o_men_nva_01", "vn_o_men_nva_08", "vn_o_men_nva_11", "vn_o_men_nva_07", "vn_o_men_nva_14", "vn_o_men_nva_10"],                                         1.2,
    ["vn_o_men_nva_01", "vn_o_men_nva_09", "vn_o_men_nva_14", "vn_o_men_nva_05", "vn_o_men_nva_08", "vn_o_men_nva_11"],                                         1.2
];

_sfSquads = _infSquads;
_vpSquads = _sfSquads;

// Teams
_infTeams = [
    ["vn_o_men_nva_01", "vn_o_men_nva_08", "vn_o_men_nva_11", "vn_o_men_nva_14"], 1,
    ["vn_o_men_nva_01", "vn_o_men_nva_08", "vn_o_men_nva_07", "vn_o_men_nva_10"], 1
];

_sfTeams = _infTeams;
_vpTeams = _sfTeams;

_atTeams = [
    ["vn_o_men_nva_01", "vn_o_men_nva_14", "vn_o_men_nva_14", "vn_o_men_nva_05"], 1,
    ["vn_o_men_nva_01", "vn_o_men_nva_14", "vn_o_men_nva_14", "vn_o_men_nva_07"], 0.5,
    ["vn_o_men_nva_01", "vn_o_men_nva_14", "vn_o_men_nva_14", "vn_o_men_nva_10"], 0.75
];

_aaTeams = [
    ["vn_o_men_nva_01", "vn_o_men_nva_43", "vn_o_men_nva_43", "vn_o_men_nva_05"], 1
];

_srTeams = [
    ["vn_o_men_nva_10", "vn_o_men_nva_12"], 1
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
    "vn_o_wheeled_z157_mg_01", 15
];

// IFVs
_vehIFVs = [
    "vn_o_wheeled_btr40_mg_01", 1,
    "vn_o_wheeled_btr40_mg_02", 1
];

// AAs
_vehSPAAs = [
    "vn_o_wheeled_z157_mg_02_nva65",    1,
    "vn_o_wheeled_btr40_mg_03_nva65",   0.75
];

// MBTs
_vehMBTs = [
    "vn_o_armor_type63_01", 1,
    "vn_o_armor_pt76b_01",  1,
    "vn_o_armor_pt76a_01",  1
];

// Helis
_vehHelis = [
    "vn_o_air_mi2_04_03", 0.3,
    "vn_o_air_mi2_04_02", 0.3,
    "vn_o_air_mi2_03_06", 0.3,
    "vn_o_air_mi2_05_01", 0.1,
    "vn_o_air_mi2_03_03", 0.3,
    "vn_o_air_mi2_01_01", 0.9,
    "vn_o_air_mi2_01_03", 0.9
];

// Heli CAS
_vehHeliCAS = [
    "vn_o_air_mi2_04_03", 1,
    "vn_o_air_mi2_04_02", 1,
    "vn_o_air_mi2_03_06", 1,
    "vn_o_air_mi2_05_01", 0.5,
    "vn_o_air_mi2_03_03", 1
];

// Jets
_vehJets = [
    "vn_o_air_mig19_mr",    1,
    "vn_o_air_mig19_hbmb",  1,
    "vn_o_air_mig19_gun",   2,
    "vn_o_air_mig19_cap",   3,
    "vn_o_air_mig19_cas",   1,
    "vn_o_air_mig19_bmb",   1
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

InA_FactionMappings insert [["PAVN", _factionMapping]];
