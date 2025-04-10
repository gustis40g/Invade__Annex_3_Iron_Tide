/*
Author: alganthe
Description: Handles creating the AI
*/
params [
    "_AO",
    ["_radiusSize", InA_Server_MainAOSize],
    ["_factionHash", InA_EnemyFactionHash]
];

if (!isServer) exitWith {};

waitUntil {
    sleep 0.1;
    (!isNil "InA_FactionMappingsDefined" && {InA_FactionMappingsDefined})
};


// To make sure we don't hit the groups cap
{
    if ((count (units _x)) == 0) then {
        deleteGroup _x;
    };

    sleep 0.05;
} forEach allGroups;


private _AOpos = (getMarkerPos _AO);
InA_Server_mainAOUnits = [];


// Determine how many units to spawn
private _enemyAmount = [] call AW_fnc_main_ao_calculate_enemy_numbers;

_enemyAmount params [
    "_MBTs",
    "_AAVics",
    "_IFVs",
    "_Cars",
    "_mainInf",
    "_AAinf",
    "_ATinf",
    "_recon",
    "_helis",
    "_jets",
    "_boats",
    "_fortifications"
];


// Spawn AO specific things
private _AOSpecific = [_AO, [_boats, _fortifications], _factionHash] call AW_fnc_main_ao_spawn_specific;
InA_Server_mainAOUnits append _AOSpecific;


// Main force
private _enemiesArray = [
    _AOpos,
    "AO",
    "#circ",
    [_MBTs, _AAVics, _IFVs, _Cars],
    [_mainInf, _recon, _AAinf, _ATinf, 0],
    50,
    _radiusSize,
    _factionHash
] call AW_fnc_spawnEnemyUnits;

InA_Server_mainAOUnits append _enemiesArray;

// Attack helos
if (_helis != 0) then {
    [_helis, _AOpos, _radiusSize] spawn {
        params ["_helis", "_AOpos", "_radiusSize"];

        for "_i" from 1 to _helis do {
            private _randomPos = [_AOpos, 0, _radiusSize, 5, 0, 0.4, 0, [], _AOpos] call BIS_fnc_findSafePos;
            _randomPos set [2, (100 + (random 100))];
            [_randomPos, nil, true] spawn AW_fnc_heliCombatPatrol;
            sleep 1;
        };
    };
};


// Jets
if (_jets != 0) then {
    [_jets] spawn {
        params ["_jets"];

        for "_i" from 1 to _jets do {
            [true] spawn AW_fnc_enemyJetSpawn;
            sleep 1;
        };
    };
};


// Garrisons
[_AO, _radiusSize, _factionHash] spawn AW_fnc_main_ao_garrison_spawner;


// Signal spawn complete
InA_Server_mainAoSpawnCompleted = true;
