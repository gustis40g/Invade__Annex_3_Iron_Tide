/*
Author: BACONMOP

Example:
_pos = getPos Player;
_unit = arty;
[_unit,_pos] call AW_fnc_artyStrike;

Parameters:
1. Unit that will fire.
2. Target Location.
*/
params [
    "_arty",
    "_pos",
    ["_limitShells", false],
    ["_minShells", 3],
    ["_maxShells", 8]
];

private _amount = 0;

if (_limitShells) then {
    _amount = (selectRandom [1, 2, 3]);
} else {
    _amount = (_minShells + (round (random (_maxShells - _minShells))));
};

private _ammo = (getArtilleryAmmo [_arty] # 0);

[_arty, _pos, _ammo, _amount] spawn {
    params ["_arty", "_pos", "_ammo", "_amount"];

    private _smokePos = [(_pos # 0), (_pos # 1), ((_pos # 2) + 25)];
    private _redSmoke = createVehicle ["SmokeShellRed", _smokePos, [], 15, "NONE"];

    // Observe spotting rounds and adjust ....
    sleep (3 + (random 5));

    _arty commandArtilleryFire [_pos, _ammo, _amount];
};
