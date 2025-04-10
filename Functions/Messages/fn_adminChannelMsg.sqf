params ["_msg", ["_adminsOnly", false, [false]]];

if (!isServer) exitWith {
    _this remoteExec ["AW_fnc_adminChannelMsg", 2];
};

private _channelInfo = (radioChannelInfo InA_Server_adminChannelID);
private _channelUnits = (_channelInfo # 3);
private _receivers = [];

if (_adminsOnly) then {
    {
        if (_x getVariable ["InA_isAdmin", false]) then {
            _receivers pushBackUnique _x;
        };
    } forEach _channelUnits;
} else {
    _receivers = +_channelUnits;
};

_receivers deleteAt (_receivers find Quartermaster);

if (_receivers isNotEqualTo []) then {
    [Quartermaster, [InA_Server_adminChannelID, (format ["%1", _msg])]] remoteExec ["customChat", _receivers];
};
