/*
Author: BACONMOP
Description: Destroy a prototype Tank

Last modified: 16/10/2017 by stanhope
modified: Fixed cleanup not working
*/

// Get Location for Sidemission -----------------
private _flatPos = [nil, nil, 15, 0.2] call AW_fnc_findSafePos;

// Create Objective Tank ------------------------
private _grp1 = createGroup InA_EnemyFactionSide;
_grp1 setGroupIdGlobal [format ["SIDE-ProtoTank"]];

private _protoTank = createVehicle ["rhs_t90sm_tv", _flatPos,[],0,"NONE"];

_protoTank call AW_fnc_vehicleCustomizationOpfor;

_protoTank lock 3;
_protoTank allowCrewInImmobile [true, true];
[_protoTank,_grp1] call BIS_fnc_spawnCrew;
[_grp1, _flatPos, nil, 200] call AW_fnc_taskRndPatrol;

[(units _grp1)] call derp_fnc_AISkill;
[(crew _protoTank)+ [_protoTank]] remoteExec ["AW_fnc_addToAllCurators", 2];

//Remove current weapons
{_protoTank removeMagazine _x} forEach ["24Rnd_125mm_APFSDS_T_Green", "12Rnd_125mm_HE_T_Green", "12Rnd_125mm_HEAT_T_Green"];
{_protoTank removeWeapon _x} forEach ["rhs_weap_2a46m_5", "rhs_weap_pkt"];
//Add new weapons
{_protoTank addWeapon _x} forEach ["Gatling_30mm_Plane_CAS_01_F","Missile_AGM_02_Plane_CAS_01_F","Rocket_04_HE_Plane_CAS_01_F"];
{_protoTank addMagazine _x} forEach ["1000Rnd_Gatling_30mm_Plane_CAS_01_F","1000Rnd_Gatling_30mm_Plane_CAS_01_F","6Rnd_Missile_AGM_02_F","7Rnd_Rocket_04_HE_F","7Rnd_Rocket_04_HE_F","7Rnd_Rocket_04_HE_F","6Rnd_Missile_AGM_02_F"];

_protoTank setVariable ["selections", []];
_protoTank setVariable ["gethit", []];
_protoTank addEventHandler
	[
		"HandleDamage",
		{
			private _unit = _this select 0;
			private _selections = _unit getVariable ["selections", []];
			private _gethit = _unit getVariable ["gethit", []];
			private _selection = _this select 1;
			if !(_selection in _selections) then
			{
				_selections set [count _selections, _selection];
				_gethit set [count _gethit, 0];
			};
			_i = _selections find _selection;
			_olddamage = _gethit select _i;
			_damage = _olddamage + ((_this select 2) - _olddamage) * 0.25;
			_gethit set [_i, _damage];
			_damage;
		}
	];

// Spawn SM Forces --------------------------------
private _vehAmount = [
    1,                  // MBTs
    (1 + (random 1)),   // SPAAs
    (1 + (random 1)),   // IFVs
    (1 + (random 1))    // MRAPs
];

private _infAmount = [
    (2 + (random 1)),   // Squads
    nil,                // SF Squads
    (1 + (random 1)),   // AA Teams
    (1 + (random 1)),   // AT Teams
    nil,                // Snipers
    (1 + (random 1)),   // Teams
    nil                 // SF Teams
];

private _smUnits = [
    _flatPos,
    "SIDE",
    "#rnd",
    _vehAmount,
    _infAmount,
    25,
    400
] call AW_fnc_spawnEnemyUnits;

_smUnits = _smUnits + units _grp1;

// Briefing and Markers ---------------------------
private _fuzzyPos = [_flatPos, 300] call AW_fnc_getFuzzyPos;

InA_Server_SideMarkers = ["SIDE", "Prototype Tank", _fuzzyPos, 300] call AW_fnc_missionMarkersCreate;
private _sideMarker = (InA_Server_SideMarkers # 0);

[
    west,
    "tankTask",
    [
        "We have gotten reports that OpFor have sent a prototype tank to their allies for a field test. Get over there and destroy that thing. Be careful, our operatives have said that has much more armor than standard and carries a wide array of powerful weapons.",
        "Side Mission: Prototype Tank",
        _sideMarker
    ],
    _fuzzyPos,
    "Created",
    0,
    true,
    "destroy",
    true
] call BIS_fnc_taskCreate;

// WaitUntil Tank is dead -------------------------
InA_Server_SideMissionUp = true;
InA_Server_SideMissionSuccess = false;
InA_Server_SideMissionSpawned = true;

waitUntil {
    sleep 5;
    ((!alive _protoTank) || !InA_Server_SideMissionUp)
};

if (!alive _protoTank) then {
    InA_Server_SideMissionSuccess = true;
    InA_Server_SideMissionUp = false;
};

// Debrief ----------------------------------------
if (InA_Server_SideMissionSuccess) then {
    0 = ["tankTask"] spawn AW_fnc_finishTask;
    [nil, _flatPos] call AW_fnc_SMhintSUCCESS;
    InA_Server_SideMissionUp = false;
} else {
    0 = ["tankTask", "Failed"] spawn AW_fnc_finishTask;
};

[InA_Server_SideMarkers] call AW_fnc_missionMarkersRemove;

sleep 120;
{ _x call AW_fnc_delete; sleep 0.1; } forEach _smUnits;
