/*
 * Author: Whigital
 * Description:
 * Checks for nearby downed players and returns true if found.
 *
 * Used in 'passiveRevive' action condition
 *
 * [_target, _this] call AW_fnc_passiveReviveCond;
 *
 */

params ["_target", "_caller", ["_range", 10]];

if ((_caller distance _target) > 5) exitWith {false};

if (!isNull (objectParent _caller)) exitWith {false};

if (_caller getVariable ["derp_revive_downed", false]) exitWith {false};

if ((_caller getVariable ["derp_revive_isCarrying", false]) || (_caller getVariable ["derp_revive_isDragging", false])) exitWith {false};

private _nearPlayers = (((getPos _target) nearObjects ["Man", _range]) select {isPlayer _x});

private _downedIdx = (_nearPlayers findIf {
    private _unit = _x;

    private _isDowned = (_unit getVariable ["derp_revive_downed", false]);
    private _isDragged = (_unit getVariable ["derp_revive_isDragged", false]);
    private _isCarried = (_unit getVariable ["derp_revive_isCarried", false]);

    _isDowned && {!_isDragged && !_isCarried}
});

if (_downedIdx == -1) exitWith {false};

true
