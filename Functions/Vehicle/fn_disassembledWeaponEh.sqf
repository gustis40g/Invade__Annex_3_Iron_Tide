params [
    "_static"
];

// Make sure the execution comes from the server ....
if (!isServer) exitWith {
    [_static] remoteExec ["AW_fnc_disassembledWeaponEh", 2];
};

[_static, {
    params [
        ["_static", objNull]
    ];

    // JIP: Static already removed, exit without any actions ....
    if (isNull _static) exitWith {};

    _static addEventHandler ["Disassembled", {
        params ["_entity", "_primaryBag", "_secondaryBag"];

        // Only fire the event where the static is local ....
        if (!local _entity) exitWith {};

        [[_entity]] remoteExec ["AW_fnc_removeFromAllCurators", 2];
    }];
}] remoteExec ["spawn", 0, _static];
