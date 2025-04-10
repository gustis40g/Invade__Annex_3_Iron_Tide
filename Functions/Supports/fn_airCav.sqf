/*
Author: BACONMOP
Description: Create Air Cav reinforce
last edited: 19/08/2017 by stanhope
edited: remove unneeded code
*/

params [
    "_dropZone",
    "_startPos",
    ["_factionHash", InA_EnemyFactionHash]
];

private _returnArray = [];
private _accepted = false;
private _flatPos = [0,0,0];
private _count = 0;

while {!_accepted} do {
    _flatPos = [getMarkerPos _dropZone, 10, InA_Server_MainAOSize, 15, 0, 0.3, 0, [], [0,0,0]] call BIS_fnc_findSafePos;

    _accepted = true;

    if (_flatPos isEqualTo [0,0,0]) then {
        _accepted = false;
        _count = _count + 1;
    };

    if (_count > 100) exitWith {};
};

if (!_accepted || ((typeName _flatPos) != "ARRAY")) exitWith {
    [format ["Failed to spawn reinforcements for AO %1", _dropZone], "AIRCAV", true] call AW_fnc_log;
    _returnArray
};

private _heli = ["#helis", _factionHash] call AW_fnc_getUnitsFromHash;

private _ambientHeli = (createVehicle [_heli, getMarkerPos _startPos, [], 0, "FLY"]);

// Randomize loadout
_ambientHeli call AW_fnc_vehicleCustomizationOpfor;

private _heliGrp = (createVehicleCrew _ambientHeli);
_heliGrp = [_heliGrp] call AW_fnc_changeGroupSide;
_heliGrp setGroupIdGlobal ["AO-SubObj-Reinforce-Heli"];

private _pilot = (driver _ambientHeli);

_pilot addEventHandler ["GetOutMan", {
    params ["_unit", "_role", "_vehicle", "_turret"];

    private _group = (group _unit);
    private _reinfGrp = (_vehicle getVariable ["ReinfGroup", grpNull]);

    {
        _x setDamage 1;
    } forEach ((units _group) + [_vehicle]);

    {
        if ((alive _x) && {((getPos _x) distance2D (getMarkerPos InA_Server_currentAO)) > InA_Server_MainAOSize}) then {
            _x setDamage 1;
        };
    } forEach (units _reinfGrp);
}];

private _squadSize = (12 min (_ambientHeli emptyPositions "cargo"));
private _unitArray = ["#squads", _factionHash] call AW_fnc_getUnitsFromHash;

private _reinfGrp = (createGroup InA_EnemyFactionSide);
private _reinfLeader = (_reinfGrp createUnit [(_unitArray # 0), getMarkerPos _startPos, [], 10, "NONE"]);

_reinfLeader moveInCargo _ambientHeli;

for "_i" from 1 to (_squadSize - 1) do {
    private _tmpUnit = _reinfGrp createUnit [(selectRandom _unitArray), getMarkerPos _startPos, [], 10, "NONE"];
    _tmpUnit moveInCargo _ambientHeli;
};

_reinfGrp = [_reinfGrp] call AW_fnc_changeGroupSide;
_reinfGrp setGroupIdGlobal [format ["AO-ReinfGroup"]];
_ambientHeli setVariable ["ReinfGroup", _reinfGrp];

0 = [_ambientHeli, _startPos, _flatPos, _heliGrp, _reinfGrp] spawn {
    params [
        "_heli",
        "_mkrHome",
        "_posDrop",
        "_heliGrp",
        "_cargoGrp"
    ];

    private _pad = ("Land_HelipadEmpty_F" createVehicle _posDrop);
    _pad setDir ((getMarkerPos _mkrHome) getDir _pad);

    _heli lock true;
    _heli allowCrewInImmobile true;

    _heliGrp setCombatMode "YELLOW";
    _heliGrp setBehaviourStrong "CARELESS";

    {
        _x disableAI "FSM";
    } forEach (units _cargoGrp);

    _cargoGrp setBehaviourStrong "CARELESS";

    private _heliDropWP = _heliGrp addWaypoint [_pad, 0];
    _heliDropWP setWaypointType "MOVE";
    _heliDropWP setWaypointCompletionRadius 5;
    _heliDropWP setWaypointStatements ["true", "private _heli = (vehicle this); _heli land 'LAND';"];

    waituntil {
        sleep 1;
        ((isTouchingGround _heli) || (!alive _heli))
    };

    if (!alive _heli) exitWith {
        _pad call AW_fnc_delete;
    };

    {
        doGetOut  _x;
        unassignVehicle _x;
    } foreach (units _cargoGrp);

    waituntil {
        sleep 0.25;
        ({(vehicle _x) == _heli} count (units _cargoGrp) == 0) || (!alive _heli)
    };

    {
        _x enableAI "FSM";
    } forEach (units _cargoGrp);

    _cargoGrp setBehaviourStrong "AWARE";

    _pad call AW_fnc_delete;

    if (alive _heli) then {
        private _wpHomePos = (getMarkerPos _mkrHome);
        private _heliHomeWP = _heliGrp addWaypoint [_wpHomePos, 0];

        _heliHomeWP setWaypointType "MOVE";
        _heliHomeWP setWaypointCompletionRadius 5;
        _heliHomeWP setWaypointStatements ["true", "(vehicle this) call AW_fnc_delete"];
    };

    if (({alive _x} count (units _cargoGrp)) > 0) then {
        [_cargoGrp] spawn AW_fnc_transferGroupHC;
    };
};

[_reinfGrp, (getMarkerPos _dropZone), nil, 150] call AW_fnc_taskRndPatrol;

{_returnArray pushBack _x} forEach units _reinfGrp;
{_returnArray pushBack _x} forEach units _heliGrp;
_returnArray pushBack _ambientHeli;

[_returnArray] call AW_fnc_addToAllCurators;
[_returnArray] call derp_fnc_AISkill;

_returnArray
