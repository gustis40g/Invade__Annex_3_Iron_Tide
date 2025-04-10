/*
 * Author: Whigital
 *
 * Description:
 * Displays welcome message or Zeus notification
 *
 */

params [["_player", objNull]];

if (isNull _player) exitWith {};

private _isCoreStaff = (_player getVariable ["InA_isCoreStaff", false]);
private _isAdmin = (_player getVariable ["InA_isAdmin", false]);
private _isZeus = (_player getVariable ["InA_isZeus", false]);

private _name = (name _player);

private _msg = (parseText format ["<t align='center' font='PuristaBold'><t size='1.6'>%1</t><br /><t size='1.2'>Welcome %2</t><br /><t size='0.8' font='PuristaMedium'>Ensure you are familiar with our server rules:<br />www.ahoyworld.net/index/rules</t></t>", "INVADE AND ANNEX", _name]);

switch (true) do {
    case _isCoreStaff: {
        _msg = (parseText format ["<br /><t align='center' font='PuristaBold' ><t size='1.6'>%1</t><br /><t size='1.2'>Welcome %2</t></t>", "ZEUS (CORE STAFF) ASSIGNED", _name]);
    };

    case _isAdmin: {
        _msg = (parseText format ["<br /><t align='center' font='PuristaBold' ><t size='1.6'>%1</t><br /><t size='1.2'>Welcome %2</t></t>", "ZEUS (PUBLIC MOD) ASSIGNED", _name]);
    };

    case _isZeus: {
        _msg = (parseText format ["<br /><t align='center' font='PuristaBold' ><t size='1.6'>%1</t><br /><t size='1.2'>Welcome %2</t></t>", "ZEUS (SPARTAN) ASSIGNED", _name]);
    };
};

[_msg, true, nil, 12, 0.3, 0.3] call BIS_fnc_textTiles;
