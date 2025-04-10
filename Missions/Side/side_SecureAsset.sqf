/*
author: stanhope, AW community member.

description:    Reworked version of securechopper.sqf made by Quiksilver,
                expanded to be more than just choopers and to have more rencent coding.
*/

// See AW_fnc_rewadsDef for available rewards ....
private _missionType = selectRandom AW_OPFOR_side_secureAsset_assets;

private _rewardId = (_missionType # 0);
private _assetType = (_missionType # 1);
private _rewardType = (["GETITEM", _rewardId] call AW_fnc_rewardsDef);
private _description = (_rewardType # 2);

//-------------------- FIND SAFE POSITION FOR OBJECTIVE
private _findSmPosResult = ["safePos", [nil, nil, 15, 0.2]] call AW_fnc_findSideMissionPos;
if (!(_findSmPosResult select 0)) exitWith {};
private _flatPos = _findSmPosResult select 1;

//----------------spawn objective
private _tentDirection = random 360;

private _hangar = "Land_TentHangar_V1_F" createVehicle _flatPos;
_hangar allowDamage false;

sideObj = _assetType createVehicle _flatPos;
waitUntil {!isNull sideObj};

sideObj setVariable ["InA_AssetSecured", false, true];
sideObj lock true;

{
    _x setVectorUp surfaceNormal position _x;
    _x setDir _tentDirection;
} forEach [_hangar, sideObj];

[sideObj] call AW_fnc_vehicleCustomization;
[sideObj] call AW_fnc_generalVehicleSettings;

//-----add actions and eventhandler
[
    sideObj,
    "<t color='#0022dd' size='1.1' font='PuristaBold'><img size='1.1' image='\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\documents_ca.paa' /> Secure asset</t>",
    "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\documents_ca.paa",
    "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\download_ca.paa",
    "((_target distance2D _this) < 6) && {!(_target getVariable ['InA_AssetSecured', false])}",
    "((_target distance2D _caller) < 6) && {!(_target getVariable ['InA_AssetSecured', false])}",
    {
        params ["","_hero"];
        
        hint "Securing asset...";

        if (currentWeapon _hero != "") then {
            _hero action ["SwitchWeapon", _hero, _hero, 99];
        };

        _hero playMoveNow "AinvPknlMstpSnonWnonDnon_medic3";
    },
    {},
    {
        params ["_target", "_caller", "_actionId", "_arguments"];

        _target setVariable ["InA_AssetSecured", true, true];

        private _name = (name _caller);
        _sidecompleted = format ["<t align='center'><t size='2.2'>Side-mission update</t><br/>____________________<br/>Good job, %1 secured the asset.</t>", _name];
        [_sidecompleted] remoteExec ["AW_fnc_globalHint", 0];

        [_target] remoteExec ["AW_fnc_rewardVehicleHandler", 2];

        sleep 4;

        ["InA_Event_SideMissionSuccess"] remoteExecCall ["AW_fnc_eventTrigger", 2];
    },
    {
        hint "You stopped securing the asset"; 
        private _unit = _this select 1;
        _unit playMoveNow "";
    },
    [],
    5,
    10,
    true,
    false
] remoteExecCall ["BIS_fnc_holdActionAdd", 0, true];

sideObj addEventHandler ["Killed", {
    params ["_unit", "_killer", "_instigator", "_useEffects"];

    private _name = (name _killer);

    if (_name == "Error: No vehicle") then {
        _name = "Someone";
    };

    private _targetStartText = format["<t align='center' size='2.2'>Side mission failed</t><br/><t size='1.5' align='center' color='#FFCF11'>Asset destroyed</t><br/>____________________<br/>%1 destroyed the asset, mission failed.", _name];
    [_targetStartText] remoteExec ["AW_fnc_globalHint", 0];
}];

//-------------------- SPAWN FORCE PROTECTION
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
    (1 + (random 1)),   // AT Teams
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

//-------------------- BRIEF
private _fuzzyPos = [_flatPos, 300] call AW_fnc_getFuzzyPos;
private _markerText = format ["Side Mission: Secure %1", _description];

InA_Server_SideMarkers = ["SIDE", (format ["Secure %1", _description]), _fuzzyPos, 300] call AW_fnc_missionMarkersCreate;
private _sideMarker = (InA_Server_SideMarkers # 0);

private _briefingText = format ["OPFOR forces have stashed %1 in a hangar somewhere on the island. We've marked the suspected location on your map; head to the hangar and secure that asset.", _description];

[
    west,
    "secureAssetTask",
    [
        _briefingText,
        _markerText,
        _sideMarker
    ],
    _fuzzyPos,
    "Created",
    0,
    true,
    "interact",
    true
] call BIS_fnc_taskCreate;

//----------Mission core--------------
InA_Server_SideMissionUp = true;
InA_Server_SideMissionSuccess = false;
InA_Server_SideMissionSpawned = true;

waitUntil {
    if (!InA_Server_SideMissionUp) then {
        sideObj setDamage 1;
    };

    sleep 5;

    ((InA_Server_SideMissionSuccess) || (!alive sideObj))
};

InA_Server_SideMissionUp = false;

//-------------------- DE-BRIEFING
if (!alive sideObj) then {
    0 = ["secureAssetTask", "Failed"] spawn AW_fnc_finishTask;
};

if (InA_Server_SideMissionSuccess) then {
    sideObj lock false;
    0 = ["secureAssetTask"] spawn AW_fnc_finishTask;
};

sideObj = objNull;

//=========Cleanup===========
sleep 5;

[InA_Server_SideMarkers] call AW_fnc_missionMarkersRemove;

//--------------------- DELETE

sleep 120;
[_enemiesArray + [_hangar]] spawn AW_fnc_delete;
