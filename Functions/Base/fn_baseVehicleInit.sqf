/*
 * Author: Whigital
 * Description:
 * Initializes Base vehicle spawning to circumvent Hide Terrain Objects module delay ....
 *
 */

private _baseConfig = (missionConfigFile >> worldName >> "AOs" >> "BASE");

waituntil {
    sleep 1;
    (((getMarkerPos ["BASE", true]) nearEntities ["ModuleHideTerrainObjects_F", 500]) isEqualTo [])
};

if (isArray (_baseConfig >> "spawnVehicles")) then {
    private _baseVehicles = (getArray (_baseConfig >> "spawnVehicles"));

    {
        _x params ["_veh", "_mkr", "_timer"];

        private _vehType = nil;

        if (!(isClass (configFile >> "CfgVehicles" >> _veh))) then {
            private _vehArray = [_veh] call AW_fnc_vehicleLookup;
            _vehType = (_vehArray # 0);
        } else {
            _vehType = _veh;
        };

        private _spawnPos = (getMarkerPos _mkr);
        private _vehicle = createVehicle [_vehType, [0,0,100], [], 100, "NONE"];
        _vehicle setDir (markerDir _mkr);

        if (_vehicle isKindOf "Ship") then {
            _vehicle setPosASL [(_spawnPos # 0), (_spawnPos # 1), 1];
        } else {
            _vehicle setPosATL [(_spawnPos # 0), (_spawnPos # 1), 0.3];
        };

        [[_vehicle]] call AW_fnc_addToAllCurators;
        [_vehicle, _timer] spawn AW_fnc_vBaseMonitor;
    } forEach _baseVehicles;
};
