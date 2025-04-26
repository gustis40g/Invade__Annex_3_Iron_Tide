/*
 * Author: Whigital
 *
 * CBRN Radiological mission to aquire CSAT weapon schematics
 *
 */

// Get position for mission
private _flatPos = [nil, nil, 25] call AW_fnc_findSafePos;

// Unit gear code block ....
_setCBRNgear = {
    params [
        "_unit",
        "_uniform",
        "_mask",
        "_tank"
    ];

    _unit forceAddUniform _uniform;
    removeBackpackGlobal _unit;
    _unit addBackpackGlobal _tank;

    _unit addGoggles _mask;
};

// Objects ....
private _compObjs = [
    ["Land_Dome_01_small_green_ruins_F",[0.675781,-1.88025,-3.86933],154.702],

    ["Land_PortableLight_single_F",[-4.11816,-0.422974,-0.742332],90],
    ["Land_PortableLight_single_F",[7.34473,0.830933,-0.742332],270],
    ["Land_PortableLight_single_F",[-0.319336,-5.07104,-0.742332],0],
    ["Land_PortableLight_double_F",[-1.46436,4.22192,-0.742332],180],
    ["Land_PortableLight_single_F",[-3.95752,4.09973,-3.26766],315],
    ["Land_PortableLight_single_F",[4.69385,6.29102,-0.816333],180],
    ["Land_PortableLight_single_F",[6.92676,6.16492,-3.14733],45],

    ["Fridge_01_closed_F",[0.514648,-5.8363,-3.14724],184.663],
    ["Land_WaterCooler_01_new_F",[-0.463867,-5.82043,-3.14724],181.287],

    ["Land_PortableGenerator_01_F",[4.87305,-3.604,-3.26766],98.5651],
    ["Land_TripodScreen_01_large_F",[3.25781,-4.35889,-3.26733],318.844],
    ["Land_TripodScreen_01_dual_v2_F",[8.16748,-1.71216,-3.14724],269.713],

    ["Land_PortableDesk_01_olive_F",[3.09033,0.340454,-3.26733],181.796],
    ["Land_PortableDesk_01_olive_F",[-2.69531,-3.49927,-3.26766],359.436],
    ["Land_PortableDesk_01_olive_F",[0.230469,0.0755615,-3.26766],178.86],

    ["Land_PortableCabinet_01_7drawers_olive_F",[1.29541,2.88928,-3.26766],87.5981],
    ["Land_PortableCabinet_01_4drawers_olive_F",[1.2959,1.64478,-3.26766],93.2725],
    ["Land_PortableCabinet_01_medical_F",[-0.154785,4.03259,-3.26766],2.76176],
    ["Land_PortableCabinet_01_closed_olive_F",[-2.1792,4.13904,-3.26766],180.289],

    ["Land_MRL_Magazine_01_F",[5.05811,3.47241,-3.26766],99.1925],

    ["Land_IPPhone_01_olive_F",[-1.84082,-3.55115,-2.38072],17.7095],
    ["Land_Tablet_02_F",[-3.40771,-3.4906,-2.38072],169.356],

    ["Land_PortableServer_01_olive_F",[2.32031,0.348633,-2.3804],359.567],
    ["Land_MultiScreenComputer_01_olive_F",[3.83545,0.331177,-2.3804],167.69],

    ["Land_Laptop_03_olive_F",[-0.602539,0.0251465,-2.38072],197.017],
    ["Land_PortableCabinet_01_bookcase_olive_F",[1.26855,0.0632324,-2.38072],83.5256]
];

