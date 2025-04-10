/*
@file: destroyUrban.sqf
Initial authors: Quiksilver,	Jester [AW], chucky [allFPS], BangaBob [EOS] for EOS
Rewritten for I&A 3.2 by stanhope

Description:
	Objective appears in urban area, with random OPFOR/INDEP enemies and civilians.
	Inf spawn in foot patrols and randomly placed in and around buildings.
*/

//==================== PREPARE MISSION =======================
//----Pick town
private _townTypes = ["NameCity", "NameCityCapital"];

// Special case for Western Sahara CDLC: Sefrou Ramal
if ((toLower worldName) == "sefrouramal") then {
    _townTypes = ["NameVillage"];
};

private _findSmPosResult = ["town", _townTypes] call AW_fnc_findSideMissionPos;
_findSmPosResult params ["_smPosFound", "_smPos"];

if (!_smPosFound) exitWith {
    ["Error finding a location for Sidemission: 'DestroyUrban'!", "SIDE"] call AW_fnc_log;
};

//----Spawn obj
private _cacheBuildingArray = nearestObjects [_smPos, ["house","building"], 300];
_cacheBuildingArray = _cacheBuildingArray select {!(typeOf _x in AW_OPFOR_side_destroyUrban_excludedBuildings)};

private _cacheBuildingArrayAmount = count _cacheBuildingArray;

if (_cacheBuildingArrayAmount == 0) exitWith {
    [(format ["Error finding suitable houses at location '%1' for Sidemission: 'DestroyUrban'!", _smPos]), "SIDE"] call AW_fnc_log;
};

private _cacheBuildingLocationFinal = [0,0,0];

private _i = 0;
private _accepted = false;
while {!_accepted && _i < _cacheBuildingArrayAmount} do {
    private _cacheBuilding = selectRandom _cacheBuildingArray;
    _cacheBuildingLocationFinal = selectRandom (_cacheBuilding buildingPos -1);
    if (isNil "_cacheBuildingLocationFinal") then {continue;};

    if !(_cacheBuildingLocationFinal isEqualTo [0,0,0]) then {
        sideObj = createVehicle [selectRandom AW_OPFOR_side_destroyUrban_crateTypes, _cacheBuildingLocationFinal, [], 0, "CAN_COLLIDE"];
        sideObj allowDamage false;
        _accepted = true;
    };
    _i = _i + 1;
};

if (!_accepted || isNil "_cacheBuildingLocationFinal") exitWith {
    [(format ["Error finding suitable house position for cache at '%1' for Sidemission: 'DestroyUrban'!", _smPos]), "SIDE"] call AW_fnc_log;
};

// Register planting event
["InA_Event_SideChargePlanted", {
    params ["_event", ["_planter", objNull]];

    private _sidecompleted = format["<t align='center'><t size='2.2'>Side-mission update</t><br/>____________________<br/>%1 planted charges on the objective.  Clear the area, detonation in 30 seconds!</t>", (name _planter)];
    [_sidecompleted] remoteExec ["AW_fnc_globalHint", 0];

    sleep 1;
    InA_Server_SideMissionSuccess = true;
}] call AW_fnc_eventRegister;

[
    sideObj,
    "Plant charges",
    "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\destroy_ca.paa",
    "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\use_ca.paa",
    "((_target distance _this) <= 4)",
    "((_target distance _this) <= 4)",
    {
        hint "Planting charges ...";
        params ["","_hero"];

        if ((currentWeapon _hero) != "") then {
            _hero action ["SwitchWeapon", _hero, _hero, 99];
        };

        _hero playMoveNow "AinvPknlMstpSnonWnonDnon_medic3";
    },
    {},
    {
        params ["_target", "_caller", "_actionId", "_arguments"];

        ["InA_Event_SideChargePlanted", _caller] remoteExec ["AW_fnc_eventTrigger", 2];
    },
    {   hint "You stopped planting charges.";
        private _unit = _this select 1;
        _unit playMoveNow "";
    },
    [],
    8,
    0,
    true,
    false
] remoteExecCall ["BIS_fnc_holdActionAdd", 0, true];


sideObj addEventHandler ["Killed", {
    params ["","","_killer"];

    _name = (name _killer);

    if (_name != "Error: No vehicle") then {
        private _sidecompleted = format ["<t align='center'><t size='2.2'>Side-mission update</t><br/>____________________<br/>%1 has destroyed the cache, good job everyone!</t>", _name];
        [_sidecompleted] remoteExec ["AW_fnc_globalHint", 0];
    };
}];

sleep 0.1;

//-------- SPAWN GUARDS and CIVILIANS
private _enemiesArray = [];

private _enemyFactions = ([InA_EnemyFaction] + (InA_EnemyFactionHash get "#aux_factions"));
private _enemyFactionWeights = ([1] + (InA_EnemyFactionHash get "#aux_faction_weights"));

private _enemyFaction = (_enemyFactions selectRandomWeighted _enemyFactionWeights);
private _enemyFactionHash = (InA_FactionMappings get _enemyFaction);

