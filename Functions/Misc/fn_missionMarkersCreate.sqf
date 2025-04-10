/*
 * Author: Whigital
 * Description:
 * Create markers based on objective
 *
 */

params [
    "_type",
    "_name",
    "_pos",
    "_size"
];

if (!isServer) exitWith {};

private _markers = [];

switch (_type) do {
    case "MAIN": {
        private _mainMarker = (createMarkerLocal ["InA_MainAO_Marker", _pos]);
        _mainMarker setMarkerShapeLocal "ICON";
        _mainMarker setMarkerTypeLocal "o_unknown";
        _mainMarker setMarkerSizeLocal [0.5, 0.5];
        _mainMarker setMarkerText (format ["%1", _name]);

        _markers pushBack _mainMarker;

        private _mainCircle = (createMarkerLocal ["InA_MainAO_Circle", _pos]);
        _mainCircle setMarkerShapeLocal "ELLIPSE";
        _mainCircle setMarkerSizeLocal [_size, _size];
        _mainCircle setMarkerBrushLocal "FDiagonal";
        _mainCircle setMarkerColor "ColorEAST";

        _markers pushBack _mainCircle;
    };

    case "SUB": {
        private _mainSubMarker = (createMarkerLocal ["InA_MainAOSub_Marker", _pos]);
        _mainSubMarker setMarkerShapeLocal "ICON";
        _mainSubMarker setMarkerTypeLocal "loc_Transmitter";
        _mainSubMarker setMarkerSizeLocal [0.5, 0.5];
        _mainSubMarker setMarkerTextLocal (format ["Sub-Objective: %1", _name]);
        _mainSubMarker setMarkerColor "ColorEAST";

        _markers pushBack _mainSubMarker;

        private _mainSubCircle = (createMarkerLocal ["InA_MainAOSub_Circle", _pos]);
        _mainSubCircle setMarkerShapeLocal "ELLIPSE";
        _mainSubCircle setMarkerSizeLocal [_size, _size];
        _mainSubCircle setMarkerBrushLocal "Border";
        _mainSubCircle setMarkerColor "ColorEAST";

        _markers pushBack _mainSubCircle;
    };

    case "SIDE": {
        private _sideMarker = (createMarkerLocal ["InA_Side_Marker", _pos]);
        _sideMarker setMarkerShapeLocal "ICON";
        _sideMarker setMarkerTypeLocal "mil_dot";
        _sideMarker setMarkerSizeLocal [0.5, 0.5];
        _sideMarker setMarkerTextLocal (format ["Side Mission: %1", _name]);
        _sideMarker setMarkerColor "ColorEAST";

        _markers pushBack _sideMarker;

        private _sideCircle = (createMarkerLocal ["InA_Side_Circle", _pos]);
        _sideCircle setMarkerShapeLocal "ELLIPSE";
        _sideCircle setMarkerSizeLocal [_size, _size];
        _sideCircle setMarkerBrushLocal "Border";
        _sideCircle setMarkerColor "ColorEAST";

        _markers pushBack _sideCircle;
    };

    case "PRIO": {
        private _prioMarker = (createMarkerLocal ["InA_Prio_Marker", _pos]);
        _prioMarker setMarkerShapeLocal "ICON";
        _prioMarker setMarkerTypeLocal "o_Ordnance";
        _prioMarker setMarkerSizeLocal [0.5, 0.5];
        _prioMarker setMarkerTextLocal (format ["Priority Target: %1", _name]);
        _prioMarker setMarkerColor "ColorEAST";

        _markers pushBack _prioMarker;

        private _prioCircle = (createMarkerLocal ["InA_Prio_Circle", _pos]);
        _prioCircle setMarkerShapeLocal "ELLIPSE";
        _prioCircle setMarkerSizeLocal [_size, _size];
        _prioCircle setMarkerBrushLocal "Border";
        _prioCircle setMarkerColor "ColorEAST";

        _markers pushBack _prioCircle;
    };
};

_markers
