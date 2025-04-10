/*
@filename: secureIntelVehicle.sqf
Author:

	Quiksilver

Description:

	Recover intel from a vehicle (add Action)
		If driver sees you, will attempt escape.
			If escapes, mission fail.
		If vehicle destroyed, mission fail.
		If intel recovered, mission success.

Last modified:

	29/07/2017 by stanhope
	
modified:
	
	pos finder

		
Status:

	20/04/2014
	WIP Third pass
	Open beta

Notes / To Do:

	- Locality issues and variables? Seems okay for now, but still work on the Side Mission selector.
	- remove action after completion?
	- Create ambush
	- Increase sleep timer before delete, too tight!

___________________________________________________________________________*/

private _objVehicles = ["rhs_tigr_3camo_vdv","rhs_tigr_vdv"];
private _objUnitTypes = [ "rhs_vdv_officer","rhs_vdv_rifleman","rhs_vdv_recon_sergeant","rhs_vdv_recon_efreitor"];

//-------------------------------------------------------------------------- FIND POSITION FOR VEHICLE
private _flatPos = [nil, nil, 15] call AW_fnc_findSafePos;

//-------------------------------------------------------------------------- NEARBY POSITIONS TO SPAWN STUFF (THEY SPAWN IN TRIANGLE SO NO ONE WILL KNOW WHICH IS THE OBJ VEHICLE. HEHEHEHE.
	private _flatPos1 = [_flatPos, 2, random 360] call BIS_fnc_relPos;
	private _flatPos2 = [_flatPos, 10, random 360] call BIS_fnc_relPos;
	private _flatPos3 = [_flatPos, 15, random 360] call BIS_fnc_relPos;

//-------------------------------------------------------------------------- CREATE GROUP, VEHICLE AND UNIT

	//--------- OBJ 1
	private _obj1 = (selectRandom _objVehicles) createVehicle _flatPos;
	waitUntil {sleep 0.1; alive _obj1};
	_obj1 setDir (random 360);

	sleep 0.1;
	private _aGroup = createGroup InA_EnemyFactionSide;
	private _objUnit1 = _aGroup createUnit [(["#officers"] call AW_fnc_getUnitsFromHash),_flatPos1, [], 0, "FORM"];
    _objUnit1 assignAsDriver _obj1;
    _objUnit1 moveInDriver _obj1;

	_aGroup = [_aGroup] call AW_fnc_changeGroupSide;
	_aGroup setGroupIdGlobal ["SIDE-Officer1"];

	//--------- OBJ 2
	private _obj2 = (selectRandom _objVehicles) createVehicle _flatPos2;
	waitUntil {sleep 0.1; alive _obj2};
	_obj2 setDir (random 360);

	sleep 0.1;
	private _bGroup = createGroup InA_EnemyFactionSide;
    private _objUnit2 = _bGroup createUnit [(["#officers"] call AW_fnc_getUnitsFromHash),_flatPos2, [], 0, "FORM"];
    _objUnit2 assignAsDriver _obj2;
    _objUnit2 moveInDriver _obj2;

	_bGroup = [_bGroup] call AW_fnc_changeGroupSide;
	_bGroup setGroupIdGlobal ["SIDE-Officer2"];

	//-------- OBJ 3
	private _obj3 = (selectRandom _objVehicles) createVehicle _flatPos3;
	waitUntil {sleep 0.1; alive _obj3};
	_obj3 setDir (random 360);

	sleep 0.1;
	private _cGroup = createGroup InA_EnemyFactionSide;
    private _objUnit3 = _cGroup createUnit [(["#officers"] call AW_fnc_getUnitsFromHash),_flatPos3, [], 0, "FORM"];
    _objUnit3 assignAsDriver _obj3;
    _objUnit3 moveInDriver _obj3;

	_cGroup = [_cGroup] call AW_fnc_changeGroupSide;
	_cGroup setGroupIdGlobal ["SIDE-Officer3"];

	sleep 0.1;

	{
		_x call AW_fnc_vehicleCustomizationOpfor;
		_x lock 3;
	} forEach [_obj1,_obj2,_obj3];

	sleep 0.1;

	[(units _aGroup) + (units _bGroup) + (units _cGroup)] call derp_fnc_AISkill;
	[(units _aGroup) + (units _bGroup) + (units _cGroup)] remoteExec ["AW_fnc_addToAllCurators", 2];

//--------------------------------------------------------------------------- ADD ACTION TO OBJECTIVE VEHICLE. NOTE: NEEDS WORK STILL. Good enough for now though.
	//---------- WHICH VEHICLE IS THE OBJECTIVE?
	private _intelObj = selectRandom [_obj1, _obj2, _obj3];

	//---------- OKAY, NOW ADD ACTION TO IT
	[_intelObj] remoteExec ["AW_fnc_addActionGetIntel", 0, true];

//--------------------------------------------------------------------------- CREATE DETECTION TRIGGER ON OBJECTIVE VEHICLE
	sleep 0.1;
	private _targetTrigger = createTrigger ["EmptyDetector", getPos _intelObj];
	_targetTrigger setTriggerArea [500, 500, 0, false];
	_targetTrigger setTriggerActivation ["WEST", "PRESENT", false];
	_targetTrigger setTriggerStatements ["this","",""];
	sleep 0.1;
	_targetTrigger attachTo [_intelObj,[0,0,0]];
	sleep 0.1;

