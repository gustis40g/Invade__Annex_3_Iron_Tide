//////////////
//// RACS ////
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
    ["#name", "RACS"],
    ["#side", independent],
    ["#aux_factions", ["AFRF", "CDF"]],
    ["#aux_faction_weights", [1.5, 1]],
    ["#indep_factions", ["AFRF", "CDF"]],
    ["#addons", ["PRACS_Core"]]
];


//// Infantry ////

// Units
_infantryMappings insert [
    ["#officers", ["PRACS_Infantry_O"]],
    ["#squadleaders", ["PRACS_Infantry_SL", "PRACS_Paratrooper_SL"]],
    ["#teamleaders", ["PRACS_Infantry_TL", "PRACS_Paratrooper_TL"]],
    ["#riflemen", ["PRACS_Infantry", "PRACS_Paratrooper"]],
    ["#lats", ["PRACS_Infantry_LAT", "PRACS_Paratrooper_LAT"]],
    ["#grenadiers", ["PRACS_Infantry_GRE", "PRACS_Paratrooper_GRE"]],
    ["#machinegunners", ["PRACS_Infantry_MMG", "PRACS_Paratrooper_MMG"]],
    ["#heavygunners", ["PRACS_Infantry_MG", "PRACS_Paratrooper_MG"]],
    ["#marksmen", ["PRACS_Infantry_M", "PRACS_Paratrooper_M"]],
    ["#sharpshooters", ["PRACS_Infantry_SHTR", "PRACS_Paratrooper_SHTR"]],
    ["#snipers", ["PRACS_Mountaineer_SHTR"]],
    ["#spotters", ["PRACS_Mountaineer_Ranger"]],
    ["#ats", ["PRACS_Infantry_LAT", "PRACS_Paratrooper_RRM"]],
    ["#hats", ["PRACS_Infantry_AT", "PRACS_Paratrooper_AT"]],
    ["#aas", ["PRACS_Infantry_AA", "PRACS_Paratrooper_AA"]],
    ["#medics", ["PRACS_Infantry_Medic", "PRACS_Paratrooper_Medic"]],
    ["#demos", ["PRACS_Infantry_ENG", "PRACS_Paratrooper_ENG"]],
    ["#engineers", ["PRACS_Infantry_ENG", "PRACS_Paratrooper_ENG"]],
    ["#paras", ["PRACS_Paratrooper"]],
    ["#crews", ["PRACS_Tank_Crewman"]],
    ["#heli_pilots", ["PRACS_Heli_pilot"]],
    ["#heli_crews", ["PRACS_air_crew"]],
    ["#pilots", ["PRACS_jet_pilot"]],
    ["#repair", ["PRACS_Infantry_ENG", "PRACS_Paratrooper_ENG"]],
    ["#ammos", ["PRACS_Infantry_RKT",  "PRACS_Infantry_RKT"]],
    ["#aats", ["PRACS_Infantry_RKT",  "PRACS_Infantry_RKT"]],
    ["#aaas", ["PRACS_Infantry_RKT",  "PRACS_Infantry_RKT"]],
    ["#ahats", ["PRACS_Infantry_RKT"]],

    ["#civs", ["C_man_1","C_man_polo_1_F_euro","C_man_polo_2_F_euro","C_man_polo_2_F","C_man_polo_3_F","C_man_polo_4_F","C_man_polo_6_F","C_man_shorts_4_F_asia"]]
];

