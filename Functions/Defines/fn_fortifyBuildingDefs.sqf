/*
 * Author: Whigital
 *
 * Description:
 * Definitions for building fortifications
 *
 */

if (!isNil "InA_BuildingFortificationDefs") exitWith {};

InA_BuildingFortificationDefs = createHashMap;

InA_BuildingFortificationDefs insert [["FLAGS", ["Flag_FIA_F", "Flag_CSAT_F", "Flag_Syndikat_F", "Flag_Viper_F", "Flag_AAF_F", "Flag_Altis_F"]]];
InA_BuildingFortificationDefs insert [["BANNERS", ["Banner_01_CSAT_F", "Banner_01_FIA_F", "Banner_01_AAF_F"]]];
InA_BuildingFortificationDefs insert [["DECALS", ["Land_Graffiti_03_F", "Land_Graffiti_01_F", "Land_Graffiti_04_F", "Land_Graffiti_05_F", "Land_Graffiti_02_F"]]];
InA_BuildingFortificationDefs insert [["SANDBAGS_LONG", ["Land_BagFence_Long_F", "Land_BagFence_01_long_green_F"]]];
InA_BuildingFortificationDefs insert [["SANDBAGS_SHORT", ["Land_BagFence_Short_F", "Land_BagFence_01_short_green_F"]]];
InA_BuildingFortificationDefs insert [["SANDBARRICADES", ["Land_SandbagBarricade_01_F", "Land_SandbagBarricade_01_hole_F", "Land_SandbagBarricade_01_half_F"]]];


InA_BuildingFortificationDefs insert [
    ["Land_i_House_Big_01_V1_F", [
        ["DECAL",[-4.78662,3.00488,2.06699],90],
        ["BANNER",[-4.79443,-5.89307,1.77066],90],
        ["SANDBAG_SHORT",[-4.67041,-3.47168,-2.65637],270],
        ["SANDBAG_SHORT",[-3.21631,-7.43066,-2.65637],0],
        ["SANDBAG_SHORT",[-4.61377,-0.625,-2.65637],270],
        ["DECAL",[5.1333,3.2793,-1.12395],270],
        ["BANNER",[5.14063,0.964355,2.09409],270],
        ["Land_TinWall_01_m_4m_v1_F",[5.16016,-5.15283,-2.02344],270],
        ["Land_Wall_Tin_4_2",[5.26416,-5.23486,1.54059],270]
    ]]
];


InA_BuildingFortificationDefs insert [
    ["Land_i_House_Big_02_V1_F", [
        ["DECAL",[-1.41992,-4.50098,-1.09715],0],
        ["BANNER",[2.8623,-4.479,-1.18506],0],
        ["SANDBAG_SHORT",[-0.0131836,6.95752,0.722623],0],
        ["SANDBAG_SHORT",[3.16797,-6.72998,-2.28738],0],
        ["SANDBAG_SHORT",[-3.04785,6.95996,0.722623],0],
        ["SANDBAG_SHORT",[3.26172,6.97314,0.722623],0],
        ["SANDBAG_SHORT",[4.51855,-5.51465,-2.28738],90],
        ["SANDBAG_SHORT",[-4.31396,-5.26416,-2.72738],270],
        ["SANDBAG_SHORT",[-4.2749,-5.15723,0.782623],270],
        ["SANDBAG_SHORT",[1.80273,-5.17188,0.782623],90],
        ["SANDBAG_SHORT",[-3.92529,6.22607,0.722623],270],
        ["SANDBAG_SHORT",[4.16406,6.19727,0.722623],90],
        ["SANDBAG_LONG",[-1.36475,-5.8457,0.782623],0],
        ["SANDBAG_LONG",[-2.68994,-6.18555,-2.72738],0],
        ["FLAG",[4.30566,-7.03809,-2.28697],180],
        ["FLAG",[-3.72119,7.23633,0.722623],0]
    ]]
];


InA_BuildingFortificationDefs insert [
    ["Land_i_Shop_01_V1_F", [
        ["DECAL",[-2.15674,7.35107,-0.80882],180],
        ["BANNER",[2.3208,7.41016,-0.104057],180],
        ["SANDBAG_SHORT",[-3.79688,-3.30859,1.07886],270],
        ["SANDBAG_SHORT",[3.0415,-3.31885,1.07886],90],
        ["SANDBAG_SHORT",[-2.77979,-2.09326,-2.76301],0],
        ["SANDBAG_LONG",[-0.399414,-3.89697,1.07886],0],
        ["FLAG",[2.83496,-4.18018,1.07886],180],
        ["Land_TinWall_01_m_4m_v1_F",[0.15625,7.38184,1.83567],180],
        ["SANDBARRICADE",[-0.777832,-3.14307,-2.8001],180]
    ]]
];


