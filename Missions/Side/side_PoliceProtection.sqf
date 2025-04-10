/*
Author: BACONMOP
side mission defend police

Last modified:  13/11/2017 by McKillen
	
modified:   general tweaks
*/

private ["_BluforUnits","_OpforFaction","_OpforUnits"];

// Find Location --------------------------
private _findSmPosResult = ["town", ["NameCity","NameCityCapital"]] call AW_fnc_findSideMissionPos;
_findSmPosResult params ["_smPosFound", "_smPos"];

if (!_smPosFound) exitWith {
    ["Error finding a location for Sidemission: 'PoliceProtection'!", "SIDE"] call AW_fnc_log;
};

private _flatPos = [_smPos, 1, 250, 2, 0, 20, 0] call BIS_fnc_findSafePos;

//----------------------select random stuff---------------------
//Blufor units
private _BluforFaction = selectRandom ["FIA","Gendarmerie"];
switch (_BluforFaction) do {
	case "FIA":{
	_BluforUnits = ["B_G_Soldier_F","B_G_Soldier_lite_F","B_G_Soldier_TL_F","B_G_Soldier_AR_F",
	"B_G_medic_F","B_G_Soldier_M_F","B_G_officer_F"];
	};
	case "Gendarmerie":{
	_BluforUnits = ["B_GEN_Commander_F","B_GEN_Soldier_F","B_GEN_Soldier_F","B_GEN_Soldier_F",
	"B_GEN_Soldier_F","B_GEN_Soldier_F"];
	};
};

//enemy units (opfor or indep)
private _OpforSide = selectRandom [east,independent];

switch (_OpforSide) do {
	case independent:{
	_OpforFaction = selectRandom ["IND_C_F","IND_F"];
	};
	case east:{
	_OpforFaction = selectRandom ["OPF_F","OPF_U_F"];
	};
};

switch (_OpforFaction) do {
	case "IND_C_F":{
	_OpforUnits = ["I_C_Soldier_Para_1_F","I_C_Soldier_Para_2_F","I_C_Soldier_Para_3_F","I_C_Soldier_Para_5_F","I_C_Soldier_Bandit_2_F",
	"I_C_Soldier_Para_4_F","I_C_Soldier_Para_6_F","I_C_Soldier_Para_7_F","I_C_Soldier_Bandit_1_F","I_C_Soldier_Bandit_3_F",
	"I_C_Soldier_Bandit_4_F","I_C_Soldier_Bandit_5_F","I_C_Soldier_Bandit_6_F"];
	};
	case "IND_F":{
	_OpforUnits = ["I_soldier_F","I_soldier_F","I_soldier_F","I_Soldier_lite_F","I_Soldier_GL_F",
	"I_Soldier_AR_F","I_Soldier_TL_F","I_Soldier_M_F","I_medic_F","I_soldier_F","I_Soldier_AT_F","I_Soldier_LAT_F","I_Soldier_AA_F"];
	};
	case "OPF_F":{
	_OpforUnits = ["O_Soldier_F","O_Soldier_F","O_Soldier_F","O_officer_F","O_Soldier_lite_F","O_Soldier_LAT_F","O_Soldier_AT_F",
	"O_Soldier_GL_F","O_Soldier_AR_F","O_soldier_M_F","O_medic_F","O_HeavyGunner_F","O_Sharpshooter_F","O_Soldier_AA_F"];
	};
	case "OPF_U_F":{
	_OpforUnits = ["O_soldierU_F","O_soldierU_AR_F","O_soldierU_TL_F","O_soldierU_medic_F","O_soldierU_LAT_F","O_soldierU_AT_F","O_soldierU_AA_F",
	"O_soldierU_M_F","O_SoldierU_GL_F","O_Urban_Sharpshooter_F","O_Urban_HeavyGunner_F","O_soldierU_F","O_soldierU_F"];
	};
};

// Police Creation -----------------------
private _squadSize = 3 + random 6;
private _BluforGroup = createGroup west;

for "_i" from 0 to _squadSize do {
	private _policeUnit = _BluforGroup createUnit [selectRandom _BluforUnits, _flatPos, [], 0, "FORM"];
	_policeUnit addMPEventHandler ["MPKilled", {
		params ["_unit", "_killer", "_instigator", "_useEffects"];

        if (!isServer) exitWith {};

		private _BluforKilled = "";

		if (isPlayer _killer) then {
			_BluforKilled = format ["<t align='center'><t size='2.2'>Side Mission update</t><br/>____________________<br/>%1 just killed one of the BLUFOR units.  You're supposed to be saving them, not killing!</t>", name _killer];
			["You just killed one of the friendly units you were supposed to save!"] remoteExec ["hintC", _killer];
		} else {
			_BluforKilled = format["<t align='center'><t size='2.2'>Side Mission update</t><br/>____________________<br/>One of the BLUFOR units just died.  Go save the remaining ones!</t>"];
		};

		[_BluforKilled] remoteExec ["AW_fnc_globalHint", 0];
	}];
	sleep 0.1;
};

[_BluforGroup, _smPos, nil, 150] call AW_fnc_taskRndPatrol;
_BluforGroup setGroupIdGlobal ["SIDE-Protectee-Group"];

[(units _BluforGroup), 20] call derp_fnc_AISkill;
[(units _BluforGroup)] remoteExec ["AW_fnc_addToAllCurators", 2];

[_BluforGroup] spawn AW_fnc_transferGroupHC;