// Squads
_infSquads = [
    ["PRACS_Infantry_SL", "PRACS_Infantry_Medic", "PRACS_Infantry_MMG", "PRACS_Infantry_GRE", "PRACS_Infantry_LAT", "PRACS_Infantry_TL", "PRACS_Infantry_ENG", "PRACS_Infantry_M"],                  2,
    ["PRACS_Infantry_SL", "PRACS_Infantry_Medic", "PRACS_Infantry_MG", "PRACS_Infantry_SHTR", "PRACS_Infantry_LAT", "PRACS_Infantry_TL", "PRACS_Infantry_GRE"],                              1.75,

    ["PRACS_Infantry_TL", "PRACS_Infantry_Medic", "PRACS_Infantry_MMG", "PRACS_Infantry_GRE", "PRACS_Infantry_LAT", "PRACS_Infantry_M"],                                                    2.5,
    ["PRACS_Infantry_TL", "PRACS_Infantry_Medic", "PRACS_Infantry_MG", "PRACS_Infantry_SHTR", "PRACS_Infantry_LAT", "PRACS_Infantry_GRE"],                                                2.25,

    ["PRACS_Infantry_TL", "PRACS_Infantry_Medic", "PRACS_Infantry_MMG", "PRACS_Infantry_GRE", "PRACS_Infantry_LAT"],                                                                     2.6,
    ["PRACS_Infantry_TL", "PRACS_Infantry_Medic", "PRACS_Infantry_MG", "PRACS_Infantry_SHTR", "PRACS_Infantry_LAT"],                                                                  2.3,

    ["PRACS_Paratrooper_SL", "PRACS_Paratrooper_Medic", "PRACS_Paratrooper_MMG", "PRACS_Paratrooper_GRE", "PRACS_Paratrooper_LAT", "PRACS_Paratrooper_TL", "PRACS_Paratrooper_ENG", "PRACS_Paratrooper_M"], 2,
    ["PRACS_Paratrooper_SL", "PRACS_Paratrooper_Medic", "PRACS_Paratrooper_MG", "PRACS_Paratrooper_SHTR", "PRACS_Paratrooper_LAT", "PRACS_Paratrooper_TL", "PRACS_Paratrooper_GRE"],     1.75,

    ["PRACS_Paratrooper_TL", "PRACS_Paratrooper_Medic", "PRACS_Paratrooper_MMG", "PRACS_Paratrooper_GRE", "PRACS_Paratrooper_LAT", "PRACS_Paratrooper_M"],                                      2.5,
    ["PRACS_Paratrooper_TL", "PRACS_Paratrooper_Medic", "PRACS_Paratrooper_MG", "PRACS_Paratrooper_SHTR", "PRACS_Paratrooper_LAT", "PRACS_Paratrooper_GRE"],                        2.25,

    ["PRACS_Paratrooper_TL", "PRACS_Paratrooper_Medic", "PRACS_Paratrooper_MMG", "PRACS_Paratrooper_LAT", "PRACS_Paratrooper_M"],                                                         2.6,
    ["PRACS_Paratrooper_TL", "PRACS_Paratrooper_Medic", "PRACS_Paratrooper_MG", "PRACS_Paratrooper_SHTR", "PRACS_Paratrooper_LAT"],                                           2.3
];

_sfSquads = [
    ["PRACS_Mountaineer_TL", "PRACS_Mountaineer_Medic", "PRACS_Mountaineer_Ranger", "PRACS_Mountaineer_ENG", "PRACS_Mountaineer_LAT", "PRACS_Mountaineer_SHTR", "PRACS_Mountaineer_RTO"],           1.25,
    ["PRACS_Mountaineer_TL", "PRACS_Mountaineer_Medic", "PRACS_Mountaineer_Ranger", "PRACS_Mountaineer_ENG", "PRACS_Mountaineer_SHTR", "PRACS_Mountaineer_RTO"],                            1.5
];

_vpSquads = [
    ["PRACS_Commando_SL", "PRACS_Commando_Medic", "PRACS_Commando_RTO", "PRACS_Commando_M", "PRACS_Commando_RKT", "PRACS_Commando_ENG"],         1
];

// Teams
_infTeams = [
    ["PRACS_Infantry_TL", "PRACS_Infantry_Medic", "PRACS_Infantry_MMG", "PRACS_Infantry_LAT"],                           2,
    ["PRACS_Infantry_TL", "PRACS_Infantry_Medic", "PRACS_Infantry_GRE", "PRACS_Infantry_M"],                             2,
    ["PRACS_Infantry_TL", "PRACS_Infantry_Medic", "PRACS_Infantry_MG", "PRACS_Infantry_SHTR"],                         1.75,
    ["PRACS_Paratrooper_TL", "PRACS_Paratrooper_Medic", "PRACS_Paratrooper_MMG", "PRACS_Paratrooper_LAT"],               2,
    ["PRACS_Paratrooper_TL", "PRACS_Paratrooper_Medic", "PRACS_Paratrooper_GRE", "PRACS_Paratrooper_M"],                 2,
    ["PRACS_Paratrooper_TL", "PRACS_Paratrooper_Medic", "PRACS_Paratrooper_MG", "PRACS_Paratrooper_SHTR"],   1.75
];

