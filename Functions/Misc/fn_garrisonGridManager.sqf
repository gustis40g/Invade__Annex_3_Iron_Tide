/*
 * Author: Whigital
 *
 * Description:
 * Creates a grid of squares that indicate where troops are garrisoned
 *
 */

params [
    "_oper",
    "_args"
];

if (!isServer) exitWith {};

switch (_oper) do {
    case "INIT": {
        if (isNil "InA_MainAO_GarrisonGrid") exitWith {};

        InA_MainAO_GarrisonGrid_Thread = [] spawn {
            private _lastTick = 0;
            private _interval = 5;

            while {!InA_Server_MainAO_Completed} do {
                if ((keys InA_MainAO_GarrisonGrid) isEqualTo []) then {break};

                if (diag_tickTime < (_lastTick + _interval)) then {
                    sleep 1;
                    continue;
                };

                _lastTick = diag_tickTime;

                {
                    private _clear = true;

                    private _marker = _x;
                    private _data = _y;

                    {
                        _x params ["_group"];

                        if (((units _group) findIf {alive _x}) != -1) then {
                            _clear = false;
                            break;
                        };
                    } forEach _data;

                    if (_clear) then {
                        ["REM", [_marker]] call AW_fnc_garrisonGridManager;
                    };
                } forEach InA_MainAO_GarrisonGrid;
            };

            ["END"] call AW_fnc_garrisonGridManager;
        };
    };

    case "END": {
        {
            deleteMarker _x;
        } forEach (keys InA_MainAO_GarrisonGrid);

        InA_MainAO_GarrisonGrid = nil;
    };

    case "ADD": {
        _args params ["_building", "_group"];

        if (isNil "InA_MainAO_GarrisonGrid") then {
            InA_MainAO_GarrisonGrid = createHashMap;
        };

        private _pos = (getPosATL _building);
        private _posX = (_pos # 0);
        private _posY = (_pos # 1);

        private _xGrid = (floor (_posX / 100) * 100);
        private _yGrid = (floor (_posY / 100) * 100);

        private _markerName = (format ["InA_MainAO_Grid_%1-%2", _xGrid, _yGrid]);

        if (_markerName in (keys InA_MainAO_GarrisonGrid)) then {
            private _gridData = (InA_MainAO_GarrisonGrid get _markerName);
            _gridData pushBack _group;
            InA_MainAO_GarrisonGrid set [_markerName, _gridData];
        } else {
            private _marker = createMarkerLocal [_markerName, [(_xGrid + 50), (_yGrid + 50)]];
            _marker setMarkerShapeLocal "RECTANGLE";
            _marker setMarkerSizeLocal [50, 50];
            _marker setMarkerColorLocal "colorOPFOR";
            _marker setMarkerAlpha 0.5;

            InA_MainAO_GarrisonGrid insert [
                [_markerName, [_group]]
            ];
        };
    };

    case "REM": {
        _args params ["_marker"];

        deleteMarker _marker;
        InA_MainAO_GarrisonGrid deleteAt _marker;
    };
};