InA_BuildingFortificationDefs insert [
    ["Land_i_Shop_02_V1_F", [
        ["DECAL",[-6.09082,2.93164,-0.888975],90],
        ["BANNER",[-6.19678,-3.22168,-0.0478992],90],
        ["SANDBAG_LONG",[-7.09863,0.00976563,1.23715],270],
        ["SANDBAG_SHORT",[5.16162,-2.96289,1.23715],90],
        ["SANDBAG_SHORT",[5.13477,0.0224609,1.23715],90],
        ["SANDBAG_SHORT",[5.14746,2.9624,1.23715],90],
        ["SANDBAG_SHORT",[4.55127,4.16797,1.23715],0],
        ["SANDBAG_SHORT",[4.53613,-4.14111,1.23715],0],
        ["SANDBAG_SHORT",[3.50488,-3.646,-2.6704],90],
        ["SANDBAG_SHORT",[3.52588,3.63037,-2.67185],90],
        ["FLAG",[5.44189,3.9585,1.38147],90],
        ["SANDBARRICADE",[4.45703,2.3291,-2.84353],90],
        ["SANDBARRICADE",[4.38867,-2.12793,-2.84204],90]
    ]]
];


InA_BuildingFortificationDefs insert [
    ["Land_i_House_Small_01_V1_F", [
        ["DECAL",[2.70654,5.25244,0.802271],180],
        ["DECAL",[5.00488,-1.77393,1.22872],270],
        ["DECAL",[-5.07861,-2.87451,0.82032],90],
        ["BANNER",[-3.43945,5.34033,1.63838],180],
        ["BANNER",[3.021,-4.88037,1.77444],0],
        ["Land_TinWall_01_m_4m_v1_F",[-1.11523,-4.84814,-0.113983],0]
    ]]
];


InA_BuildingFortificationDefs insert [
    ["Land_i_House_Small_02_V1_F", [
        ["DECAL",[2.20752,3.28027,1.01928],180],
        ["DECAL",[2.45752,-3.72314,1.00952],0],
        ["BANNER",[-4.00732,-0.687988,0.62258],91.4642]
    ]]
];


InA_BuildingFortificationDefs insert [
    ["Land_i_House_Small_03_V1_F", [
        ["DECAL",[-4.53564,5.31006,1.20257],180],
        ["DECAL",[-5.94678,-0.69873,1.52538],90],
        ["DECAL",[5.86084,-5.21191,1.59142],270],
        ["BANNER",[2.32373,5.31396,1.1963],180],
        ["BANNER",[-1.58887,-2.75098,1.38211],0]
    ]]
];


InA_BuildingFortificationDefs insert [
    ["Land_i_Stone_Shed_V1_F", [
        ["DECAL",[-4.28418,0.849609,1.14161],90],
        ["BANNER",[0.923828,-1.01904,1.03912],0],
        ["Land_TinWall_01_m_4m_v1_F",[-1.97461,-1.01611,0.0916462],0],
        ["DECAL",[-0.183105,4.76123,1.23963],180],
        ["DECAL",[3.5625,3.45215,1.51507],270]
    ]]
];


InA_BuildingFortificationDefs insert [
    ["Land_i_Stone_HouseSmall_V1_F", [
        ["DECAL",[0.253418,-1.36865,0.395148],0],
        ["DECAL",[3.375,5.64746,1.15488],179.741],
        ["DECAL",[-6.03613,5.63086,0.292128],179.741],
        ["BANNER",[-5.68652,-1.36914,1.15306],0],
        ["SANDBAG_SHORT",[6.91992,-2.99072,-1.10849],180],
        ["SANDBAG_SHORT",[8.09326,-2.35547,-1.09498],90],
        ["SANDBAG_SHORT",[-9.01465,-2.28418,-1.09382],90],
        ["SANDBAG_SHORT",[-7.92236,-3.02783,-1.10371],0]
    ]]
];


