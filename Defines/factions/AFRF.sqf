//////////////
//// AFRF ////
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
    ["#name", "AFRF"],
    ["#side", east],
    ["#aux_factions", ["CDF", "RACS"]],
    ["#aux_faction_weights", [1, 1.5]],
    ["#indep_factions", ["CDF", "RACS"]],
    ["#addons", ["rhs_main", "PRACS_SLA_Core"]]
];


//// Infantry ////

// Units
_infantryMappings insert [
    ["#officers", ["rhs_vdv_officer", "rhs_vdv_des_officer"]],
    ["#squadleaders", ["rhs_vdv_sergeant", "rhs_vdv_des_sergeant"]],
    ["#teamleaders", ["rhs_vdv_junior_sergeant", "rhs_vdv_des_junior_sergeant"]],
    ["#riflemen", ["rhs_vdv_rifleman", "rhs_vdv_des_rifleman"]],
    ["#lats", ["rhs_vdv_LAT", "rhs_vdv_des_LAT"]],
    ["#grenadiers", ["rhs_vdv_grenadier_rpg", "rhs_vdv_des_grenadier_rpg"]],
    ["#machinegunners", ["rhs_vdv_arifleman_rpk", "rhs_vdv_des_arifleman_rpk"]],
    ["#heavygunners", ["rhs_vdv_machinegunner", "rhs_vdv_des_machinegunner"]],
    ["#marksmen", ["rhs_vdv_marksman", "rhs_vdv_des_marksman"]],
    ["#sharpshooters", ["rhs_vdv_marksman_asval", "rhs_vdv_des_marksman_asval"]],
    ["#snipers", ["rhs_vdv_recon_marksman"]],
    ["#spotters", ["rhs_vdv_recon_rifleman_scout"]],
    ["#ats", ["rhs_vdv_at", "rhs_vdv_des_at"]],
    ["#hats", ["rhs_vdv_at", "rhs_vdv_des_at"]],
    ["#aas", ["rhs_vdv_aa", "rhs_vdv_des_aa"]],
    ["#medics", ["rhs_vdv_medic", "rhs_vdv_des_medic"]],
    ["#demos", ["rhs_vdv_engineer", "rhs_vdv_des_engineer"]],
    ["#engineers", ["rhs_vdv_engineer", "rhs_vdv_des_engineer"]],
    ["#paras", ["rhs_vdv_LAT", "rhs_vdv_des_LAT"]],
    ["#crews", ["rhs_vdv_crew_commander", "rhs_vdv_combatcrew"]],
    ["#heli_pilots", ["rhs_pilot_combat_heli"]],
    ["#heli_crews", ["rhs_pilot_combat_heli"]],
    ["#pilots", ["rhs_pilot"]],
    ["#repair", ["rhs_vdv_engineer", "rhs_vdv_des_engineer"]],
    ["#ammos", ["rhs_vdv_machinegunner_assistant",  "rhs_vdv_des_machinegunner_assistant"]],
    ["#aats", ["rhs_vdv_strelok_rpg_assist",  "rhs_vdv_des_strelok_rpg_assist"]],
    ["#aaas", ["rhs_vdv_strelok_rpg_assist",  "rhs_vdv_des_strelok_rpg_assist"]],
    ["#ahats", ["rhs_vdv_strelok_rpg_assist"]],

    ["#civs", ["C_man_1","C_man_polo_1_F_euro","C_man_polo_2_F_euro","C_man_polo_2_F","C_man_polo_3_F","C_man_polo_4_F","C_man_polo_6_F","C_man_shorts_4_F_asia"]]
];

