params [
    ["_vehicle", objNull],
    ["_timer", 600],
    ["_interval", 60],
    ["_range", 300]
];

if (!canSuspend) exitWith {};

if (isNull _vehicle || {(_vehicle isKindOf "Plane")}) exitWith {};

private _lastActiveTime = serverTime;

while {alive _vehicle} do {
    private _vehiclePos = (getPos _vehicle);
    private _crew = (crew _vehicle);

    if ((({alive _x} count _crew) > 0) ||
        {
            ([_vehicle, _range] call AW_fnc_isNearBase) || {
                [_vehicle, _range] call AW_fnc_playersNear
            }
        }
    ) then {
        _lastActiveTime = serverTime;
    };

    if ((serverTime - _lastActiveTime) > _timer) then {
        private _posData = [(getPos _vehicle)] call AW_fnc_getRewardAreaPosition;
        _vehicle setDir (_posData # 1);
        _vehicle setPos (_posData # 0);

        if (isEngineOn _vehicle) then {
            [_vehicle, false] remoteExec ["engineOn", _vehicle];
        };

        private _hitPointDamage = (getAllHitPointsDamage _vehicle);

        _vehicle setdamage 0;

        {
            if (_x > 0.6) then {
                _vehicle setHitIndex [_forEachIndex, 0.6, true];
            };
        } forEach (_hitPointDamage # 2);

        if ((fuel _vehicle) < 0.1) then {
            _vehicle setFuel 0.1;
        };
    };

    sleep _interval;
};