for "_i" from 1 to (6 + random 2) do {
    private _randomPos = [_cacheBuildingLocationFinal, 0 , 300, 5, 0, 0.4, 0, [], []] call BIS_fnc_findSafePos;
    private _squadType = ["#teams", _enemyFactionHash] call AW_fnc_getUnitsFromHash;
    private _grp = [_squadType, _randomPos] call AW_fnc_spawnAIGroup;
    [_grp, _cacheBuildingLocationFinal, nil, (random 300)] call AW_fnc_taskCircPatrol;

    _grp setGroupIdGlobal [format ["SIDE-Inf-Group%1", _i]];
    { _enemiesArray pushBack _x; } forEach (units _grp);

    [(units _grp)] call derp_fnc_AISkill;
    [(units _grp)] remoteExec ["AW_fnc_addToAllCurators", 2];

    [_grp] spawn AW_fnc_transferGroupHC;
};

//-----------enemies in buildings
_infBuildingArray = nearestObjects [sideObj, ["house","building"], 200];
_infBuildingAmount = count _infBuildingArray;

if (_infBuildingAmount > 0) then {
    private _GarrisonedBuildings = _infBuildingAmount min 30;

    for "_i" from 0 to _GarrisonedBuildings do {
        _garrisongroup = createGroup east;
        _garrisongroup setGroupIdGlobal [format ["SIDE-Inf-Garrison%1", _i]];
        _infBuilding = selectRandom _infBuildingArray;
        _infBuildingArray = _infBuildingArray - [_infBuilding];
        _infbuildingpos = _infBuilding buildingPos -1;

        _buildingposcount = count _infbuildingpos;
        _Garrisonpos = _buildingposcount/2;
        private _squad = ["#squads", _enemyFactionHash] call AW_fnc_getUnitsFromHash;
        for "_i" from 1 to _Garrisonpos do {
            _unitpos = selectRandom _infbuildingpos;
            _infbuildingpos = _infbuildingpos - _unitpos;
            _unit = _garrisongroup createUnit [ selectRandom _squad, _unitpos, [], 0, "CAN_COLLIDE"];
            _unit disableAI "PATH";
        };
        _enemiesArray = _enemiesArray + (units _garrisongroup);
        [(units _garrisongroup)] call derp_fnc_AISkill;
        [(units _garrisongroup)] remoteExec ["AW_fnc_addToAllCurators", 2];
        [_garrisongroup] spawn AW_fnc_transferGroupHC;
        sleep 0.1;
    };
};

//---------intel action
private _infHash = (_enemyFactionHash get "#infantry");

private _leaderTypes = (
    (_infHash get "#officers") +
    (_infHash get "#squadleaders") +
    (_infHash get "#teamleaders")
);

Side_DroppedIntel = [];

// Register Intel found event
["InA_Event_SideIntelFound", {
    params ["_event", ["_intelObj", objNull]];

    private _currentSize = markerSize "sideMissionHintCircle";
    private _markerSize = (_currentSize select 0) * 0.8;
    "sideMissionHintCircle" setMarkerSize [_markerSize, _markerSize];
    "sideMissionHintCircle" setMarkerPos ([(getPos sideObj), _markerSize] call AW_fnc_getFuzzyPos);

    if (_intelObj in Side_DroppedIntel) then {
        Side_DroppedIntel deleteAt (Side_DroppedIntel find _intelObj);
        deleteVehicle _intelObj;
    };
}] call AW_fnc_eventRegister;

{
    if (!((typeOf _x) in _leaderTypes)) then {continue};

    _x addMPEventHandler ["MPKilled", {
        params ["_unit", "_killer", "_instigator", "_useEffects"];

        if (!isServer) exitWith {};

        if (random 1 < 0.4) exitWith {};

        private _intelTypes = ["Intel_File1_F", "Land_Suitcase_F", "Intel_File2_F"];
        private _intelObj = createVehicle [(selectRandom _intelTypes), (getPos _unit), [], 2];
        private _pos = getPosATL _intelObj;
        _pos = _pos getPos [1, random 360];
        _pos set [2, 0];
        _intelObj setPosASL _pos;
        Side_DroppedIntel pushBack _intelObj;

        [
            _intelObj, [
                "Grab intel", {
                    params ["_target", "_caller", "_actionId", "_arguments"];

                    ["InA_Event_SideIntelFound", _target] remoteExec ["AW_fnc_eventTrigger", 2];

                    hint "Map updated";
                },
                [],
                0,
                true,
                true,
                "",
                "InA_Client_SideMissionUp",
                3,
                false,
                "",
                ""
            ]
        ] remoteExec ["addAction", 0, true];

    }];
} forEach _enemiesArray;

private _infHash = (InA_EnemyFactionHash get "#infantry");
private _civTypes = (_infHash get "#civs");

