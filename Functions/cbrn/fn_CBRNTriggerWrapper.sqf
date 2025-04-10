params [
    ["_trigger", objNull],
    ["_cbrnType", "CHEM"],
    ["_interval", 5]
];

if (!isServer) exitWith {
    ["Executing machine not server, exiting ....", "AW_fnc_CBRNTriggerWrapper"] call AW_fnc_log;
};

if (isNull _trigger) exitWith {};

if (isNil "InA_CBRN_WrapperRunning") then {
    InA_CBRN_WrapperRunning = false;
};

if (!InA_CBRN_WrapperRunning) then {
    private _threatPos = (getPos _trigger);
    private _threatRadius = ((triggerArea _trigger) # 0);

    // Threat type: [<type>, <life expectancy (s) at ground zero>]
    private _threatProfiles = [
        ["CHEM", 10],
        ["BIO", 20],
        ["RAD", 25],
        ["NUKE", 15]
    ];

    private _threatIdx = (_threatProfiles findIf {(_x # 0) == _cbrnType});

    private _lifeExpectancy = 10;

    if (_threatIdx != -1) then {
        _lifeExpectancy = ((_threatProfiles # _threatIdx) # 1);
    };

    while {InA_Server_SideMissionUp && {(triggerActivated _trigger)}} do {
        InA_CBRN_WrapperRunning = true;

        private _listTrigger = (list _trigger);

        private _players = (_listTrigger select {(isPlayer _x) && {(_x isKindOf "Man") && !(_x getVariable ["AW_CBRN_isClientLoopRunning", false])}});
        private _vehicles = ((_listTrigger select {(isPlayer _x) && {!(_x isKindOf "Man")}}));

        {
            {
                if ((isPlayer _x) && {!(_x getVariable ["AW_CBRN_isClientLoopRunning", false])}) then {
                    _players pushBackUnique _x;
                };
            } forEach (crew _x);
        } forEach _vehicles;

        {
            [_x, _threatPos, _threatRadius, _lifeExpectancy] remoteExec ["AW_fnc_CBRNClientLoop", (owner _x)];
        } forEach _players;

        sleep _interval;
    };

    InA_CBRN_WrapperRunning = false;
};
