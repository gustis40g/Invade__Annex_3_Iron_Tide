/*
    Author: Whigital
    Description: spawns an object relative to another

    params:
        _origin: object: anchor to spawn relaitve to
        _data: the relative data:
        _rndDir: direction to add to the dir that's defined in _data
        _posOnly: only return pos, do not spawn vehicle
        _posWorldMode: to be used when objects are spawned on or under water

    returns: the spawned objective or the position to spawn
*/

params [
    "_origin",
    "_data",
    "_rndDir",
    ["_posOnly", false],
    ["_posWorldMode", false]
];
_data params ["_class", "_relPos", "_dir"];

private _realPos = (_origin modelToWorld _relPos);
if (_posWorldMode) then {
    _realPos = (_origin modelToWorldWorld _relPos);
};

if (_posOnly) exitWith {[_realPos, (_dir + _rndDir)]};

private _obj = createVehicle [_class, [0, 0, 0], [], 0, "NONE"];
_obj setDir (_dir + _rndDir);

if (_posWorldMode) then {
    _obj setPosWorld (_origin modelToWorldWorld _relPos);
} else {
    _obj setPosATL (_origin modelToWorld _relPos);
};

_obj