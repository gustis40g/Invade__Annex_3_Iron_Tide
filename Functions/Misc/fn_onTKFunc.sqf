
if (!hasInterface) exitWith {};
if (player getVariable ["InA_isZeus", false]) exitWith {};
if ((player getVariable 'timeTKd' == round(time)) || (roleDescription player find "Pilot" > -1)) exitWith {};

amountOfTKs = amountOfTKs + 1;
player setVariable ['timeTKd', round (time), false];

params ["_killed"];
hintC format ["%1, you just teamkilled %2, which is not allowed. You should apologize to %2.", name player, _killed];

[] spawn {
    sleep 6000;
    amountOfTKs = amountOfTKs - 1;
};

if (amountOfTKs == (TKLimit -1)) exitWith {
    player enableSimulation false;
    titleText ["<t align='center'><t size='1.6' font='PuristaBold'>Simulation has been disabled as a result of excessive teamkilling. </t><br /> <t size='1.2' font='PuristaBold'>This is a final warning.  Respawn to re-enable simulation and make this message disappear.</t><br /><br /><t size='0.9' font='PuristaBold'>If you continue to teamkill AhoyWorld cannot be held responsible for the consequences.</t></t>", "BLACK", 2, true, true];
    [] spawn {
        waitUntil{!alive player};
        titleFadeOut 0;
    };
};

if (amountOfTKs >= TKLimit) exitWith {
    private _uid = getPlayerUID player;

    [player, format["Automated server message: %1 will be kicked for teamkilling.", name player]] remoteExecCall ["sideChat", 0];
    titleText ["<t align='center'><t size='1.8' font='PuristaBold'>You have exceeded the server limit for teamkills. <br /> You will be kicked shortly.</t><br /> <t size='1.2' font='PuristaBold'>Your unique ID has been logged along with with your name.</t><br/><br /><t size='1.0' font='PuristaBold'>This message will not go away. In 30 seconds or when you open the esc-menu, you will be kicked from the server.</t><br/><br/><t size='0.8' font='PuristaBold'>We reserve the right to ban you for these teamkills, this may happen without any further notice.</t></t>", "BLACK", 2, true, true];
    private _diagLogTxt = format ["Player '%1' / '%2' will be kicked for teamkilling", (name player), _uid];
    [_diagLogTxt, "KICK"] call AW_fnc_log;
    player enableSimulation false;

    player spawn {
        waitUntil {!isNull (findDisplay 49)};
        [_this] remoteExec ["AW_fnc_handleServerKick", 2];
    };
    kickOnRespawn = true;

    player spawn {
        sleep 30;
        [_this] remoteExec ["AW_fnc_handleServerKick", 2];
    };
};
