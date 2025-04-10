//////////////
//// VC_M ////
//////////////

private _infSquads = [];
private _infTeams = [];

private _factionMapping = createHashMap;
private _infantryMappings = createHashMap;

_factionMapping insert [
    ["#name", "Viet Cong (Main)"],
    ["#side", east],
    ["#addons", ["loadorder_f_vietnam"]]
];


//// Infantry ////

// Units
_infantryMappings insert [
    ["#officers", ["vn_o_men_vc_01"]],
    ["#squadleaders", ["vn_o_men_vc_01"]],
    ["#teamleaders", ["vn_o_men_vc_01"]],
    ["#riflemen", ["vn_o_men_vc_06"]],
    ["#lats", ["vn_o_men_vc_14"]],
    ["#grenadiers", ["vn_o_men_vc_07"]],
    ["#machinegunners", ["vn_o_men_vc_11"]],
    ["#heavygunners", ["vn_o_men_vc_11"]],
    ["#marksmen", ["vn_o_men_vc_10"]],
    ["#sharpshooters", ["vn_o_men_vc_10"]],
    ["#snipers", ["vn_o_men_vc_10"]],
    ["#spotters", ["vn_o_men_vc_01"]],
    ["#ats", ["vn_o_men_vc_14"]],
    ["#hats", ["vn_o_men_vc_14"]],
    ["#aas", ["vn_o_men_vc_14"]],
    ["#medics", ["vn_o_men_vc_08"]],
    ["#demos", ["vn_o_men_vc_09"]],
    ["#engineers", ["vn_o_men_vc_09"]],
    ["#paras", ["vn_o_men_vc_06"]]
];

// Squads
_infSquads = [
    ["vn_o_men_vc_01", "vn_o_men_vc_08", "vn_o_men_vc_11", "vn_o_men_vc_07", "vn_o_men_vc_14", "vn_o_men_vc_01", "vn_o_men_vc_09", "vn_o_men_vc_10"],   1,
    ["vn_o_men_vc_01", "vn_o_men_vc_08", "vn_o_men_vc_09", "vn_o_men_vc_14", "vn_o_men_vc_01", "vn_o_men_vc_06", "vn_o_men_vc_11", "vn_o_men_vc_06"],   0.9,

    ["vn_o_men_vc_01", "vn_o_men_vc_08", "vn_o_men_vc_11", "vn_o_men_vc_07", "vn_o_men_vc_14", "vn_o_men_vc_10"],                                       1.2,
    ["vn_o_men_vc_01", "vn_o_men_vc_08", "vn_o_men_vc_09", "vn_o_men_vc_14", "vn_o_men_vc_06", "vn_o_men_vc_11"],                                       1.2
];

// Teams
_infTeams = [
    ["vn_o_men_vc_01", "vn_o_men_vc_08", "vn_o_men_vc_11", "vn_o_men_vc_07"], 1,
    ["vn_o_men_vc_01", "vn_o_men_vc_08", "vn_o_men_vc_09", "vn_o_men_vc_14"], 0.9,
    ["vn_o_men_vc_01", "vn_o_men_vc_08", "vn_o_men_vc_10", "vn_o_men_vc_06"], 1,
    ["vn_o_men_vc_01", "vn_o_men_vc_08", "vn_o_men_vc_07", "vn_o_men_vc_11"], 1
];

_infantryMappings insert [["#squads", _infSquads]];
_infantryMappings insert [["#teams", _infTeams]];

_factionMapping insert [
    ["#infantry", _infantryMappings]
];

InA_FactionMappings insert [["VC_M", _factionMapping]];
