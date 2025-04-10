/*
Author: Quiksilver
Description: Priority Mission control
*/

if (!isServer) exitWith {};

if (isNil "InA_prioMissionList") then {
    InA_prioMissionList = [];

    {
        InA_prioMissionList pushBack _x;
    } forEach (getArray (missionConfigFile >> worldName >> "Missions" >> "Prios"));
};

waitUntil {
    sleep 10;
    !isNil "InA_Server_currentAO" && {!(InA_Server_currentAO in InA_Server_controlledZones)}
};

if (isNil "InA_PrevPrioObj") then {
    InA_PrevPrioObj = [];

    private _prevCount = (ceil ((count InA_prioMissionList) / 2));

    for [{_i = 0}, {_i < _prevCount}, {_i = (_i + 1)}] do {
        InA_PrevPrioObj set [_i, "#dummy#"];
    };
};

while {InA_Server_missionActive} do {
    private _minPlayerCount = 15 + (round (random 5));

    if (InA_Server_PlayerCount >= _minPlayerCount) then {

        private _viableOptions = (InA_prioMissionList - InA_PrevPrioObj);

        private _mission = (selectRandom _viableOptions);

        InA_PrevPrioObj deleteAt 0;
        InA_PrevPrioObj pushBack _mission;

        private _uri = "missions\Priority\prio_%1.sqf";

        [format ["Spawning Priomission '%1'", _mission], "PRIO"] call AW_fnc_log;

        private _currentMission = execVM format [_uri, _mission];
        InA_Server_PrioMissionSpawned = false;
        private _shouldterminate = true;

        // Loop for checking mission spawning
        for "_i" from 1 to 120 do {
            sleep 1;

            // Mission spawned, all good ....
            if (InA_Server_PrioMissionSpawned) then {
                _shouldterminate = false;
                break;
            };

            // Mission script execution failed !
            if (isNull _currentMission) then {
                break;
            };
        };

        if (_shouldterminate) then {
            if (isNull _currentMission) then {
                [format ["ERROR: Priomission '%1' script exited prematurely !", _mission], "SIDE", true] call AW_fnc_log;
            } else {
                [format ["WARNING: Priomission '%1' spawning timed out and will be terminated !", _mission], "PRIO", true] call AW_fnc_log;
                terminate _currentMission;
            };
        } else {
            [format ["Priomission '%1' spawned", _mission], "PRIO"] call AW_fnc_log;

            waitUntil {
                sleep 5;
                scriptDone _currentMission
            };

            [format ["Priomission '%1' completed", _mission], "PRIO"] call AW_fnc_log;
            sleep (1500 + (random 600));
        };
    };

    sleep 10;
};
