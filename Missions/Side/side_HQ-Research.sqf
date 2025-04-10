/*@file: HQresearch.sqf
Author:	Quiksilver

Last modified:	29/07/2017 by stanhope

modified:	pos finder

Description: Creates an HQ from which research has to be recovered.
*/

private _vehicletypes = ["O_MRAP_02_F","O_Truck_03_covered_F","O_Truck_03_transport_F","O_Heli_Light_02_unarmed_F","O_Truck_02_transport_F","O_Truck_02_covered_F","C_SUV_01_F","C_Van_01_transport_F"];

//-------------------- FIND POSITION FOR OBJECTIVE

private _flatPos = [nil, nil, 15, 0.2] call AW_fnc_findSafePos;

// Register planting event
["InA_Event_SideChargePlanted", {
    params ["_event", ["_planter", objNull]];

    private _sidecompleted = format["<t align='center'><t size='2.2'>Side-mission update</t><br/>____________________<br/>%1 planted charges on the objective.  Clear the area, detonation in 30 seconds!</t>", (name _planter)];
    [_sidecompleted] remoteExec ["AW_fnc_globalHint", 0];

    sleep 1;
    InA_Server_SideMissionSuccess = true;
}] call AW_fnc_eventRegister;

//-------------------- SPAWN OBJECTIVE BUILDING AND RELATED THINGS

	private _veh = (selectRandom _vehicletypes) createVehicle ([_flatPos, 15, 30, 10, 0, 0.5, 0] call BIS_fnc_findSafePos);
	_veh lock 3;
	private _laptopType = selectRandom ["Land_Laptop_unfolded_F","Land_Laptop_device_F"];

    sideObj = "Land_Research_HQ_F" createVehicle _flatPos;
    sideObj animate ["door_1_rot", 1];
	sideObj setVectorUp [0,0,1];
	sideObj setDir 0;

    private _laptop = _laptopType createVehicle _flatPos;
    _laptop setDir 0;
    private _table = "Land_CampingTable_small_F" createVehicle _flatPos;
    _table setDir 180;
    sleep 0.3;
    [sideObj,_table,[0,0,0.8]] call BIS_fnc_relPosObject;
    sleep 1;
    [_table,_laptop,[0,0,0.85]] call BIS_fnc_relPosObject;

     //put holdaction on laptop
    [_laptop,"Secure intel and plant charges",
    "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\documents_ca.paa",
    "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\download_ca.paa",
    "_target distance _this <= 5","_target distance _this <= 5",
    {   hint "Securing intel ... Planting charges ...";
         params ["","_hero"];
        if ( currentWeapon _hero != "" ) then
        {	_hero action ["SwitchWeapon", _hero, _hero, 99]; };
        _hero playMoveNow "AinvPknlMstpSnonWnonDnon_medic3";
    },{},{
        params ["_target", "_caller", "_actionId", "_arguments"];

        ["InA_Event_SideChargePlanted", _caller] remoteExec ["AW_fnc_eventTrigger", 2];
    },
    {   hint "You stopped securing the intel.";
        private _unit = _this select 1;
        _unit playMoveNow "";
    },[], 8, 0,true,false] remoteExecCall ["BIS_fnc_holdActionAdd", 0, true];

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

    InA_Server_SideMarkers = ["SIDE", "Seize Research Data", _fuzzyPos, 300] call AW_fnc_missionMarkersCreate;
    private _sideMarker = (InA_Server_SideMarkers # 0);

    [
        west,
        "hqResearchTask",
        [
            "OPFOR are conducting advanced military research on Altis. Find the data secure it and then torch the place!  If the data gets destroyed this mission will be a failure.  Recon reports suggest that the building will look like this: <br/><br/><img image='Media\Briefing\hqResearch.jpg' width='300' height='150'/>",
            "Side Mission: Seize Research Data",
            _sideMarker
        ],
        _fuzzyPos,
        "Created",
        0,
        true,
        "search",
        true
    ] call BIS_fnc_taskCreate;

//-------------------- [ CORE LOOPS ] ------------------------ [ CORE LOOPS ]
    InA_Server_SideMissionUp = true;
    InA_Server_SideMissionSuccess = false;
	InA_Server_SideMissionSpawned = true;


waitUntil {
    sleep 5; 
    (!InA_Server_SideMissionUp || InA_Server_SideMissionSuccess || (!alive _laptop))
};

if (!alive _laptop || !InA_Server_SideMissionUp) then {
    //------------------ DE-BRIEFING
    0 = ["hqResearchTask", "Failed"] spawn AW_fnc_finishTask;
    InA_Server_SideMissionUp = false;
    InA_Server_SideMissionSuccess = false;
    _laptop call AW_fnc_delete;
};

if (InA_Server_SideMissionSuccess) then {

    //-------------------- BOOM!        
    sleep 30;	    										// ghetto bomb timer
    _laptop call AW_fnc_delete;
    "Bo_Mk82" createVehicle _flatPos; 				    // default "Bo_Mk82","Bo_GBU12_LGB"
    sleep 0.1;
    //-------------------- DE-BRIEFING
    [nil, _flatPos] call AW_fnc_SMhintSUCCESS;
    0 = ["hqResearchTask"] spawn AW_fnc_finishTask;
    InA_Server_SideMissionUp = false;
        sleep (4 + (random 3));
    [_flatPos] spawn AW_fnc_cookoff;
};

// Unregister events
["InA_Event_SideChargePlanted"] call AW_fnc_eventUnregister;

//-------------------- DE-BRIEFING
[InA_Server_SideMarkers] call AW_fnc_missionMarkersRemove;

InA_Server_SideMissionUp = false;

//--------------------- DELETE
sleep 120;
_table call AW_fnc_delete;
_veh call AW_fnc_delete;

if (!alive sideObj) then {
    (nearestObject [_flatPos,"Land_Research_HQ_ruins_F"]) call AW_fnc_delete;
} else {
    sideObj call AW_fnc_delete;
};

[_enemiesArray] spawn AW_fnc_delete;
