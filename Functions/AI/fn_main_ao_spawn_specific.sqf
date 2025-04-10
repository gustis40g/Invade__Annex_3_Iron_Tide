params [
    "_AO",
    "_enemyAmount",
    ["_factionHash", InA_EnemyFactionHash]
];

private _AOpos = getMarkerPos _AO;
private _AOType = (missionConfigFile >> worldName >> "AOs" >> _AO >> "type") call BIS_fnc_getCfgData;
_enemyAmount params ["_boats", "_fortificationNumbers"];

private _spawnedObjects = [];

switch (_AOType) do {
    // FOBs and other military installations
    case "Military": {
        if (count (AW_OPFOR_main_military_bunkers) == 0) exitWith {};

        private _spawnUnitsInFortification = {
            params ["_building", "_grp", "_factionHash"];

            private _units = [];
            private _buildingType = typeOf _building;
            private _infbuildingpos = _building buildingPos -1;

            if ((count _infbuildingpos) == 0) then {continue};

            _infbuildingpos = _infbuildingpos call BIS_fnc_arrayShuffle;

            private _unitTypes = ["#riflemen", 1, "#lats", 0.75, "#machinegunners", 0.5,"#grenadiers", 0.5];
            private _limit = 1;

            if (_buildingType == "Land_BagBunker_Tower_F") then {
                _limit = 3;
            };

            {
                if (_forEachIndex > _limit) then {break};

                private _unitType = [(selectRandomWeighted _unitTypes), _factionHash] call AW_fnc_getUnitsFromHash;
                private _unit = _grp createUnit [_unitType, _x, [], 0, "CAN_COLLIDE"];

                _units pushBack _unit;
                _unit disableAI "PATH";
                _unit setUnitPos "UP";
            } forEach _infbuildingpos;

            [_units] remoteExec ["AW_fnc_addToAllCurators", 2];

            _units
        };

        for "_i" from 1 to _fortificationNumbers do {
            private _pos = [_AOpos, 10, InA_Server_MainAOSize, 10, 0, 0.1, 0, [], [0,0,0]] call BIS_fnc_findSafePos;
            private _origin = createVehicle ["Land_BagBunker_Small_F", _pos, [], 0, "NONE"];
            _origin setVectorUp [0, 0, 1];
            _spawnedObjects pushBack _origin;

            private _grp = (createGroup InA_EnemyFactionSide);
            private _spawnedUnits = [_origin, _grp, _factionHash] call _spawnUnitsInFortification;
            _spawnedObjects append _spawnedUnits;

            {
                private _obj = [_origin, _x, 0] call AW_fnc_spawnRelative;
                _obj allowDamage false;

                private _objPos = (getPos _obj);
                _objPos set [2, 0];
                _obj setPos _objPos;
                _obj setVectorUp (surfaceNormal _objPos);

                _spawnedObjects pushBack _obj;
                _spawnedUnits = ([_obj, _grp, _factionHash] call _spawnUnitsInFortification);
                _spawnedObjects append _spawnedUnits;
            } forEach selectRandom AW_OPFOR_main_military_bunkers;

            private _originPos = (getPos _origin);
            _originPos set [2, 0];
            _origin setPos _originPos;
            _origin setVectorUp (surfaceNormal _originPos);

            _grp = [_grp] call AW_fnc_changeGroupSide;
            _grp setGroupIdGlobal [format ["AO-Fort%1", _i]];
            [_grp] spawn AW_fnc_transferGroupHC;

            sleep 0.2;
        };
    };

    case "Coastline": {

    };

    case "Hill": {

    };

    case "Outpost": {

    };

    case "Town": {

    };
};

_spawnedObjects
