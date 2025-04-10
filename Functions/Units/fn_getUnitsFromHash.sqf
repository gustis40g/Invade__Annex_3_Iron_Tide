/*
 * Author: Whigital
 * Description:
 * Does lookup against faction mapping hashMap and returns
 * requested unit/group/team/vehicle
 *
 */

params [
    "_type",
    ["_factionHash", InA_EnemyFactionHash]
];

private _return = "";

private _infHash = (_factionHash get "#infantry");
private _vehHash = (_factionHash get "#vehicles");

private _returnArray = [];

switch (true) do {
    case (_type in (keys _infHash)): {
        _returnArray = (_infHash get _type);
    };

    case (_type in (keys _vehHash)): {
        _returnArray = (_vehHash get _type);
    };

    case (_type in (keys _factionHash)): {
        _returnArray = (_factionHash get _type);
    };
};

if ((typeName _returnArray) == (typeName [])) then {
    if (((count _returnArray) > 1) && {(typeName (_returnArray # 1)) == (typeName 0)}) then {
        _return = (selectRandomWeighted _returnArray);
    } else {
        _return = (selectRandom _returnArray);
    };
} else {
    _return = _returnArray;
};

_return
