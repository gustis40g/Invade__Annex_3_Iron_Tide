params [
    "_toRemove"
];

if (!isServer) exitWith {
    [_toRemove] remoteExec ["AW_fnc_removeFromAllCurators", 2];
};

{
    _x removeCuratorEditableObjects [_toRemove, true];
} forEach allCurators;
