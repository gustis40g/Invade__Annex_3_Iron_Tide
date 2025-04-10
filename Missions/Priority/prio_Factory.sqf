/*
Author: Lost Bullet

Description: reinforces the AO with enemies while the factory building is up.  As long as the engineer in the factory building is alive the building cannot be destroyed.
*/

private _infTeams = ["rhs_group_rus_vdv_infantry_squad","rhs_group_rus_vdv_infantry_section_AT","rhs_group_rus_vdv_infantry_section_AT","rhs_group_rus_vdv_infantry_recon_squad","rhs_group_rus_vdv_infantry_recon_fireteam"];
private _vehicleTypes = ["rhs_t90am_tv", "rhs_t90sm_tv", "rhs_t80um", "rhs_t72be_tv","rhs_bmp3mera_msv","rhs_bmp3_late_msv","rhs_bmd4ma_vdv","rhs_bmd4_vdv","rhs_zsu234_aa", "rhs_btr80a_vdv","rhs_sprut_vdv","rhs_bmp2k_tv", "rhsgref_BRDM2_vdv", "rhs_bmd2m", "rhs_bmd4m_vdv"];
private _attackheliTypes = ["RHS_Ka52_vvsc", "rhs_mi28n_vvsc",
                            "RHS_Mi24P_vvsc","RHS_Mi24V_vvsc","RHS_Mi8MTV3_heavy_vdv"];
private _jetTypes = ["rhs_mig29sm_vvsc","RHS_Su25SM_vvsc",
                     "RHS_T50_vvs_generic_ext","RHS_T50_vvs_blueonblue"];

private _noSpawning =  InA_Server_BaseArray + [InA_Server_currentAO];
private _noSpawningRange = 2000;

/* --- 1. FIND POSITION FOR OBJECTIVE --- */
private _flatPos = [(getMarkerPos InA_Server_currentAO), 4000, 20, 0.2] call AW_fnc_findSafePos;

/* --- 2. SPAWN OBJECTIVE --- */

	Factory = "Land_i_Shed_Ind_F" createVehicle _flatPos;
	waitUntil {!isNull Factory};
	Factory setDir random 360;
	Factory allowDamage false; //no CAS bombing it until the Engineer inside is killed.

	//===Place engineers team/objectives inside Factory
	
	//where should he be?
	private _garrisonpos = Factory buildingPos -1;
	private _engenieerpos =  selectRandom _garrisonpos;
	_garrisonpos = _garrisonpos - [_engenieerpos];
	
	private _priorityGroup = createGroup InA_EnemyFactionSide;

	private _objectiveUnit = _priorityGroup createUnit ["O_V_Soldier_Exp_hex_F", _engenieerpos, [], 0, "CAN_COLLIDE"];
	_objectiveUnit disableAI "PATH";
	_objectiveUnit addMPEventHandler ["MPKilled", {
		params ["_unit","","_killer"];
		if (!isServer) exitWith {};

        Factory allowDamage true;
		private _name = name _killer;
		if (_name == "Error: No vehicle") then{
		    _name = "some genius jarhead who thought it'd be a good idea to run an enemy over with his jacked up monster truck";
		};
		private _engineerkilled = format["<t align='center'><t size='2.2'>Prio Mission update</t><br/>____________________<br/>Fantastic job, lads! The OPFOR engineer has been killed by %1.  Now move in and demo that building</t>",_name];
		[_engineerkilled] remoteExec ["AW_fnc_globalHint",0];
	}];

	Factory addEventHandler ["Killed", {
        params ["_unit","","_killer"];
        private _name = name _killer;
        if (_name == "Error: No vehicle") then{
            _name = "someone";
        };
        private _msg = format["<t align='center'><t size='2.2'>Prio Mission Complete</t><br/>____________________<br/>Fantastic job, lads! The factory has been destroyed by %1</t>",_name];
        [_msg] remoteExec ["AW_fnc_globalHint",0];
        //debrief

        0 = ["prioFacTask"] spawn AW_fnc_finishTask;

        [InA_Server_PrioMarkers] call AW_fnc_missionMarkersRemove;
    }];

	//fill the rest of the building
	private _buildingposcount = count _garrisonpos;
	_buildingposcount = floor(_buildingposcount*3/4);
	private _unittypes = ["O_recon_F","O_Soldier_SL_F","O_Soldier_lite_F","O_Soldier_AR_F","O_soldierU_exp_F","O_Soldier_F","O_HeavyGunner_F","O_Urban_HeavyGunner_F",
	"O_soldierU_F","O_Urban_Sharpshooter_F","O_Sharpshooter_F"];

	for "_i" from 1 to _buildingposcount do {
	    private _unitpos = (selectRandom _garrisonpos);
        private _unit = _priorityGroup createUnit [(selectRandom _unittypes), _unitpos, [], 0, "CAN_COLLIDE"];
        _garrisonpos = _garrisonpos - [_unitpos];
        _unit disableAI "PATH";
        sleep 0.1;
	};

    _priorityGroup = [_priorityGroup] call AW_fnc_changeGroupSide;
    _priorityGroup setGroupIdGlobal ["PRIO-Factory-Group"];

    private _enemiesArray = units _priorityGroup;

    [_enemiesArray] call derp_fnc_AISkill;
    [_enemiesArray] remoteExec ["AW_fnc_addToAllCurators", 2];
    [_priorityGroup] spawn AW_fnc_transferGroupHC;


