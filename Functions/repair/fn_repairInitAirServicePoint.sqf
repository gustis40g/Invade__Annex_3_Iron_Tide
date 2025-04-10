#include "repair_macros.hpp"
/*
 * Author: Whigital
 *
 * Description: Initializes a Air Service pad
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

private _originPos = (getMarkerPos [_marker, true]);
private _dir = (markerDir _marker);
private _overWater = (surfaceIsWater _originPos);

private _pad = createVehicle ["Land_HelipadEmpty_F", [0, 0, 0], [], 50, "NONE"];

_pad setDir _dir;

if (_overWater) then {
    _pad setPosASL (AGLToASL _originPos);
} else {
    {
        hideObjectGlobal _x;
    } forEach ((nearestObjects [_originPos, [], 10, true]) - (allMissionObjects "all") - allPlayers);

    _pad setPosATL _originPos;
};

private _offset = 6;

private _lights = [
    "Land_Flush_Light_red_F",
    "Land_Flush_Light_green_F",
    "PortableHelipadLight_01_blue_F"
];

private _things = [
    "Box_NATO_AmmoVeh_F",
    "Box_EAF_AmmoVeh_F",
    "VirtualReammoBox_F",
    "Land_Missle_Trolley_02_F",
    "Land_Bomb_Trolley_01_F",
    "Land_MRL_Magazine_01_F",
    "Land_EngineCrane_01_F",
    "CargoNet_01_barrels_F",
    "CargoNet_01_box_F"
];

private _thingsSelected = [];

private _innerLight = (_lights # 1);
private _outerLight = (_lights # 0);

private _padComposition = [
    [_outerLight, -_offset, _offset],
    [_outerLight, _offset, _offset],
    [_outerLight, _offset, 0],
    [_outerLight, _offset, -_offset],
    [_outerLight, -_offset, -_offset],
    [_outerLight, -_offset, 0],

    [_innerLight, 0, _offset],
    [_innerLight, 0, (_offset * 0.5)],
    [_innerLight, -(_offset * 0.5), 0],
    [_innerLight, (_offset * 0.5), 0],
    [_innerLight, 0, -(_offset * 0.5)],
    [_innerLight, 0, -_offset]
];

if (!_overWater) then {
    private _cutterOffset = 4;

    if (_edgeTop) then {
        _padComposition append [
            ["VR_Area_01_circle_4_grey_F", 0, 0, 0],
            ["RANDOM", -((_offset / 4) + (random (_offset / 2))), (_offset + (2 + (random 2))), (random 45), true],
            ["RANDOM", ((_offset / 4) + (random (_offset / 2))), (_offset + (2 + (random 2))), (random 315), true]
        ];
    } else {
        _padComposition append [
            ["Land_PedestrianCrossing_01_6m_6str_F", 0 , 3],
            ["Land_PedestrianCrossing_01_6m_6str_F", 0 , -3]
        ];
    };

    if (_edgeLeft) then {
        _padComposition append [
            ["RANDOM", -(_offset + (2 + (random 2))), ((_offset / 4) + (random (_offset / 2))), (random 225), true],
            ["RANDOM", -(_offset + (2 + (random 2))), -((_offset / 4) + (random (_offset / 2))), (random 135), true]
        ];
    };

    if (_edgeRight) then {
        _padComposition append [
            ["RANDOM", (_offset + (2 + (random 2))), -((_offset / 4) + (random (_offset / 2))), (random 90), true],
            ["RANDOM", (_offset + (2 + (random 2))), ((_offset / 4) + (random (_offset / 2))), (random 270), true]
        ];
    };

    _padComposition append [
        ["Land_ClutterCutter_large_F", -_cutterOffset, _cutterOffset],
        ["Land_ClutterCutter_large_F", _cutterOffset, _cutterOffset],
        ["Land_ClutterCutter_large_F", _cutterOffset, -_cutterOffset],
        ["Land_ClutterCutter_large_F", -_cutterOffset, -_cutterOffset]
    ];
};

{
    _x params ["_class", "_xOS", "_yOS", ["_objDir", 0], ["_simple", false]];

    private _pos = (
        if (_overWater) then {
            _pad modelToWorldWorld [_xOS, _yOS, 0]
        } else {
            _pad modelToWorld [_xOS, _yOS, 0]
        }
    );

    if (_class == "RANDOM") then {
        _class = (selectRandom (_things - _thingsSelected));
        _thingsSelected pushBack _class;
    };

    private _tmpObj = createVehicle [_class, [0, 0, 0]];

    _tmpObj setDir (_dir + _objDir);

    if (_overWater) then {
        _tmpObj setPosWorld _pos;
    } else {
        _pos set [2, 0];
        _tmpObj setPos _pos;
    };

    if (_simple) then {
        _tmpObj = [_tmpObj] call BIS_fnc_replaceWithSimpleObject;
    };

    _tmpObj allowDamage false;
} forEach _padComposition;

_pad setVariable [QGVAR(isServicePoint), true, true];
_pad setVariable [QGVAR(Radius), GVAR(Air_Distance), true];
_pad setVariable [QGVAR(Type), "Air", true];
_pad setVariable [QGVAR(InUse), false, true];

private _marker = createMarker [(format ["InA_AirService_%1-%2-%3", (random 99), (random 99), (random 99)]), _pad];
_marker setMarkerType "b_maint";
_marker setMarkerText "Air Service";
_marker setMarkerSize [0.5, 0.5];

GVAR(AirPads) pushBack _pad;
publicVariable QGVAR(AirPads);
