/*
Author: stanhope, AW-community member,
bassed off of existing side missions created by and for AW.

Description: Players have to rescue IDAP people that have been captured by enemy forces.  If more than 1 of the 4 IDAP people die the mission fails.

Last modified: 26/09/2017 by stanhope
	
modified: fixed some stuff with the help of Ryko
*/

//config
civsFreed = 0;
civsKilled = 0;

private _spawnedUnits = [];
private _groupsArray = [];  
private _guerFaction = (selectRandom (InA_EnemyFactionHash get "#guer_factions"));

private _guerFactionHash = (InA_FactionMappings get _guerFaction);

private _hostageTypes = [
    "C_IDAP_Man_AidWorker_01_F",
    "C_IDAP_Man_AidWorker_02_F",
    "C_IDAP_Man_AidWorker_07_F",
    "C_IDAP_Man_AidWorker_08_F",
    "C_IDAP_Man_AidWorker_09_F",
    "C_IDAP_Man_AidWorker_04_F",
    "C_IDAP_Man_Paramedic_01_F"
];

//mission pos finder
private _flatPos = [nil, nil, 10, 0.2] call AW_fnc_findSafePos;

//create IDAP tent
sideObj = "Land_MedicalTent_01_white_IDAP_open_F" createVehicle _flatPos;
_spawnedUnits = _spawnedUnits + [sideObj];
sideObj setDir 0;
sideObj setVectorUp surfaceNormal position sideObj;
sideObj allowDamage false;
private _sideObjPos = getPos sideObj;
private _sideObjPosX = _sideObjPos select 0;
private _sideObjPosY = _sideObjPos select 1;

//create hostages
private _hostageGroup = createGroup civilian;
private _hostage1 = _hostageGroup createUnit [(selectRandom _hostageTypes), [_sideObjPosX - 2.4 , _sideObjPosY + 3], [], 0, "CAN_COLLIDE"];
private _hostage2 = _hostageGroup createUnit [(selectRandom _hostageTypes), [_sideObjPosX - 2.4 , _sideObjPosY + 1], [], 0, "CAN_COLLIDE"];
private _hostage3 = _hostageGroup createUnit [(selectRandom _hostageTypes), [_sideObjPosX - 2.4 , _sideObjPosY - 1], [], 0, "CAN_COLLIDE"];
private _hostage4 = _hostageGroup createUnit [(selectRandom _hostageTypes), [_sideObjPosX - 2.4 , _sideObjPosY - 3], [], 0, "CAN_COLLIDE"];

// Register Intel found event
["InA_Event_SideHostageFreed", {
    params ["_event", "_args"];
    
    _args params [["_hostage", objNull], "_rescuer"];

    [_hostage, 'Acts_ExecutionVictim_Unbow'] remoteExec ['switchMove', 0, _hostage];
    civsFreed = civsFreed + 1;
    private _name = (name _rescuer);
    _sidecompleted = format["<t align='center'><t size='2.2'>Side-mission update</t><br/>____________________<br/>%1 freed a hostage.  Good job everyone, now free the rest of them.</t>",_name];
    [_sidecompleted] remoteExec ["AW_fnc_globalHint",0,false];

    0 = [_hostage] spawn {
        params ["_unit"];

        sleep 10;
        _unit call AW_fnc_delete;
    };
}] call AW_fnc_eventRegister;

//play the captured animation + add an adaction to be able to free the civs + killed event handler
{
	_x disableAI "PATH";
	_x disableAI "FSM";
	_x disableAI "AUTOCOMBAT";
	_x disableAI "autoTarget";
	[_x, "Acts_ExecutionVictim_Loop"] remoteExec ["switchMove", 0, _x];

	[_x,"Save hostage",
    "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\help_ca.paa",
    "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\use_ca.paa",
    "_target distance _this <= 4","_target distance _this <= 4",
    {hint "Freeing hostage";
    params ["","_hero"];
    if ( currentWeapon _hero != "" ) then
    {	_hero action ["SwitchWeapon", _hero, _hero, 99]; };
    _hero playMoveNow "AinvPknlMstpSnonWnonDnon_medic3";
    },{},{
        params ["_target", "_caller", "_actionId", "_arguments"];

        ["InA_Event_SideHostageFreed", [_target, _caller]] remoteExec ["AW_fnc_eventTrigger", 2];
    },
    {hint "You stopped unzipping the hostage";
    private _unit = _this select 1;
    _unit playMoveNow "";
    },[],8, 0,true,false] remoteExecCall ["BIS_fnc_holdActionAdd", 0, true];

	_x addMPEventHandler ["MPKilled", {
		params ["_unit","","_killer"];

        if (!isServer) exitWith {};

		[_unit, 'Acts_ExecutionVictim_Kill_End'] remoteExec ['switchMove', 0, _unit];

		civsKilled = civsKilled + 1;
		private _name = name _killer;

		if !(_name == "Error: No vehicle") then {
			private _civkilled = "";

			if (isPlayer _killer) then {
				_civkilled = format["<t align='center'><t size='2.2'>%1 killed an IDAP guy!</t><br/>____________________<br/>3 IDAP guys need to survive for us to call this mission a success!</t>",_name];
				["You just killed one of the hostages you were supposed to free!"] remoteExec ["hintC", _killer];
			} else {
				_civkilled  = format["<t align='center'><t size='2.2'>The enemy executed an IDAP guy!</t><br/>____________________<br/>3 IDAP guys need to survive for us to call this mission a success!</t>"];
			};

			[_civkilled] remoteExec ["AW_fnc_globalHint",0];
		};
		removeAllActions _unit;
	}];
	
	_spawnedUnits = _spawnedUnits + [_x];
} forEach (units _hostageGroup);

