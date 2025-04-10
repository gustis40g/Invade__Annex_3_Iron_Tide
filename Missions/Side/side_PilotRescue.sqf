/*
Author: stanhope, AW-community member
bassed off of existing AW created side missions
Description: mission in which players have to find and heal a crashed helipilot before he dies.
Bleedouttimer starts running when player get's within 3.5km of the obj.
*/

private _bleedOutTimer = 900; //time before the pilot dies
private _triggerRange = 3500; //if players get within this radius the bleedouttimer starts running

//-------------------- FIND SAFE POSITION FOR heliwreck
private _findSmPosResult = ["safePos",[nil, nil, 15, 0.2]] call AW_fnc_findSideMissionPos;
if (!(_findSmPosResult select 0)) exitWith {};
private _flatPos = _findSmPosResult select 1;

// Heli-wreck Creation -----------------------
	sideObj = AW_OPFOR_side_rescuePilot_wreckType createVehicle _flatPos;
	waitUntil {sleep 0.1; alive sideObj};
	sideObj setDir 88.370;
	sideObj setVectorUp surfaceNormal position sideObj;
	
//Pilot Creation -----------------------
private _pilot = "C_man_pilot_F" createVehicle [(getPos sideObj select 0)+4, (getPos sideObj select 1)-4, ((getPos sideObj select 2))];
_pilot setVectorUp surfaceNormal position _pilot;
_pilot setDir 88.370;

removeAllWeapons _pilot;
removeAllItems _pilot;
removeAllAssignedItems _pilot;
removeUniform _pilot;
removeVest _pilot;
removeBackpack _pilot;
removeHeadgear _pilot;
removeGoggles _pilot;
_pilot forceAddUniform (AW_OPFOR_side_rescuePilot_pilotUniformVestHelmet select 0);
_pilot addVest (AW_OPFOR_side_rescuePilot_pilotUniformVestHelmet select 1);
_pilot addHeadgear (AW_OPFOR_side_rescuePilot_pilotUniformVestHelmet select 2);
_pilot allowDamage false;
[_pilot, "Acts_LyingWounded_loop"] remoteExec ["switchMove", 0, _pilot];

[_pilot,"Rescue pilot",
"\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\help_ca.paa",
"\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\heal_ca.paa",
"_target distance _this <= 4","_target distance _this <= 4",
{hint "Performing First Aid ....";
private _unit = _this select 1;
if ( currentWeapon _unit != "" ) then
{	_unit action ["SwitchWeapon", _unit, _unit, 99]; };
_unit playMoveNow "AinvPknlMstpSnonWnonDnon_medic3";

},{},{
    params ["_target", "_caller", "_actionId", "_arguments"];
    private _sidecompleted = format["<t align='center'><t size='2.2'>Side-mission update</t><br/>____________________<br/>%1 healed the pilot.  Good job everyone.</t>", (name _caller)];
    [_sidecompleted] remoteExec ["AW_fnc_globalHint",0];
    sleep 4;

    ["InA_Event_SideMissionSuccess"] remoteExecCall ["AW_fnc_eventTrigger", 2];
},
{hint "You stopped performing first aid";
private _unit = _this select 1;
_unit playMoveNow "";
},[],10, 0,true,false] remoteExecCall ["BIS_fnc_holdActionAdd", 0, true];

// Spawn enemy forces--------------------------------------
private _vehAmount = [
    nil,                    // MBTs
    (1 + (random 1)),       // SPAAs
    (1 + (random 1)),       // IFVs
    (selectRandom [0, 1])   // MRAPs
];

private _infAmount = [
    (2 + (random 1)),   // Squads
    nil,                // SF Squads
    1,                  // AA Teams
    1,                  // AT Teams
    (1 + (random 1)),   // Snipers
    nil,                // Teams
    (2 + (random 1))    // SF Teams
];

private _enemiesArray = [
    _flatPos,
    "SIDE",
    "#circ",
    _vehAmount,
    _infAmount,
    25,
    400
] call AW_fnc_spawnEnemyUnits;

// Briefing ------------------------------------------------
private _fuzzyPos = [_flatPos, 300] call AW_fnc_getFuzzyPos;

InA_Server_SideMarkers = ["SIDE", "Search and Rescue", _fuzzyPos, 300] call AW_fnc_missionMarkersCreate;
private _sideMarker = (InA_Server_SideMarkers # 0);

[
    west,
    "rescueTask",
    [
        "We received a distress call from a friendly helicopter pilot but the call was cut short. We believe the enemy has shot his heli down, your job is to find and rescue the pilots.  We have reasons to believe that at least 1 pilot survived. Be careful when approaching the search area we expect heavy AA.",
        "Side Mission: Search and Rescue",
        _sideMarker
    ],
    _fuzzyPos,
    "Created",
    0,
    true,
    "heal",
    true
] call BIS_fnc_taskCreate;

//mission core
InA_Server_SideMissionUp = true;
InA_Server_SideMissionSuccess = false;
InA_Server_SideMissionSpawned = true;


//First wait till there are enough players near
while {InA_Server_SideMissionUp} do {	

	private _numPlayersnear = 0;
    {	if ((_x distance _flatPos) < _triggerRange) then {
            _numPlayersnear = _numPlayersnear + 1;
			sleep 0.1;
        };
    } forEach allPlayers;

	if (_numPlayersnear > 0) exitWith{};
    if (!alive _pilot) exitWith{};
	sleep 10;
};
sleep 1;

while {InA_Server_SideMissionUp} do {
	if (InA_Server_SideMissionSuccess) exitWith {

		//-------------------- DE-BRIEFING
		[nil, _flatPos] call AW_fnc_SMhintSUCCESS;
        0 = ["rescueTask"] spawn AW_fnc_finishTask;
		InA_Server_SideMissionUp = false;
	};
	
	if ((_bleedOutTimer <= 0) || (!alive _pilot) || !InA_Server_SideMissionUp) exitWith {
		//-------------------- DE-BRIEFING
        0 = ["rescueTask", "Failed"] spawn AW_fnc_finishTask;
		InA_Server_SideMissionUp = false;
	};
	
	_bleedOutTimer = _bleedOutTimer -5;
    sleep 5;
};

_pilot call AW_fnc_delete;
sleep 5;

[InA_Server_SideMarkers] call AW_fnc_missionMarkersRemove;

//-------------------- DELETE
sleep 120;
sideObj call AW_fnc_delete;
[_enemiesArray] spawn AW_fnc_delete;
