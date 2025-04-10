/*
 * Author: Whigital
 * Description:
 * InA mission variable initialzation
 *
 *
 */

if (!isServer) exitWith {};

InA_Server_missionActive = true;

InA_Server_RespawnVehiclesArray = [];
InA_Server_blacklistPositions = [];
InA_Server_blacklistPositionTimers = createHashMap;
InA_Server_MapSpecificBlacklistPositions = [];
InA_Server_RewardMarkerHash = createHashMap;
InA_Server_prioUnits = [];
InA_Server_sideUnits = [];
InA_Server_controlledZones = [];
InA_Server_capturedFOBs = [];
InA_Server_StaticBases = [];
InA_Server_BaseArray = [];
InA_Server_currentAO = nil;
InA_Server_mainAOUnits = [];
InA_Server_subObjUnits = [];
InA_Server_manualAO = nil;
InA_Server_MainAOShutdown = false;
InA_Server_RewardVehicles = [];


// BaseArray setup
{
    InA_Server_StaticBases pushBack _x;
} forEach (getArray (missionConfigFile >> worldName >> "Bases" >> "staticBases"));

{
    InA_Server_BaseArray pushBack _x;
    ["InA_Event_UpdateBaseArray", _x] remoteExec ["AW_fnc_eventTrigger", 0, true];
} forEach InA_Server_StaticBases;

private _fullArsenal = ((["GearRestriction", 1] call BIS_fnc_getParamValue) < 1);


// Load persistent data
private _wipePersistentData = (["AOPersistenceWipe", 0] call BIS_fnc_getParamValue) == 1;
InA_Server_PersistenceEnabled = (["AOPersistence", 0] call BIS_fnc_getParamValue) == 1;

if (_wipePersistentData) then {
    [true] call AW_fnc_missionPersistenceSave;
};

if (InA_Server_PersistenceEnabled && !_wipePersistentData) then {
    call AW_fnc_missionPersistenceLoad;
};


// AO completion counters
private _aoCompletionCount = (["AOCompletionCount", -1] call BIS_fnc_getParamValue);
private _aoCount = ((count ("true" configClasses (missionConfigFile >> worldName >> "AOs"))) - (count InA_Server_BaseArray));

if ((_aoCompletionCount == -1) || {_aoCompletionCount >= _aoCount}) then {
    InA_Server_MainAOsToComplete = _aoCount;
} else {
    InA_Server_MainAOsToComplete = _aoCompletionCount;
};

if ((count InA_Server_controlledZones) >= InA_Server_MainAOsToComplete) then {
    [true] call AW_fnc_missionPersistenceSave;
    InA_Server_controlledZones = [];
    InA_Server_capturedFOBs = [];
};

if ((count InA_Server_controlledZones) < count InA_Server_StaticBases) then {
    InA_Server_controlledZones append InA_Server_StaticBases;
};

if (InA_Server_controlledZones isNotEqualTo []) then {
    {
        ["InA_Event_UpdateControlledZones", _x] remoteExec ["AW_fnc_eventTrigger", 0, true];
    } forEach InA_Server_controlledZones;
};


// Select the last AO played so the next AO can be chosen based upon this AO
private _currentAOIndex = nil;

if (InA_Server_controlledZones isEqualTo InA_Server_StaticBases) then {
    _currentAOIndex = 0;
} else {
    _currentAOIndex = ((count InA_Server_controlledZones) - 1);
};

