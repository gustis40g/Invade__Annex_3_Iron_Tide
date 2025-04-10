#include "repair_macros.hpp"
/*
 * Author: Whigital
 *
 * Description: Initializes a Ground Service pad
 *
 */

params [
    "_marker",
    ["_borders", [1, 0, 1]]
];

if (!isServer) exitWith {};

private _edgeLeft = ([false , true] select (_borders # 0));
private _edgeTop = ([false , true] select (_borders # 1));
private _edgeRight = ([false , true] select (_borders # 2));

private _originPos = (getMarkerPos _marker);
private _dir = (markerDir _marker);

private _pad = createVehicle ["Land_HelipadEmpty_F", [0, 0, 0], [], 50, "NONE"];

_pad setDir _dir;
_pad setPos _originPos;

{
    hideObjectGlobal _x;
} forEach ((nearestObjects [_originPos, [], 10, true]) - (allMissionObjects "all") - allPlayers);

private _cutterOffset = 4;

{
    _x params ["_xOS", "_yOS"];

    private _pos = _pad modelToWorld [_xOS, _yOS, 0];
    private _cutter = createVehicle ["Land_ClutterCutter_large_F", [0, 0, 0]];

    _cutter setDir _dir;
    _cutter setPos _pos;
} forEach [
    [-_cutterOffset, _cutterOffset],
    [_cutterOffset, _cutterOffset],
    [_cutterOffset, -_cutterOffset],
    [-_cutterOffset, -_cutterOffset]
];

private _offset = 4.5;

private _things = [
    "Land_EngineCrane_01_F",
    "Box_NATO_AmmoVeh_F",
    "Land_ScrapHeap_1_F",
    "Box_EAF_AmmoVeh_F",
    "VirtualReammoBox_F",
    "Land_TankEngine_01_used_F",
    "Land_Pallet_MilBoxes_F",
    "CargoNet_01_box_F",
    "Land_PaperBox_open_full_F",
    "CargoNet_01_barrels_F"
];

private _thingsSelected = [];

private _padComposition = [
    ["Land_ConcretePanels_02_single_v1_F", -2, 2],
    ["Land_ConcretePanels_02_single_v1_F", 0, 2],
    ["Land_ConcretePanels_02_single_v1_F", 2, 2],
    ["Land_ConcretePanels_02_single_v1_F", -2, -2],
    ["Land_ConcretePanels_02_single_v1_F", 0, -2],
    ["Land_ConcretePanels_02_single_v1_F", 2, -2]
];

if (_edgeTop) then {
    _padComposition append [
        ["RANDOM", -((random (_offset - 1)) + 1), ((_offset + 1) + (random 1)), (random 90)],
        ["RANDOM", ((random (_offset - 1)) + 1), ((_offset + 1) + (random 1)), (random 45)]
    ];
};

if (_edgeLeft) then {
    _padComposition append [
        ["RANDOM", -((_offset + 1) + (random 1)), (1 + (random _offset)), (random 135)],
        ["RANDOM", -((_offset + 1) + (random 1)), -(random (_offset - 1)), (random 180)]
    ];
};

if (_edgeRight) then {
    _padComposition append [
        ["RANDOM", ((_offset + 1) + (random 1)), (1 + (random _offset)), (random 90)],
        ["RANDOM", ((_offset + 1) + (random 1)), -(random (_offset - 1)), (random 225)]
    ];
};

{
    _x params ["_class", "_xOS", "_yOS", ["_objDir", 0]];

    private _pos = (_pad modelToWorld [_xOS, _yOS, 0]);

    if (_class == "RANDOM") then {
        _class = (selectRandom (_things - _thingsSelected));
        _thingsSelected pushBack _class;
    };

    private _tmpObj = createVehicle [_class, [0, 0, 0]];
    _tmpObj setDir (_dir + _objDir);
    _pos set [2, 0];
    _tmpObj setPos _pos;

    _tmpObj = [_tmpObj] call BIS_fnc_replaceWithSimpleObject;
} forEach _padComposition;

_pad setVariable [QGVAR(isServicePoint), true, true];
_pad setVariable [QGVAR(Radius), GVAR(Ground_Distance), true];
_pad setVariable [QGVAR(Type), "Land", true];
_pad setVariable [QGVAR(InUse), false, true];

private _marker = createMarker [(format ["InA_GroundService_%1-%2-%3", (random 99), (random 99), (random 99)]), _pad];
_marker setMarkerType "b_maint";
_marker setMarkerText "Ground Service";
_marker setMarkerSize [0.5, 0.5];

GVAR(GroundPads) pushBack _pad;
publicVariable QGVAR(GroundPads);
