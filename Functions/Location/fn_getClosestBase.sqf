/*
 * Author: Whigital
 * Description:
 * Gets the closest Base/F.O.B from position.
 *
 */

params [
    "_pos",
    ["_oper", "CLOSEST"]
];

private _baseDistances = [];

private _bases = (
    if (isServer) then {
        InA_Server_BaseArray
    } else {
        InA_Client_BaseArray
    }
);

{
    private _basePos = (getMarkerPos _x);
    private _dist = (_pos distance2D _basePos);

    _baseDistances pushBack [_dist, _x];
} forEach _bases;

_baseDistances sort true;

private _basesSorted = (_baseDistances apply {_x # 1});

private _baseRet = [];

switch (_oper) do {
    case "CLOSEST": {
        _baseRet = [(_basesSorted # 0)];
    };

    case "ALL": {
        _baseRet = +_basesSorted;
    };

    default {
        // NOOP
    };
};

_baseRet