private _compWalls = [
    ["Land_Mil_WallBig_4m_F",[-12.5708,0.938721,-3.86933],101.184],
    ["Land_Mil_WallBig_4m_F",[-12.8677,-3.01208,-3.86933],87.1327],
    ["Land_Mil_WallBig_4m_F",[0.335449,-15.4049,-3.86933],2.4343],
    ["Land_Mil_WallBig_4m_F",[-11.9409,-6.83105,-3.86933],65.5131],
    ["Land_Mil_WallBig_4m_F",[-3.56396,-14.7377,-3.86933],17.3535],
    ["Land_Mil_WallBig_4m_F",[-9.88086,-10.1866,-3.86933],51.3132],
    ["Land_Mil_WallBig_4m_F",[2.13818,-15.385,-3.86933],355.989],
    ["Land_Mil_WallBig_4m_F",[-7.0498,-12.9384,-3.86933],37.0194],
    ["Land_Mil_WallBig_4m_F",[1.1167,11.5978,-3.86933],181.413],
    ["Land_Mil_WallBig_4m_F",[8.51953,9.31592,-3.86933],218.21],
    ["Land_Mil_WallBig_4m_F",[5.03125,11.0472,-3.86933],194.244],
    ["Land_Mil_WallBig_4m_F",[-11.2134,4.65613,-3.86933],119.435],
    ["Land_Mil_WallBig_4m_F",[-8.81201,7.79321,-3.86933],135.493],
    ["Land_Mil_WallBig_4m_F",[-2.73047,11.0525,-3.86933],162.271],
    ["Land_Mil_WallBig_4m_F",[-6.34521,9.57874,-3.86933],152.831],
    ["Land_Mil_WallBig_4m_F",[10.2935,-11.5121,-3.86933],317.215],
    ["Land_Mil_WallBig_4m_F",[13.9829,-4.65173,-3.86933],280.722],
    ["Land_Mil_WallBig_4m_F",[12.6865,-8.38452,-3.86933],297.366],
    ["Land_Mil_WallBig_4m_F",[14.2495,-0.715454,-3.86933],267.127],
    ["Land_Mil_WallBig_4m_F",[13.3418,3.10168,-3.86933],246.467],
    ["Land_Mil_WallBig_4m_F",[11.3179,6.50757,-3.86933],232.075],

    ["Land_CncWall4_F",[9.70215,-0.0505371,-3.86933],90],
    ["Land_CncWall4_F",[5.78467,-6.2699,-3.86933],180],
    ["Land_CncWall4_F",[-0.916992,-7.71948,-3.86933],180],
    ["Land_CncWall4_F",[4.2124,8.02161,-3.86933],0],
    ["Land_CncWall1_F",[-5.63818,-3.9978,-3.86933],180],
    ["Land_CncWall1_F",[3.40186,-6.68311,-3.86933],90],
    ["Land_CncWall1_F",[-6.35645,2.04138,-3.86933],270],
    ["Land_CncWall1_F",[-6.37646,0.75647,-3.86933],270],
    ["Land_CncWall1_F",[2.31299,-7.70215,-3.86933],180],
    ["Land_CncWall1_F",[9.19336,-3.24768,-3.86933],135],
    ["Land_CncWall1_F",[-6.37891,-0.519043,-3.86933],270],
    ["Land_CncWall1_F",[8.82861,-5.26208,-3.86933],90],
    ["Land_CncWall1_F",[-4.15137,-7.73706,-3.86933],180],
    ["Land_CncWall1_F",[-5.18701,-5.3656,-3.86933],270],
    ["Land_CncWall1_F",[8.82617,-3.98853,-3.86933],90],
    ["Land_CncWall1_F",[-5.19043,-4.08984,-3.86933],270],
    ["Land_CncWall1_F",[-5.17725,-6.6427,-3.86933],270],
    ["Land_CncWall1_F",[-5.70703,3.29773,-3.86933],315],
    ["Land_CncWall1_F",[-5.29639,5.4873,-3.86933],270],
    ["Land_CncWall1_F",[1.23975,7.151,-3.86933],270],
    ["Land_CncWall1_F",[-4.22363,6.49915,-3.86933],0],
    ["Land_CncWall1_F",[-0.467773,6.73767,-3.86933],0],
    ["Land_CncWall1_F",[7.44629,7.48206,-3.86933],45],
    ["Land_CncWall1_F",[9.69873,4.45728,-3.86933],90],
    ["Land_CncWall1_F",[0.810059,6.74487,-3.86933],0],
    ["Land_CncWall1_F",[-5.29541,4.22327,-3.86933],270],
    ["Land_CncWall1_F",[8.34961,6.58167,-3.86933],45],
    ["Land_CncWall1_F",[9.69775,3.18726,-3.86933],90],
    ["Land_CncWall1_F",[9.24854,5.67822,-3.86933],45],

    ["Land_CncShelter_F",[-2.31689,6.7124,-3.86933],0],
    ["Land_CncShelter_F",[-6.84229,-2.38074,-3.86933],270]
];

