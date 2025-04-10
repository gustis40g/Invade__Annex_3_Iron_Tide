//zeusupdater.sqf

if (!isServer) exitWith {};

InA_Server_ZeusUpdaterEnabled = true;

private _interval = 120;
private _lastRun = serverTime;

["Zeus Updater loop starting ....", "ZEUS UPDATER", true] call AW_fnc_log;

while {InA_Server_ZeusUpdaterEnabled} do {
    if (serverTime < (_lastRun + _interval)) then {
        sleep 5;
        continue;
    };

    _lastRun = serverTime;

    private _objects = (call AW_fnc_getEditableObjects);

    {
        [_x, _objects] call AW_fnc_updateEditableObjects;
    } forEach allCurators;
};

["Zeus Updater loop stopped ....", "ZEUS UPDATER", true] call AW_fnc_log;
