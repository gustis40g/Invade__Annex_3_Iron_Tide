/*
 * Author: Whigital
 *
 * Description:
 * Check player/owner for Zeus access
 *
 */

params ["_input"];

if (!isServer) exitWith {false};

if !((_input isEqualType 0) || (_input isEqualType objNull)) exitWith {false};

if ((_input isEqualType objNull) && {isNull _input}) exitWith {false};

private _zeusUIDs = (InA_Server_coreStaffUIDs + InA_Server_staffUIDs + InA_Server_spartanUIDs);
private _inZeusUIDs = false;
private _unit = objNull;

if (_input isEqualType objNull) then {
    _inZeusUIDs = ((getPlayerUID _input) in _zeusUIDs);
    _unit = _input;
} else {
    _unit = ((allPlayers select {(owner _x) == _input}) # 0);

    if (!isNil "_unit") then {
        _inZeusUIDs = ((getPlayerUID _unit) in _zeusUIDs);
    };
};

private _assignedUnits = (allCurators apply {getAssignedCuratorUnit _x});

_inZeusUIDs && {(_unit in _assignedUnits)}
