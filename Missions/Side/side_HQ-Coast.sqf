/*
Author:	Quiksilver (credit Rarek [AW] for initial design)

Description:
	Secure explosives crate on coastal HQ.
	Destroying the HQ first yields failure.
	Securing the weapons first yields success.
*/

private _posBlacklist = [
    [[21345, 14625], 1000]   // Limni swamps
];

private _flatPos = [nil, nil, 10, 0.2, _posBlacklist, true] call AW_fnc_findSafePos;

// Register planting event
["InA_Event_SideChargePlanted", {
    params ["_event", ["_planter", objNull]];

    private _sidecompleted = format["<t align='center'><t size='2.2'>Side-mission update</t><br/>____________________<br/>%1 planted charges on the objective.  Clear the area, detonation in 30 seconds!</t>", (name _planter)];
    [_sidecompleted] remoteExec ["AW_fnc_globalHint", 0];

    sleep 1;
    InA_Server_SideMissionSuccess = true;
}] call AW_fnc_eventRegister;

//------------------------------------------- SPAWN OBJECTIVE AND AMBIENCE
	private _randomDir = (random 360);
	sideObj = "Land_Cargo_HQ_V1_F" createVehicle _flatPos;
	waitUntil {alive sideObj};
	sideObj enableSimulationGlobal true;
    sideObj enableDynamicSimulation true;
	sideObj animate ["door_1_rot", 1];
	sideObj setDir _randomDir;
	sideObj setVectorUp [0,0,1];

	private _objectType = selectRandom ["Box_NATO_AmmoVeh_F","Box_East_AmmoVeh_F","O_supplyCrate_F","B_CargoNet_01_ammo_F","CargoNet_01_box_F"];
    private _object = _objectType createVehicle _flatPos;

    [sideObj,_object,[0,0,0.7]] call BIS_fnc_relPosObject;

    [_object,"Plant charges",
    "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\destroy_ca.paa",
    "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\use_ca.paa",
    "_target distance _this <= 5","_target distance _this <= 5",
    {   hint "Planting charges ...";
         params ["","_hero"];
        if ( currentWeapon _hero != "" ) then
        {	_hero action ["SwitchWeapon", _hero, _hero, 99]; };
        _hero playMoveNow "AinvPknlMstpSnonWnonDnon_medic3";
    },{},{
        params ["_target", "_caller", "_actionId", "_arguments"];

        ["InA_Event_SideChargePlanted", _caller] remoteExec ["AW_fnc_eventTrigger", 2];
     },
    {   hint "You stopped planting charges.";
        private _unit = _this select 1;
        _unit playMoveNow "";
    },[], 8, 0,true,false] remoteExecCall ["BIS_fnc_holdActionAdd", 0, true];

	//--------- BOAT POSITIONS
	private _boatPos = [_flatPos, 50, 150, 10, 2, 1, 0] call BIS_fnc_findSafePos;
	private _trawlerPos = [_flatPos, 100, 300, 10, 2, 1, 0] call BIS_fnc_findSafePos;

	//--------- ENEMY HMG BOAT (SEEMS RIGHT SINCE ITS BY THE COAST)

	private _boat = "O_Boat_Armed_01_hmg_F" createVehicle _boatPos;
	waitUntil {sleep 0.1; alive _boat};

	private _smuggleGroup = createGroup InA_EnemyFactionSide;
	private _commander = _smuggleGroup createUnit ["rhs_vmf_emr_crew_commander", _boatPos, [], 0, "NONE"];
	private _driver = _smuggleGroup createUnit ["rhs_vmf_emr_combatcrew", _boatPos, [], 0, "NONE"];
	private _cargo1 = _smuggleGroup createUnit ["rhs_vmf_emr_combatcrew", _boatPos, [], 0, "NONE"];
	private _cargo2 = _smuggleGroup createUnit ["rhs_vmf_emr_combatcrew", _boatPos, [], 0, "NONE"];
	private _cargo3 = _smuggleGroup createUnit ["rhs_vmf_emr_combatcrew", _boatPos, [], 0, "NONE"];
	private _cargo4 = _smuggleGroup createUnit ["rhs_vmf_emr_combatcrew", _boatPos, [], 0, "NONE"];

	_commander assignAsCommander _boat;
	_commander moveInCommander _boat;
	_driver assignAsDriver _boat;
	_driver moveInDriver _boat;
	_cargo1 assignAsCargo _boat;
	_cargo1 moveInCargo _boat;
	_cargo2 assignAsCargo _boat;
    _cargo2 moveInCargo _boat;
	_cargo3 assignAsCargo _boat;
    _cargo3 moveInCargo _boat;
	_cargo4 assignAsCargo _boat;
    _cargo4 moveInCargo _boat;

	_boat lock 3;
    _boat allowCrewInImmobile true;

    _smuggleGroup = [_smuggleGroup] call AW_fnc_changeGroupSide;
    _smuggleGroup setGroupIdGlobal ["SIDE-Smugglers"];
    [(units _smuggleGroup), 25] call derp_fnc_AISkill;

    for "_w" from 1 to 5 do {
        private _wpPos = [_flatPos, 50, 300, 10, 2, 1, 0] call BIS_fnc_findSafePos;
        private _wp = _smuggleGroup addWaypoint [_wpPos, 10];

        if (_w == 5) then {
            _wp setWaypointType "CYCLE";
        } else {
            _wp setWaypointType "MOVE";
        };
    };
	
    [(units _smuggleGroup) + [_boat]] remoteExec ["AW_fnc_addToAllCurators", 2];

	_smuggleGroup setGroupIdGlobal [format ["SIDE-Sea-AssaultBoat"]];
	private _unitsArray = (units _smuggleGroup);

	//---------- SHIPPING TRAWLER FOR AMBIENCE
	private _trawler = "C_Boat_Civil_04_F" createVehicle _trawlerPos;
	_trawler setDir random 360;
	_trawler allowDamage false;

