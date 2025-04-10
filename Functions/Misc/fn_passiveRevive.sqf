/*
Author: Stanhope
Description: Heals all players near the person calling it (derp revive)
To be called via:
object addAction ["Revive player(s)", {_this spawn AW_fnc_passiveHeal;}, [], -200, false, true, "", "[_target, _this] call AW_fnc_passiveReviveCond", 10, true];
*/

params ["_target", ["_range", 10]];

if (!isServer) exitWith {};

if (isNull _target) exitWith {};

private _nearPlayers = (((getPos _target) nearObjects ["Man", _range]) select {isPlayer _x});

private _downed = (_nearPlayers select {
    private _unit = _x;

    private _isDowned = (_unit getVariable ["derp_revive_downed", false]);
    private _isDragged = (_unit getVariable ["derp_revive_isDragged", false]);
    private _isCarried = (_unit getVariable ["derp_revive_isCarried", false]);

    _isDowned && {!_isDragged && !_isCarried}
});

{
    [_x, "REVIVED"] remoteExecCall ["derp_revive_fnc_switchState", _x];
} forEach _downed;
