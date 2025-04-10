/*
author: stanhope
Idea proved by chutnut & Eagle-eye
Code from other I&A side mission has been copy pasted in

description:  Vipers are sitting on some intel.  It's hidden somewhere in an area.  Find and secure it.
*/

private _flatPos = [nil, nil, 15] call AW_fnc_findSafePos;

//----------spawn intel, tent
private _tent = "Land_IRMaskingCover_01_F" createVehicle _flatPos;
_tent allowDamage false;
_tent enableSimulation false;

private _intellobj = "Land_TripodScreen_01_large_F" createVehicle _flatPos;

_intellobj addEventHandler ["Killed",{
	params ["_unit","","_killer"];
	_name = name _killer;
	if (_name == "Error: No vehicle") then{
	    _name = "Someone";
	};
	_targetStartText = format["<t align='center' size='2.2'>Sub-Objective</t><br/><t size='1.5' align='center' color='#FFCF11'>Intel Destroyed</t><br/>____________________<br/>%1 destroyed the Intel, mission failed.",_name];
	[_targetStartText] remoteExec ["AW_fnc_globalHint",0];
}];

[_intellobj,"Secure intel",
"\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\documents_ca.paa",
"\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\download_ca.paa",
"_target distance _this <= 4","_target distance _this <= 4",
{
    hint "Downloading Intel...";
    params ["","_hero"];
    if ( currentWeapon _hero != "" ) then
    {	_hero action ["SwitchWeapon", _hero, _hero, 99]; };
    _hero playMoveNow "AinvPknlMstpSnonWnonDnon_medic3";
},{},{
    params ["_target", "_caller"];
    private _sidecompleted = format["<t align='center'><t size='2.2'>Side-mission update</t><br/>____________________<br/>%1 recovered the intel.</t>",name _caller];
    [_sidecompleted] remoteExec ["AW_fnc_globalHint",0];

    ["InA_Event_SideMissionSuccess"] remoteExecCall ["AW_fnc_eventTrigger", 2];

    _target call AW_fnc_delete;
},{
    hint "You stop downloading the intel.";
    private _unit = _this select 1;
    _unit playMoveNow "";
},[],
8, 0,true,false] remoteExecCall ["BIS_fnc_holdActionAdd", 0, true];

sideObj = _intellobj;


//-----spawn force protection
private _vehAmount = [
    1,                  // MBTs
    (1 + (random 1)),   // SPAAs
    1,                  // IFVs
    1                   // MRAPs
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

private _enemiesArray = [
    _flatPos,
    "SIDE",
    "#rnd",
    _vehAmount,
    _infAmount,
    25,
    400
] call AW_fnc_spawnEnemyUnits;


//-----spawn viper protection:
private _vipergroupPos = [_intellobj, 5, 50, 2, 0, 20, 0] call BIS_fnc_findSafePos;

private _vipergroup = createGroup InA_EnemyFactionSide;

for "_i" from 1 to 8 do {

	private _unittype = selectRandom ["rhs_vdv_recon_rifleman","rhs_vdv_recon_sergeant","rhs_vdv_recon_rifleman_asval","rhs_vdv_recon_medic","rhs_vdv_recon_marksman","rhs_vdv_recon_rifleman_lat","rhs_vdv_recon_efreitor"];
	private _unit = _vipergroup createUnit [_unittype, _vipergroupPos, [], 5, "NONE"];
};

_vipergroup = [_vipergroup] call AW_fnc_changeGroupSide;
_vipergroup setGroupIdGlobal ["SIDE-Inf-Vipers"];

[_vipergroup, _flatPos, nil, 50] call AW_fnc_taskRndPatrol;
[(units _vipergroup), 30] call derp_fnc_AISkill;
[(units _vipergroup)] remoteExec ["AW_fnc_addToAllCurators", 2];

[_vipergroup] spawn AW_fnc_transferGroupHC;

_enemiesArray = _enemiesArray + units _vipergroup;

//----------------task/circle/....
    private _fuzzyPos = [_flatPos, 300] call AW_fnc_getFuzzyPos;

    InA_Server_SideMarkers = ["SIDE", "Capture Intel", _fuzzyPos, 300] call AW_fnc_missionMarkersCreate;
    private _sideMarker = (InA_Server_SideMarkers # 0);

    [
        west,
        "ViperIntellTask",
        [
            "We've spotted an enemy viper team with a significant force protection around them.  They must be sitting on some valuable intel.  Go get this intel.  Our intel suggests that the objective will look like this: <img image='Media\Briefing\viperIntel.jpg' width='300' height='150'/>",
            "Side Mission: Capture Intel",
            _sideMarker
        ],
        _fuzzyPos,
        "Created",
        0,
        true,
        "search",
        true
    ] call BIS_fnc_taskCreate;

//==============mission core==============
InA_Server_SideMissionUp = true;
InA_Server_SideMissionSuccess = false;
InA_Server_SideMissionSpawned = true;

waitUntil {
    sleep 5;
    ((!alive _intellobj) || InA_Server_SideMissionSuccess  || !InA_Server_SideMissionUp)
};

if (InA_Server_SideMissionSuccess) then {
    0 = ["ViperIntellTask"] spawn AW_fnc_finishTask;
    [nil, _flatPos] call AW_fnc_SMhintSUCCESS;
    InA_Server_SideMissionUp = false;
} else {
    if (!alive _intellobj || !InA_Server_SideMissionUp) then {
        0 = ["ViperIntellTask", "Failed"] spawn AW_fnc_finishTask;
        InA_Server_SideMissionUp = false;
        InA_Server_SideMissionSuccess = false;
    };
};

sleep 5;

[InA_Server_SideMarkers] call AW_fnc_missionMarkersRemove;

sleep 120;
{ _x call AW_fnc_delete } forEach [_tent, _intellobj];
[_enemiesArray] spawn AW_fnc_delete;
