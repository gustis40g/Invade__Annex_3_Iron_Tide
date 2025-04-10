/*
    author: stanhope
    Idea proved by Tales
    Code from other I&A side mission has been copy pasted in.
    description: Rebels have set up a camp.  Find it and raze it to the ground.
*/

//-------------------- FIND SAFE POSITION FOR MISSION
private _findSmPosResult = ["safePos",[nil, nil, 10, 0.2]] call AW_fnc_findSideMissionPos;
if (!(_findSmPosResult select 0)) exitWith {};
private _flatPos = _findSmPosResult select 1;

//================Create camp
private _tentsarray = [];
private _spawnedUnits = [];
private _campObjs = [_flatPos, 0, AW_OPFOR_side_militiaCamp] call BIS_fnc_objectsMapper;
{
    private _pos = getPosATL _x;
    _pos set [2, 0];
    _x setPosATL _pos;
    _x setVectorUp surfaceNormal _pos;

    if (!(_x isKindOf "Land_TentDome_F")) then {continue;};
    _x allowDamage false;
    _tentsarray pushBack _x;
} forEach _campObjs;

//===============create militia
private _groupsArray = [];

private _enemyFactions = (InA_EnemyFactionHash get "#guer_factions");
private _enemyFaction = (selectRandom _enemyFactions);
private _enemyFactionHash = (InA_FactionMappings get _enemyFaction);

//infantry
for "_i" from 1 to 5 do {
    private _rng = 25 + random 275;
    private _randomPos = [_flatPos, 0 , _rng, 5, 0, 0.4, 0, [], _flatPos] call BIS_fnc_findSafePos;
    private _squadType = ["#squads", _enemyFactionHash] call AW_fnc_getUnitsFromHash;
    private _grp = [_squadType, _randomPos] call AW_fnc_spawnAIGroup;
    [_grp, _flatPos, nil, _rng] call AW_fnc_taskCircPatrol;
    _grp setGroupIdGlobal [format ["SIDE-Inf-Group%1", _i]];
	_spawnedUnits = _spawnedUnits + units _grp;
	_groupsArray = _groupsArray + [_grp];

    [_grp] spawn AW_fnc_transferGroupHC;
};

//vehicles
for "_i" from 1 to 4 do {
	private _randomPos = [_flatPos, 5, 350, 2, 0, 20, 0] call BIS_fnc_findSafePos;
    private _grp = createGroup east;
    _grp setGroupIdGlobal [format ["SIDE-Veh%1", _i]];
    private _vehicletype = selectRandom AW_OPFOR_side_militiaCamp_vehicles;
    private _veh =  _vehicletype createVehicle _randompos;
    _veh allowCrewInImmobile [true, true];
    _veh lock 2;
    switch (_vehicletype) do {
        case "vn_o_wheeled_btr40_mg_02";
        case "rhsgref_cdf_reg_uaz_dshkm":{
            createVehicleCrew _veh;
            (crew _veh) join _grp;
            private _rng = 25 + random 275;
            [_grp, _flatPos, nil, _rng] call AW_fnc_taskCircPatrol;
            _grp setSpeedMode "LIMITED";
        };
        case "vn_o_nva_65_static_dshkm_high_02";
        case "rhs_Kornet_9M133_2_msv";
        case "rhsgref_cdf_Igla_AA_pod":{
            private _unitType = (["#riflemen", _enemyFactionHash] call AW_fnc_getUnitsFromHash);
            private _grpMember = _grp createUnit [_unitType, _flatpos, [], 0, "FORM"];
            _grpMember assignAsGunner _veh;
            _grpMember moveInGunner _veh;
            _veh setDir (random 360);
        };
    };
	_groupsArray append [_grp];
	_spawnedUnits append ((units _grp) + [_veh]);

    [_grp] spawn AW_fnc_transferGroupHC;
};

[_spawnedUnits] spawn AW_fnc_addToAllCurators;
[_spawnedUnits] call derp_fnc_AISkill;

_spawnedUnits = _spawnedUnits + _campObjs;

//----------------task/circle/....
private _fuzzyPos = [_flatPos, 300] call AW_fnc_getFuzzyPos;

