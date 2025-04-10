/*
Author:	Quiksilver
Description: Mission control for side missions
*/

if (!isServer) exitWith {};

if (isNil "InA_sideMissionList") then {
    InA_sideMissionList = [];
    {
        InA_sideMissionList pushBack _x;
    } forEach (getArray (missionConfigFile >> worldName >> "Missions" >> "Sides"));
};

if (isNil "InA_SidePrevMissions") then {
    InA_SidePrevMissions = ["PoliceProtection", "PilotRescue"];
};

// How many side missions we want to keep track of for having recently played them.
private _InA_SidePrevMissions_MaxCount = 5;

while {InA_Server_missionActive} do {
    private _mission = selectRandom (InA_sideMissionList - InA_SidePrevMissions);

    InA_SidePrevMissions pushBack _mission;
    if (count InA_SidePrevMissions >= _InA_SidePrevMissions_MaxCount || count InA_SidePrevMissions == count InA_sideMissionList) then {
        InA_SidePrevMissions deleteAt 0;
    };

    //start the mission
    private _uri = "Missions\Side\side_%1.sqf";

    [format ["Spawning Sidemission '%1'", _mission], "SIDE"] call AW_fnc_log;

    private _currentMission = execVM format [_uri, _mission];
    InA_Server_SideMissionSpawned = false;
    private _shouldTerminate = true;

    // Loop for checking mission spawning
    for "_i" from 1 to 120 do {
        sleep 1;

        // Mission spawned, all good ....
        if (InA_Server_SideMissionSpawned) then {
            _shouldTerminate = false;
            break;
        };

        // Mission script execution failed !
        if (isNull _currentMission) then {
            break;
        };
    };

    if (_shouldTerminate) then {
        if (isNull _currentMission) then {
            [format ["ERROR: Sidemission '%1' script exited prematurely !", _mission], "SIDE", true] call AW_fnc_log;
        } else {
            [format ["WARNING: Sidemission '%1' spawning timed out and will be terminated !", _mission], "SIDE", true] call AW_fnc_log;
            terminate _currentMission;
        };
    } else {
        [format ["Sidemission '%1' spawned", _mission], "SIDE"] call AW_fnc_log;

        waitUntil {
            sleep 5;
            scriptDone _currentMission
        };

        [format ["Sidemission '%1' finished", _mission], "SIDE"] call AW_fnc_log;
        sleep (600 + (random 300));
    };

    sleep 10;
};
