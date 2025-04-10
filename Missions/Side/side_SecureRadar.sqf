/*@file: secureRadar.sqf
Author:	Quiksilver

Description: Get radar telemetry from enemy radar site, then destroy it.

Last modified:	10/12/2017 by stanhope
	
modified: unlocked the obj-building
*/

private _enemiesArray = [];

//-------------------- FIND SAFE POSITION FOR OBJECTIVE
private _flatPos = [nil, nil, 30, 0.5] call AW_fnc_findSafePos;

private _objPos = [_flatPos, 15, 30, 10, 0, 0.5, 0] call BIS_fnc_findSafePos;

//-------------------- SPAWN OBJECTIVE

    //define the objective
	sideObj = "Land_Radar_Small_F" createVehicle _flatPos;
	waitUntil {!isNull sideObj};
	sideObj setDir random 360;

    //create house, laptop, table
	private _dummyType = selectRandom["Land_Ammobox_rounds_F","Box_NATO_AmmoOrd_F","Box_NATO_Ammo_F","Box_IED_Exp_F"];
	private _laptopType = selectRandom ["Land_Laptop_unfolded_F","Land_Laptop_device_F"];

    private _house = "Land_Cargo_House_V3_F" createVehicle _objPos;
    _house setDir 0;
    _house animate ["door_1_rot", 1];
    private _laptop = _laptopType createVehicle _objPos;
    _laptop setDir 0;
	private _table = "Land_CampingTable_small_F" createVehicle _objPos;
	_table setDir 180;
    {_x allowDamage false;} forEach [_laptop,_table];
	sleep 0.3;

    //Move everything to the right place.
    [_house,_table,[0,2.5,0.8]] call BIS_fnc_relPosObject;
	[_table,_laptop,[0,0,0.8]] call BIS_fnc_relPosObject;

    //put holdaction on laptop
	[
        _laptop,
        "Secure intel",
        "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\documents_ca.paa",
        "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\download_ca.paa",
        "_target distance _this <= 4","_target distance _this <= 4",
        {
            params ["_target", "_caller", "_actionId", "_arguments"];

            hint "Downloading radar codes ....";

            if ((currentWeapon _caller) != "") then {
                _caller action ["SwitchWeapon", _caller, _caller, 99];
            };

            _caller playMoveNow "AinvPknlMstpSnonWnonDnon_medic3";
        },
        {},
        {
            params ["_target", "_caller", "_actionId", "_arguments"];

            hint "Receiving data .... Verifying ....";
            sleep 5;

            private _sidecompleted = format ["<t align='center'><t size='2.2'>Side-mission update</t><br/>____________________<br/>%1 recovered the intel.</t>", (name _caller)];
            [_sidecompleted] remoteExec ["AW_fnc_globalHint", 0];

            sleep 5;

            ["InA_Event_SideMissionSuccess"] remoteExecCall ["AW_fnc_eventTrigger", 2];
        },
        {
            params ["_target", "_caller", "_actionId", "_arguments"];

            hint "You stop downloading the codes.";
            _caller playMoveNow "";
        },
        [],
        8,
        0,
        true,
        false
    ] remoteExecCall ["BIS_fnc_holdActionAdd", 0, true];

    //spawn ambient towers
	private _tower1Pos = sideObj getPos [50, 0];
	private _tower2Pos = sideObj getPos [50, 120];
	private _tower3Pos = sideObj getPos [50, 240];
	
	private _tower1 = "Land_Cargo_Patrol_V3_F" createVehicle _tower1Pos;
	private _tower2 = "Land_Cargo_Patrol_V3_F" createVehicle _tower2Pos;
	private _tower3 = "Land_Cargo_Patrol_V3_F" createVehicle _tower3Pos;
	
	_tower1 setDir 180;
	_tower2 setDir 300;
	_tower3 setDir 60;

    private _towerGarrisonPos = [];
	{
	    _x allowDamage false;
	     private _towerXGarrison = _x buildingPos -1; /*To get garrison positions for later use*/
	     _towerGarrisonPos = _towerGarrisonPos + _towerXGarrison;
	} forEach [_tower1,_tower2,_tower3];
	sleep 0.3;

	//garrison the towers
	private _garrisongroup = createGroup InA_EnemyFactionSide;
    private _Garrisonpos = count _towerGarrisonPos;
    private  _unitTypes = ["#riflemen", "#machinegunners", "#marksmen", "#lats", "#heavygunners", "#sharpshooters"];

    for "_i" from 1 to (_Garrisonpos) do {
        private _unitpos = selectRandom _towerGarrisonPos;
        _towerGarrisonPos = _towerGarrisonPos - [_unitpos];
        private _unitType = [(selectRandom _unitTypes)] call AW_fnc_getUnitsFromHash;
        private _unit = _garrisongroup createUnit [_unitType, _unitpos, [], 0, "CAN_COLLIDE"];
        _unit disableAI "PATH";
        sleep 0.1;
    };

    _garrisongroup = [_garrisongroup] call AW_fnc_changeGroupSide;
    _garrisongroup setGroupIdGlobal ["SIDE-Tower-Guards"];
    _enemiesArray = units _garrisongroup;
    [(units _garrisongroup)] call derp_fnc_AISkill;
    [(units _garrisongroup)] remoteExec ["AW_fnc_addToAllCurators", 2];

    [_garrisongroup, [[[_tower1, _tower2, _tower3], _flatPos], {
        params ["_towers", "_pos"];

        waitUntil {
            sleep 1;
            ((_towers findIf {(_x distance2D _pos) > 100}) == -1)
        };
    }]] spawn AW_fnc_transferGroupHC;

