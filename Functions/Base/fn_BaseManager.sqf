/*
Author:  BACONMOP
Description: For new Spawned bases

Last edited: 20/10/2017 by stanhope
Edited: Names of respawn markers + teleporter
*/
params [
    "_base",
    ["_unhide", true],
    ["_hint", true]
];

if (!isServer) exitWith {};

if (isRemoteExecuted && {!([remoteExecutedOwner] call AW_fnc_isStaff)}) exitWith {
    private _caller = objNull;
    private _players = allPlayers;

    private _playerIdx = (_players findIf {(owner _x) == remoteExecutedOwner});

    if (_playerIdx != -1) then {
        _caller = (_players # _playerIdx);
    };

    private _msg = (format ["%1 :: Non Staff player %1 (%2) tried to spawn a FOB (%3)!", _fnc_scriptName, (name _caller), (getPlayerUID _caller), _base]);
    [_msg, "VIOLATION", true] call AW_fnc_log;
};

InA_Server_capturedFOBs pushBackUnique _base;

if !(_base in InA_Server_controlledZones) then {
    InA_Server_controlledZones pushBackUnique _base;
    ["InA_Event_UpdateControlledZones", _base] remoteExec ["AW_fnc_eventTrigger", 0, true];
};

private _aoConfigPath = (missionConfigFile >> worldName >> "AOs" >> _base);
private _baseType = (getText (_aoConfigPath >> "Base" >> "baseType"));

// Respawn Position & markers -------------------------------
private _baseRespawnMarker = (getText (_aoConfigPath >> "Base" >> "spawn"));
private _respawnMarkerPos = (getMarkerPos _baseRespawnMarker);
private _baseMarkerName = (getText (_aoConfigPath >> "Base" >> "marker"));
private _baseArsenal = (getText (_aoConfigPath >> "Base" >> "arsenal"));
private _baseName = (getText (_aoConfigPath >> "nameAlt"));

if (_baseMarkerName in InA_Server_BaseArray) exitWith {[format ["FOB %1 creation was requested but it has already been created", _base], "ERROR"] call AW_fnc_log;};

private _baseMarker = createMarkerLocal [_baseMarkerName, _respawnMarkerPos];
_baseMarker setMarkerShapeLocal "ICON";
_baseMarker setMarkerTypeLocal "b_hq";
_baseMarker setMarkerText _baseName;

InA_Server_BaseArray pushBackUnique _baseMarker;
["InA_Event_UpdateBaseArray", _baseMarker] remoteExec ["AW_fnc_eventTrigger", 0, true];

// Reward markers
private _baseCfgRewardMarkers = (getArray (_aoConfigPath >> "Base" >> "reward_markers"));

if (_baseCfgRewardMarkers isNotEqualTo []) then {
    private _baseRewardMarkers = [];

    {
        if ((markerType _x) != "") then {
            _baseRewardMarkers pushBack _x;
        };
    } forEach _baseCfgRewardMarkers;

    if (_baseRewardMarkers isNotEqualTo []) then {
        InA_Server_RewardMarkerHash insert [[_baseMarker, _baseRewardMarkers]];
    };
};


// Create the crate -----------------------
private _arsenalPos = (getMarkerPos [_baseArsenal, true]);
private _arsenal = [_arsenalPos, nil, nil, true, _base] call AW_fnc_arsenalCreate;

if ((_baseType == "FOB") && {_baseRespawnMarker != ""}) then {
    private _respawnMarker = [west, _respawnMarkerPos, _baseName] call BIS_fnc_addRespawnPosition;

    // Vehicles ---------------------------------------
    private _baseVehicles = (getArray (_aoConfigPath >> "Base" >> "vehicles"));

    {
        _x params ["_veh", "_mkr", "_timer"];

        private _vehType = nil;

        if (!(isClass (configFile >> "CfgVehicles" >> _veh))) then {
            private _vehArray = [_veh] call AW_fnc_vehicleLookup;
            _vehType = (_vehArray # 0);
        } else {
            _vehType = _veh;
        };

        private _spawnPos = (getMarkerPos _mkr);
        private _vehicle = createVehicle [_vehType, [0,0,0] getPos [random 50, random 360], [], 50, "NONE"];
        _vehicle setDir (markerDir _mkr);
        if (_vehicle isKindOf "Ship") then {
            _vehicle setPosASL [(_spawnPos # 0), (_spawnPos # 1), 1];
        } else {
            _vehicle setPosATL [(_spawnPos # 0), (_spawnPos # 1), 0.3];
        };

        [[_vehicle]] call AW_fnc_addToAllCurators;
        [_vehicle, _timer, _base, _veh, (getPosWorld _vehicle)] spawn AW_fnc_vBaseMonitor;
    } forEach _baseVehicles;
};

if (_unhide) then {
    private _fobStuff = (((allMissionObjects "all") + (allSimpleObjects [])) select {(_x distance2D _respawnMarkerPos) < 250});

    // Unhide
    {
        if (isObjectHidden _x) then {
            _x hideObjectGlobal false;
        };
    } forEach _fobStuff;
};

private _createGroundServiceMarker = {
    params ["_name", "_pos"];
    private _mrk = createMarker [_name,_pos];
    _mrk setMarkerShape "ICON";
    _mrk setMarkerType "b_maint";
    _mrk setMarkerText "Ground service";
    _mrk setMarkerSize [0.5, 0.5];
};

private _createAirServiceMarker = {
    params ["_name", "_pos"];
    private _mrk = createMarker [_name,_pos];
    _mrk setMarkerShape "ICON";
    _mrk setMarkerType "o_maint";
    _mrk setMarkerColor "colorBLUFOR";
    _mrk setMarkerText "Air service";
    _mrk setMarkerSize [0.5, 0.5];
};

// Service pads
if (isClass (_aoConfigPath >> "ServicePads")) then {
    private _airRepairMarkers = (getArray (_aoConfigPath >> "ServicePads" >> "Air"));
    private _groundRepairMarkers = (getArray (_aoConfigPath >> "ServicePads" >> "Ground"));

    {
        _x call AW_fnc_repairInitAirServicePoint;
    } forEach _airRepairMarkers;

    {
        _x call AW_fnc_repairInitGroundServicePoint;
    } forEach _groundRepairMarkers;
};

//FOB specific stuff
switch (_base) do {
    // Altis FOBs
    case "Terminal": {
        private _docksScript = [_arsenal] spawn {
            params ["_arsenal"];

            private _pole = createVehicle ["Flag_NATO_F", [0, 0, 0], [], 50, "NONE"];
            _pole allowDamage false;
            _pole setDir 166;
            _pole setPosATL [15341.8, 15797.3, 10.5938];

            private _docksMarker = createMarkerLocal ["term_docks_marker", [15338.5, 15797.1]];
            _docksMarker setMarkerShapeLocal "ICON";
            _docksMarker setMarkerTypeLocal "b_naval";
            _docksMarker setMarkerSizeLocal [0.5, 0.5];
            _docksMarker setMarkerText "Boats";

            private _rewardMarker = createMarkerLocal ["term_rewards_marker", [15314.1,17336.2]];
            _rewardMarker setMarkerShapeLocal "ICON";
            _rewardMarker setMarkerTypeLocal "b_unknown";
            _rewardMarker setMarkerSizeLocal [0.5, 0.5];
            _rewardMarker setMarkerText "Rewards";

            // Teleport to Guardian docks
            [_arsenal, {
                params ["_arsenal"];

                if (!hasInterface) exitWith {};

                private _act = _arsenal addAction [
                    "<t color='#009ACD'>Teleport to Docks</t>",
                    {
                        params ["_target", "_caller", "_actionId", "_arguments"];

                        cutText ["","BLACK OUT"];
                        sleep 1;
                        [_caller, "Terminal_Docks"] remoteExec ["AW_fnc_baseTeleport", 2];
                        sleep 1;
                        cutText ["","BLACK IN"];
                    },
                    nil,
                    -100,
                    false,
                    true,
                    "",
                    "true",
                    10
                ];
            }] remoteExec ["call", 0, true];

            // Teleport to Guardian from docks
            [_pole, {
                params ["_pole"];

                if (!hasInterface) exitWith {};

                private _act = _pole addAction [
                    "<t color='#009ACD'>Teleport to FOB Guardian</t>",
                    {
                        params ["_target", "_caller", "_actionId", "_arguments"];

                        cutText ["","BLACK OUT"];
                        sleep 1;
                        [_caller, "Terminal"] remoteExec ["AW_fnc_baseTeleport", 2];
                        sleep 1;
                        cutText ["","BLACK IN"];
                    },
                    nil,
                    -100,
                    false,
                    true,
                    "",
                    "true",
                    10
                ];
            }] remoteExec ["call", 0, true];
        };
    };

    case "AAC_Airfield": {};
    case "Stadium": {};
    case "Molos_Airfield": {};
    case "AO_Abdera": {};


    // Cam Lao Nam FOBs
    case "AO_SanBayBan": {};
    case "AO_MaiLoc": {};
    case "AO_PemPatBase": {};
    case "AO_DaoTrai": {};
    case "AO_PleikuBoatBase": {};


    // Sefrou Ramal FOBs
    case "Ramal_Airbase": {};

    // Tanoa FOBs
    case "AO_Lifou": {};
    case "AO_Aerodrome": {};


    // Malden FOB
    case "AO_Airport": {};

    default {
        private _text = format ["ERROR: AW_fnc_BaseManager did not recognize '%1' as an FOB", _base];
        [_text, "BASE", true] call AW_fnc_log;
    };
};

// Notification ----------------------------------------
if (_hint) then {
    private _txt = format["<t align='center' size='2.2'>Base Taken</t><br/><t size='1.5' align='center' color='#FFCF11'>%1</t><br/>____________________<br/>Good Job. We have now setup a base at that location.<br/><br/>We have provided you with some vehicles at that the new FOB.", _baseName];
    [_txt] remoteExec ["AW_fnc_globalHint", 0];
};
