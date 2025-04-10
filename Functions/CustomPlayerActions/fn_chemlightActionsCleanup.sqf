// Cleanup any attached chemlight/strobes on player
params [
    ["_unit", objNull]
];

if (isNull _unit) exitWith {};

private _item = _unit getVariable ["InA_ShoulderAttachedItem", objNull];

if (!isNull _item) then {
    detach _item;
    _item call AW_fnc_delete;
};

if ((count (attachedObjects _unit)) > 0) then {
    {
        detach _x;
        _x call AW_fnc_delete;
    } forEach (attachedObjects _unit);
};
