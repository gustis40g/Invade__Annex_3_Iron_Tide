/*
 * Author: Whigital
 * Description:
 * InA mission persistence save
 *
 *
 */

params [["_reset", false]];

if (!isServer) exitWith {};


/*
Saveformat:
<hashTable> <worldName>:<hashTable>
    "controlledZones":[InA_Server_controlledZones]
    "capturedFOBs":[InA_Server_capturedFOBs]
    "rewards":[[vehicletype, pos], ....]
*/

private _persistenceData = (profileNamespace getVariable ["InA_Server_PersistenceData", createHashMap]);

if (_reset) exitWith {
    _persistenceData set [worldName, createHashMapFromArray [
        ["controlledZones", []],
        ["capturedFOBs", []],
        ["rewards", []]
    ]];

    profileNamespace setVariable ["InA_Server_PersistenceData", _persistenceData];
    saveProfileNamespace;
};

private _rewards = [];

{
    if (!alive _x) then {
        InA_Server_RewardVehicles deleteAt _forEachIndex;
        continue;
    };

    private _rewardId = (_x getVariable ["InA_RewardId", -1]);

    if (_rewardId == -1) then {continue};

    _rewards pushBack [_rewardId, (getPos _x)];
} forEach InA_Server_RewardVehicles;

_persistenceData set [worldName, createHashMapFromArray [
    ["controlledZones", InA_Server_controlledZones],
    ["capturedFOBs", InA_Server_capturedFOBs],
    ["rewards", _rewards]
]];

profileNamespace setVariable ["InA_Server_PersistenceData", _persistenceData];
saveProfileNamespace;

[(format ["Persistence data saved for map: %1", worldName]), "SAVE", false] call AW_fnc_log;
