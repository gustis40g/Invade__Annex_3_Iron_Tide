/*
    fn_aoMarkers.sqf

    Creates markers for all the AOs depending on if they're captured or not
*/
params ["_action", "_type"];

if (isNil "AW_map_AOMarkers") then {
    AW_map_AOMarkers = [];
};

private _createMarker = {
    params ["_isCaptured", "_AO"];

    private _markerName = format ["AW_MAP_cap_%1_%2", _isCaptured, _AO];
    if (_markerName in AW_map_AOMarkers) exitWith {};

    private _mrk = createMarkerLocal [_markerName, getMarkerPos _AO];
    _mrk setMarkerShapeLocal "ICON";
    private _markerType = "o_unknown";
    private _markerColor = "colorOPFOR";
    if (_isCaptured) then {
        _markerType = "b_unknown";
        _markerColor = "colorBLUFOR";
    };
    _mrk setMarkerTypeLocal _markerType;
    _mrk setMarkerColorLocal _markerColor;
    _mrk setMarkerSizeLocal [0.5, 0.5];
    AW_map_AOMarkers pushBack _mrk;
};

private _createMarkers = {
    params ["_type", "_createMarkerCode"];

    missionNamespace setVariable [format ["AW_map_AOMarkers_%1Shown", _type], true];

    private _config = (missionConfigFile >> worldName >> "AOs");

    private _AOs = "true" configClasses (_config);

    {
        private _AO = configName _x;
        private _baseType = (getText (_config >> _AO >> "type"));
        if (_baseType == "MainBase" || _baseType == "Carrier") then {
            continue;
        };
        private _isCaptured = (_AO) in InA_Client_controlledZones;

        if ((_type == "friendly" && _isCaptured) || _type == "all") then {
            [_isCaptured, _AO] call _createMarkerCode;
        };
        if ((_type == "enemy" && !_isCaptured) || _type == "all") then {
            [_isCaptured, _AO] call _createMarkerCode;
        };
    } forEach _AOs;
};

private _deleteMarkers = {
    params ["_type"];

    missionNamespace setVariable [format ["AW_map_AOMarkers_%1Shown", _type], false];

    {
        if (_type == "all") then {
            deleteMarkerLocal _x;
            AW_map_AOMarkers = AW_map_AOMarkers - [_x];
        };
        if (_type == "friendly") then {
            if ( _x find "AW_MAP_cap_true" != -1 ) then {
                deleteMarkerLocal _x;
                AW_map_AOMarkers = AW_map_AOMarkers - [_x];
            };
        };
        if (_type == "enemy") then {
            if ( _x find "AW_MAP_cap_false" != -1 ) then {
                deleteMarkerLocal _x;
                AW_map_AOMarkers = AW_map_AOMarkers - [_x];
            };
        };
    } forEach AW_map_AOMarkers;
};

switch (_action) do {
    case "create": {
        [_type, _createMarker] call _createMarkers;
    };

    case "delete": {
        [_type] call _deleteMarkers;
    };
};