private _compLights = [
    ["Land_PortableLight_double_F",[-8.8623,-10.65,-3.86933],231.975],
    ["Land_PortableLight_double_F",[-9.14697,6.73999,-3.86933],316.37],
    ["Land_PortableLight_double_F",[12.6958,-7.27698,-3.86933],117.894]
];

private _compGuards = [
    ["O_Survivor_F",[8.33496,-14.7754,-3.86789],204.904],
    ["O_Survivor_F",[-2.27734,-14.1259,-3.86789],16.0664],
    ["O_Survivor_F",[5.76709,-16.0884,-3.86789],135.329],
    ["O_Survivor_F",[6.90625,-1.32666,-0.741377],97.3077],
    ["O_Survivor_F",[-3.50732,-4.51477,-0.741377],227.728],
    ["O_Survivor_F",[-10.7544,-7.45679,-3.86789],61.9033],
    ["O_Survivor_F",[-7.69385,-0.522949,-3.86789],207.879],
    ["O_Survivor_F",[-3.74023,3.79578,-0.741377],304.753],
    ["O_Survivor_F",[-10.1699,4.90051,-3.86789],124.026],
    ["O_Survivor_F",[-0.37207,8.00989,-3.86789],355.598],
    ["O_Survivor_F",[1.87109,10.8923,-3.86789],179.923],
    ["O_Survivor_F",[2.81055,5.96179,-0.803332],339.445],
    ["O_Survivor_F",[6.86914,6.04114,-0.793804],40.0257],
    ["O_Survivor_F",[13.4712,-3.40332,-3.86789],260.934]
];

private _compStaff = [
    ["C_scientist_F",[-2.51758,-4.43127,-3.26622],347.947],
    ["C_scientist_F",[0.839355,-3.4729,-3.26622],108.558],
    ["C_scientist_F",[6.60303,-1.61987,-3.26622],91.5165],
    ["C_scientist_F",[-0.0688477,0.973877,-3.26622],166.071],
    ["C_scientist_F",[3.22119,1.27637,-3.26622],172.433],
    ["C_scientist_F",[5.90674,2.19214,-3.26622],8.78217]
];

private _guardUnits = [
    "rhs_vdv_recon_sergeant",
    "rhs_vdv_recon_medic",
    "rhs_vdv_recon_marksman",
    "rhs_vdv_recon_rifleman",
    "rhs_vdv_recon_rifleman_lat"
];

private _sideObjs = [];
private _sideUnits = [];

private _rndDir = (random 360);

// Spawn base object ....
private _origin = createVehicle ["Land_Research_HQ_F", [0, 0, 0], [], 0, "NONE"];
_origin setDir _rndDir;
_origin setPos _flatPos;

_sideObjs pushBack _origin;


// Spawn objects ....
{
    private _obj = [_origin, _x, _rndDir] call AW_fnc_spawnRelative;
    _obj allowDamage false;
    _sideObjs pushBack _obj;
} forEach _compObjs;


