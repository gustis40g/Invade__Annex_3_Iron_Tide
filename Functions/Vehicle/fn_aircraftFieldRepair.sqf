params [
    ["_aircraft", objNull]
];

if (isNull _aircraft || !alive _aircraft) exitWith {};

if (!local _aircraft) exitWith {
    [_aircraft] remoteExec ["AW_fnc_aircraftFieldRepair", _aircraft];
};

private _hps = (getAllHitPointsDamage _aircraft);

_aircraft setdamage 0;

{
    private _damage = _x;

    if (_damage > 0.6) then {
        _aircraft setHitIndex [_forEachIndex, 0.6, true];
    };
} forEach (_hps # 2);

if (_aircraft isKindOf "VTOL_02_base_F") then {
    {
        _aircraft setHit [_x, 0.25, true];
    } forEach [
        "HitRAileron",
        "HitLAileron",
        "HitRCElevator",
        "HitLCElevator",
        "HitRCRudder",
        "HitLCRudder"
    ];
};