//-------------civs
for "_i" from 1 to (4 + random 2) do {
    private _randomPos = [getPos sideObj, 10, 250, 5, 0, 0.3, 0, [], (getPos sideObj)] call BIS_fnc_findSafePos;
    private _civgroup = createGroup civilian;
    _civgroup setGroupIdGlobal [format ["SIDE-Inf-Civ%1", _i]];

    for "_i" from 1 to (1 + random 2) do {
        private _unittype = selectRandom _civTypes;
        private _unit = _civgroup createUnit [_unittype, _randomPos, [], 0, "CAN_COLLIDE"];

        _unit addMPEventHandler ["MPKilled", {
            params ["_unit", "_killer", "_instigator", "_useEffects"];
            
            if (!isServer) exitWith {};

            _name = name _killer;

            if (_name != "Error: No vehicle") then {
                _civkilled = format ["<t align='center'><t size='2.2'>%1 killed a civilian!</t><br/>____________________<br/>High command doesn't like civilian casualties.  DO NOT kill civilians</t>", _name];
                [_civkilled] remoteExec ["AW_fnc_globalHint", 0, false];
            };
        }];

        [
            _unit,
            "Search for intel",
            "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\documents_ca.paa",
            "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\download_ca.paa",
            "(alive _target) && {(_target distance _this) <= 5}",
            "(alive _target) && {(_target distance _this) <= 5}",
            {
                hint "Searching for intel...";
            },
            {},
            {
                params ["_target", "_caller", "_actionId", "_arguments"];

                if (random 1 > 0.5) then {
                    hint "You found some intel, updating map now";
                    ["InA_Event_SideIntelFound", _target] remoteExec ["AW_fnc_eventTrigger", 2];
                } else {
                    hint "You didn't find any intel";
                };
            },
            {
                hint "You stop searching for intel.";
            },
            [],
            5,
            0,
            true,
            false
        ] remoteExecCall ["BIS_fnc_holdActionAdd", 0, true];
    };

    _civgroup setSpeedMode "LIMITED";
    [_civgroup, (getPos sideObj), nil, 150] call AW_fnc_taskRndPatrol;
    _enemiesArray = _enemiesArray + (units _civgroup);
    [(units _civgroup)] remoteExec ["AW_fnc_addToAllCurators", 2];
    [_civgroup] spawn AW_fnc_transferGroupHC;
    sleep 0.1;
};


//-------------------- BRIEFING
//smaller cirle to make it a tad easier
private _objectivepos = getPos sideObj;
private _fuzzyPos = [_objectivepos, 50] call AW_fnc_getFuzzyPos;
private _sideMissionHintCircle = createMarker ["sideMissionHintCircle",_fuzzyPos];
"sideMissionHintCircle" setMarkerShape "RECTANGLE";
"sideMissionHintCircle" setMarkerBrush "BDiagonal";
"sideMissionHintCircle" setMarkerSize [100, 100];

InA_Server_SideMarkers = ["SIDE", "Destroy Weapons Shipment", _smPos, 300] call AW_fnc_missionMarkersCreate;
private _sideMarker = (InA_Server_SideMarkers # 0);

[
    west,
    "urbancacheTask",
    [
        "Enemy forces have moved a cache with advanced weapons into a town and are planning on handing those out to hostile guerrilla forces.  Find the cache and destroy it.  The cache will be in the village marked on the map, and is in all likelihood in the square marked with diagonal lines.  The cache will look similar to this one: <br/><br/><img image='Media\Briefing\urbanCache.jpg' width='300' height='150'/>",
        "Side Mission: Destroy Weapons Shipment",
        _sideMarker
    ],
    _smPos,
    "Created",
    0,
    true,
    "search",
    true
] call BIS_fnc_taskCreate;


//--------------------- WAIT UNTIL OBJECTIVE COMPLETE
InA_Server_SideMissionUp = true;
InA_Server_SideMissionSpawned = true;
InA_Server_SideMissionSuccess = false;

sideObj allowDamage true;
["InA_Event_SideMissionUp", true] remoteExec ["AW_fnc_eventTrigger", 0, true];

waitUntil {
    sleep 5;
    (
        (InA_Server_SideMissionSuccess || !alive sideObj) ||
        !InA_Server_SideMissionUp
    )
};

//--------------------- BOOM
if ((InA_Server_SideMissionSuccess) && {alive sideObj}) then {
    sleep 30;			// ghetto bomb timer
    private _objPos = getPos sideObj;
    sideObj call AW_fnc_delete;
    "Bo_GBU12_LGB" createVehicle _objPos; 		// default "Bo_Mk82"
    sleep (4 + (random 3));
    [_objPos] spawn AW_fnc_cookoff;
};

// Unregister events
["InA_Event_SideChargePlanted"] call AW_fnc_eventUnregister;
["InA_Event_SideIntelFound"] call AW_fnc_eventUnregister;

//-------------------- DE-BRIEFING
	InA_Server_SideMissionUp = false;
	["InA_Event_SideMissionUp", false] remoteExec ["AW_fnc_eventTrigger", 0, true];
	[nil, _objectivepos] call AW_fnc_SMhintSUCCESS;
	deleteMarker "sideMissionHintCircle";

    0 = ["urbancacheTask"] spawn AW_fnc_finishTask;

    [InA_Server_SideMarkers] call AW_fnc_missionMarkersRemove;

//--------------------- DELETE, DESPAWN, HIDE and RESET
	sleep 120;
	{ [_x] spawn AW_fnc_delete } forEach (_enemiesArray + Side_DroppedIntel);
