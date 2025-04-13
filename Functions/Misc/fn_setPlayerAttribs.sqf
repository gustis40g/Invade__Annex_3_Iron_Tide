/*
 * Author: Whigital
 *
 * Description:
 * Sets player variables and params
 *
 */

params [["_player", objNull]];

if (!isServer) exitWith {};

if (isNull _player) exitWith {};

private _uid = (getPlayerUID _player);


private _isZeus = (_uid in (InA_Server_coreStaffUIDs + InA_Server_staffUIDs + InA_Server_spartanUIDs));

if (_isZeus) then {
    _player setVariable ["InA_isZeus", true, true];

    if (_uid in InA_Server_coreStaffUIDs) then {
        _player setVariable ["InA_isCoreStaff", true, true];
        _player setVariable ["InA_isAdmin", true, true];
    };

    if (_uid in InA_Server_staffUIDs) then {
        _player setVariable ["InA_isAdmin", true, true];
    };
};

_player setVariable ["InA_PlayerAttribsSet", true, true];
