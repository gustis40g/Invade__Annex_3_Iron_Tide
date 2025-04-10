//////////////
//// SYND ////
//////////////

private _infSquads = [];
private _infTeams = [];

private _factionMapping = createHashMap;
private _infantryMappings = createHashMap;

_factionMapping insert [
    ["#name", "Syndikat"],
    ["#side", independent]
];


//// Infantry ////

// Units
_infantryMappings insert [
    ["#officers", ["I_C_Soldier_Bandit_4_F", "I_C_Soldier_Para_2_F"]],
    ["#squadleaders", ["I_C_Soldier_Bandit_4_F", "I_C_Soldier_Para_2_F"]],
    ["#teamleaders", ["I_C_Soldier_Bandit_4_F", "I_C_Soldier_Para_2_F"]],
    ["#riflemen", ["I_C_Soldier_Para_1_F", "I_C_Soldier_Bandit_5_F", "I_C_Soldier_Bandit_7_F", "I_C_Soldier_Para_7_F"]],
    ["#lats", ["I_C_Soldier_Bandit_2_F", "I_C_Soldier_Para_5_F"]],
    ["#grenadiers", ["I_C_Soldier_Bandit_6_F", "I_C_Soldier_Para_6_F"]],
    ["#machinegunners", ["I_C_Soldier_Bandit_3_F", "I_C_Soldier_Para_4_F"]],
    ["#heavygunners", ["I_C_Soldier_Bandit_3_F", "I_C_Soldier_Para_4_F"]],
    ["#marksmen", ["I_C_Soldier_Para_1_F", "I_C_Soldier_Bandit_5_F", "I_C_Soldier_Bandit_7_F", "I_C_Soldier_Para_7_F"]],
    ["#sharpshooters", ["I_C_Soldier_Para_1_F", "I_C_Soldier_Bandit_5_F", "I_C_Soldier_Bandit_7_F", "I_C_Soldier_Para_7_F"]],
    ["#snipers", ["I_C_Soldier_Para_1_F", "I_C_Soldier_Bandit_5_F", "I_C_Soldier_Bandit_7_F", "I_C_Soldier_Para_7_F"]],
    ["#spotters", ["I_C_Soldier_Para_1_F", "I_C_Soldier_Bandit_5_F", "I_C_Soldier_Bandit_7_F", "I_C_Soldier_Para_7_F"]],
    ["#ats", ["I_C_Soldier_Bandit_2_F", "I_C_Soldier_Para_5_F"]],
    ["#hats", ["I_C_Soldier_Bandit_2_F", "I_C_Soldier_Para_5_F"]],
    ["#aas", ["I_C_Soldier_Bandit_2_F", "I_C_Soldier_Para_5_F"]],
    ["#medics", ["I_C_Soldier_Bandit_1_F", "I_C_Soldier_Para_3_F"]],
    ["#demos", ["I_C_Soldier_Bandit_8_F", "I_C_Soldier_Para_8_F"]],
    ["#engineers", ["I_C_Soldier_Bandit_8_F", "I_C_Soldier_Para_8_F"]],
    ["#paras", ["I_C_Soldier_Para_1_F", "I_C_Soldier_Bandit_5_F", "I_C_Soldier_Bandit_7_F", "I_C_Soldier_Para_7_F"]]
];

// Squads
_infSquads = [
    ["I_C_Soldier_Bandit_4_F", "I_C_Soldier_Bandit_1_F", "I_C_Soldier_Bandit_3_F", "I_C_Soldier_Bandit_6_F", "I_C_Soldier_Bandit_2_F", "I_C_Soldier_Bandit_4_F", "I_C_Soldier_Bandit_8_F", "I_C_Soldier_Para_1_F"], 1,
    ["I_C_Soldier_Para_2_F", "I_C_Soldier_Para_3_F", "I_C_Soldier_Bandit_5_F", "I_C_Soldier_Para_5_F", "I_C_Soldier_Para_7_F", "I_C_Soldier_Para_2_F", "I_C_Soldier_Para_4_F", "I_C_Soldier_Para_8_F"],             0.9,

    ["I_C_Soldier_Bandit_4_F", "I_C_Soldier_Bandit_1_F", "I_C_Soldier_Bandit_3_F", "I_C_Soldier_Bandit_2_F", "I_C_Soldier_Bandit_8_F", "I_C_Soldier_Para_1_F"],                                                     1.2,
    ["I_C_Soldier_Para_2_F", "I_C_Soldier_Para_3_F", "I_C_Soldier_Bandit_5_F", "I_C_Soldier_Para_5_F", "I_C_Soldier_Para_4_F", "I_C_Soldier_Para_8_F"],                                                             1.2,

    ["I_C_Soldier_Bandit_4_F", "I_C_Soldier_Bandit_1_F", "I_C_Soldier_Bandit_2_F", "I_C_Soldier_Bandit_8_F", "I_C_Soldier_Para_1_F"],                                                                               1.3,
    ["I_C_Soldier_Para_2_F", "I_C_Soldier_Para_3_F", "I_C_Soldier_Para_5_F", "I_C_Soldier_Para_4_F", "I_C_Soldier_Para_8_F"],                                                                                       1.3
];

// Teams
_infTeams = [
    ["I_C_Soldier_Bandit_4_F", "I_C_Soldier_Bandit_1_F", "I_C_Soldier_Bandit_3_F", "I_C_Soldier_Para_6_F"],     1,
    ["I_C_Soldier_Para_2_F", "I_C_Soldier_Para_3_F", "I_C_Soldier_Bandit_7_F", "I_C_Soldier_Bandit_2_F"],       0.9,
    ["I_C_Soldier_Bandit_4_F", "I_C_Soldier_Bandit_1_F", "I_C_Soldier_Bandit_5_F", "I_C_Soldier_Bandit_3_F"],   1,
    ["I_C_Soldier_Para_2_F", "I_C_Soldier_Para_3_F", "I_C_Soldier_Para_8_F", "I_C_Soldier_Para_5_F"],           0.9,
    ["I_C_Soldier_Bandit_4_F", "I_C_Soldier_Bandit_1_F", "I_C_Soldier_Bandit_3_F", "I_C_Soldier_Bandit_2_F"],   1,
    ["I_C_Soldier_Para_2_F", "I_C_Soldier_Para_3_F", "I_C_Soldier_Bandit_8_F", "I_C_Soldier_Para_6_F"],         0.9
];

_infantryMappings insert [["#squads", _infSquads]];
_infantryMappings insert [["#teams", _infTeams]];

_factionMapping insert [
    ["#infantry", _infantryMappings]
];

InA_FactionMappings insert [["SYND", _factionMapping]];
