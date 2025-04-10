/*
    Author: BACONMOP
    Description: Creates and handles Sub Objectives
*/

params [["_factionHash", InA_EnemyFactionHash]];

if (isNil "InA_MainAOSubObjs") then {
    InA_MainAOSubObjs = [];

    {
        InA_MainAOSubObjs pushBack _x;
    } forEach (getArray (missionConfigFile >> worldName >> "Missions" >> "SubObjs"));
};

if (isNil "InA_MainAOPrevSubObj") then {
    InA_MainAOPrevSubObj = [];

    private _prevCount = (ceil ((count InA_MainAOSubObjs) / 2));

    for [{_i = 0}, {_i < _prevCount}, {_i = (_i + 1)}] do {
        InA_MainAOPrevSubObj set [_i, "#dummy#"];
    };
};

InA_Server_MainAOControl_EndSubObj = false;

private _viableOptions = (InA_MainAOSubObjs - InA_MainAOPrevSubObj);

private _subObj = "";

if (count _viableOptions < 1) then {
    _subObj = (selectRandom InA_MainAOSubObjs);
} else {
    _subObj = (selectRandom _viableOptions);
};

if (_subObj == "") exitWith {
    InA_Server_MainAoSubObjComplete = true;
    [format ["Could not select a sub objective to spawn"], "Subobj", true] spawn AW_fnc_log;
};

InA_MainAOPrevSubObj deleteAt 0;
InA_MainAOPrevSubObj pushBack _subObj;

[format ["Spawning SubObj %1", _subObj], "SubObj", false] call AW_fnc_log;

private _uri = "Missions\Main\SubObj\sub_%1.sqf";


InA_Server_MainAoSubObjSpawn_Complete = false;

private _currentMission = [_factionHash] execVM format [_uri, _subObj];

private _timeOut = (serverTime + 30);

waituntil {
    sleep 1;
    (InA_Server_MainAoSubObjSpawn_Complete || (serverTime > _timeOut) || (isNull _currentMission))
};

if (!InA_Server_MainAoSubObjSpawn_Complete) exitWith {
    if (serverTime > _timeOut) then {
        [format ["SubObj '%1' spawning timed out !", _subObj], "SubObj", true] call AW_fnc_log;
    };

    if (isNull _currentMission) then {
        [format ["SubObj '%1' failed to spawn !", _subObj], "SubObj", true] call AW_fnc_log;
    };
};

[format ["SubObj '%1' successfully spawned", _subObj], "SubObj", false] call AW_fnc_log;

waitUntil {
    sleep 1;
    (scriptDone _currentMission)
};

InA_Server_MainAoSubObjComplete = true;
