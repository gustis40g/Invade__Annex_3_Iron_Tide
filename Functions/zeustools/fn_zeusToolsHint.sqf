/*
 * Author: Whigital
 * Description:
 * zeusTools Global Hints
 *
 */

params ["_hintType"];

if (!isServer) exitWith {};

if (isRemoteExecuted && {!([remoteExecutedOwner] call AW_fnc_isZeus)}) exitWith {
    // Go away non Zeus player
};

// Send Hint clear on empty args
if (isNil "_hintType") exitWith {
    [""] remoteExec ["AW_fnc_globalHint", 0];
};

private _msg = "";

switch (_hintType) do {
    case "FFWarn": {
        _msg = "<t align='center' font='PuristaBold' ><t size='1.4' color='#ff0000'>WARNING to ALL</t><t size='0.9'><br /> Check your targets,<br />Continued FF will result in Kick or Ban.<br />Not sure? Dont fire! </t></t>";
    };

    case "ZeusSpam": {
        _msg = "<t align='center' font='PuristaBold' ><t size='1.4' color='#ff0000'>WARNING to ALL</t><t size='0.9'><br />Do not spam the zeus key (Y)<br /> This could result in action being taken against you.</t></t>";
    };

    case "ZeusActive": {
        _msg = "<t align='center' font='PuristaBold' ><t size='1.2'>Message from zeus</t><t size='0.8'><br />Zeus is now active, AI is no longer dumb.<br />They now see tracers, IR lasers, hear gunshots, ...</t></t>";
    };

    case "StealVehicle": {
        _msg = "<t align='center' font='PuristaBold' ><t size='1.4' color='#ff0000'>Do NOT steal vehicles</t><t size='0.9'><br />Warning to all - do not steal vehicles.  Further stealing of vehicles will result in a kick or ban.<br />Not sure if a vehicle is taken?  Ask.</t></t>";
    };

    case "CASWarn": {
        _msg = "<t align='center' font='PuristaBold' ><t size='1.2' color='#ff0000'>Support assets such as mortar or CAS must be called in by infantry, Uncalled CAS or mortar could result in a kick or ban!</t></t>";
    };
};

[_msg] remoteExec ["AW_fnc_globalHint", 0];