_groupsArray = _groupsArray + [_hostageGroup];
_hostageGroup setGroupIdGlobal [format ["SIDE-Hostages"]];


//Hostage Guards
private _guardTypes = [
    "#riflemen",
    "#teamleaders",
    "#machinegunners",
    "#engineers",
    "#medics",
    "#demos",
    "#marksmen"
];

private _hostageTakerGroup = createGroup InA_EnemyFactionSide;

private _unitType = [(selectRandom _guardTypes), _guerFactionHash] call AW_fnc_getUnitsFromHash;
private _hostageTaker1 = _hostageTakerGroup createUnit [_unitType, [_sideObjPosX + 2.4 , _sideObjPosY + 3], [], 0, "CAN_COLLIDE"];
_hostageTaker1 doWatch getPos _hostage1;

_unitType = [(selectRandom _guardTypes), _guerFactionHash] call AW_fnc_getUnitsFromHash;
private _hostageTaker2 = _hostageTakerGroup createUnit [_unitType, [_sideObjPosX + 2.4 , _sideObjPosY + 1], [], 0, "CAN_COLLIDE"];
_hostageTaker2 doWatch getPos _hostage2;

_unitType = [(selectRandom _guardTypes), _guerFactionHash] call AW_fnc_getUnitsFromHash;
private _hostageTaker3 = _hostageTakerGroup createUnit [_unitType, [_sideObjPosX + 2.4 , _sideObjPosY - 1], [], 0, "CAN_COLLIDE"];
_hostageTaker3 doWatch getPos _hostage3;

_unitType = [(selectRandom _guardTypes), _guerFactionHash] call AW_fnc_getUnitsFromHash;
private _hostageTaker4 = _hostageTakerGroup createUnit [_unitType, [_sideObjPosX + 2.4 , _sideObjPosY - 3], [], 0, "CAN_COLLIDE"];
_hostageTaker4 doWatch getPos _hostage4;

_unitType = [(selectRandom _guardTypes), _guerFactionHash] call AW_fnc_getUnitsFromHash;
private _hostageTaker5 = _hostageTakerGroup createUnit [_unitType, [_sideObjPosX , _sideObjPosY + 6], [], 0, "CAN_COLLIDE"];
_hostageTaker5 setDir 0;

_unitType = [(selectRandom _guardTypes), _guerFactionHash] call AW_fnc_getUnitsFromHash;
private _hostageTaker6 = _hostageTakerGroup createUnit [_unitType, [_sideObjPosX , _sideObjPosY - 6], [], 0, "CAN_COLLIDE"];
_hostageTaker6 setDir 180;

{
	private _unit = _x;
	_unit disableAI "PATH";
	_spawnedUnits = _spawnedUnits + [_unit];
	{_unit removeMagazines _x} forEach ["HandGrenade", "MiniGrenade"];
} forEach (units _hostageTakerGroup);

_hostageTakerGroup = [_hostageTakerGroup] call AW_fnc_changeGroupSide;
_hostageTakerGroup setGroupIdGlobal [format ["SIDE-Hostage-Guards"]];

_groupsArray = _groupsArray + [_hostageTakerGroup];

[(units _hostageTakerGroup)] call derp_fnc_AISkill;
[(units _hostageGroup) + (units _hostageTakerGroup)] remoteExec ["AW_fnc_addToAllCurators", 2];


// Spawn force protection
private _vehAmount = [
    nil,   // MBTs
    nil,   // SPAAs
    nil,   // IFVs
    nil    // MRAPs
];

private _infAmount = [
    (4 + (random 2)),   // Squads
    nil,                // SF Squads
    nil,                // AA Teams
    nil,                // AT Teams
    nil,                // Snipers
    nil,                // Teams
    nil                 // SF Teams
];

