//////////////
//// TURA ////
//////////////

private _infSquads = [];
private _infTeams = [];

private _factionMapping = createHashMap;
private _infantryMappings = createHashMap;

_factionMapping insert [
    ["#name", "TURA"],
    ["#side", independent],
    ["#addons", ["data_f_lxWS_Loadorder"]]
];


//// Infantry ////

// Units
_infantryMappings insert [
    ["#officers", ["I_SFIA_watcher_lxWS", "I_Tura_deserter_lxWS"]],
    ["#squadleaders", ["I_SFIA_watcher_lxWS", "I_Tura_deserter_lxWS"]],
    ["#teamleaders", ["I_SFIA_watcher_lxWS", "I_Tura_deserter_lxWS"]],
    ["#riflemen", ["I_Tura_deserter_lxWS", "I_SFIA_defector_lxWS"]],
    ["#lats", ["I_SFIA_hireling_lxWS", "I_Tura_soldier_UAV_lxWS"]],
    ["#grenadiers", ["I_C_Soldier_Bandit_6_F"]],
    ["#machinegunners", ["I_SFIA_enforcer_lxWS", "I_Tura_HeavyGunner_lxWS"]],
    ["#heavygunners", ["I_SFIA_enforcer_lxWS", "I_Tura_HeavyGunner_lxWS"]],
    ["#marksmen", ["I_SFIA_scout_lxWS"]],
    ["#sharpshooters", ["I_SFIA_scout_lxWS"]],
    ["#snipers", ["I_SFIA_scout_lxWS"]],
    ["#spotters", ["I_SFIA_watcher_lxWS"]],
    ["#ats", ["I_SFIA_hireling_lxWS", "I_Tura_soldier_UAV_lxWS"]],
    ["#hats", ["I_SFIA_hireling_lxWS", "I_Tura_soldier_UAV_lxWS"]],
    ["#aas", ["I_SFIA_hireling_lxWS", "I_Tura_soldier_UAV_lxWS"]],
    ["#medics", ["I_SFIA_medic2_lxWS"]],
    ["#demos", ["I_Tura_soldier_UAV_lxWS"]],
    ["#engineers", ["I_Tura_soldier_UAV_lxWS"]],
    ["#paras", ["I_SFIA_defector_lxWS", "I_Tura_deserter_lxWS"]]
];

// Squads
_infSquads = [
    ["I_SFIA_watcher_lxWS", "I_SFIA_medic2_lxWS", "I_SFIA_enforcer_lxWS", "I_SFIA_thug_lxWS", "I_SFIA_hireling_lxWS", "I_SFIA_enforcer_lxWS", "I_Tura_soldier_UAV_lxWS", "I_SFIA_enforcer_lxWS"],       1,
    ["I_Tura_deserter_lxWS", "I_SFIA_medic2_lxWS", "I_SFIA_defector_lxWS", "I_Tura_soldier_UAV_lxWS", "I_SFIA_scout_lxWS", "I_Tura_deserter_lxWS", "I_Tura_HeavyGunner_lxWS", "I_SFIA_enforcer_lxWS"],  0.9,

    ["I_SFIA_watcher_lxWS", "I_SFIA_medic2_lxWS", "I_SFIA_enforcer_lxWS", "I_SFIA_hireling_lxWS", "I_Tura_soldier_UAV_lxWS", "I_SFIA_enforcer_lxWS"],                                                   1.2,
    ["I_Tura_deserter_lxWS", "I_SFIA_medic2_lxWS", "I_SFIA_defector_lxWS", "I_Tura_soldier_UAV_lxWS", "I_Tura_HeavyGunner_lxWS", "I_SFIA_enforcer_lxWS"],                                               1.2,

    ["I_SFIA_watcher_lxWS", "I_SFIA_medic2_lxWS", "I_SFIA_hireling_lxWS", "I_Tura_soldier_UAV_lxWS", "I_SFIA_enforcer_lxWS"],                                                                           1.3,
    ["I_Tura_deserter_lxWS", "I_SFIA_medic2_lxWS", "I_Tura_soldier_UAV_lxWS", "I_Tura_HeavyGunner_lxWS", "I_SFIA_enforcer_lxWS"],                                                                       1.3
];

// Teams
_infTeams = [
    ["I_SFIA_watcher_lxWS", "I_SFIA_medic2_lxWS", "I_SFIA_enforcer_lxWS", "I_SFIA_thug_lxWS"],      1,
    ["I_Tura_deserter_lxWS", "I_SFIA_medic2_lxWS", "I_SFIA_scout_lxWS", "I_SFIA_hireling_lxWS"],    0.9,
    ["I_SFIA_watcher_lxWS", "I_SFIA_medic2_lxWS", "I_SFIA_defector_lxWS", "I_SFIA_enforcer_lxWS"],  1,
    ["I_Tura_deserter_lxWS", "I_SFIA_medic2_lxWS", "I_SFIA_enforcer_lxWS", "I_SFIA_enforcer_lxWS"], 0.9,
    ["I_SFIA_watcher_lxWS", "I_SFIA_medic2_lxWS", "I_SFIA_enforcer_lxWS", "I_SFIA_hireling_lxWS"],  1,
    ["I_Tura_deserter_lxWS", "I_SFIA_medic2_lxWS", "I_Tura_soldier_UAV_lxWS", "I_SFIA_thug_lxWS"],  0.9
];

_infantryMappings insert [["#squads", _infSquads]];
_infantryMappings insert [["#teams", _infTeams]];

_factionMapping insert [
    ["#infantry", _infantryMappings]
];

InA_FactionMappings insert [["TURA", _factionMapping]];