// Spawn walls + lights ....
{
    private _obj = [_origin, _x, _rndDir] call AW_fnc_spawnRelative;
    _obj allowDamage false;

    private _pos = (getPosATL _obj);
    _obj setPosATL [(_pos # 0), (_pos # 1), 0];
    _obj setVectorUp [0, 0, 1];

    _sideObjs pushBack _obj;
} forEach (_compWalls + _compLights);


// Spawn Staff ....
private _staffGroup = (createGroup InA_EnemyFactionSide);

{
    private _data = [_origin, _x, _rndDir, true] call AW_fnc_spawnRelative;
    private _pos = (_data # 0);
    private _dir = (_data # 1);

    private _unit = _staffGroup createUnit ["rhs_vdv_recon_efreitor", _pos, [], 0, "NONE"];

    _unit setDir _dir;
    _unit setPosATL _pos;

    [_unit, "U_C_CBRN_Suit_01_White_F", "G_AirPurifyingRespirator_01_F", "B_CombinationUnitRespirator_01_F"] call _setCBRNgear;

    removeHeadgear _unit;
    _unit unassignItem "NVGoggles_OPFOR";
    _unit removeItem "NVGoggles_OPFOR";

    (backpackContainer _unit) setObjectTextureGlobal [1, "a3\supplies_f_enoch\bags\data\b_cur_01_co.paa"];
    (backpackContainer _unit) setObjectTextureGlobal [2, "a3\supplies_f_enoch\bags\data\b_cur_01_co.paa"];
    _unit linkItem "G_AirPurifyingRespirator_01_nofilter_F";

    _unit disableAI "PATH";
    _unit setUnitPos "UP";

    [[_unit]] call AW_fnc_addToAllCurators;

    _sideUnits pushBack _unit;
} forEach _compStaff;

_staffGroup = [_staffGroup] call AW_fnc_changeGroupSide;
_staffGroup setGroupIdGlobal ["SIDE-Research-Staff"];

[(units _staffGroup)] call derp_fnc_AISkill;


// Spawn Guards ....
private _guardGroup = (createGroup InA_EnemyFactionSide);

{
    private _data = [_origin, _x, _rndDir, true] call AW_fnc_spawnRelative;
    private _pos = (_data # 0);
    private _dir = (_data # 1);

    private _unit = _guardGroup createUnit [(selectRandom _guardUnits), _pos, [], 0, "NONE"];

    _unit setDir _dir;
    _unit setPosATL _pos;

    [_unit, "U_I_E_CBRN_Suit_01_EAF_F", "G_AirPurifyingRespirator_01_F", "B_CombinationUnitRespirator_01_F"] call _setCBRNgear;

    _unit addHeadgear "H_HelmetSpecO_blk";

    _unit disableAI "PATH";
    _unit setUnitPos "UP";

    (backpackContainer _unit) setObjectTextureGlobal [1, "a3\supplies_f_enoch\bags\data\b_cur_01_co.paa"];
    (backpackContainer _unit) setObjectTextureGlobal [2, "a3\supplies_f_enoch\bags\data\b_cur_01_co.paa"];
    _unit linkItem "G_AirPurifyingRespirator_01_nofilter_F";

    [[_unit]] call AW_fnc_addToAllCurators;

    _sideUnits pushBack _unit;
} forEach _compGuards;

_guardGroup = [_guardGroup] call AW_fnc_changeGroupSide;
_guardGroup setGroupIdGlobal ["SIDE-Research-Guards"];

[(units _guardGroup)] call derp_fnc_AISkill;

{
    [_x, [[_origin, _flatPos], {
        params ["_hq", "_pos"];

        waitUntil {
            sleep 1;
            (_hq in (_pos nearObjects [(typeOf _hq), 2]))
        };
    }]] spawn AW_fnc_transferGroupHC;
} forEach [_staffGroup, _guardGroup];


// Spawn patrols and update their gear ....

private _vehAmount = [
    1,                  // MBTs
    (1 + (random 1)),   // SPAAs
    1,                  // IFVs
    (1 + (random 1))    // MRAPs
];

private _infAmount = [
    (3 + (random 1)),   // Squads
    (1 + (random 1)),   // SF Squads
    (1 + (random 1)),   // AA Teams
    (1 + (random 1)),   // AT Teams
    nil,                // Snipers
    (1 + (random 1)),   // Teams
    (1 + (random 1))    // SF Teams
];

private _enemyArray = [
    _flatPos,
    "SIDE",
    "#rnd",
    _vehAmount,
    _infAmount,
    25,
    500
] call AW_fnc_spawnEnemyUnits;

_sideUnits = (_sideUnits + _enemyArray);

{
    if (!(_x isKindOf "Man")) then {
        continue;
    };

    [_x, "U_I_E_CBRN_Suit_01_EAF_F", "G_RegulatorMask_F", "B_SCBA_01_F"] call _setCBRNgear;

    (backpackContainer _x) setObjectTextureGlobal [2, "a3\supplies_f_enoch\bags\data\b_scba_01_co.paa"];

    if ((headgear _x) in ["H_HelmetO_oucamo", "H_HelmetLeaderO_oucamo"]) then {
        _x addHeadgear "H_HelmetSpecO_blk";
    };
} forEach _enemyArray;


// Spawn intel object ....
private _laptop = [_origin, ["Land_Laptop_03_olive_F",[6.19434,3.21741,-2.54959],356.751], _rndDir] call AW_fnc_spawnRelative;
_laptop setVariable ["SchematicsAcquired", false, true];

// Create CBRN trigger ....
private _triggerAct = format ["[thisTrigger, '%1', %2] spawn AW_fnc_CBRNTriggerWrapper;", "RAD", 5];
private _CBRNTrigger = createTrigger ["EmptyDetector", _flatPos];
_CBRNTrigger setTriggerArea [500, 500, 0, false];
_CBRNTrigger setTriggerActivation ["ANYPLAYER", "PRESENT", true];
_CBRNTrigger setTriggerStatements ["this", _triggerAct, ""];

_sideObjs pushBack _CBRNTrigger;


// Add Hold Action to intel object ....
[
    _laptop,
    "Secure Schematics",
    "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\documents_ca.paa",
    "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\download_ca.paa",
    "((_target distance _this) <= 3) && {!(_target getVariable ['SchematicsAcquired', false])}",
    "((_target distance _this) <= 3) && {!(_target getVariable ['SchematicsAcquired', false])}",
    {
        hint "Downloading schematics ....";
    },
    {},
    {
        params ["_target", "_caller", "_actionId", "_arguments"];

        _target setVariable ["SchematicsAcquired", true, true];

        ["InA_Event_SideMissionSuccess"] remoteExecCall ["AW_fnc_eventTrigger", 2];

        private _sidecompleted = format ["<t align='center'><t size='2.2'>Side-mission update</t><br/>____________________<br/>%1 acquired the schematics.</t>", (name _caller)];
        [_sidecompleted] remoteExec ["AW_fnc_globalHint", 0];
    },
    {
        hint "You stop downloading the schematics.";
    },
    [],
    8,
    0,
    true,
    false
] remoteExecCall ["BIS_fnc_holdActionAdd", 0, true];

//----------------task/circle/....
private _fuzzyPos = [_flatPos, 300] call AW_fnc_getFuzzyPos;

InA_Server_SideMarkers = ["SIDE", "Intel (Radiological)", _fuzzyPos, 300] call AW_fnc_missionMarkersCreate;
private _sideMarker = (InA_Server_SideMarkers # 0);

[
    west,
    "RadioIntelTask",
    [
        "Satellite imaging has discovered a CSAT weapon research facility, which is believed to be developing some kind of new Radiological weapon. Get your CBRN gear on, assault the facility and grab those schematics.<br /><br />Check the FAQ for information about which gear has to be used.  This mission can be played without owning any DLCs<br /><br /><img image='Media\Briefing\cbrn_rad_intel.jpg' width='300' height='150'/>",
        "Side Mission: Intel (Radiological)",
        _sideMarker
    ],
    _fuzzyPos,
    "Created",
    0,
    true,
    "download",
    true
] call BIS_fnc_taskCreate;

//==============mission core==============
InA_Server_SideMissionUp = true;
InA_Server_SideMissionSuccess = false;
InA_Server_SideMissionSpawned = true;

["InA_Event_SideMissionUp", true] remoteExec ["AW_fnc_eventTrigger", 0, true];

waitUntil {
    if (!InA_Server_SideMissionUp) exitWith {
        _laptop setVariable ["SchematicsAcquired", true, true];
        true
    };

    sleep 5;

    InA_Server_SideMissionSuccess
};

if (InA_Server_SideMissionSuccess) then {
    0 = ["RadioIntelTask"] spawn AW_fnc_finishTask;
    _laptop call AW_fnc_delete;
    [nil, _flatPos] call AW_fnc_SMhintSUCCESS;
    InA_Server_SideMissionUp = false;
} else {
    if (!InA_Server_SideMissionUp) then {
        0 = ["RadioIntelTask", "Failed"] spawn AW_fnc_finishTask;
        _laptop call AW_fnc_delete;
        InA_Server_SideMissionUp = false;
        InA_Server_SideMissionSuccess = false;
    };
};

[InA_Server_SideMarkers] call AW_fnc_missionMarkersRemove;

["InA_Event_SideMissionUp", false] remoteExec ["AW_fnc_eventTrigger", 0, true];

[120, (_sideObjs + _sideUnits)] spawn {
    params [
        "_period",
        "_toDelete"
    ];

    sleep _period;

    [_toDelete] spawn AW_fnc_delete;
};
