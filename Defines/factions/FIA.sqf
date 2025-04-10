/////////////
//// FIA ////
/////////////

private _infSquads = [];
private _infTeams = [];

private _factionMapping = createHashMap;
private _infantryMappings = createHashMap;

_factionMapping insert [
    ["#name", "FIA"],
    ["#side", east]
];


//// Infantry ////

// Units
_infantryMappings insert [
    ["#officers", ["O_G_officer_F"]],
    ["#squadleaders", ["O_G_Soldier_SL_F"]],
    ["#teamleaders", ["O_G_Soldier_TL_F"]],
    ["#riflemen", ["O_G_Soldier_F"]],
    ["#lats", ["O_G_Soldier_LAT_F"]],
    ["#grenadiers", ["O_G_Soldier_GL_F"]],
    ["#machinegunners", ["O_G_Soldier_AR_F"]],
    ["#heavygunners", ["O_G_Soldier_AR_F"]],
    ["#marksmen", ["O_G_soldier_M_F"]],
    ["#sharpshooters", ["O_G_Sharpshooter_F"]],
    ["#snipers", ["O_G_Sharpshooter_F"]],
    ["#spotters", ["O_G_Soldier_lite_F"]],
    ["#ats", ["O_G_Soldier_LAT2_F"]],
    ["#hats", ["O_G_Soldier_LAT2_F"]],
    ["#aas", ["O_G_Soldier_LAT_F"]],
    ["#medics", ["O_G_medic_F"]],
    ["#demos", ["O_G_Soldier_exp_F"]],
    ["#engineers", ["O_G_engineer_F"]],
    ["#paras", ["O_G_Soldier_F"]]
];

// Squads
_infSquads = [
    ["O_G_Soldier_SL_F", "O_G_medic_F", "O_G_Soldier_AR_F", "O_G_Soldier_GL_F", "O_G_Soldier_LAT_F", "O_G_Soldier_TL_F", "O_G_engineer_F", "O_G_soldier_M_F"],  1,
    ["O_G_Soldier_SL_F", "O_G_medic_F", "O_G_Sharpshooter_F", "O_G_Soldier_LAT_F", "O_G_Soldier_F", "O_G_Soldier_TL_F", "O_G_Soldier_AR_F", "O_G_engineer_F"],  0.9,

    ["O_G_Soldier_TL_F", "O_G_medic_F", "O_G_Soldier_AR_F", "O_G_Soldier_LAT_F", "O_G_engineer_F", "O_G_soldier_M_F"],                                          1.2,
    ["O_G_Soldier_TL_F", "O_G_medic_F", "O_G_Sharpshooter_F", "O_G_Soldier_LAT_F", "O_G_Soldier_AR_F", "O_G_engineer_F"],                                       1.2,

    ["O_G_Soldier_TL_F", "O_G_medic_F", "O_G_Soldier_AR_F", "O_G_Soldier_LAT_F", "O_G_soldier_M_F"],                                                            1.3,
    ["O_G_Soldier_TL_F", "O_G_medic_F", "O_G_Sharpshooter_F", "O_G_Soldier_LAT_F", "O_G_engineer_F"],                                                           1.3
];

// Teams
_infTeams = [
    ["O_G_Soldier_SL_F", "O_G_medic_F", "O_G_Soldier_AR_F", "O_G_Soldier_GL_F"],    1,
    ["O_G_Soldier_SL_F", "O_G_medic_F", "O_G_Sharpshooter_F", "O_G_Soldier_LAT_F"], 0.9,
    ["O_G_Soldier_SL_F", "O_G_medic_F", "O_G_soldier_M_F", "O_G_engineer_F"],       1,
    ["O_G_Soldier_SL_F", "O_G_medic_F", "O_G_Soldier_exp_F", "O_G_Soldier_LAT_F"],  0.9,
    ["O_G_Soldier_SL_F", "O_G_medic_F", "O_G_Soldier_AR_F", "O_G_Soldier_LAT2_F"],  1,
    ["O_G_Soldier_SL_F", "O_G_medic_F", "O_G_Soldier_exp_F", "O_G_Soldier_GL_F"],   0.9
];

_infantryMappings insert [["#squads", _infSquads]];
_infantryMappings insert [["#teams", _infTeams]];

_factionMapping insert [
    ["#infantry", _infantryMappings]
];

InA_FactionMappings insert [["FIA", _factionMapping]];
