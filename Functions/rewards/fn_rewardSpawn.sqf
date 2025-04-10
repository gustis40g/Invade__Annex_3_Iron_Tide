/*
 * Author: Whigital
 *
 * Main reward spawning function. Takes an Id as input and creates and customizes
 * a vehicle. See AW_fnc_rewardsDef for Id's.
 *
 */

params [
    "_rewardId",
    ["_movePos", nil],
    ["_posOverride", false],
    ["_caller", objNull]
];

if (!isServer) exitWith {};

if (isRemoteExecuted && {(!isNull _caller) && {!([(owner _caller)] call AW_fnc_isZeus)}}) exitWith {
    private _msg = (format ["%1 :: Non Zeus %2 (%3) tried spawn a reward!", _fnc_scriptName, (name _caller), (getPlayerUID _caller)]);
    [_msg, "VIOLATION", true] call AW_fnc_log;
};

private _vehicle = [_rewardId, [0, 0, 500]] call InA_fnc_FactionRewardSpawn;

[_vehicle] call AW_fnc_generalVehicleSettings;


// Persistence
_vehicle setVariable ["InA_RewardId", _rewardId];
InA_Server_RewardVehicles pushBack _vehicle;

private _msg = "at closest reward area";

private _signalSpawn = {
    params [
        "_id",
        "_where",
        "_caller"
    ];

    if (isNull _caller) exitWith {};

    private _rewardData = ["GETITEM", _id] call AW_fnc_rewardsDef;

    private _msg = format ["%1 spawned %2 ....", (_rewardData # 2), _where];

    if (hasInterface) then {
        systemChat _msg;
    } else {
        [_msg] remoteExecCall ["systemChat", _caller];
    };
};

private _resetVehicleState = {
    params ["_vehicle"];

    sleep 2;

    if ((damage _vehicle) > 0) then {
        _vehicle setDamage 0;
    };

    if ((fuel _vehicle) < 1) then {
        _vehicle setFuel 1;
    };

    
    if ((locked _vehicle) != 0) then {
        _vehicle lock false;
    };
};

private _moveToJetSpawn = {
    params ["_aircraft"];

    private _posData = call AW_fnc_getRewardJetPosition;
    _posData params ["_pos", "_dir"];

    //VTOL is big, move it up some more
    if (_aircraft isKindOf "B_T_VTOL_01_armed_F") then {
        _pos = (_pos vectorAdd [0, 0, 2]);
    } else {
        _pos = (_pos vectorAdd [0, 0, 0.5]);
    };

    _aircraft setDir _dir;

    if (surfaceIsWater _pos) then {
        _aircraft setPosASL (AGLToASL _pos);
    } else {
        _aircraft setPosATL _pos;
    };
};

if (_vehicle isKindOf "Plane") exitWith {
    if ((!isNil "_movePos") && {_posOverride}) then {
        _vehicle setPos _movePos;
        _msg = "on cursor";
    } else {
        //[_vehicle] spawn _moveToCarrier;
        [_vehicle] spawn _moveToJetSpawn;
        _msg = "at an plane spawn area";
    };

    [_rewardId, _msg, _caller] call _signalSpawn;

    [_vehicle] spawn _resetVehicleState;

    _vehicle
};

[_vehicle] spawn AW_fnc_rewardVehicleHandler;

if (_vehicle isKindOf "Helicopter") exitWith {
    if ((!isNil "_movePos") && {_posOverride}) then {
        _vehicle setPos _movePos;
        _msg = "on cursor";
    } else {
        private _posData = [] call AW_fnc_getRewardAreaPosition;
        _vehicle setDir (_posData # 1);
        _vehicle setPos (_posData # 0);
    };

    [_rewardId, _msg, _caller] call _signalSpawn;

    [_vehicle] spawn _resetVehicleState;

    _vehicle
};

if (isNil "_movePos") exitWith {
    private _pos = (getMarkerPos "BASE");

    if (!isNull _caller) then {
        _pos = (getPos _caller);
    };

    private _posData = [_pos] call AW_fnc_getRewardAreaPosition;
    _vehicle setDir (_posData # 1);
    _vehicle setPos (_posData # 0);

    [_rewardId, _msg, _caller] call _signalSpawn;

    [_vehicle] spawn _resetVehicleState;

    _vehicle
};

if (_posOverride) then {
    _vehicle setPos _movePos;
    _msg = "on cursor";
} else {
    private _pos = [_movePos, 15, 65, 8, 0, 0.5, 0, [], _movePos] call BIS_fnc_findSafePos;
    _vehicle setPos _pos;
    _msg = "near";
};

[_rewardId, _msg, _caller] call _signalSpawn;

[_vehicle] spawn _resetVehicleState;

_vehicle