// Squads
_infSquads = [
    ["rhs_vdv_sergeant", "rhs_vdv_medic", "rhs_vdv_arifleman_rpk", "rhs_vdv_grenadier_rpg", "rhs_vdv_LAT", "rhs_vdv_junior_sergeant", "rhs_vdv_engineer", "rhs_vdv_marksman"], 2,
    ["rhs_vdv_sergeant", "rhs_vdv_medic", "rhs_vdv_machinegunner", "rhs_vdv_marksman_asval", "rhs_vdv_LAT", "rhs_vdv_junior_sergeant", "rhs_vdv_grenadier_rpg"], 1.75,

    ["rhs_vdv_junior_sergeant", "rhs_vdv_medic", "rhs_vdv_arifleman_rpk", "rhs_vdv_grenadier_rpg", "rhs_vdv_LAT", "rhs_vdv_marksman"], 2.5,
    ["rhs_vdv_junior_sergeant", "rhs_vdv_medic", "rhs_vdv_machinegunner", "rhs_vdv_marksman_asval", "rhs_vdv_LAT", "rhs_vdv_grenadier_rpg"], 2.25,

    ["rhs_vdv_junior_sergeant", "rhs_vdv_medic", "rhs_vdv_arifleman_rpk", "rhs_vdv_grenadier_rpg", "rhs_vdv_LAT"], 2.6,
    ["rhs_vdv_junior_sergeant", "rhs_vdv_medic", "rhs_vdv_machinegunner", "rhs_vdv_marksman_asval", "rhs_vdv_LAT"], 2.3,

    ["rhs_vdv_des_sergeant", "rhs_vdv_des_medic", "rhs_vdv_des_arifleman_rpk", "rhs_vdv_des_grenadier_rpg", "rhs_vdv_des_LAT", "rhs_vdv_des_junior_sergeant", "rhs_vdv_des_engineer", "rhs_vdv_des_marksman"], 2,
    ["rhs_vdv_des_sergeant", "rhs_vdv_des_medic", "rhs_vdv_des_machinegunner", "rhs_vdv_des_marksman_asval", "rhs_vdv_des_LAT", "rhs_vdv_des_junior_sergeant", "rhs_vdv_des_grenadier_rpg"], 1.75,

    ["rhs_vdv_des_junior_sergeant", "rhs_vdv_des_medic", "rhs_vdv_des_arifleman_rpk", "rhs_vdv_des_grenadier_rpg", "rhs_vdv_des_LAT", "rhs_vdv_des_marksman"], 2.5,
    ["rhs_vdv_des_junior_sergeant", "rhs_vdv_des_medic", "rhs_vdv_des_machinegunner", "rhs_vdv_des_marksman_asval", "rhs_vdv_des_LAT", "rhs_vdv_des_grenadier_rpg"], 2.25,

    ["rhs_vdv_des_junior_sergeant", "rhs_vdv_des_medic", "rhs_vdv_des_arifleman_rpk", "rhs_vdv_des_LAT", "rhs_vdv_des_marksman"], 2.6,
    ["rhs_vdv_des_junior_sergeant", "rhs_vdv_des_medic", "rhs_vdv_des_machinegunner", "rhs_vdv_des_marksman_asval", "rhs_vdv_des_LAT"], 2.3
];

_sfSquads = [
    ["rhs_vdv_recon_sergeant", "rhs_vdv_recon_medic", "rhs_vdv_recon_rifleman_scout", "rhs_vdv_recon_arifleman_scout", "rhs_vdv_recon_rifleman_lat", "rhs_vdv_recon_marksman", "rhs_vdv_recon_efreitor"], 1.25,
    ["rhs_vdv_recon_sergeant", "rhs_vdv_recon_medic", "rhs_vdv_recon_rifleman_scout", "rhs_vdv_recon_arifleman_scout", "rhs_vdv_recon_marksman", "rhs_vdv_recon_efreitor"], 1.5
];

_vpSquads = [
    ["rhs_vdv_recon_efreitor", "rhs_vdv_recon_rifleman_scout", "rhs_vdv_recon_marksman_asval", "rhs_vdv_recon_rifleman_asval", "rhs_vdv_recon_rifleman_scout_akm", "rhs_vdv_recon_marksman_asval"], 1
];

// Teams
_infTeams = [
    ["rhs_vdv_junior_sergeant", "rhs_vdv_medic", "rhs_vdv_arifleman_rpk", "rhs_vdv_LAT"], 2,
    ["rhs_vdv_junior_sergeant", "rhs_vdv_medic", "rhs_vdv_grenadier_rpg", "rhs_vdv_marksman"], 2,
    ["rhs_vdv_junior_sergeant", "rhs_vdv_medic", "rhs_vdv_machinegunner", "rhs_vdv_marksman_asval"], 1.75,
    ["rhs_vdv_des_junior_sergeant", "rhs_vdv_des_medic", "rhs_vdv_des_arifleman_rpk", "rhs_vdv_des_LAT"], 2,
    ["rhs_vdv_des_junior_sergeant", "rhs_vdv_des_medic", "rhs_vdv_des_grenadier_rpg", "rhs_vdv_des_marksman"], 2,
    ["rhs_vdv_des_junior_sergeant", "rhs_vdv_des_medic", "rhs_vdv_des_machinegunner", "rhs_vdv_des_marksman_asval"], 1.75
];