/* --- 3. SPAWN FORCE PROTECTION --- */

private _vehAmount = [
    (1 + (random 1)),   // MBTs
    (1 + (random 1)),   // SPAAs
    (1 + (random 1)),   // IFVs
    (1 + (random 1))    // MRAPs
];

private _infAmount = [
    (2 + (random 2)),       // Squads
    (selectRandom [0, 1]),  // SF Squads
    (1 + (random 1)),       // AA Teams
    (1 + (random 1)),       // AT Teams
    nil,                    // Snipers
    nil,                    // Teams
    nil                     // SF Teams
];

private _enemyAry = [
    _flatPos,
    "PRIO",
    "#rnd",
    _vehAmount,
    _infAmount,
    25,
    400
] call AW_fnc_spawnEnemyUnits;

_enemiesArray = (_enemiesArray + _enemyAry);


/* --- 5. define the functions for the spawning of stuff --- */

private _infSpawnCode = {
    params ["_reinforceGroupamount", "_enemiesArray", "_numPlayersinAO"];
    //ground troop multiplier --> account for number of players on AO
    private _totalspawnUnits = 3 + floor (_numPlayersinAO * 0.2);
    if (_totalspawnUnits > 16) then { _totalspawnUnits = 16;};

    private _reinforceGroup = createGroup InA_EnemyFactionSide;
    _reinforceGroupamount = _reinforceGroupamount + 1;

    private _randomspawnPosition = [position Factory, 0, (300 * 1.2), 1, 0, 0.4, 0, [], position Factory] call BIS_fnc_findSafePos;
    for "_i" from 1 to _totalspawnUnits do {
        _unit = selectRandom AW_OPFOR_units_array;
        _grpMember = _reinforceGroup createUnit [_unit, _randomspawnPosition, [], 0, "FORM"];
        sleep 0.1;
    };

    _reinforceGroup = [_reinforceGroup] call AW_fnc_changeGroupSide;
    _reinforceGroup setGroupIdGlobal [format ['PRIO-Reinforce-Infantry%1', _reinforceGroupamount]];

    [_reinforceGroup, getMarkerPos InA_Server_currentAO, nil, (InA_Server_MainAOSize/2)] call AW_fnc_taskRndPatrol;

    [(units _reinforceGroup)] call derp_fnc_AISkill;

    {_x addCuratorEditableObjects [units _reinforceGroup, false];} forEach allCurators;
    _enemiesArray = _enemiesArray + (units _reinforceGroup);
    InA_Server_mainAOUnits append (units _reinforceGroup);

    [_reinforceGroupamount, _enemiesArray]
};

private _vehSpawnCode = {
    params ["_reinforceGroupamount","_enemiesArray", "_numPlayersinAO"];

    private _randomspawnPosition = [position Factory, 0, (300 * 1.2), 1, 0, 0.4, 0, [], position Factory] call BIS_fnc_findSafePos;
    private _veh = (selectRandom _vehicleTypes) createVehicle _randomspawnPosition;
    _veh call AW_fnc_vehicleCustomizationOpfor;

    waitUntil {sleep 0.5; !isNull _veh};
    private _reinforceGroup = createGroup InA_EnemyFactionSide;
    private _tmpGrp = createVehicleCrew _veh;
    (units _tmpGrp) joinSilent _reinforceGroup;
    _reinforceGroupamount = _reinforceGroupamount + 1;
    _reinforceGroup setGroupIdGlobal [format ['PRIO-Reinforce-Vehicle%1', _reinforceGroupamount]];
    [_reinforceGroup, getMarkerPos InA_Server_currentAO, nil, (InA_Server_MainAOSize/2)] call AW_fnc_taskRndPatrol;
    _veh lock 3;
    _veh allowCrewInImmobile true;
    _reinforceGroup setBehaviour "COMBAT";
    _reinforceGroup setCombatMode "RED";
    _veh engineOn true;

    [(units _reinforceGroup)] call derp_fnc_AISkill;

    _enemiesArray = _enemiesArray + (units _reinforceGroup) + [_veh];
    InA_Server_mainAOUnits append ((units _reinforceGroup) + [_veh]);
    {_x addCuratorEditableObjects [units _reinforceGroup + [_veh], false];} forEach allCurators;

    [_reinforceGroupamount, _enemiesArray]
};