InA_Server_currentAO = (InA_Server_controlledZones # _currentAOIndex);


// Check for map environment type
if (isNil "InA_Server_MapEnvType") then {
    InA_Server_MapEnvType = (call {
        private _env = ((missionConfigFile >> worldName >> "environment") call BIS_fnc_getCfgData);

        if (!isNil "_env") then {
            _env
        } else {
            "Default"
        }
    });
};


// Collect params
InA_Server_MainAOSize = ["AOSize", 800] call BIS_fnc_getParamValue;
InA_Server_MissionMinDistance = (["MissionSpawnRange", 2500] call BIS_fnc_getParamValue);

InA_Server_MainAODistanceArray = [
    (["AOSearchRadiusMin", 2500] call BIS_fnc_getParamValue),
    (["AOSearchRadiusOuter", 2500] call BIS_fnc_getParamValue)
];

InA_Server_AISkillsFromServer = ([false, true] # (["UseServerSkillSettings", 0] call BIS_fnc_getParamValue));
InA_Server_MainAOEnemiesThreshold = (["AOEnemiesThreshold", 8] call BIS_fnc_getParamValue);
InA_Server_TransferZeusUnitsToHC = ([false, true] select (["TransferZeusUnitsToHC", 1] call BIS_fnc_getParamValue));


// Set reinforcement limits and update playercount
InA_Server_AOReinforceThresholds = createHashMap;

InA_Server_AOReinforceThresholds insert [
    ["Para", []],
    ["Vehicle", [15, 60, 1, 8]],
    ["Heli", [15, 60, 1, 6]],
    ["Jet", [15, 60, 1, 4]]
];

InA_Server_AOReinforceVehicleLimit = 0;
InA_Server_AOReinforceVehicleCount = 0;

InA_Server_AOReinforceHeliLimit = 0;
InA_Server_AOReinforceHeliCount = 0;

InA_Server_AOReinforceJetLimit = 0;
InA_Server_AOReinforceJetCount = 0;


// Revive Stuff
missionNamespace setVariable ["derp_revive_bandage_item", ["FirstAidKit","vn_b_item_firstaidkit","vn_o_item_firstaidkit","vn_b_item_medikit_01","Medikit"], true];
missionNamespace setVariable ["derp_revive_revive_item", ["vn_b_item_medikit_01","Medikit"], true];
missionNamespace setVariable ["derp_revive_bandage_item_remove", true, true];
missionNamespace setVariable ["derp_revive_withstand_amount", 2, true];


// Init Stevies
{
    private _stevie = (missionNamespace getVariable [_x, objNull]);

    if (isNull _stevie) then {continue};

    ["InA_Event_ArsenalAdded", _stevie] remoteExec ["AW_fnc_eventTrigger", 0, _stevie];
} forEach (getArray (missionConfigFile >> worldName >> "arsenalObjects"));


// Mission blacklist positions
{
    InA_Server_MapSpecificBlacklistPositions pushBack _x;
} forEach (getArray (missionConfigFile >> worldName >> "missionBlacklistPositions"));


// Respawn point at Main Base
[west, (getMarkerPos "BASE"), "Main base"] call BIS_fnc_addRespawnPosition;


// Hide FOBs
[] spawn {
    private _aoFobHash = createHashMap;
    private _baseMarkers = (getArray (missionConfigFile >> worldName >> "Bases" >> "baseMarkers"));

    {
        private _resMarker = (getTextRaw (_x >> "Base" >> "spawn"));
        private _ao = (configName _x);
        _aoFobHash insert [[_resMarker, _ao]];
    } forEach ("isClass (_x >> 'Base')" configClasses (missionConfigFile >> worldName >> "AOs"));

    {
        // Don't hide if FOB was loaded from persistence data
        private _aoName = _aoFobHash get _x;

        if (isNil "_aoName") then {
            [format ["Failed to get AO classname for basemarker '%1', skipping", _x], "INIT"] call AW_fnc_log;
            continue
        };

        private _fobName = (getText (missionConfigFile >> worldName >> "AOs" >> _aoName >> "nameAlt"));

        if (_aoName in InA_Server_capturedFOBs) then {
            [format ["FOB '%1' already captured and will not be hidden", _fobName], "INIT"] call AW_fnc_log;
            [_aoName, false, false] call AW_fnc_BaseManager;
            continue
        };

        [format ["FOB '%1' has not been captured and will be hidden", _fobName], "INIT"] call AW_fnc_log;

        private _allStuff = ((getMarkerPos _x) nearObjects 250);
        private _fobStuff = (_allStuff - (nearestTerrainObjects [(getMarkerPos _x), [], 250, false]));

        {
            _x hideObjectGlobal true;
        } forEach _fobStuff;
    } forEach _baseMarkers;
};


// Map bridges
[] spawn {
    if (isClass ((missionConfigFile >> worldName >> "Bridges"))) then {
        private _bridgesConfig = (missionConfigFile >> worldName >> "Bridges");
        private _bridges = ("true" configClasses _bridgesConfig);

        {
            private _name = (configName _x);
            private _startMarker = (getText (_x >> "startMarker"));
            private _bridgeDir = (markerDir _startMarker);
            private _markerArray = (getText (_x >> "bridgeMarker"));
            private _bridgePieces = (getArray (_x >> "bridgePieces"));
            private _bridgePieces = (getArray (_x >> "bridgePieces"));

            private _startPos = (getMarkerPos [_startMarker, true]);
            _startPos = (AGLToASL _startPos);

            private _markerPos = (parseSimpleArray _markerArray);

            diag_log text format ["Building bridge '%1' ....", _name];

            private _handle = [_startPos, _bridgeDir, _bridgePieces] execVM "scripts\misc\buildBridge.sqf";

            waituntil {
                sleep 0.5;
                (scriptDone _handle)
            };

            diag_log text format ["Bridge '%1' built ....", _name];

            private _bridgeMarker = (createMarkerLocal [(format ["InA_Bridge-%1", _name]), _markerPos]);
            _bridgeMarker setMarkerShapeLocal "ICON";
            _bridgeMarker setMarkerTypeLocal "loc_BusStop";
            _bridgeMarker setMarkerText "Bridge";
        } forEach _bridges;
    };
};


// Setup Reward marker hash
private _baseCfgRewardMarkers = (getArray (missionConfigFile >> worldName >> "AOs" >> "BASE" >> "reward_markers"));
private _baseRewardMarkers = [];

{
    if ((markerType _x) != "") then {
        _baseRewardMarkers pushBack _x;
    };
} forEach _baseCfgRewardMarkers;

if (_baseRewardMarkers isNotEqualTo []) then {
    InA_Server_RewardMarkerHash insert [["BASE", _baseRewardMarkers]];
};


// Set capture progress marker
private _progress = (round ((((count InA_Server_controlledZones) - (count InA_Server_StaticBases)) / InA_Server_MainAOsToComplete) * 100));

if (isNil {getMarkerColor "captureProgress"}) then {
    InA_Server_progressMarker = (createMarkerLocal ["captureProgress", [300, (worldSize - 300)]]);
    InA_Server_progressMarker setMarkerShapeLocal "ICON";
    InA_Server_progressMarker setMarkerTypeLocal "mil_dot";
    InA_Server_progressMarker setMarkerColorLocal "ColorBlack";
    InA_Server_progressMarker setMarkerText format ["Capture progress: %1%2", _progress, "%"];
} else {
    InA_Server_progressMarker = "captureProgress";
    InA_Server_progressMarker setMarkerPosLocal [300, (worldSize - 300)];
    InA_Server_progressMarker setMarkerText format ["Capture progress: %1%2", _progress, "%"];
};


// Spawn Base vehicles from config
[] spawn AW_fnc_baseVehicleInit;


// Signal Persistent data loading function that it's safe to spawn persisted rewards
InA_Server_PersistedRewardsSpawningSafe = true;


// Let's start this baby up
[] spawn {
    // Vehicle respawn thread
    execVM "scripts\vehicle\VehicleRespawn.sqf";

    if (isClass (configFile >> "CfgPatches" >> "task_force_radio")) then {
        0 = execVM "scripts\misc\radioChannelChart.sqf";
    };

    waitUntil {
        sleep 1;
        (!isNil "InA_UnitDefines_Loaded" && {InA_UnitDefines_Loaded}) &&
        (!isNil "InA_FactionMappingsDefined" && {InA_FactionMappingsDefined})
    };

    waitUntil {
        sleep 1;
        (serverTime > 60)
    };


    // Main AO thread
    [format ["Starting up Main_Machine, HCs connected: %1", (count InA_Server_HeadlessClients)], "AO", true] call AW_fnc_log;
    InA_Server_mainScriptHandle = execVM "Missions\Main\Main_Machine.sqf";


    // Side mission thread
    if (("sideMissions" call BIS_fnc_getParamValue) == 1) then {
        [] spawn {
            waitUntil {
                sleep (60 + (random 30));
                (!isNil "InA_Server_currentAO")
            };

            [format ["Starting up MissionControl, HCs connected: %1", (count InA_Server_HeadlessClients)], "SIDE", true] call AW_fnc_log;
            InA_Server_sideScriptHandle = execVM "Missions\Side\MissionControl.sqf";
        };
    };


    // Prio mission thread
    if (("prioMissions" call BIS_fnc_getParamValue) == 1) then {
        [] spawn {
            waitUntil {
                sleep (90 + (random 30));
                (!isNil "InA_Server_currentAO")
            };

            [format ["Starting up MissionControl, HCs connected: %1", (count InA_Server_HeadlessClients)], "PRIO", true] call AW_fnc_log;
            InA_Server_prioScriptHandle = execVM "Missions\Priority\MissionControl.sqf";
        };
    };

    sleep 5;

    // Cleanup thread
    InA_Server_cleanupScriptHandle = execVM "scripts\misc\cleanup.sqf";

    // Zeus updater thread
    InA_Server_zeusupdaterScriptHandle = execVM "scripts\zeus\zeusupdater.sqf";
};