_sfTeams = [
    ["rhs_vdv_recon_sergeant", "rhs_vdv_recon_medic", "rhs_vdv_recon_rifleman_scout", "rhs_vdv_recon_marksman"], 1.25,
    ["rhs_vdv_recon_sergeant", "rhs_vdv_recon_medic", "rhs_vdv_recon_arifleman_scout", "rhs_vdv_recon_rifleman_lat"], 1.25,
    ["rhs_vdv_recon_sergeant", "rhs_vdv_recon_medic", "rhs_vdv_recon_efreitor", "rhs_vdv_recon_arifleman_scout"], 1.25
];

_vpTeams = [
    ["rhs_vdv_recon_efreitor", "rhs_vdv_recon_rifleman_scout", "rhs_vdv_recon_rifleman_scout_akm", "rhs_vdv_recon_marksman_asval"], 1,
    ["rhs_vdv_recon_efreitor", "rhs_vdv_recon_rifleman_scout", "rhs_vdv_recon_marksman_asval", "rhs_vdv_recon_rifleman_asval"], 1
];

_atTeams = [
    ["rhs_vdv_junior_sergeant", "rhs_vdv_at", "rhs_vdv_at", "rhs_vdv_strelok_rpg_assist"], 1.5,
    ["rhs_vdv_junior_sergeant", "rhs_vdv_at", "rhs_vdv_at", "rhs_vdv_strelok_rpg_assist"], 1.25,
    ["rhs_vdv_des_junior_sergeant", "rhs_vdv_des_at", "rhs_vdv_des_at", "rhs_vdv_des_strelok_rpg_assist"], 1.5
];

_aaTeams = [
    ["rhs_vdv_junior_sergeant", "rhs_vdv_aa", "rhs_vdv_aa", "rhs_vdv_strelok_rpg_assist"], 1.5,
    ["rhs_vdv_des_junior_sergeant", "rhs_vdv_des_aa", "rhs_vdv_des_aa", "rhs_vdv_des_strelok_rpg_assist"], 1.5
];

_srTeams = [
    ["rhs_vdv_recon_marksman", "rhs_vdv_recon_rifleman_scout"], 0.75
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
    "rhs_tigr_sts_3camo_vdv", 3,
    "rhs_tigr_sts_vdv", 2.25,
    "rhsgref_BRDM2_vdv", 2.75,
    "PRACS_SLA_BTR40_AT", 2,
    "rhs_btr80_vdv", 2,
    "PRACS_SLA_UAZ_AT", 2,
    "PRACS_SLA_UAZ_SPG9", 2
];

// IFVs
_vehIFVs = [
    "rhs_bmd4_vdv", 1.75,
    "rhs_bmp3mera_msv", 2,
    "rhs_bmd4ma_vdv", 1.75,
    "rhs_btr80a_vdv", 2,
    "rhs_bmd2m", 1.5,
    "rhs_bmp2k_vdv", 1.5
];

// AAs
_vehSPAAs = [
    "rhs_zsu234_aa", 2,
    "PRACS_SLA_2S6M_Tunguska", 1.5,
    "PRACS_SLA_SA13", 2,
    "PRACS_SLA_SA9", 2,
    "PRACS_SLA_SA8", 0.5
];

// MBTs
_vehMBTs = [
    "rhs_t90am_tv", 0.75,
    "rhs_t72be_tv", 0.85,
    "rhs_t80um", 1,
    "rhs_t90sab_tv", 1,
    "rhs_sprut_vdv", 0.5
];

// Helis
_vehHelis = [
    "RHS_Mi24V_vvsc", 0.5,
    "RHS_Mi8MTV3_heavy_vvsc", 0.75,
    "RHS_Mi8AMTSh_vvsc", 0.75,
    "RHS_Mi24Vt_vvsc", 0.75,
    "rhs_ka60_grey", 1,
    "rhs_ka60_c", 1,
    "RHS_Mi8mt_vvs", 1,
    "RHS_Mi8mt_vvsc", 1
];

// Heli CAS
_vehHeliCAS = [
    "RHS_Ka52_vvs", 0.75,
    "RHS_Mi24P_vvs", 1,
    "rhs_mi28n_vvs", 1
];

// Jets
_vehJets = [
    "RHS_Su25SM_vvsc", 3,
    "rhs_mig29sm_vvsc", 3,
    "rhs_mig29sm_vvs", 2,
    "RHS_T50_vvs_generic_ext", 1,
    "RHS_T50_vvs_blueonblue", 1
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

InA_FactionMappings insert [["AFRF", _factionMapping]];
