/*
author: Unknown

description: spawn an ammo cache as subobjective

Last modified: 12/12/2017 by stanhope

Modified: made more sturdy, hopefully preventing it from buging out again
*/
private ["_cacheBuilding"];
private _aoLoaction = getMarkerPos InA_Server_currentAO;
private _cacheBuildingArray = nearestObjects [_aoLoaction, ["house", "building"], 700];
private _cacheBuildingArrayCount = count _cacheBuildingArray;
private _accepted = false;
private _i = 0;
private _cacheBuildingLocationFinal = [0,0,0];
ammoCrate = objNull;

if (_cacheBuildingArrayCount > 0) then {
    while {!_accepted} do {
        _cacheBuilding = selectRandom _cacheBuildingArray;
        if ((count (_cacheBuilding buildingPos -1)) > 0) then {
            _cacheBuildingLocationFinal = selectRandom (_cacheBuilding buildingPos -1);
            if !(_cacheBuildingLocationFinal isEqualTo [0,0,0]) then {
                ammoCrate = createVehicle ["O_supplyCrate_F", _cacheBuildingLocationFinal, [], 0, "CAN_COLLIDE"];
                _accepted = true;
            };
        };
        _i = _i + 1;
        if (_i > 1000) exitWith {_accepted = false; InA_Server_MainAoSubObjComplete = true;}
    };
} else {
    InA_Server_MainAoSubObjComplete = true;
};

if (_accepted) then {

    private _fuzzyPos = [(((getPos ammoCrate) select 0) - 200) + (random 400),(((getPos ammoCrate) select 1) - 200) + (random 400),0];

    InA_Server_SubMarkers = ["SUB", "Cache", _fuzzyPos, 225] call AW_fnc_missionMarkersCreate;
    private _subMarker = (InA_Server_SubMarkers # 0);

    private _defenders = [_cacheBuilding] call AW_fnc_buildingDefenders;

    [_defenders] call derp_fnc_AISkill;

    private _targetStartText = format[
    "<t align='center' size='2.2'>Sub-Objective</t><br/><t size='1.5' align='center' color='#FFCF11'>Supply Cache</t><br/>____________________
    <br/>We have received intel from local resistance fighters that OPFOR have hidden a weapons cache in the area. Take it out and expect it to be guarded.<br/><br/>"];
    [_targetStartText] remoteExec ["AW_fnc_globalHint",0];

    [
        west,
        [
            "SubAoTask",
            "MainAoTask"
        ],
        [
            "We have received intel from local resistance fighters that OPFOR have hidden a weapons cache in the area. Take it out and expect it to be guarded.",
            "Ammo Cache",
            _subMarker
        ],
        _fuzzyPos,
        "Created",
        0,
        true,
        "destroy",
        true
    ] call BIS_fnc_taskCreate;

    InA_Server_MainAoSubObjSpawn_Complete = true;

    ["InA_Event_CacheChargePlanted", {
        params ["_event", "_args"];

        _args params ["_cache", "_planter"];

        private _aoName = [] call AW_fnc_getCurrentAOName;
        private _targetStartText = format["<t align='center' size='2.2'>Sub-Objective</t><br/><t size='1.5' align='center' color='#FFCF11'>Charges planted</t><br/>____________________<br/>%Charges have been planted on the cache in %1 by %2.  Get clear it will blow in 30 seconds!",_aoName, name _planter];
        [_targetStartText] remoteExec ["AW_fnc_globalHint",0];

        0 = [_cache] spawn {
            params ["_cache"];

            sleep 30;

            if (alive _cache) then {
                _pos = getPos _cache;
                "Bo_GBU12_LGB" createVehicle _pos;
                _cache setDamage 1;
                sleep (4 + (random 3));
                [_pos] spawn AW_fnc_cookoff;
            };
        };
    }] call AW_fnc_eventRegister;

    ammoCrate addEventHandler ["Killed",{
        params ["_unit","","_killer"];
        _name = name _killer;
        if (_name == "Error: No vehicle") then{
            _name = "Someone";
        };
        _aoName = [] call AW_fnc_getCurrentAOName;
        _targetStartText = format["<t align='center' size='2.2'>Sub-Objective</t><br/><t size='1.5' align='center' color='#FFCF11'>Cache Destroyed</t><br/>____________________<br/>%2 destroyed the cache in %1, good job everyone!",_aoName,_name];
        [_targetStartText] remoteExec ["AW_fnc_globalHint",0];
    }];

    [
        ammoCrate,
        "Plant charges",
        "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\destroy_ca.paa",
        "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\use_ca.paa",
        "_target distance _this <= 5","_target distance _this <= 5",
        {
            hint "Planting charges ...";
            params ["","_hero"];
            if ( currentWeapon _hero != "" ) then
            {	_hero action ["SwitchWeapon", _hero, _hero, 99]; };
            _hero playMoveNow "AinvPknlMstpSnonWnonDnon_medic3";
        },
        {},
        {
            params ["_ammoCrate","_hero"];

            ["InA_Event_BunkerPoweredOff", [_ammoCrate, _hero]] remoteExec ["AW_fnc_eventTrigger", 2];
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

    InA_Server_subObjUnits append _defenders;
    
    ammoCrate setPosWorld [(getPosWorld ammoCrate) select 0, (getPosWorld ammoCrate) select 1, ((getPosWorld ammoCrate) select 2) + 1];

    waitUntil {
        if (InA_Server_MainAOControl_EndSubObj) exitWith {
            ammoCrate setDamage 1;

            true
        };

        sleep 5;
        
        (!alive ammoCrate)
    };

    0 = ["SubAoTask"] spawn AW_fnc_finishTask;

    [InA_Server_SubMarkers] call AW_fnc_missionMarkersRemove;

} else {
    InA_Server_MainAoSubObjComplete = true;
};

InA_Server_MainAO_SubObjComplete = true;
