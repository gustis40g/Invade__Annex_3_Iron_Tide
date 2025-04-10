/*
author: ?
Description: scripts that cleans up things every 360 seconds
*/

if (!isServer) exitWith {};

["Cleanup thread starting up ....", "CLEANUP", true] call AW_fnc_log;

InA_Server_cleanupScriptEnable = true;

private _getAllThingsToDelete = {
    private _ejectionItems = [
        "B_Ejection_Seat_Plane_Fighter_01_F",
        "B_Ejection_Seat_Plane_CAS_01_F",
        "O_Ejection_Seat_Plane_CAS_02_F",
        "O_Ejection_Seat_Plane_Fighter_02_F",
        "I_Ejection_Seat_Plane_Fighter_04_F",
        "I_Ejection_Seat_Plane_Fighter_03_F",
        "plane_fighter_01_canopy_f",
        "plane_fighter_02_canopy_f",
        "plane_fighter_03_canopy_f",
        "plane_fighter_04_canopy_f",
        "Plane_CAS_01_Canopy_f",
        "Plane_CAS_02_Canopy_f",
        "vn_b_air_f4b_ejection_seat_01"
    ];

    private _toDelete = [];

    _toDelete append allDead;
    _toDelete append (allMissionObjects "CraterLong");
    _toDelete append (allMissionObjects "WeaponHolderSimulated");

    {
        sleep 0.1;

        private _holder = _x;

        if ([_holder] call AW_fnc_isNearBase) then {
            _toDelete pushBack _holder;
            continue;
        };

        if (!([_holder, 50] call AW_fnc_playersNear)) then {
            _toDelete pushBack _holder;
        };
    } forEach (allMissionObjects "WeaponHolder");

    // Delete abandoned player placed/assembled static weapons
    {
        sleep 0.1;

        private _static = _x;

         // Only interested in player assembled statics
        if (!(_static getVariable ["InA_isStaticWeaponPlayerAssembled", false])) then {
            continue;
        };

        // Check if players close
        if ([_static, 500] call AW_fnc_playersNear) then {
           continue;
        };

        _toDelete pushBack _static;
    } forEach (allMissionObjects "StaticWeapon");

    // Only stuff that isn't moving
    {
        sleep 0.1;

        if ( speed _x != 0 ) then{
            continue;
        };

        _toDelete pushBack _x;
    } forEach (entities [_ejectionItems, []]);

    {
        _x params ["_time", "_objs"];

        if (_time < serverTime) then {
            _toDelete append _objs;

            InA_ImpactCraterObjects deleteAt _forEachIndex;
        };
    } forEach InA_ImpactCraterObjects;

    _toDelete
};

private _changeWeather = {
    fogParams params ["_fogValue", "_fogDecay", "_fogBase"];

    private _fogLimitPct = 8;

    if (_fogdecay != 0) then {_fogdecay = 0;};
    if (_fogBase != 0) then {_fogBase = 0;};

    60 setFog [_fogValue, _fogDecay, _fogBase];

    if (_fogValue > (_fogLimitPct / 100)) then {
        0 = [_fogValue, _fogDecay, _fogBase] spawn {
            params ["_fogValue", "_fogDecay", "_fogBase"];

            private _delay = 30;
            private _iter = 10;
            private _fogStep = (_fogValue / _iter);

            for "_i" from 1 to _iter do {
                _fogValue = (_fogValue - _fogStep);
                30 setFog [_fogValue, _fogDecay, _fogBase];
                sleep _delay;
            };
        };
    };

    private _windArray = wind;
    {
        if (_x > 8) then {
            _windArray set [_forEachIndex, 2];
        };
    } forEach _windArray;

    _windArray pushBack false;
    setWind _windArray;
};

private _changeTimeMultiplier = {
    if (sunOrMoon != 1) then {
        if (("NoNightTimeOverCast" call BIS_fnc_getParamValue) == 1) then {
            30 setOvercast 0;
        };

        private _multiplier = ("NightTimeMultiplier" call BIS_fnc_getParamValue);

        if (timeMultiplier != _multiplier) then {
            setTimeMultiplier _multiplier;
        };
    } else {
        if (timeMultiplier != 1) then {
            setTimeMultiplier 1;
        };
    };
};

private _clearBlacklist = {
    {
        if (_y < serverTime) then {
            InA_Server_blacklistPositions deleteAt (InA_Server_blacklistPositions find _x);
            InA_Server_blacklistPositionTimers deleteAt _x;
        };
    } forEach InA_Server_blacklistPositionTimers;
};

private _getStats = {
    params ["_prefix"];

    diag_activeScripts params ["_spawns", "_execVMs", "_execs", "_execFSMs"];

    private _msg = format [
        "[Scripts: (spawn: %1 / execVM: %2 / execFSM: %3) / HCs: %4 / Players: %5]",
        _spawns,
        _execVMs,
        _execFSMs,
        (count InA_Server_HeadlessClients),
        (count (allPlayers - (entities "HeadlessClient_F")))
    ];

    private _allUnits = (allUnits - allPlayers);
    private _allGroups = allGroups;

    private _serverStats = format [
        "Server: [FPS: %1 / Groups: %2 (%3) / Units: %4 (%5)]",
        ((round (diag_fps * 100.0)) / 100.0),
        ({local _x} count allGroups),
        (count allGroups),
        ({local _x} count _allUnits),
        (count _allUnits)
    ];

    private _finalMessage = format ["%1 | %2", _msg, _serverStats];

    if (InA_Server_HeadlessClients isNotEqualTo []) then {
        {
            if (!isNil "InA_Server_Stats_HCResponse") then {
                InA_Server_Stats_HCResponse = nil;
            };

            remoteExecCall ["AW_fnc_getStatsMsg", _x];

            waitUntil {
                sleep 0.1;
                (!isNil "InA_Server_Stats_HCResponse")
            };

            _finalMessage = format ["%1 | %2: [%3]", _finalMessage, (vehicleVarName _x), InA_Server_Stats_HCResponse];
        } forEach InA_Server_HeadlessClients;
    };

    _finalMessage = format ["Cleanup %1 - %2", _prefix, _finalMessage];

    [_finalMessage, "STATS", false] call AW_fnc_log;
};

["InA_Event_StatsCallback", {
    params ["_event", "_args"];

    InA_Server_Stats_HCResponse = _args;
}] call AW_fnc_eventRegister;

private _lastRun = serverTime;
private _interval = 300;

while {InA_Server_cleanupScriptEnable} do {
    if ((_lastRun + _interval) > serverTime) then {
        sleep 5;
        continue;
    };

    _lastRun = serverTime;

    ["start"] call _getStats;

    // Environmental stuff
    call _changeWeather;
    call _changeTimeMultiplier;

    // Clean up things and stuff
    {
        _x call AW_fnc_delete;
        sleep 0.1;
    } forEach (call _getAllThingsToDelete);

    // Purge groups
    [[], {
        {
            if ((local _x) && {(count units _x) == 0}) then {
                deleteGroup _x;
            };

            sleep 0.1;
        } forEach allGroups;
    }] remoteExec ["spawn", (InA_Server_HeadlessClients + [2])];

    // Remove blacklisted pos from InA_Server_blacklistPositions after timeout
    call _clearBlacklist;

    ["end  "] call _getStats;
};

["InA_Event_StatsCallback"] call AW_fnc_eventUnregister;

["Cleanup thread stopped", "CLEANUP", true] call AW_fnc_log;
