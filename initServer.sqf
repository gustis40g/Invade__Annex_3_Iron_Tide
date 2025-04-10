/*
Author:	BACONMOP
Edited by:
    S0zi0p4th
    Ryko
    Stanhope
    LostBullet
    McKillen

Description:	Things that may run on the server.
*/

if (!hasInterface) then {
    enableEnvironment false;
};

// Ares / Achilles / ZEN
missionNamespace setVariable ["Ares_Allow_Zeus_To_Execute_Code", false, true];
missionNamespace setVariable ["ZEN_disableCodeExecution", true, true];


//BIS Dynamic Groups:
["Initialize"] call BIS_fnc_dynamicGroups;


//======================Zeus Modules
InA_Server_coreStaffUIDs = [];
InA_Server_staffUIDs = [];
InA_Server_spartanUIDs = [];

InA_Server_fnc_getServerCmdPwd = {""};

/*
    Pilot airframe limiter
    See fn_pilotAirframeCounter and fn_pilotGroundedCheck for details
*/

// Airframe limit over InA_Server_PilotAirframeLimitPeriod
InA_Server_PilotAirframeLimit = 4;
// Period over which InA_Server_PilotAirframeLimit will be counted
InA_Server_PilotAirframeLimitPeriod = ((InA_Server_PilotAirframeLimit * 15) * 60);

// Airframe limit over InA_Server_PilotAirframeLimitPeriodShort
InA_Server_PilotAirframeLimitLow  = 3;
// Period over which InA_Server_PilotAirframeLimitLow will be counted
InA_Server_PilotAirframeLimitPeriodShort = ((InA_Server_PilotAirframeLimitLow * 10) * 60);

// Period to ground a pilot
InA_Server_PilotAirframeTimeout = (60 * 60);

InA_Server_PilotAirframeTimers = createHashMap;
InA_Server_PilotAirframeCounters = createHashMap;
InA_Server_PilotAirframeMapper = createHashMap;


InA_Server_HeadlessClients = [];
InA_Server_PlayerCount = 0;


// Admin channel
InA_Server_adminChannelID = radioChannelCreate [[0.8, 0, 0, 1], "Admin Channel", "%UNIT_NAME", [Quartermaster], true];
[Quartermaster, "Steve"] remoteExec ["setName", 0, true];

adminLogged setVariable ["showNotification", false, true];

// Mission eventhandlers
addMissionEventHandler ["PlayerConnected", {
    params ["_id", "_uid", "_name", "_jip", "_owner", "_idstr"];

    if (((toLower _name) find "headlessclient") == -1) then {
        InA_Server_PlayerCount = (InA_Server_PlayerCount + 1);
        call AW_fnc_updateVehicleThresholds;
    };
}];

// Headless Client
addMissionEventHandler ["HandleDisconnect", {
    params ["_unit", "_id", "_uid", "_name"];

    if ((typeOf _unit) != "HeadlessClient_F") then {
        InA_Server_PlayerCount = (InA_Server_PlayerCount - 1);
        call AW_fnc_updateVehicleThresholds;
    } else {
        InA_Server_HeadlessClients deleteAt (InA_Server_HeadlessClients find _unit);
    };

    false
}];

// General handler
addMissionEventHandler ["HandleDisconnect", {
    params ["_unit", "_id", "_uid", "_name"];

    // Reset derp revive state
    if ("derp_revive" in (getMissionConfigValue "respawnTemplates")) then {
        _unit setVariable ["derp_revive_downed", false, true];
    };

    if (!isNull (objectParent _unit)) then {
        private _vehicle = (vehicle _unit);

        [_unit, _vehicle] spawn {
            params ["_unit", "_vehicle"];

            [_vehicle, _unit] remoteExecCall ["deleteVehicleCrew", _vehicle];

            waitUntil {sleep 0.01; !(_unit in (crew _vehicle))};

            if (((crew _vehicle) isEqualTo []) && {(alive _vehicle) && {isEngineOn _vehicle}}) then {
                [_vehicle, false] remoteExec ["engineOn", _vehicle];
            };
        };
    };

    // Cleanup spawned drones
    if (_unit getUnitTrait "UAVHacker") then {
        call AW_fnc_uavCleanup;
    };

    // Cleanup chemligths
    [_unit] call AW_fnc_chemlightActionsCleanup;

    // Handle Zeus stuff
    private _zeusVarName = (format ["InA_DynCurator_%1", _uid]);
    private _zeus = missionNamespace getVariable [_zeusVarName, nil];

    if (!isNil "_zeus") then {
        if (!isNull _zeus) then {
            private _markers = _zeus getVariable ["PlacedCuratorMarkers", []];

            {
                deleteMarker _x;
            } forEach _markers;

            private _group = (group _zeus);
            deleteVehicle _zeus;
            deleteGroup _group;
        };

        missionNamespace setVariable [_zeusVarName, nil];
    };

    // Handle UAV stuff
    if (_unit getUnitTrait "UAVHacker") then {
        _unit connectTerminalToUAV objNull;
    };

    false
}];


// Let's get started ....
execVM "Defines\factionDefines.sqf";
execVM "Scripts\init\missionInit.sqf";
execVM "scripts\zeus\curatorPinged.sqf";

// Get local Zeus info
#include "\arma3_readme.txt";