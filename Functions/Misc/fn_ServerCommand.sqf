/*
    fn_ServerCommand

    Executes server commands.

    Params:
        _command: (String)  The command to execute
        _params: (String)   A param to pass to the command

    Returns:
        true for success, false on fail
*/

params ["_command", "_param"];

if (!isServer) exitWith {};

private _serverpassword = [] call InA_Server_fnc_getServerCmdPwd;

private _returnVal = false;

switch (_command) do {
    case "kick": {
        _returnVal = _serverpassword serverCommand format ["#kick %1", _param];
    };
    case "ban": {
        _returnVal = _serverpassword serverCommand format ["#exec ban %1", _param];
    };
    case "clearkicks": {
        _returnVal = _serverpassword serverCommand format ["#exec clearkicks"];
    };
    case "serverRestart": {
        _returnVal = _serverpassword serverCommand "#shutdown";
    };
    case "missionRestart": {
        _returnVal = _serverpassword serverCommand "#restart";
    };
};

_returnVal