InA_BuildingFortificationDefs insert [
    ["Land_i_Stone_HouseBig_V1_F", [
        ["DECAL",[0.848633,6.02295,2.65149],179.741],
        ["DECAL",[-0.612305,-1.99316,-0.26649],0],
        ["DECAL",[5.47949,2.90234,-0.279783],270],
        ["DECAL",[-2.53027,0.257813,2.49276],90],
        ["BANNER",[2.94336,-2.00635,0.744804],0],
        ["BANNER",[-2.53516,3.46191,1.18263],90],
        ["SANDBAG_SHORT",[3.78223,-2.83154,-1.84251],90],
        ["SANDBAG_SHORT",[-3.39941,4.22998,-1.84251],180],
        ["SANDBAG_LONG",[6.60742,2.45605,1.18749],270]
    ]]
];


InA_BuildingFortificationDefs insert [
    ["Land_i_Addon_02_V1_F", [
        ["DECAL",[-2.98096,-0.749023,1.49168],0],
        ["BANNER",[0.610352,-0.741699,1.58527],0]
    ]]
];


InA_BuildingFortificationDefs insert [
    ["Land_i_Garage_V1_F", [
        ["SANDBARRICADE",[-4.12305,0.933594,-0.0989208],270],
        ["DECAL",[4.44482,3.11279,1.25218],180],
        ["DECAL",[2.52588,-2.91406,2.07148],0],
        ["DECAL",[-2.24219,3.10303,2.01252],180],
        ["BANNER",[5.4751,-0.533691,1.68964],270],
        ["SANDBAG_SHORT",[7.19775,1.39258,-0.168837],89.9797],
        ["SANDBAG_SHORT",[6.46582,2.48877,-0.254942],0]
    ]]
];


InA_BuildingFortificationDefs insert [
    ["Land_GH_House_1_F", [
        ["DECAL",[-5.00684,-4.84326,2.92883],90],
        ["DECAL",[3.28174,1.9209,2.92871],180],
        ["DECAL",[-3.34277,1.9209,-0.662762],180],
        ["DECAL",[5.00635,-5.10938,-0.347633],270],
        ["BANNER",[-3.29102,1.92627,3.1066],180],
        ["SANDBAG_LONG",[2.28516,-9.58252,-2.10117],0],
        ["SANDBAG_LONG",[-2.49268,-9.56641,1.39883],0],
        ["SANDBAG_LONG",[2.2832,-9.5835,1.39883],0],
        ["SANDBAG_LONG",[-2.32227,-9.56543,-2.10117],0],
        ["FLAG",[-1.16016,-9.53076,1.39883],270]
    ]]
];


InA_BuildingFortificationDefs insert [
    ["Land_GH_House_2_F", [
        ["DECAL",[4.99805,-6.11865,1.54735],270],
        ["DECAL",[-3.29541,2.12451,1.24515],180],
        ["DECAL",[-5.01221,-2.73633,1.19069],90],
        ["BANNER",[3.16895,2.11475,1.07581],180],
        ["SANDBAG_SHORT",[-2.29199,-9.4209,-0.330635],0],
        ["SANDBAG_SHORT",[2.36133,-9.42871,-0.343007],0],
        ["SANDBAG_SHORT",[-3.77832,-8.75098,-0.355709],90],
        ["FLAG",[3.38477,-9.30371,-0.276174],270]
    ]]
];


InA_BuildingFortificationDefs insert [
    ["Land_Unfinished_Building_01_F", [
        ["SANDBAG_SHORT",[2.89063,-3.41943,-2.29853],0],
        ["SANDBAG_LONG",[2.93359,-5.02783,1.19647],0],
        ["Land_TinWall_01_m_4m_v1_F",[-5.27002,-0.817383,-1.32909],90],
        ["DECAL",[1.46387,5.11865,-0.885535],270],
        ["DECAL",[-1.3042,6.69189,-0.297252],180],
        ["DECAL",[-5.52051,2.56592,-0.509025],90],
        ["BANNER",[-5.52051,4.11182,2.2288],90],
        ["BANNER",[-0.457031,6.68604,2.24994],180],
        ["SANDBAG_SHORT",[2.96924,1.56836,1.19647],180],
        ["SANDBAG_SHORT",[1.271,3.13037,1.19647],270],
        ["SANDBAG_LONG",[4.64453,-0.883301,-2.29853],270],
        ["SANDBAG_LONG",[4.82031,-0.896973,1.19647],270],
        ["FLAG",[1.50684,0.918945,1.19647],90]
    ]]
];


