/*
 * Author: Whigital
 *
 * Description: Spawns a chopper and squad that gets para dropped.
 *
 */

params [
    "_startPos",
    "_dropPos",
    ["_factionHash", InA_EnemyFactionHash]
];


if (isNil "InA_AOParaReinforceCounter") then {
    InA_AOParaReinforceCounter = 1;
};

private _heliType = ["#helis", _factionHash] call AW_fnc_getUnitsFromHash;
private _heli = (createVehicle [_heliType, _startPos, [], 0, "FLY"]);
private _heliGrp = (createVehicleCrew _heli);

_heliGrp = [_heliGrp] call AW_fnc_changeGroupSide;

_heliGrp setGroupIdGlobal [format ["AO-ParaHeli-%1", InA_AOParaReinforceCounter]];

{
    _x setSkill 1;
} forEach (units _heliGrp);

[((units _heliGrp) + [_heli])] call AW_fnc_addToAllCurators;

private _squadSize = (10 min (_heli emptyPositions "cargo"));
private _paraGrp = (createGroup InA_EnemyFactionSide);

for "_i" from 1 to _squadSize do {
    private _paraUnit = ["#paras", _factionHash] call AW_fnc_getUnitsFromHash;
    private _unit = (_paraGrp createUnit [_paraUnit, _startPos, [], 0, "NONE"]);
    _unit assignAsCargo _heli;
    _unit moveInCargo _heli;

    private _backpackType = (backpack _unit);

    if (_backpackType != "B_Parachute") then {
        if (_backpackType != "") then {
            private _backpackItems = (backpackItems _unit);
            _unit setVariable ["InA_Para_BackpackData", [_backpackType, _backpackItems]];
        };

        removeBackpack _unit;
        _unit addBackpack "B_Parachute";
    };
};

_paraGrp = [_paraGrp] call AW_fnc_changeGroupSide;

private _pilot = (driver _heli);

_pilot addEventHandler ["GetOutMan", {
    params ["_unit", "_role", "_vehicle", "_turret"];

    private _group = (group _unit);
    private _reinfGrp = (_vehicle getVariable ["cargoGrp", grpNull]);
    {
        _x setDamage 1;
    } forEach ((units _group) + [_vehicle]);

    {
        if ((alive _x) && {((getPos _x) distance2D (getMarkerPos InA_Server_currentAO)) > InA_Server_MainAOSize}) then {
            _x setDamage 1;
        };
    } forEach (units _reinfGrp);
}];

_paraGrp setGroupIdGlobal [format ["AO-ParaReinf-%1", InA_AOParaReinforceCounter]];

[(units _paraGrp)] call derp_fnc_AISkill;
[(units _paraGrp)] call AW_fnc_addToAllCurators;

InA_AOParaReinforceCounter = (InA_AOParaReinforceCounter + 1);

0 = [_heli, _startPos, _dropPos, _paraGrp] spawn {
    params [
        "_heli",
        "_startPos",
        "_posDrop",
        "_cargoGrp"
    ];

    _heli flyInHeight (75 + (random 50));
    _heli lock true;
    _heli allowCrewInImmobile true;

    {
        _x disableAI "FSM";
    } forEach (units _cargoGrp);

    _cargoGrp setBehaviourStrong "CARELESS";

    private _heliGrp = (group (driver _heli));

    _heli setVariable ["cargoGrp", _cargoGrp];

    _heliGrp setCombatMode "RED";
    _heliGrp setBehaviourStrong "CARELESS";
    _heliGrp setSpeedMode "FULL";

    private _paraCode = (toString {
        private _heliGrp = (group this);
        if (!local _heliGrp) exitWith {};

        private _heli = (vehicle this);
        private _paraGrp = (_heli getVariable ["cargoGrp", grpNull]);

        0 = [_paraGrp] spawn {
            params ["_paraGrp"];

            {
                unassignVehicle _x;

                [_x] orderGetIn false;
                [_x] allowGetIn false;

                moveOut _x;

                _x spawn {
                    params ["_unit"];

                    private _backpackData = (_unit getVariable ["InA_Para_BackpackData", []]);

                    if (_backpackData isNotEqualTo []) then {
                        waitUntil {
                            sleep 1;
                            ((isTouchingGround _unit) || (!alive _unit))
                        };

                        if (!alive _unit) exitWith {};

                        _backpackData params ["_backpackType", "_backpackItems"];

                        removeBackpack _unit;

                        _unit addBackpack _backpackType;

                        clearAllItemsFromBackpack _unit;

                        {
                            _unit addItemToBackpack _x;
                        } foreach _backpackItems;

                        sleep 1;
                    };

                    _unit setVariable ["InA_Para_safeToXfer", true];
                };

                sleep 0.25;
            } forEach (units _paraGrp);
        };
    });

    private _paraWP = _heliGrp addWaypoint [_posDrop, 200];

    _paraWP setWaypointType "MOVE";
    _paraWP setWaypointCompletionRadius InA_Server_MainAOSize;
    _paraWP setWaypointStatements ["true", _paraCode];

    private _homeWP = _heliGrp addWaypoint [_startPos, 100];

    _homeWP setWaypointType "MOVE";
    _homeWP setWaypointCompletionRadius 100;
    _homeWP setWaypointStatements ["true", "(vehicle this) call AW_fnc_delete;"];

    [_cargoGrp, _posDrop, nil, 200] call AW_fnc_taskRndPatrol;

    waitUntil {
        sleep 0.25;
        (({(objectParent _x) == _heli} count (units _cargoGrp)) == 0)
    };

    {
        _x enableAI "FSM";
    } forEach (units _cargoGrp);

    _cargoGrp setBehaviourStrong "AWARE";

    _cargoGrp spawn {
        params ["_cargoGrp"];

        waitUntil {
            sleep 1;
            ((count ((units _cargoGrp) select {(alive _x) && {!(_x getVariable ["InA_Para_safeToXfer", false])}})) == 0)
        };

        [_cargoGrp] spawn AW_fnc_transferGroupHC;
    };
};

[_paraGrp, _heli]
