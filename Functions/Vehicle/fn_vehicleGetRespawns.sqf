/*
 * Author: Whigital
 * Description:
 * Returns info about vehicles currently on the respawn queue
 *
 */

params [["_oper", "RAW"]];

if (!isServer) exitWith {};

if (!isRemoteExecuted) exitWith {};

switch (_oper) do {
    case "HINT": {
        private _respawnArray = [];

        {
            _x params ["_veh", "_vehType", "_spawnPos", "_spawnDir", "_spawnDelay", "_timeDestroyed", "_base", "_uid"];

            if (!isNil "_timeDestroyed") then {
                private _timeLeft = (round ((_spawnDelay - (serverTime - _timeDestroyed)) / 60));

                if (_timeLeft < 1) then {_timeLeft = "<1"};

                _respawnArray pushBack format ["%1 / %2: %3 min", ([_base] call AW_fnc_getFOBDisplayName), ([_vehType] call AW_fnc_getRespawnVehicleDisplayName), _timeLeft];
            };
        } forEach InA_Server_RespawnVehiclesArray;

        if (count _respawnArray > 0) then {
            ["Vehicle respawn time:", _respawnArray] remoteExecCall ["hintC", remoteExecutedOwner];
        } else {
            ["Currently there are no vehicles respawning"] remoteExecCall ["hintC", remoteExecutedOwner];
        };
    };

    case "RAW": {
        private _respawnArray = [];

        {
            _x params ["_veh", "_vehType", "_spawnPos", "_spawnDir", "_spawnDelay", "_timeDestroyed", "_base", "_uid"];

            if (!isNil "_timeDestroyed") then {
                private _timeLeft = (round ((_spawnDelay - (serverTime - _timeDestroyed)) / 60));

                if (_timeLeft < 1) then {_timeLeft = "<1"};

                _respawnArray pushBack [([_vehType] call AW_fnc_getRespawnVehicleDisplayName), ([_base] call AW_fnc_getFOBDisplayName), _timeLeft, _uid];
            };
        } forEach InA_Server_RespawnVehiclesArray;

        InA_Client_RespawningVehicles_List = _respawnArray;
        remoteExecutedOwner publicVariableClient "InA_Client_RespawningVehicles_List";
        InA_Client_RespawningVehicles_List = nil;
    };
};
