/*
    Description:
        A simple logging function that'll write to the RPT & if needed log to admin channel
    Author:
        Stanhope

    Params:
        _msg:                   anything:   what you want to log
        _prefix:                string:     the prefix, e.g. error, mainAO, ...
        _sendInAdminChannel:    boolean:    true send to admin channel, false for not.
*/

if (!isServer) exitWith {
    _this remoteExec ["AW_fnc_log", 2];
};

params [
    "_msg",
    ["_prefix", "LOG"],
    ["_sendInAdminChannel", false]
];

private _assembled = format ["[%1] %2", (toUpper _prefix), _msg];

diag_log text format ["[I&A3] %1", _assembled];

if (_sendInAdminChannel) then {
    [_assembled, false] spawn AW_fnc_adminChannelMsg;
};
