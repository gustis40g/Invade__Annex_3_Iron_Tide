/*
 * Author: Whigital
 *
 * Description:
 * Displays join hint
 *
 */

private _name = (name player);
private _uid = (getPlayerUID player);

private _hint = "";

switch (true) do {
    case (player getVariable ["InA_isCoreStaff", false]): {
        _hint = format ["<t align='center' size='2.2' color='#FF0000'>%1<br/></t><t size='1.4' color='#33CCFF'>%2</t><br/>has joined the server. To get involved in the Ahoy World community, register an account at www.AhoyWorld.net and get stuck in!</t><br/>", "AhoyWorld Core Staff", _name];
    };

    case (player getVariable ["InA_isAdmin", false]): {
        _hint = format ["<t align='center' size='2.2' color='#FF0000'>%1<br/></t><t size='1.4' color='#33CCFF'>%2</t><br/>has joined the server. To get involved in the Ahoy World community, register an account at www.AhoyWorld.net and get stuck in!</t><br/>", "AhoyWorld Public Moderator", _name];
    };

    case (player getVariable ["InA_isZeus", false]): {
        _hint = format ["<t align='center' size='2.2' color='#FF0000'>%1<br/></t><t size='1.4' color='#33CCFF'>%2</t><br/>has joined the server. To get involved in the Ahoy World community, register an account at www.AhoyWorld.net and get stuck in!</t><br/>", "AhoyWorld Spartan", _name];
    };

    default {
        private _infoArray = (squadParams player);

        if ((count _infoArray) > 0) then {
            _infoArray params ["_squadArray", "_memberArray"];
            _squadArray params ["_squadNick" , "_squadName", "_squadEmail", "_squadWeb", "_squadPicture", "_squadTitle"];
            _memberArray params ["_memberId", "_memberNick", "_memberName", "_memberEmail", "_memberIcq", "_memberRemark"];

            if (_squadEmail != "staff@ahoyworld.net") exitWith {};

            private _allowedSquads = ["AhoyWorld Core Staff", "AhoyWorld Moderator", "AW Invade and Annex Developer", "AhoyWorld Enhanced Veteran",
                "AhoyWorld Spartan", "Ahoyworld Member", "AhoyWorld Donator", "Xwatt's Bear Battalion", "Lindi's Ye' Old Geezers","Itsmemario's Pizza Patrol",
                "Solex's Fire and Rescue Squad", "ahoyworld member 2", "Ahoyworld Member 2", "ahoyworld field ambassador", "AhoyWorld Enhanced Veteran",
                "AhoyWorld Field Ambassador"
            ];

            if !(_squadName in _allowedSquads) exitWith {
                private _text = format ["Player %1 (%2) joined with a the ahoyworld staff email in their squad XML (%3). Possible hacking attempt.", _name, _uid, _squadName];
                [_text, "SQUAD XML", true] call AW_fnc_log;
            };

            _hint = format ["<t align='center' size='2.2' color='#FF0000'>%1<br/></t><t size='1.4' color='#33CCFF'>%2</t><br/>has joined the server. To get involved in the Ahoy World community, register an account at www.AhoyWorld.net and get stuck in!</t><br/>", _squadName, _memberNick];
        };
    };
};

//if (profileNamespace getVariable ["AW_I&A_disableJoinHint", false]) exitWith {};

if (_hint != "") then {
    [_hint] remoteExec ["AW_fnc_globalHint", 0, false];
};
