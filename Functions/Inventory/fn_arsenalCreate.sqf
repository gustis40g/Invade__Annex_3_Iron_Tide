/*
 * Author: Whigital
 * Description:
 * Creates an Arsenal serverside
 *
 */

params [
    "_pos",
    ["_full", false],
    ["_curator", false],
    ["_baseArsenal", false],
    ["_base", nil]
];

if (!isServer) exitWith {};

if (isRemoteExecuted && {!([remoteExecutedOwner] call AW_fnc_isZeus)}) exitWith {
    private _caller = objNull;
    private _players = allPlayers;

    private _playerIdx = (_players findIf {(owner _x) == remoteExecutedOwner});

    if (_playerIdx != -1) then {
        _caller = (_players # _playerIdx);
    };

    private _msg = (format ["%1 :: Non Zeus player %1 (%2) tried to spawn an arsenal!", _fnc_scriptName, (name _caller), (getPlayerUID _caller)]);
    [_msg, "VIOLATION", true] call AW_fnc_log;
};

private _arsenal = "B_CargoNet_01_ammo_F" createVehicle (_pos);

clearItemCargoGlobal _arsenal;
clearWeaponCargoGlobal _arsenal;
clearBackpackCargoGlobal _arsenal;
clearMagazineCargoGlobal _arsenal;

_arsenal enableRopeAttach false;
_arsenal setMass 5000;

if (_curator) then {
    [[_arsenal]] call AW_fnc_addToAllCurators;
};

private _params = [_arsenal, _full, _baseArsenal];

if (!isNil "_base") then {
    _params pushBack _base;
};

["InA_Event_ArsenalAdded", _params] remoteExec ["AW_fnc_eventTrigger", 0, _arsenal];

_arsenal