//--------------------------------------------------------------------------- SPAWN GUARDS
    private _vehAmount = [
        nil,    // MBTs
        nil,    // SPAAs
        1,      // IFVs
        1       // MRAPs
    ];

    private _infAmount = [
        (2 + (random 1)),   // Squads
        (1 + (random 1)),   // SF Squads
        1,                  // AA Teams
        1,                  // AT Teams
        nil,                // Snipers
        nil,                // Teams
        nil                 // SF Teams
    ];

    private _enemiesArray = [
        _flatPos,
        "SIDE",
        "#rnd",
        _vehAmount,
        _infAmount,
        25,
        300
    ] call AW_fnc_spawnEnemyUnits;

//--------------------------------------------------------------------------- BRIEFING

	private _fuzzyPos = [_flatPos, 300] call AW_fnc_getFuzzyPos;

	InA_Server_SideMarkers = ["SIDE", "Secure Intel", _fuzzyPos, 300] call AW_fnc_missionMarkersCreate;
	private _sideMarker = (InA_Server_SideMarkers # 0);

    [
        west,
        "secureIntelVicTask",
        [
            "We have reports from locals that sensitive, strategic information is changing hands. This is a target of opportunity! We've marked the position on your map; head over there and secure the intel. It should be stored on one of the vehicles or on their persons.  Do Not Destroy the unarmed vehicles or Officers - for this will compromise the mission.",
            "Side Mission: Secure Intel",
            _sideMarker
        ],
        _fuzzyPos,
        "Created",
        0,
        true,
        "intel",
        true
    ] call BIS_fnc_taskCreate;

	sleep 0.1;

	//----- Reset VARS for loops
	InA_Server_SideMissionUp = true;
	InA_Server_SideMissionSuccess = false;
	InA_Server_SideMissionSpawned = true;

	private _notEscaping = true;
	private _gettingAway = false;
	private _heEscaped = false;

	sleep 0.1;

//-------------------------- [ CORE LOOPS ]

while { InA_Server_SideMissionUp } do {
	sleep 0.1; //to prevent loop from spamming RPT if it bugs out

	//------------------------------------------ IF VEHICLE IS DESTROYED [FAIL]

	if (!alive _intelObj) exitWith {

		sleep 0.1;

		0 = ["secureIntelVicTask", "Failed"] spawn AW_fnc_finishTask;
		InA_Server_SideMissionUp = false;

		sleep 120;

		{ _x call AW_fnc_delete } forEach [_targetTrigger,_objUnit1,_objUnit2,_objUnit3,_obj1,_obj2,_obj3];
		[_enemiesArray] spawn AW_fnc_delete;
	};

	//----------------------------------------- IS THE ENEMY TRYING TO ESCAPE?

	if (_notEscaping) then {

		//---------- NO? then LOOP until YES or an exitWith {}.

		sleep 0.1;

		if (_intelObj call BIS_fnc_enemyDetected) then {

			sleep 0.1;

			private _sideUpdate = "<t align='center'><t size='2.2'>Side-mission update</t><br/>____________________<br/>Target has spotted you and is trying to escape with the intel !</t>";
			[_sideUpdate] remoteExec ["AW_fnc_globalHint",0];

			//---------- WHERE TO / HOW WILL THE OBJECTIVES ESCAPE?

			{
				_escape1WP = _x addWaypoint [getMarkerPos InA_Server_currentAO, 100];
				_escape1WP setWaypointType "MOVE";
				_escape1WP setWaypointBehaviour "CARELESS";
				_escape1WP setWaypointSpeed "FULL";
			} forEach [_aGroup,_bGroup,_cGroup];

			//---------- END THE NOT ESCAPING LOOP

			_notEscaping = false;

			sleep 0.1;

			//---------- SET GETTING AWAY TO TRUE TO DETECT IF HE'S ESCAPED.

			_gettingAway = true;
		};
	};

	//-------------------------------------------- THE ENEMY IS TRYING TO ESCAPE

	if (_gettingAway) then {

		sleep 0.1;

		//_targetTrigger attachTo [_intelObj,[0,0,0]];

		if (count list _targetTrigger < 1) then {

			sleep 0.1;

			_heEscaped = true;

			sleep 0.1;

			_gettingAway = false;
		};
	};

	//------------------------------------------- THE ENEMY ESCAPED [FAIL]

	if (_heEscaped) exitWith {};

	//-------------------------------------------- THE INTEL WAS RECOVERED [SUCCESS]

	if (InA_Server_SideMissionSuccess) exitWith {
		//---------- REMOVE 'GET INTEL' ACTION
		[_intelObj] remoteExec ["removeAllActions", 0, _intelObj];
	};
	//-------------------- END LOOP
};

if (InA_Server_SideMissionSuccess) then {
    0 = ["secureIntelVicTask"] spawn AW_fnc_finishTask;
    sleep 5;

    InA_Server_SideMissionUp = false;
    [nil, _flatPos] call AW_fnc_SMhintSUCCESS;
} else {
    0 = ["secureIntelVicTask", "Failed"] spawn AW_fnc_finishTask;
};

InA_Server_SideMissionUp = false;

[InA_Server_SideMarkers] call AW_fnc_missionMarkersRemove;

sleep 120;

{ _x call AW_fnc_delete } forEach [_targetTrigger,_objUnit1,_objUnit2,_objUnit3,_obj1,_obj2,_obj3];
[_enemiesArray] spawn AW_fnc_delete;
