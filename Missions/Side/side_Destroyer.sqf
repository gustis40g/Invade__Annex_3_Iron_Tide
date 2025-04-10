
private _findSmPosResult = ["water", []] call AW_fnc_findSideMissionPos;
if (!(_findSmPosResult select 0)) exitWith {};
private _flatpos = _findSmPosResult select 1;

private _rndDir = (random 360);
private _spawnedObjects = [];

//Create starting point
private _origin = createVehicle ["Land_Destroyer_01_base_F", [0, 0, 0], [], 0, "NONE"];

// Wait for the init EH to create the ship parts ....
waitUntil {
    sleep 0.1;
    ((_origin getVariable ["bis_carrierParts", []]) isNotEqualTo [])
};

_origin setDir _rndDir;
_origin setPosASL [_flatPos # 0, _flatPos # 1, 0];

// Re position the ship parts after proxy move and dir ....
[_origin] call BIS_fnc_Destroyer01PosUpdate;

// Wait for hull parts to get moved
waitUntil {
    sleep 1;

    (((_origin getVariable "bis_carrierParts") findIf {((getPosASL (_x # 0)) distance2D _flatpos) > 150}) == -1)
};

// Customize the ship
private _flag = [_origin, "ShipFlag_US_F"] call bis_fnc_destroyer01GetShipPart;
_flag setFlagTexture "\A3\Data_F\Flags\flag_CSAT_CO.paa";

private _stern = [_origin, "Land_Destroyer_01_hull_05_F"] call bis_fnc_destroyer01GetShipPart;
_stern setObjectTextureGlobal [0, "\A3\Boat_F_Destroyer\Destroyer_01\Data\Destroyer_01_tag_05_co.paa"];

private _bow = [_origin, "Land_Destroyer_01_hull_01_F"] call bis_fnc_destroyer01GetShipPart;

{
    _bow setObjectTextureGlobal [_x, (format ["A3\Boat_F_Destroyer\Destroyer_01\Data\Destroyer_01_N_0%1_co.paa", (floor (random 10))])];
} forEach [0, 1, 2];


//Spawn objects
private _objects = [["Land_Mi8_wreck_F",[-5.04883,-86.4023,13.9749],269.129],["Land_TimberPile_03_F",[5.75781,-65.064,11.7471],90],["Land_TimberPile_03_F",[-5.8125,-65.0625,11.7164],90],["Land_TimberPile_03_F",[-0.253906,-60.7886,11.6977],90],["B_Slingload_01_Ammo_F",[2.63281,-77.0649,13.4302],0.00787292],["B_Slingload_01_Ammo_F",[-2.80859,-77.1484,13.5494],359.997],["B_Slingload_01_Ammo_F",[-0.0839844,-77.1626,13.4831],359.997],["Land_PaperBox_01_open_water_F",[-9.91406,-51.1279,11.1551],358.655],["Land_PaperBox_01_open_water_F",[-8.34766,-51.1084,11.1343],359.669],["Land_Cargo20_military_green_F",[-6.0918,-58.4502,11.8494],89.9989],["Land_WoodenCrate_01_stack_x5_F",[-2.88867,-37.9717,20.3676],90],["Land_WoodenCrate_01_stack_x5_F",[5.62695,-37.584,20.1557],0],["Land_WoodenCrate_01_stack_x5_F",[-2.8125,-36.2969,20.3816],90],["Land_WoodenCrate_01_stack_x5_F",[3.95898,-37.5552,20.2029],0],["B_CargoNet_01_ammo_F",[0.648438,-5.11523,8.07607],0.000796922],["Land_WoodPile_02_F",[-7.9668,6.44336,7.93042],0],["Land_WoodenPlanks_01_F",[-7.45117,13.6831,7.86054],269.359],["Land_Cargo10_military_green_F",[-12.7246,8.44629,8.42905],180],["B_Slingload_01_Fuel_F",[-6.2832,8.62695,8.45733],90.0088],["CargoNet_01_barrels_F",[-10.6426,18.0742,7.72596],0.00165497],["CargoNet_01_barrels_F",[-7.59961,18.1006,7.64115],0.00171338],["CargoNet_01_barrels_F",[-9.12695,18.0669,7.6824],0.00160621],["CargoNet_01_barrels_F",[-0.0664063,15.771,12.1709],0.000714598],["Land_Mil_WallBig_4m_F",[5.88867,9.85986,8.99305],90],["Land_Mil_WallBig_4m_F",[-13.0137,12.5195,8.8347],0],["Land_Mil_WallBig_4m_F",[-14.8379,16.3813,8.97431],90],["Land_Mil_WallBig_4m_F",[-0.160156,26.4126,10.3439],0],["Land_Mil_WallBig_4m_F",[-14.875,10.1411,8.83453],90],["Land_Mil_WallBig_4m_F",[-4.00391,26.3955,10.4463],0],["Land_Mil_WallBig_4m_F",[-11.6406,19.0015,8.94725],90],["Land_Mil_WallBig_4m_F",[-2.65625,28.3657,10.4564],90],["Land_Mil_WallBig_4m_F",[-14.9395,12.5474,8.88818],90],["CargoNet_01_box_F",[-0.746094,13.9868,7.69197],0.000879819],["Land_Mi8_wreck_F",[4.44727,43.9863,10.4652],0],["Land_Mi8_wreck_F",[-3.13281,47.7427,10.2137],180],["B_Slingload_01_Fuel_F",[1.13086,32.7676,10.1239],90],["CargoNet_01_barrels_F",[-5.6543,53.4482,9.10266],0.000716051],["CargoNet_01_barrels_F",[-8.55273,54.3643,9.19863],0.000726134],["Land_HBarrier_3_F",[-8.34375,41.6699,9.33561],0],["Land_Mil_WallBig_4m_F",[-7.82813,31.5376,10.4993],0],["Land_Mil_WallBig_4m_F",[-2.6543,32.2466,10.5074],90],["B_Slingload_01_Cargo_F",[5.66211,52.7803,9.94877],316.165],["Land_RepairDepot_01_civ_F",[-6.35352,85.7256,10.9808],180.001],["Land_WoodenPlanks_01_messy_F",[-3.29883,68.1055,9.66981],0],["Land_WoodenPlanks_01_messy_F",[-7.72852,68.126,9.60417],0],["Land_WoodenPlanks_01_messy_F",[3.62305,67.9775,9.60542],0],["Land_Mi8_wreck_F",[0.605469,78.8979,10.3974],0],["Land_DieselGroundPowerUnit_01_F",[-10.4883,63.6108,9.59551],359.996],["CargoNet_01_barrels_F",[5.08398,83.7314,9.24856],9.12993e-005],["CargoNet_01_barrels_F",[5.00781,85.2358,9.21207],0.000656355],["CargoNet_01_barrels_F",[5.06055,82.1729,9.28254],359.997],["Land_CratesWooden_F",[-12.6855,64.2764,9.43013],180],["Land_Cargo20_military_green_F",[-8.94141,77.3501,9.82773],90],["Land_PaperBox_01_open_boxes_F",[9.875,-51.1509,11.2433],1.04486],["Land_PaperBox_01_open_boxes_F",[8.39844,-51.1641,11.2131],359.973],["Land_Cargo20_military_green_F",[6.47852,-58.4429,12.0857],90.0016],["Land_DieselGroundPowerUnit_01_F",[7.21484,9.43555,8.15113],359.975],["Land_PaperBox_01_open_water_F",[7.28711,13.4111,7.87359],0.000756582],["Land_PaperBox_01_open_water_F",[7.27734,11.9028,7.9053],0.000756491],["Land_PaperBox_01_open_water_F",[7.33008,14.938,7.83518],0.000758127],["Land_CinderBlocks_01_F",[11.9883,13.8867,8.13749],0],["Land_CinderBlocks_01_F",[11.7715,10.6782,8.13532],0],["Land_CinderBlocks_01_F",[11.8984,12.812,8.14174],0],["Land_CinderBlocks_01_F",[11.8613,11.7529,8.14082],0],["Land_Missle_Trolley_02_F",[13.1094,7.31934,7.90928],270.972],["Land_HBarrier_3_F",[9.20508,18.187,7.95297],0],["Land_Mil_WallBig_4m_F",[14.7832,17.0166,8.97302],270],["Land_Mil_WallBig_4m_F",[14.6641,10.1235,8.92226],270],["Land_Mil_WallBig_4m_F",[11.0176,19.0273,8.87359],270],["Land_Mil_WallBig_4m_F",[14.7227,13.9785,8.97635],270],["Land_Mil_WallBig_4m_F",[12.8867,14.5488,8.98316],180],["Land_Mil_WallBig_4m_F",[7.85547,7.60352,9.00477],180],["Land_WoodenPlanks_01_messy_F",[8.03906,67.9429,9.50304],0],["B_Slingload_01_Fuel_F",[6.98438,88.7319,10.0287],270],["CargoNet_01_barrels_F",[8.93359,83.625,9.35458],0.000699703],["CargoNet_01_barrels_F",[8.90039,85.1416,9.32804],0.000657024],["CargoNet_01_barrels_F",[8.92578,82.0361,9.3732],0.000560718],["Land_Cargo20_military_green_F",[8.9707,77.7441,10.1657],90.0005]];
{
    private _obj = [_origin, _x, _rndDir, false, true] call AW_fnc_spawnRelative;
    _obj allowDamage false;
    _obj enableSimulationGlobal false;
    if (_obj isKindOf "B_CargoNet_01_ammo_F") then {
        clearWeaponCargoGlobal _obj;
        clearItemCargoGlobal _obj;
        clearMagazineCargoGlobal _obj;
        clearBackpackCargoGlobal _obj;
    };
    _spawnedObjects pushBack _obj;
} forEach _objects;

//Spawn planks & ropes
private _planks = [["Land_Plank_01_4m_F",[0.078125,-109.451,12.9874],0],["Land_Plank_01_4m_F",[-16.4727,19.48,7.38717],270],["Land_Plank_01_4m_F",[16.9512,19.5757,7.32958],90]];
{
    private _obj = [_origin, _x, _rndDir, false, true] call AW_fnc_spawnRelative;
    _obj enableSimulationGlobal false;
    _obj allowDamage false;
    _spawnedObjects pushBack _obj;
} forEach _planks;

private _ropes = [["Land_Rope_F",[-0.0234375,-110.833,-11.9424],0],["Land_Rope_F",[-17.9824,19.3413,-17.4247],270],["Land_Rope_F",[18.4648,19.6553,-17.424],0]];
{
    private _obj = [_origin, _x, _rndDir, false, true] call AW_fnc_spawnRelative;
    _obj enableSimulationGlobal false;
    _obj allowDamage false;
    _spawnedObjects pushBack _obj;
    [_obj,
        ["Climb up",
        {
            params ["_rope", "_player"];
            private _plank = nearestObject [getPos _player, "Land_Plank_01_4m_F"];
            ["RopeLayer", ["Climbing up", "BLACK", 0.5]] remoteExec ["cutText", _player];
            sleep 0.5;
            _player setPosWorld (getPosWorld _plank);
            ["RopeLayer", ["Climbing up", "BLACK IN", 0.5]] remoteExec ["cutText", _player];
        }, nil, 9, true, true, "", "((getPosASL _this) # 2) < 2", 50]
    ] remoteExec ["addaction", 0, true];
} forEach _ropes;

//Spawn guards
private _infPosArray = [["RoadCone_F",[-8.21484,-62.8721,10.8849],359.987],["RoadCone_F",[2.63477,-69.8643,11.1124],0.00391353],["RoadCone_F",[-3.94141,-62.8398,10.9916],0.0117144],["RoadCone_F",[4.0957,-62.8652,11.0827],0.0104292],["RoadCone_F",[-3.29688,-69.9175,11.207],0.00395738],["RoadCone_F",[-0.152344,-69.9556,11.1723],0.00394147],["RoadCone_F",[-9.08594,-38.4321,19.3362],0.00429927],["RoadCone_F",[-8.60742,-49.7002,10.8],0.00429754],["RoadCone_F",[-10.2949,-35.0537,19.2445],0.00423874],["RoadCone_F",[-4.76758,-42.6494,19.6417],0.000887882],["RoadCone_F",[5.20703,-42.4321,19.4095],359.996],["RoadCone_F",[-1.67578,-58.8252,10.8981],0.00434221],["RoadCone_F",[1.41406,-58.8311,10.9695],0.00434716],["RoadCone_F",[-8.10156,-55.8623,10.7379],0.00428893],["RoadCone_F",[-6.00391,-54.1641,10.7202],0.00458425],["RoadCone_F",[-4.58594,-38.751,19.7035],0.000889796],["RoadCone_F",[-8.48438,-46.3521,10.8557],0.0042539],["RoadCone_F",[-4.47656,-36.502,19.7115],0.000890075],["RoadCone_F",[5.31445,-39.3081,19.4464],359.993],["RoadCone_F",[4.4082,-30.0278,14.0627],0.00425729],["RoadCone_F",[2.62109,-29.5674,17.2584],0.00061135],["RoadCone_F",[4.93555,-32.3853,19.673],0.00259423],["RoadCone_F",[-1.33008,-38.3462,19.6469],0.000890282],["RoadCone_F",[1.65234,-37.9922,19.5762],0.000879684],["RoadCone_F",[-1.15234,-15.3662,7.39099],360],["RoadCone_F",[1.01563,-7.44727,7.4531],359.997],["RoadCone_F",[-0.914063,-13.3447,7.39783],0.0025632],["RoadCone_F",[-0.818359,-22.1675,10.5965],0.00433439],["RoadCone_F",[5.52734,-20.2915,10.6733],0.00433478],["RoadCone_F",[5.44727,-28.1133,10.7995],0.00428058],["RoadCone_F",[4.59766,-29.0742,17.2456],0.00443586],["RoadCone_F",[2.55859,-24.1543,17.1647],0.00426893],["RoadCone_F",[0.90625,27.7388,8.91557],0.00428009],["RoadCone_F",[-1.42578,27.6841,8.97741],359.999],["RoadCone_F",[5.78125,20.0039,7.29773],359.994],["RoadCone_F",[-1.1582,30.5122,9.03291],0.00428762],["RoadCone_F",[-4.0918,27.9927,9.04639],0.00428566],["RoadCone_F",[-8.05859,30.2002,9.08223],0.00429318],["RoadCone_F",[-8.99414,24.979,9.08863],0.00437072],["RoadCone_F",[0.769531,25.0601,7.33729],0.00428023],["RoadCone_F",[0.869141,21.7979,7.27037],0.0042276],["RoadCone_F",[1.8457,19.6323,7.26454],359.994],["RoadCone_F",[-0.53125,15.585,7.29699],359.994],["RoadCone_F",[1.22656,2.61914,7.61245],359.994],["RoadCone_F",[4.33203,5.28857,7.5936],359.994],["RoadCone_F",[-4.37305,4.8501,7.51271],359.994],["RoadCone_F",[-0.0273438,14.0566,11.9464],0.00425754],["RoadCone_F",[-12.5762,10.627,7.35993],359.994],["RoadCone_F",[-13.1602,5.15967,7.35898],0.00428673],["RoadCone_F",[-4.48828,6.40234,7.46212],359.994],["RoadCone_F",[-10.7031,19.9082,7.50955],359.995],["RoadCone_F",[-7.76953,19.7964,7.4255],359.994],["RoadCone_F",[-5.62891,19.9604,7.37046],359.994],["RoadCone_F",[-5.26172,12.3467,7.30737],359.995],["RoadCone_F",[-5.18945,14.6587,7.29423],359.994],["RoadCone_F",[-13.8047,52.4946,9.00108],0.0131585],["RoadCone_F",[-9.30859,57.8691,9.03691],0.00425571],["RoadCone_F",[0.478516,52.9634,8.7737],0.00426461],["RoadCone_F",[0.699219,45.7476,8.90356],0.0042558],["RoadCone_F",[0.380859,39.0322,9.05055],0.00426133],["RoadCone_F",[0.958984,35.2036,9.06381],0.00425584],["RoadCone_F",[-7.89648,39.9258,8.8498],0.00425584],["RoadCone_F",[-8.83203,33.5479,9.00587],0.00426137],["RoadCone_F",[-4.26563,45.9219,8.79252],0.00425584],["RoadCone_F",[2.61719,88.8628,8.84257],0.00410952],["RoadCone_F",[-4.37109,87.938,8.84884],0.00416838],["RoadCone_F",[-9.29492,87.9063,8.94978],359.995],["RoadCone_F",[-6.67188,89.6016,8.94023],0.00412671],["RoadCone_F",[-8.41797,81.5107,8.78245],0.00431686],["RoadCone_F",[-6.84961,79.6167,8.78041],0.00445936],["RoadCone_F",[-6.57422,75.4658,8.84484],0.00434291],["RoadCone_F",[-8.89453,73.0859,8.83765],0.00441612],["RoadCone_F",[-12.9355,61.707,9.01328],0.00434633],["RoadCone_F",[-8.33789,65.4375,9.01842],0.0043445],["RoadCone_F",[-3.54102,65.6763,9.04184],0.00429351],["RoadCone_F",[-3.35352,70.6235,9.03228],0.00444253],["RoadCone_F",[-2.54297,76.8608,8.92452],0.00449122],["RoadCone_F",[2.31445,83.0601,8.92103],359.999],["RoadCone_F",[4.77148,66.1777,8.90629],0.00433252],["RoadCone_F",[2.41797,66.2305,8.96266],0.00434014],["RoadCone_F",[7.60352,-62.5464,11.0417],0.010135],["RoadCone_F",[6.54883,-54.4331,10.9259],0.00442002],["RoadCone_F",[8.90234,-55.9312,10.9972],0.00437567],["RoadCone_F",[9.72461,-49.1416,10.8017],0.00450354],["RoadCone_F",[8.54688,-46.4805,10.6769],0.00428943],["RoadCone_F",[8.39453,-38.9263,19.0091],0.00425981],["RoadCone_F",[10.6738,-36.0532,19.0012],0.00423754],["RoadCone_F",[9.24219,20.0615,7.3683],359.994],["RoadCone_F",[8.9707,9.57568,7.56919],359.994],["RoadCone_F",[9.0332,30.6133,8.79513],0.0042877],["RoadCone_F",[7.36914,5.37402,7.5586],359.999],["RoadCone_F",[14,5.47363,7.39504],359.994],["RoadCone_F",[13.7051,13.4858,7.5492],359.994],["RoadCone_F",[13.5762,11.3853,7.53293],359.994],["RoadCone_F",[7.67383,56.6787,8.82398],0.004263],["RoadCone_F",[8.13086,47.959,9.03179],0.00426137],["RoadCone_F",[8.13086,44.729,9.06882],0.0042558],["RoadCone_F",[8.1543,37.772,8.98855],0.00425575],["RoadCone_F",[7.16797,82.519,9.07049],0.00769039],["RoadCone_F",[7.27148,85.0884,9.02246],0.0042346],["RoadCone_F",[6.70508,75.0557,9.08872],0.00433104],["RoadCone_F",[6.83008,79.2007,9.10338],0.00434553],["RoadCone_F",[9.125,73.9985,9.03611],0.0043572],["RoadCone_F",[9.06445,66.0166,8.81381],0.00429337],["RoadCone_F",[7.05078,65.9229,8.84824],0.00433542],["RoadCone_F",[12.0645,61.5659,8.81144],0.00433089]];
private _unitTypes = ["#squadleaders", "#riflemen", "#medics", "#engineers", "#paras"];

private _groups = [];
private _units = [];
private _guardGroup = nil;
while { count _infPosArray > 0 && count _groups < 5} do {

    if (isNil "_guardGroup" || {count units _guardGroup > 8}) then {
        if (count _groups > 3) exitWith {break;};
        _guardGroup = (createGroup east);
        _groups pushBack _guardGroup;
        _guardGroup setGroupIdGlobal [format["SIDE-DESTROYER-%1", count _groups]];
    };
    private _infPos = selectRandom _infPosArray;
    _infPosArray = _infPosArray - [_infPos];

    private _data = [_origin, _infPos, _rndDir, true, true] call AW_fnc_spawnRelative;
    private _pos = (_data # 0);
    private _dir = (_data # 1);

    private _unitType = [(selectRandom _unitTypes)] call AW_fnc_getUnitsFromHash;
    private _unit = _guardGroup createUnit [_unitType, _pos, [], 0, "NONE"];

    _unit setDir _dir;
    _unit setPosWorld _pos;

    _unit disableAI "PATH";
    _unit setUnitPos "UP";
    _spawnedObjects pushBack _unit;
    _units pushBack _unit;
};

[_units] call AW_fnc_addToAllCurators;
[_units] call derp_fnc_AISkill;

{
    [_x, [[_origin, _flatPos], {
        params ["_base", "_pos"];

        waitUntil {
            sleep 1;
            (((_base getVariable "bis_carrierParts") findIf {((getPosASL (_x # 0)) distance2D _pos) > 150}) == -1)
        };
    }]] spawn AW_fnc_transferGroupHC;
} forEach _groups;

private _intelObj = [_origin, ["Land_PortableServer_01_black_F",[0.0292969,-38.2944,19.5189],180], _rndDir, false, true] call AW_fnc_spawnRelative;
_intelObj enableSimulationGlobal false;
_intelObj allowDamage false;
_intelobj setVariable ["IntelAcquired", false, true];
_spawnedObjects pushBack _intelObj;

[
    _intelObj,
    "Secure intel",
    "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\documents_ca.paa",
    "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\download_ca.paa",
    "((_target distance _this) <= 3) && {!(_target getVariable ['IntelAcquired', false])}",
    "((_target distance _this) <= 3) && {!(_target getVariable ['IntelAcquired', false])}",
    {
        hint "Downloading Intel...";
        params ["","_hero"];
        if ((currentWeapon _hero) != "") then {
            _hero action ["SwitchWeapon", _hero, _hero, 99];
        };

        _hero playMoveNow "AinvPknlMstpSnonWnonDnon_medic3";
    },
    {},
    {
        params ["_target", "_caller"];

        _target setVariable ["IntelAcquired", true, true];

        private _sidecompleted = format["<t align='center'><t size='2.2'>Side-mission update</t><br/>____________________<br/>%1 recovered the intel.</t>", (name _caller)];
        [_sidecompleted] remoteExec ["AW_fnc_globalHint",0];

        ["InA_Event_SideMissionSuccess"] remoteExecCall ["AW_fnc_eventTrigger", 2];
    },
    {
        hint "You stop downloading the intel.";
        private _unit = _this select 1;
        _unit playMoveNow "";
    },
    [],
    8,
    0,
    true,
    false
] remoteExecCall ["BIS_fnc_holdActionAdd", 0, true];

//----------------task/circle/....
private _fuzzyPos = [_flatPos, 300] call AW_fnc_getFuzzyPos;

InA_Server_SideMarkers = ["SIDE", "Secure Intel From Destroyer", _fuzzyPos, 300] call AW_fnc_missionMarkersCreate;
private _sideMarker = (InA_Server_SideMarkers # 0);

[
    west,
    "DestroyerIntel",
    [
        "One of our destroyers has been hijacked by enemy forces.  On the bridge of this destroyer there's a server rack with highly sensitive information that you need to go retreive ASAP.  Recon of the destroyer suggests that there are ropes hanging from the sides and front of the ship you can use to climb up in addition to the ladders at the back.",
        "Side Mission: Secure Intel From Destroyer",
        _sideMarker
    ],
    _fuzzyPos,
    "Created",
    0,
    true,
    "search",
    true
] call BIS_fnc_taskCreate;

//==============mission core==============
InA_Server_SideMissionUp = true;
InA_Server_SideMissionSuccess = false;
InA_Server_SideMissionSpawned = true;

waitUntil {
    if (!InA_Server_SideMissionUp) exitWith {
        _intelobj setVariable ["IntelAcquired", true, true];
        true
    };

    sleep 5;

    ((!alive _intelobj) || InA_Server_SideMissionSuccess || !InA_Server_SideMissionUp)
};

 if (InA_Server_SideMissionSuccess) then {
    0 = ["DestroyerIntel"] spawn AW_fnc_finishTask;
    [] call AW_fnc_SMhintSUCCESS;
    InA_Server_SideMissionUp = false;
} else {
    if (!alive _intelobj || !InA_Server_SideMissionUp) then {
        0 = ["DestroyerIntel", "Failed"] spawn AW_fnc_finishTask;
        InA_Server_SideMissionUp = false;
        InA_Server_SideMissionSuccess = false;
    };
};


// Cleanup
[InA_Server_SideMarkers] call AW_fnc_missionMarkersRemove;

[_spawnedObjects, _flatPos, _origin] spawn {
    params ["_toDelete", "_pos", "_destroyerBase"];

    sleep 120;

    [_toDelete] spawn AW_fnc_delete;

    // Wait until players left the area
    waitUntil {
        sleep 10;
        !([_pos, 200] call AW_fnc_playersNear)
    };

    if (!isNull _destroyerBase) then {
        // Primary deletion routine
        private _destroyerParts = (_destroyerBase getVariable ["bis_carrierParts", []]);

        {
            _x params ["_obj", "_memPoint"];
            deleteVehicle _obj;
        } forEach _destroyerParts;

        deleteVehicle _destroyerBase;
    } else {
        // Fallback deletion routine
        private _types = [
            "Land_Destroyer_01_base_F", "Land_Destroyer_01_hull_01_F", "Land_Destroyer_01_hull_02_F",
            "Land_Destroyer_01_hull_03_F", "Land_Destroyer_01_hull_04_F", "Land_Destroyer_01_hull_05_F",
            "Land_Destroyer_01_interior_02_F", "Land_Destroyer_01_interior_03_F", "Land_Destroyer_01_interior_04_F",
            "Land_HelipadEmpty_F", "ShipFlag_US_F"
        ];

        private _shipParts = _pos nearEntities [_types, 200];

        {
            deleteVehicle _x;
        } forEach _shipParts;
    };
};