//-------------------- SPAWN FORCE PROTECTION
    private _vehAmount = [
        1,                  // MBTs
        (1 + (random 1)),   // SPAAs
        (1 + (random 1)),   // IFVs
        (1 + (random 1))    // MRAPs
    ];

    private _infAmount = [
        (2 + (random 1)),   // Squads
        (1 + (random 1)),   // SF Squads
        1,                  // AA Teams
        1,                  // AT Teams
        (1 + (random 1)),   // Snipers
        nil,                // Teams
        nil                 // SF Teams
    ];

    private _enemyArray = [
        _flatPos,
        "SIDE",
        "#rnd",
        _vehAmount,
        _infAmount,
        15,
        400
    ] call AW_fnc_spawnEnemyUnits;

    _enemiesArray = (_enemiesArray + _enemyArray);


//-------------------- BRIEF
private _fuzzyPos = [_flatPos, 300] call AW_fnc_getFuzzyPos;

InA_Server_SideMarkers = ["SIDE", "Secure Radar", _fuzzyPos, 300] call AW_fnc_missionMarkersCreate;
private _sideMarker = (InA_Server_SideMarkers # 0);

[
    west,
    "secureRadarTask",
    [
        "OPFOR have captured a small radar on the island to support their aircraft. We've marked the position on your map; head over there and secure the site. First take the data and then destroy it.",
        "Side Mission: Secure Radar",
        _sideMarker
    ],
    _fuzzyPos,
    "Created",
    0,
    true,
    "search"
    ,true
] call BIS_fnc_taskCreate;

//====== MISSION CORE=======
    InA_Server_SideMissionUp = true;
    InA_Server_SideMissionSuccess = false;
    InA_Server_SideMissionSpawned = true;

waitUntil {
    sleep 5;
    (!InA_Server_SideMissionUp || InA_Server_SideMissionSuccess || (!alive sideObj))
};

if ((!alive sideObj) || !InA_Server_SideMissionUp) then {
    //-------------------- DE-BRIEFING
    0 = ["secureRadarTask", "Failed"] spawn AW_fnc_finishTask;
    InA_Server_SideMissionSuccess = false;
    _laptop call AW_fnc_delete;
};

if (InA_Server_SideMissionSuccess) then {

    //-------------------- BOOM!
    _laptop call AW_fnc_delete;
    sleep 30;	    										// ghetto bomb timer
    "Bo_Mk82" createVehicle _flatPos; 				    // default "Bo_Mk82","Bo_GBU12_LGB"
    [nil, _flatPos] call AW_fnc_SMhintSUCCESS;
	InA_Server_SideMissionUp = false;
	sleep (4 + (random 3));
	[_flatPos] spawn AW_fnc_cookoff;

    0 = ["secureRadarTask"] spawn AW_fnc_finishTask;
};

InA_Server_SideMissionUp = false;

 sleep 5;

[InA_Server_SideMarkers] call AW_fnc_missionMarkersRemove;

//--------------------- DELETE
sleep 120;
{ _x call AW_fnc_delete } forEach [_house,_tower1,_tower2,_tower3, _table];

if (!alive sideObj)then {
    (nearestObject [_flatPos,"Land_Radar_Small_ruins_F"]) call AW_fnc_delete;
} else {
    sideObj call AW_fnc_delete
};
[_enemiesArray] spawn AW_fnc_delete;
