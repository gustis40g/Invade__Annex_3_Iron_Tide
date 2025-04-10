/*
    Function that simulates cookoff
*/

params ["_pos"];

private _timing = [0.2, 2 + random(2), 1 + random(2), 0.5];

if (random(10) > 5) then {
    _timing = [0.2] + _timing;
};

{
    "SmallSecondary" createVehicle (_pos getPos [random 2, random 360]);
    sleep _x;
} forEach _timing;

