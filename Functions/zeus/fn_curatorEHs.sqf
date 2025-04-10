/*
 * Author: Whigital
 * Description:
 * Adds EHs for Curator events
 *
 */

params [["_module", objNull]];

if (isNull _module) exitWith {};


// Object placed
private _curatorObjPlacedEhIdx = (_module getVariable ["CuratorObjPlacedEhIdx", -1]);

if (_curatorObjPlacedEhIdx == -1) then {
    private _placedIdx = _module addEventHandler ["CuratorObjectPlaced", {
        params ["_curator", "_entity"];

        if !(_entity isKindOf "Man") then {
            [[_entity]] remoteExec ["AW_fnc_addToAllCurators", 2];
        };
    }];

     _module setVariable ["CuratorObjPlacedEhIdx", _placedIdx];
};


// Group placed
private _curatorGrpPlacedEhIdx = (_module getVariable ["CuratorGrpPlacedEhIdx", -1]);

// Make sure the EH is added only once per module
if (_curatorGrpPlacedEhIdx == -1) then {
    private _placedIdx = _module addEventHandler ["CuratorGroupPlaced", {
        _this remoteExec ["AW_fnc_curatorGrpPlacedHandler", 2];
    }];

    _module setVariable ["CuratorGrpPlacedEhIdx", _placedIdx];
};


// Marker placed
private _curatorMarkerPlacedEhIdx = (_module getVariable ["CuratorMarkerPlacedEhIdx", -1]);

// Make sure the EH is added only once per module
if (_curatorMarkerPlacedEhIdx == -1) then {
    private _placedIdx = _module addEventHandler ["CuratorMarkerPlaced", {
        params ["_curator", "_marker"];

        private _markers = _curator getVariable ["PlacedCuratorMarkers", []];

        _markers pushBackUnique _marker;

        _curator setVariable ["PlacedCuratorMarkers", _markers, true];
    }];

    _module setVariable ["CuratorMarkerPlacedEhIdx", _placedIdx];
};


// Marker deleted
private _curatorMarkerDeletedEhIdx = (_module getVariable ["CuratorMarkerDeletedEhIdx", -1]);

// Make sure the EH is added only once per module
if (_curatorMarkerDeletedEhIdx == -1) then {
    private _deletedIdx = _module addEventHandler ["CuratorMarkerDeleted", {
        params ["_curator", "_marker"];

        private _markers = _curator getVariable ["PlacedCuratorMarkers", nil];

        if (!isNil "_markers") then {
            _markers deleteAt (_markers find _marker);

            _curator setVariable ["PlacedCuratorMarkers", _markers, true];
        }
    }];

    _module setVariable ["CuratorMarkerDeletedEhIdx", _deletedIdx];
};
