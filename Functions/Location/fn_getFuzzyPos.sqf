/*
fn_getFuzzyPos.sqf

Returns a randomized position within the specified range of the given position.

params:
    _initalialPos:  Object, Position2D or Position3D
    _range:         Number

*/

params ["_initialPos", ["_range", 300, [0]]];

private _randomPos = _initialPos getPos [(random _range), random 360];

_randomPos