// Briefing ----------------------------
private _taskDesc = "";
private _taskName = "";

switch (_BluforFaction) do{
    case "FIA": {
        _taskName = "Protect FIA Forces";
        _taskDesc = "Undercover agents have provided Intel that hostile forces are planning to attack a squad of allied FIA forces. We have their approximate location, so get over there and protect them.";
    };

    case "Gendarmerie": {
        _taskName = "Protect U.N. Police Forces";
        _taskDesc = "Undercover agents have provided Intel that hostile forces are planning to attack a U.N. Police Force. We have the approximate location the police force. Get over there and protect the police.";
    };
};

InA_Server_SideMarkers = ["SIDE", _taskName, _smPos, 300] call AW_fnc_missionMarkersCreate;
private _sideMarker = (InA_Server_SideMarkers # 0);

[
    west,
    "policeTask",
    [
        _taskDesc,
        (format ["Side Mission: %1", _taskName]),
        _sideMarker
    ],
    _smPos,
    "Created",
    0,
    true,
    "defend",
    true
] call BIS_fnc_taskCreate;


//Mission config
InA_Server_SideMissionUp = true;
InA_Server_SideMissionSuccess = false;
InA_Server_SideMissionSpawned = true;


// Give players time to get there -------
sleep 180;
private _EnemyOnTheMove = format["<t align='center'><t size='2.2'>Side Mission update</t><br/>____________________<br/>Intel suggest that hostile forces are mobilizing!</t>"];
[_EnemyOnTheMove] remoteExec ["AW_fnc_globalHint",0];


// Enemy Creation -----------------------
private _opForAttackos = [_flatPos, 750, 1250, 2, 0, 20, 0] call BIS_fnc_findSafePos;

private _opForGrp2Pos = [_opForAttackos, 5, 50, 2, 0, 20, 0] call BIS_fnc_findSafePos;
private _opForGrp3Pos = [_opForAttackos, 5, 50, 2, 0, 20, 0] call BIS_fnc_findSafePos;
private _opForGrp4Pos = [_opForAttackos, 5, 50, 2, 0, 20, 0] call BIS_fnc_findSafePos;

private _grp2 = createGroup _OpforSide;
for "_i" from 0 to 7 do {
	_opForUnit = _grp2 createUnit [selectRandom _OpforUnits, _opForGrp2Pos, [], 0, "FORM"];
	_opForUnit disableAI "FSM";
	sleep 0.1;
};
[_grp2,_smPos] call BIS_fnc_taskAttack;

private _grp3 = createGroup _OpforSide;
for "_i" from 0 to 7 do {
	_opForUnit = _grp3 createUnit [selectRandom _OpforUnits, _opForGrp3Pos, [], 0, "FORM"];
	_opForUnit disableAI "FSM";
	sleep 0.1;
};
[_grp3,_smPos] call BIS_fnc_taskAttack;

private _grp4 = createGroup _OpforSide;
for "_i" from 0 to 7 do {
	_opForUnit = _grp4 createUnit [selectRandom _OpforUnits, _opForGrp4Pos, [], 0, "FORM"];
	_opForUnit disableAI "FSM";
	sleep 0.1;
};
[_grp4,_smPos] call BIS_fnc_taskAttack;

{
    _x setGroupIdGlobal [format ["SIDE-Attacker-Group%1", (_forEachIndex + 1)]];
    [_x] spawn AW_fnc_transferGroupHC;
} forEach [_grp2, _grp3, _grp4];

private _enemiesArray = units _grp2 + units _grp3 + units _grp4;
[_enemiesArray] call derp_fnc_AISkill;
[_enemiesArray] remoteExec ["AW_fnc_addToAllCurators", 2];


// Wait for one side to be dead -----------
waitUntil {
    sleep 5;

    (
        (!InA_Server_SideMissionUp) || (({alive _x} count (units _BluforGroup)) < 1) || (
            (({alive _x} count (units _grp2)) < 1) &&
            (({alive _x} count (units _grp3)) < 1) &&
            (({alive _x} count (units _grp4)) < 1)
        )
    )
};

{ _x allowDamage false; } forEach units _BluforGroup;

// Debrief --------------------------------
switch (true) do {
    case (({alive _x} count (units _BluforGroup)) < 1): {
        private _BluforKilled = format["<t align='center'><t size='2.2'>Side Mission failed</t><br/>____________________<br/>All allied units died.</t>"];
        [_BluforKilled] remoteExec ["AW_fnc_globalHint",0];
        0 = ["policeTask", "Failed"] spawn AW_fnc_finishTask;
        InA_Server_SideMissionSuccess = false;
    };

    case (!InA_Server_SideMissionUp): {
        0 = ["policeTask", "Failed"] spawn AW_fnc_finishTask;
        InA_Server_SideMissionSuccess = false;
    };

    case (
          (({alive _x} count (units _grp2)) < 1) &&
          (({alive _x} count (units _grp3)) < 1) &&
          (({alive _x} count (units _grp4)) < 1)
          ): {
        [nil, _flatPos] call AW_fnc_SMhintSUCCESS;
        0 = ["policeTask"] spawn AW_fnc_finishTask;
    };
    default {
        /*I don't know what happened, let's just do nothing and let the mission quitly delete*/
    };
};

// Deletion --------------------------------
sleep 5;

[InA_Server_SideMarkers] call AW_fnc_missionMarkersRemove;

sleep 120;
private _todelete = (units _BluforGroup) + _enemiesArray;
[_todelete] spawn AW_fnc_delete;