//-------------------- SPAWN FORCE PROTECTION
    private _vehAmount = [
        1,                  // MBTs
        (1 + (random 1)),   // SPAAs
        (1 + (random 1)),   // IFVs
        (1 + (random 1))    // MRAPs
    ];

    private _infAmount = [
        (3 + (random 1)),   // Squads
        (1 + (random 1)),   // SF Squads
        1,                  // AA Teams
        1,                  // AT Teams
        (1 + (random 1)),   // Snipers
        nil,                // Teams
        nil                 // SF Teams
    ];

    private _enemiesArray = [
        _flatPos,
        "SIDE",
        "#rnd",
        _vehAmount,
        _infAmount,
        15,
        400
    ] call AW_fnc_spawnEnemyUnits;

//-------------------- BRIEFING
	private _fuzzyPos = [_flatPos, 300] call AW_fnc_getFuzzyPos;

    InA_Server_SideMarkers = ["SIDE", "Secure Smuggled Explosives", _fuzzyPos, 300] call AW_fnc_missionMarkersCreate;
    private _sideMarker = (InA_Server_SideMarkers # 0);

    [
        west,
        "hqCoastTask",
        [
            "OPFOR have been smuggling explosives onto the island and hiding them in a Mobile HQ on the coastline.We've marked the building on your map; head over there and secure the current shipment. Keep well back when you blow it, there's a lot of stuff in that building.  Aerial surveillance suggests the building will look like this: <br/><br/><img image='Media\Briefing\hqCoast.jpg' width='300' height='150'/>",
            "Side Mission: Secure Smuggled Explosives",
            _sideMarker
        ],
        _fuzzyPos,
        "Created",
        0,
        true,
        "search",
        true
    ] call BIS_fnc_taskCreate;

	InA_Server_SideMissionSpawned = true;


//-------------------- [ CORE LOOPS ]----------------------- [CORE LOOPS]
	InA_Server_SideMissionUp = true;
	InA_Server_SideMissionSuccess = false;
	private _objPos = getPos _object;

waitUntil {
    sleep 5;
    (!InA_Server_SideMissionUp || InA_Server_SideMissionSuccess || (!alive _object))
};

if (!InA_Server_SideMissionUp) then {
    _object call AW_fnc_delete;
    //-------------------- DE-BRIEFING
    InA_Server_SideMissionUp = false;
    InA_Server_SideMissionSuccess = false;
    0 = ["hqCoastTask", "Failed"] spawn AW_fnc_finishTask;
};

if (InA_Server_SideMissionSuccess) then {
    sleep 30;
    "Bo_GBU12_LGB" createVehicle _objPos;
    _object call AW_fnc_delete;
    
    //-------------------- DE-BRIEFING
    InA_Server_SideMissionUp = false;
    [nil, _flatPos] call AW_fnc_SMhintSUCCESS;
    0 = ["hqCoastTask"] spawn AW_fnc_finishTask;
    
    sleep (4 + (random 3));
    [_flatPos] spawn AW_fnc_cookoff;
};

if (!alive _object && !InA_Server_SideMissionSuccess) then {
    //-------------------- DE-BRIEFING
    InA_Server_SideMissionUp = false;
    [nil, _flatPos] call AW_fnc_SMhintSUCCESS;
    _object call AW_fnc_delete;
    0 = ["hqCoastTask"] spawn AW_fnc_finishTask;
};

["InA_Event_SideChargePlanted"] call AW_fnc_eventUnregister;

[InA_Server_SideMarkers] call AW_fnc_missionMarkersRemove;

//cleanup
sleep 120;

{ _x call AW_fnc_delete } forEach [_boat,_trawler];

if (!alive sideObj)then {
    (nearestObject [_flatPos,"Land_Cargo_HQ_V1_ruins_F"]) call AW_fnc_delete;
} else {
    sideObj call AW_fnc_delete
};

{ [_x] spawn AW_fnc_delete } forEach [_unitsArray,_enemiesArray];