InA_BuildingFortificationDefs insert [
    ["Land_Unfinished_Building_02_F", [
        ["SANDBARRICADE",[-4.97852,-3.42725,-2.48896],180],
        ["DECAL",[6.38135,-1.83057,2.69386],270],
        ["DECAL",[3.93213,-3.85205,-1.07682],0],
        ["BANNER",[-0.92627,-6.51953,0.858739],0],
        ["SANDBAG_SHORT",[5.27246,-3.57617,0.868169],0],
        ["SANDBARRICADE",[2.81494,5.74658,-2.49589],0],
        ["SANDBARRICADE",[5.05322,5.71631,-2.50148],0],
        ["Land_Wall_Tin_4_2",[6.36865,3.53369,-2.50247],270],
        ["Land_TinWall_01_m_4m_v1_F",[6.31885,-1.23291,-2.49747],270],
        ["DECAL",[-8.35352,-1.26953,-0.917867],90],
        ["BANNER",[-5.13232,6.06152,-0.826835],180],
        ["SANDBAG_SHORT",[0.340332,5.8418,0.908004],0],
        ["SANDBAG_SHORT",[7.58447,5.69287,0.726362],0],
        ["SANDBAG_LONG",[-5.83398,5.9043,0.915773],180],
        ["SANDBAG_LONG",[4.07568,5.83301,0.923975],180],
        ["FLAG",[2.04395,5.71338,0.974724],0]
    ]]
];


InA_BuildingFortificationDefs insert [
    ["Land_i_Barracks_V1_F", [
        ["Land_TinWall_01_m_4m_v1_F",[-14.0483,1.59521,4.64772],90],
        ["DECAL",[-14.0151,-3.66309,3.86506],90],
        ["Land_Wall_Tin_4_2",[-4.43457,-7.02344,4.44426],0],
        ["Land_Wall_Tin_4_2",[1.44385,5.14209,1.08196],180],
        ["Land_Wall_Tin_4_2",[-0.632324,-7.02344,4.44426],0],
        ["Land_Wall_Tin_4_2",[5.53809,5.14209,1.08196],180],
        ["Land_TinWall_01_m_4m_v1_F",[11.7158,-4.95898,4.59525],0],
        ["Land_TinWall_01_m_4m_v1_F",[7.63916,-4.95898,4.59525],0],
        ["Land_TinWall_01_m_4m_v1_F",[6.4082,5.05078,4.56682],180],
        ["DECAL",[15.0181,3.12695,1.81418],270],
        ["BANNER",[-5.46045,-6.91162,3.28388],0],
        ["BANNER",[6.19727,6.62598,3.73898],180],
        ["BANNER",[-3.56006,6.62598,3.73898],180],
        ["FLAG",[16.5566,6.00098,3.852],135]
    ]]
];


InA_BuildingFortificationDefs insert [
    ["Land_i_Shed_Ind_F", [
        ["Land_TinWall_01_m_4m_v1_F",[-9.22119,0.645996,-0.492801],90],
        ["DECAL",[-3.63281,-2.08057,0.55703],0],
        ["DECAL",[-1.08496,9.05713,0.427465],180],
        ["BANNER",[-9.1709,5.93945,2.33442],90],
        ["Land_Wall_Tin_4_2",[16.3516,6.08252,1.10325],270],
        ["DECAL",[16.2158,1.479,1.04733],270],
        ["DECAL",[10.4058,9.05518,1.44461],180],
        ["BANNER",[13.7026,-2.0835,2.17566],0]
    ]]
];


InA_BuildingFortificationDefs insert [
    ["Land_GH_Gazebo_F", [
        ["SANDBARRICADE",[-1.93945,-2.62451,-1.83978],180],
        ["SANDBARRICADE",[1.80078,3.84229,-1.7341],180],
        ["Land_Wall_Tin_4_2",[-1.67627,4.04199,-2.09187],180],
        ["Land_TinWall_01_m_4m_v1_F",[5.23779,-2.34326,-1.7341],0],
        ["DECAL",[-7.51611,-0.606445,-0.243867],90],
        ["SANDBAG_SHORT",[-6.21045,-3.94043,-1.83978],0],
        ["SANDBAG_SHORT",[-7.38184,-3.20068,-1.83978],90],
        ["SANDBAG_LONG",[5.47412,-3.91309,-1.83978],0],
        ["FLAG",[-3.08691,-2.76514,-1.83987],90],
        ["DECAL",[7.5,2.39063,-0.244159],270],
        ["SANDBAG_SHORT",[7.36182,-3.23486,-1.83987],90]
    ]]
];