InA_Server_SideMarkers = ["SIDE", "Militia camp", _fuzzyPos, 300] call AW_fnc_missionMarkersCreate;
private _sideMarker = (InA_Server_SideMarkers # 0);

[
    west,
    "MilitiaCampTask",
    [
        "Intel suggest that hostile milita forces have set up camp somewhere around here.  Move in, kill all the hostiles and then raze their camp to the ground.  High flying drones captured this image of their camp: <br/><br/><img image='Media\Briefing\campSite.jpg' width='300' height='150'/>",
        "Side Mission: Militia camp",
        _sideMarker
    ],
    _fuzzyPos,
    "Created",
    0,
    true,
    "search",
    true
] call BIS_fnc_taskCreate;

//============core loop============
InA_Server_SideMissionSuccess = false;
InA_Server_SideMissionUp = true;
InA_Server_SideMissionSpawned = true;


while {InA_Server_SideMissionUp} do {
    private _enemiesCount = 0;
    {
        _enemiesCount = _enemiesCount + ({ alive _x && {((_x distance2D _flatPos) < 500)} } count (units _x));
    } forEach _groupsArray;

    if (_enemiesCount < 5) exitWith {break};

    sleep 5;
};

if (InA_Server_SideMissionUp) then {
    {_x allowDamage true;} forEach _tentsarray;
    private _targetStartText = format["<t align='center' size='2.2'>Side mission update</t><br/>____________________<br/>Most enemy units are dead now.  Go raze that camp to the ground"];
    [_targetStartText] remoteExec ["AW_fnc_globalHint",0];

    private _tent = (selectRandom _tentsarray);

    [
        _tent,
        "Plant charges",
        "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\destroy_ca.paa",
        "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\use_ca.paa",
        "_target distance _this <= 5",
        "_target distance _this <= 5",
        {
            hint "Planting charges ...";
            params ["","_hero"];
            if ( currentWeapon _hero != "" ) then {
                _hero action ["SwitchWeapon", _hero, _hero, 99];
            };

            _hero playMoveNow "AinvPknlMstpSnonWnonDnon_medic3";
        },
        {},
        {
            params ["_target", "_caller", "_actionId", "_arguments"];

            ["InA_Event_SideChargePlanted", [_target, _caller]] remoteExec ["AW_fnc_eventTrigger", 2];
        },
        {
            hint "You stopped planting charges.";
            private _unit = _this select 1;
            _unit playMoveNow "";
        },
        [],
        8,
        0,
        true,
        false
    ] remoteExecCall ["BIS_fnc_holdActionAdd", 0, true];
};

// Register planting event
["InA_Event_SideChargePlanted", {
    params ["_event", "_args"];

    _args params ["_tent", "_planter"];

    private _sidecompleted = format ["<t align='center'><t size='2.2'>Side-mission update</t><br/>____________________<br/>%1 planted charges on the objective.  Clear the area, detonation in 30 seconds!</t>", (name _planter)];
    [_sidecompleted] remoteExec ["AW_fnc_globalHint", 0];

    private _pos = (getPos _tent);

    [_pos] spawn {
        params ["_pos"];
        sleep 30;
        "Bo_GBU12_LGB" createVehicle (_pos getPos [0,0]);
        sleep 0.2;
        "Bo_GBU12_LGB" createVehicle (_pos getPos [1.5,0]);
        sleep 0.2;
        "Bo_GBU12_LGB" createVehicle (_pos getPos [1.5,90]);
        sleep 0.2;
        "Bo_GBU12_LGB" createVehicle (_pos getPos [1.5,180]);
        sleep 0.2;
        "Bo_GBU12_LGB" createVehicle (_pos getPos [1.5,270]);
    };
}] call AW_fnc_eventRegister;


while {!InA_Server_SideMissionSuccess} do {
    if (!InA_Server_SideMissionUp) then {break};

    sleep 3;

    if (({alive _x} count _tentsarray) > 0) then {continue};

    InA_Server_SideMissionSuccess = true;
    InA_Server_SideMissionUp = false;
};

["InA_Event_SideChargePlanted"] call AW_fnc_eventUnregister;

if (InA_Server_SideMissionSuccess) then {
    0 = ["MilitiaCampTask"] spawn AW_fnc_finishTask;
    sleep 5;
    [nil, _flatPos] call AW_fnc_SMhintSUCCESS;
} else {
    0 = ["MilitiaCampTask", "Failed"] spawn AW_fnc_finishTask;
};

InA_Server_SideMissionUp = false;

[InA_Server_SideMarkers] call AW_fnc_missionMarkersRemove;

sleep 120;
[_spawnedUnits] spawn AW_fnc_delete;
