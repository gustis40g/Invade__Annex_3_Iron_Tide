//////////////
//// VC_L ////
//////////////

private _infSquads = [];
private _infTeams = [];

private _factionMapping = createHashMap;
private _infantryMappings = createHashMap;

_factionMapping insert [
    ["#name", "Viet Cong (Locals)"],
    ["#side", east],
    ["#addons", ["loadorder_f_vietnam"]]
];


//// Infantry ////

// Units
_infantryMappings insert [
    ["#officers", ["vn_o_men_vc_local_01"]],
    ["#squadleaders", ["vn_o_men_vc_local_01"]],
    ["#teamleaders", ["vn_o_men_vc_local_15"]],
    ["#riflemen", ["vn_o_men_vc_local_06"]],
    ["#lats", ["vn_o_men_vc_local_28"]],
    ["#grenadiers", ["vn_o_men_vc_local_21"]],
    ["#machinegunners", ["vn_o_men_vc_local_11"]],
    ["#heavygunners", ["vn_o_men_vc_local_11"]],
    ["#marksmen", ["vn_o_men_vc_local_10"]],
    ["#sharpshooters", ["vn_o_men_vc_local_10"]],
    ["#snipers", ["vn_o_men_vc_local_10"]],
    ["#spotters", ["vn_o_men_vc_local_15"]],
    ["#ats", ["vn_o_men_vc_local_28"]],
    ["#hats", ["vn_o_men_vc_local_28"]],
    ["#aas", ["vn_o_men_vc_local_28"]],
    ["#medics", ["vn_o_men_vc_local_08"]],
    ["#demos", ["vn_o_men_vc_local_09"]],
    ["#engineers", ["vn_o_men_vc_local_09"]],
    ["#paras", ["vn_o_men_vc_local_06"]]
];

// Squads
_infSquads = [
    ["vn_o_men_vc_local_01", "vn_o_men_vc_local_08", "vn_o_men_vc_local_11", "vn_o_men_vc_local_21", "vn_o_men_vc_local_28", "vn_o_men_vc_local_15", "vn_o_men_vc_local_09", "vn_o_men_vc_local_10"], 1,
    ["vn_o_men_vc_local_01", "vn_o_men_vc_local_08", "vn_o_men_vc_local_09", "vn_o_men_vc_local_28", "vn_o_men_vc_local_11", "vn_o_men_vc_local_15", "vn_o_men_vc_local_21", "vn_o_men_vc_local_11"], 0.9,

    ["vn_o_men_vc_local_01", "vn_o_men_vc_local_08", "vn_o_men_vc_local_11", "vn_o_men_vc_local_21", "vn_o_men_vc_local_09", "vn_o_men_vc_local_10"], 1.2,
    ["vn_o_men_vc_local_01", "vn_o_men_vc_local_08", "vn_o_men_vc_local_09", "vn_o_men_vc_local_28", "vn_o_men_vc_local_11", "vn_o_men_vc_local_11"], 1.2
];

// Teams
_infTeams = [
    ["vn_o_men_vc_local_15", "vn_o_men_vc_local_08", "vn_o_men_vc_local_21", "vn_o_men_vc_local_10"], 1,
    ["vn_o_men_vc_local_15", "vn_o_men_vc_local_08", "vn_o_men_vc_local_11", "vn_o_men_vc_local_28"], 0.9,
    ["vn_o_men_vc_local_15", "vn_o_men_vc_local_08", "vn_o_men_vc_local_06", "vn_o_men_vc_local_09"], 1
];

_infantryMappings insert [["#squads", _infSquads]];
_infantryMappings insert [["#teams", _infTeams]];

_factionMapping insert [
    ["#infantry", _infantryMappings]
];

InA_FactionMappings insert [["VC_L", _factionMapping]];