private _casHeliCode = {
    params ["_numPlayersinAO"];

    [(getMarkerPos "airCavSpawnMarker")] spawn AW_fnc_heliCombatPatrol;
};

private _jetSpawnCode = {
    params ["_numPlayersinAO"];

    if (InA_Server_AOReinforceJetCount >= InA_Server_AOReinforceJetLimit) then {
        sleep 5;
    } else {
        [] spawn AW_fnc_enemyJetSpawn;
    };
};

/* --- 6. GET RANDOM TYPE OF FACTORY MISSION --- */
//private _typeFactory = selectRandom["infantry","infantry","infantry","vehicle","vehicle","cas helicopters","cas helicopters","jets"];
//private _typeFactory = selectRandom ["cas helicopters", "jets"];
private _typeFactory = "jets";

/* --- 7. BRIEF --- */
private _fuzzyPos = [((_flatPos select 0) - 300) + (random 600),((_flatPos select 1) - 300) + (random 600),0];

InA_Server_PrioMarkers = ["PRIO", "Factory", _fuzzyPos, 300] call AW_fnc_missionMarkersCreate;
private _prioMarker = (InA_Server_PrioMarkers # 0);

private _typeFactoryText = format["The enemies have set up a factory, producing %1. The enemy will keep reinforcing the AO until this factory is taken out!<br /><br />Intel suggests that the factory looks like a big industrial shed. First kill the viper engineer inside then demo that building. Previous sites looked like this: <br/><br/><img image='Media\Briefing\prioFactory.jpg' width='300' height='150'/>",_typeFactory];

[
    west,
    "prioFacTask",
    [
        _typeFactoryText,
        "Priority Target: Factory",
        _prioMarker
    ],
    _fuzzyPos,
    "Created",
    0,
    true,
    "destroy",
    true
] call BIS_fnc_taskCreate;

/* --- 8. core loop --- */
InA_Server_PrioMissionSpawned = true;
InA_Server_PrioMissionUp = true;

private _reinforceGroupamount = 0;
private _nextRun = serverTime;

while {((alive Factory) && InA_Server_PrioMissionUp)} do{
	
	// ---- if its the first run or current AO doesn't have friendly's, don't spawn anything ----
	private _numPlayersinAO = 0;
	private _playerClose = [];

    if (_nextRun > serverTime) then {
        sleep 5;
        continue;
    };

    // Pause if Main AO is shutdown
    if (InA_Server_MainAOShutdown) then {
        sleep 5;
        continue;
    };

    {
        if ((_x distance (getMarkerPos InA_Server_currentAO)) < InA_Server_MainAOSize) then {
            _playerClose pushBack _x;
        };
    } forEach allPlayers;

    _numPlayersinAO = count _playerClose;

    sleep 0.1;
    
    if (_numPlayersinAO isEqualTo []) then {
        sleep 5;
        continue;
    } else {
        switch (_typefactory) do {
            case "infantry": {
                private _returnArray = [_reinforceGroupamount, _enemiesArray, _numPlayersinAO] call _infSpawnCode;
                _reinforceGroupamount = _returnArray select 0;
                _enemiesArray = _returnArray select 1;

                _nextRun = (serverTime + 240);
            };
            case "vehicle": {
                private _returnArray = [_reinforceGroupamount, _enemiesArray, _numPlayersinAO] call _vehSpawnCode;
                _reinforceGroupamount = _returnArray select 0;
                _enemiesArray = _returnArray select 1;

                private _timetosleep = 300 - floor (_numPlayersinAO * 2);
                _nextRun = (serverTime + _timetosleep);
            };

            case "cas helicopters": {
                [_numPlayersinAO] call _casHeliCode;
                private _timetosleep = 480 - floor (_numPlayersinAO * 4);
                _nextRun = (serverTime + _timetosleep);
            };
            case "jets": {
                [_numPlayersinAO] call _jetSpawnCode;
                private _timetosleep = 480 - floor (_numPlayersinAO * 4);
                _nextRun = (serverTime + _timetosleep);
            };
        };
    };
};

if (!InA_Server_PrioMissionUp) then {
    0 = ["prioFacTask", "Failed"] spawn AW_fnc_finishTask;
    [InA_Server_PrioMarkers] call AW_fnc_missionMarkersRemove;
};

//cleanup
sleep 60;
(nearestObject[_flatPos, "Land_Shed_Ind_ruins_F"]) call AW_fnc_delete;
[_enemiesArray] spawn AW_fnc_delete;