_sfTeams = [
    ["PRACS_Mountaineer_TL", "PRACS_Mountaineer_Medic", "PRACS_Mountaineer_Ranger", "PRACS_Mountaineer_SHTR"],           1.25,
    ["PRACS_Mountaineer_TL", "PRACS_Mountaineer_Medic", "PRACS_Mountaineer_ENG", "PRACS_Mountaineer_LAT"],          1.25,
    ["PRACS_Mountaineer_TL", "PRACS_Mountaineer_Medic", "PRACS_Mountaineer_RTO", "PRACS_Mountaineer_ENG"],         1.25
];

_vpTeams = [
    ["PRACS_Commando_SL", "PRACS_Commando_Medic", "PRACS_Commando_RKT", "PRACS_Commando_ENG"],      1,
    ["PRACS_Commando_SL", "PRACS_Commando_Medic", "PRACS_Commando_RTO", "PRACS_Commando_M"],       1
];

_atTeams = [
    ["PRACS_Infantry_TL", "PRACS_Infantry_LAT", "PRACS_Infantry_LAT", "PRACS_Infantry_RKT"],              1.5,
    ["PRACS_Infantry_TL", "PRACS_Infantry_AT", "PRACS_Infantry_AT", "PRACS_Infantry_RKT"],           1.25,
    ["PRACS_Paratrooper_TL", "PRACS_Paratrooper_RRM", "PRACS_Paratrooper_RRM", "PRACS_Infantry_RKT"],          1.5
];

_aaTeams = [
    ["PRACS_Infantry_TL", "PRACS_Infantry_AA", "PRACS_Infantry_AA", "PRACS_Infantry_RKT"],          1.5,
    ["PRACS_Paratrooper_TL", "PRACS_Paratrooper_AA", "PRACS_Paratrooper_AA", "PRACS_Infantry_RKT"],      1.5
];

_srTeams = [
    ["PRACS_Mountaineer_SHTR", "PRACS_Mountaineer_Ranger"], 0.75
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
    "PRACS_M1025_M2", 3,
    "PRACS_M1151_Mk19", 2.25,
    "PRACS_M1165_M134_QSB", 2.75,
    "PRACS_M1117", 2.5,
    "PRACS_M113_M2", 2,
    "PRACS_M113_mk19", 2,
    "PRACS_M966_TOW", 2
];

// IFVs
_vehIFVs = [
    "PRACS_FV107", 1.75,
    "PRACS_Pizarro", 2,
    "PRACS_BMR_A3_GA1", 1.75,
    "PRACS_Pizarro_SLE", 2,
    "PRACS_FV101", 1.5,
    "PRACS_BMR_ATGM", 1.5
];

// AAs
_vehSPAAs = [
    "PRACS_M163_PIVADS", 2,
    "PRACS_M163_MACHBET", 1,
	"PRACS_M985_AD", 1,
	"PRACS_m48_chapparal", 1
];

// MBTs
_vehMBTs = [
    "PRACS_M1A1_AIM",    1,
    "PRACS_M60S",    0.85,
    "PRACS_M60A3",   0.75
];

// Helis
_vehHelis = [
    "PRACS_Sa330_Puma_SOCAT",    0.5,
    "PRACS_UH1H_CAS",     0.75,
    "PRACS_Sa330_Puma", 1,
    "PRACS_UH1H", 1,
    "PRACS_MH6S", 1
];

// Heli CAS
_vehHeliCAS = [
    "PRACS_AH1S", 0.5,
    "PRACS_Sa330_Puma_SOCAT", 1,
    "PRACS_UH1H_CAS", 1
];

// Jets
_vehJets = [
    "PRACS_A4M",      3,
    "PRACS_MirageV",  3,
    "PRACS_F16", 2,
    "PRACS_F16CJR", 1,
    "PRACS_Mohawk", 0.5
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

InA_FactionMappings insert [["RACS", _factionMapping]];
