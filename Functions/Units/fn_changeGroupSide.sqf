/*
 * Author: Whigital
 * Description: Moves units in a group to a new group of specific side
 *
 */

params ["_oldGrp", ["_side", InA_EnemyFactionSide]];

private _units = (units _oldGrp);

// Check if units belong to the desired side
if ((_units findIf {(side _x) != _side}) == -1) exitWith {
    _oldGrp
};

private _newGrp = (createGroup _side);

_units joinSilent _newGrp;

deleteGroup _oldGrp;

// Indicate that the group side was changed
_newGrp setVariable ["InA_GroupChangeSide", _side, true];

_newGrp
