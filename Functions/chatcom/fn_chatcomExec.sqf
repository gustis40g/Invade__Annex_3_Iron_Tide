/*****************************************************************************
Function name: RWT_fnc_chatcomExec;
Authors: longbow
License: MIT License

Description:
	Functions executes a command, defined in rwt_chatcom class, and
        passes arguments to it.

Arguments:
	ARRAY [_COM,_ARG1,..,_ARG_N]
		_COM - STRING, name of command from rwt_chatcom class
		_ARG1-_ARGN - STRING, optional arguments to command
*/

if ((toLower _this) find "login" != -1) then {
    _this spawn {
        sleep 1;

        private _msg = "";
        private _logToChat = false;

        switch (true) do {
            case (player getVariable ["InA_isAdmin", false]): {
                _msg = format ["Admin login attempt by Staff: '%1' / '%2'", (name player), (getPlayerUID player)];
            };

            case (player getVariable ["InAisZeus", false]): {
                _msg = format ["Admin login attempt by Zeus: '%1' / '%2'", (name player), (getPlayerUID player)];
            };

            default {
                _msg = format ["Admin login attempt by non Zeus/Staff player: '%1' / '%2'", (name player), (getPlayerUID player)];
                _logToChat = true;
            };
        };

        [_msg, "ADMIN", _logToChat] call AW_fnc_log;
    };
};

if ((toLower _this) find "admin" != -1) then {
    _this spawn {
        private _msg = toLower(_this);
        if (count(_msg) < 7) then {
            hintC "When typing !admin be sure to include a short message as to why you need an admin.";
        };
    };
};
