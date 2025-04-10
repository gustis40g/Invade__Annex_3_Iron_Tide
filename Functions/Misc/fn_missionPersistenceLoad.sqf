/*
 * Author: Whigital
 * Description:
 * InA mission persistence load
 *
 *
 */

if (!isServer) exitWith {};

private _persistenceData = (profileNamespace getVariable ["InA_Server_PersistenceData", createHashMap]);

// Wrong type or format of PersistenceData
if ((typeName _persistenceData) != "HASHMAP") exitWith {
    _persistenceData = createHashMapFromArray [worldName, createHashMapFromArray [
        ["controlledZones", []],
        ["capturedFOBs", []],
        ["rewards", []]
    ]];

    profileNamespace setVariable ["InA_Server_PersistenceData", _persistenceData];
    saveProfileNamespace;
};

private _mapData = (_persistenceData getOrDefault [worldName, createHashMap]);

// Wrong type or format of mapData
if ((typeName _mapData) != "HASHMAP") exitWith {
    _mapData = createHashMapFromArray [
        ["controlledZones", []],
        ["capturedFOBs", []],
        ["rewards", []]
    ];

    _persistenceData insert  [[worldName, _mapData]];

    profileNamespace setVariable ["InA_Server_PersistenceData", _persistenceData];
    saveProfileNamespace;
};

// Empty hashMap
if (_mapData isEqualTo createHashMap) exitWith {};

InA_Server_controlledZones = (_mapData getOrDefault ["controlledZones", []]);
InA_Server_capturedFOBs = (_mapData getOrDefault ["capturedFOBs", []]);

private _rewards = (_mapData getOrDefault ["rewards", []]);

if (_rewards isNotEqualTo []) then {
    [_rewards] spawn {
        params ["_rewards"];

        waitUntil {
            sleep 1;
            (!isNil "InA_Server_PersistedRewardsSpawningSafe" && {InA_Server_PersistedRewardsSpawningSafe})
        };

        {
            _x params ["_id", "_pos"];

            private _vehicle = [_id, _pos] call AW_fnc_rewardSpawn;
            private _posData = [_pos] call AW_fnc_getRewardAreaPosition;

            _vehicle setDir (_posData # 1);
            _vehicle setPos (_posData # 0);
        } forEach _rewards;
    };
};

[format ["Persistence data loaded for map: %1", worldName], "LOAD", false] call AW_fnc_log;
