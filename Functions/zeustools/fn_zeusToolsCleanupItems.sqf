/*
 * Author: Whigital
 * Description:
 * Clean up items withing a specific radius
 *
 */

params ["_pos", "_radius", "_type"];

if (!isServer) exitWith {};

if (isRemoteExecuted && {!([remoteExecutedOwner] call AW_fnc_isZeus)}) exitWith {
    private _caller = objNull;
    private _players = allPlayers;

    private _playerIdx = (_players findIf {(owner _x) == remoteExecutedOwner});

    if (_playerIdx != -1) then {
        _caller = (_players # _playerIdx);
    };

    private _msg = (format ["%1 :: Non Zeus player %2 (%3) tried to clean: %4", _fnc_scriptName, (name _caller), (getPlayerUID _caller), [_pos, _type,_radius]]);
    [_msg, "VIOLATION", true] call AW_fnc_log;
};

if !(_type in ["Smoke", "Explosive"]) exitWith {
    [(format ["Unknown type supplied: %1", _type])] remoteExec ["systemChat", remoteExecutedOwner];
};

private _itemsToRemove = [];

switch (_type) do {
    case "Smoke": {
        _itemsToRemove = (_pos nearObjects ["smokeShell", _radius]);
    };

    case "Explosive": {
        {
            _itemsToRemove append (_pos nearObjects [_x, _radius]);
        } forEach ["MineBase", "TimeBombCore"];
    };
};

private _msg = (format ["Nothing to remove: Couldn't find any %1(s) within %2 meters ....", _type, _radius]);

if (_itemsToRemove isEqualTo []) exitWith {
    [_msg] remoteExec ["systemChat", remoteExecutedOwner];
};

private _count = (count _itemsToRemove);

{
    _x call AW_fnc_delete;
} forEach _itemsToRemove;

_msg = (format ["Removed %1 %2(s) ....", _count, _type]);

[_msg] remoteExec ["systemChat", remoteExecutedOwner];