private _enemyArray = [
    _flatPos,
    "SIDE",
    "#rnd",
    _vehAmount,
    _infAmount,
    25,
    400,
    _guerFactionHash
] call AW_fnc_spawnEnemyUnits;

_spawnedUnits append _enemyArray;


// Vehicles
private _vicAmount = 0;
private _staticAmount = 0;
private _vehicletypes = [
    "I_G_Offroad_01_armed_F",
    "I_static_AA_F",
    "I_static_AT_F",
    "I_HMG_01_high_F",
    "I_G_Offroad_01_armed_F",
    "I_C_Offroad_02_LMG_F"
];

for "_x" from 1 to 5 do {
    private _randomPos = [_flatPos, 10, 250, 5, 0, 0.3, 0, [], _flatPos] call BIS_fnc_findSafePos;

    private _grp1 = createGroup InA_EnemyFactionSide;
    private _vehicletype = selectRandom _vehicletypes;
    private _vehc = _vehicletype createVehicle _randompos;
    _vehc allowCrewInImmobile [true, true];
    _vehc lock 2;
    
    if (_vehc isKindOf "Car") then {
        _vicAmount = _vicAmount + 1;

        _vehc call AW_fnc_vehicleCustomizationOpfor;

        _grp1 = createVehicleCrew _vehc;

        _grp1 = [_grp1] call AW_fnc_changeGroupSide;
        _grp1 setGroupIdGlobal [format ["SIDE-Vehicle%1", _vicAmount]];

        _grp1 setSpeedMode "LIMITED";

        [_grp1, _flatPos, nil, 275] call AW_fnc_taskRndPatrol;
    } else {
        _staticAmount = _staticAmount + 1;

        _vehc enableSimulationGlobal false;
        _vehc setVectorUp (surfaceNormal _randomPos);

        private _grpMember = _grp1 createUnit [(["#engineers", _guerFactionHash] call AW_fnc_getUnitsFromHash), _flatpos, [], 0, "FORM"];
        _grpMember assignAsGunner _vehc;
        _grpMember moveInGunner _vehc;
        _vehc enableWeaponDisassembly false;
        _vehc setDir (random 360);
        _vehc setPos _randomPos;
        _vehc setVectorUp (surfaceNormal _randomPos);
        _vehc enableSimulationGlobal true;

        _grp1 = [_grp1] call AW_fnc_changeGroupSide;
        _grp1 setGroupIdGlobal [format ["SIDE-Static%1", _staticAmount]];
    };

    _groupsArray = _groupsArray + [_grp1];
    _spawnedUnits = _spawnedUnits + units _grp1 + [_vehc];

    [(units _grp1)] call derp_fnc_AISkill;

    [(crew _vehc) + [_vehc]] call AW_fnc_addToAllCurators;

    [_grp1] spawn AW_fnc_transferGroupHC;
};


//----------------task/circle/....
private _fuzzyPos = [_flatPos, 300] call AW_fnc_getFuzzyPos;

InA_Server_SideMarkers = ["SIDE", "Free IDAP", _fuzzyPos, 300] call AW_fnc_missionMarkersCreate;
private _sideMarker = (InA_Server_SideMarkers # 0);

[
    west,
    "FreeCivsTask",
    [
        "Hostile guerilla forces have taken local IDAP workers prisoner.  Find those IDAP guys and set them free.  According to intell hostile forces only have access to light vehicles and static weapons.  A deflector has given us these images of the site where the IDAP guys are being held:  <br/><br/><img image='Media\Briefing\IDAP.jpg' width='300' height='150'/>",
        "Side Mission: Free IDAP",
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
InA_Server_SideMissionUp = true;

waitUntil {
    sleep 5;
    (!InA_Server_SideMissionUp || (civsFreed >= 3) || (civsKilled >= 2))
};

if ((civsKilled >= 2) || !InA_Server_SideMissionUp) then {
    //mission failed
    0 = ["FreeCivsTask", "Failed"] spawn AW_fnc_finishTask;
};

if (civsFreed >= 3) then {
    //mission success
    0 = ["FreeCivsTask"] spawn AW_fnc_finishTask;
     [nil, _flatPos] call AW_fnc_SMhintSUCCESS;
};

["InA_Event_SideHostageFreed"] call AW_fnc_eventUnregister;

InA_Server_SideMissionUp = false;

[InA_Server_SideMarkers] call AW_fnc_missionMarkersRemove;

sleep 120;

{ _x call AW_fnc_delete; sleep 0.1;} forEach _spawnedUnits;
[_groupsArray] spawn AW_fnc_delete;
