/*
 * Author: Whigital
 *
 * Description:
 * Control helicopter gunner turrets
 *
 */

params ["_oper", "_heli"];

if (isNull _heli) exitWith {};

if (isNil "InA_HeliTurretsControl_TurretData") then {
    InA_HeliTurretsControl_TurretData = createHashMapFromArray [
        ["B_Heli_Transport_01_F", [
            [[1], "LMG_Minigun_Transport"],
            [[2], "LMG_Minigun_Transport2"]
        ]],
        ["vn_b_air_ch34_01_01", [
            [[1], "vn_m60_v_07"]
        ]],
        ["vn_b_air_uh1c_03_01", [
            [[1], "vn_m134_v_09"],
            [[2], "vn_m134_v_10"]
        ]],
        ["vn_b_air_uh1d_03_06",[
            [[1], "vn_m60_v_twin_07"],
            [[2], "vn_m60_v_twin_08"]
        ]]
    ];

    {
        InA_HeliTurretsControl_TurretData insert [
            [_x, [
                [[1], "vn_m60_v_07"],
                [[2], "vn_m60_v_08"]
            ]]
        ];
    } forEach [
        "vn_b_air_uh1d_02_01", "vn_b_air_uh1c_07_01", "vn_b_air_uh1c_07_06",
        "vn_b_air_uh1d_02_06", "vn_b_air_uh1c_01_01", "vn_b_air_uh1c_02_01",
        "vn_b_air_uh1e_01_04", "vn_b_air_uh1e_02_04"
    ];

    {
        InA_HeliTurretsControl_TurretData insert [
            [_x, [
                [[1], "vn_m60_v_08"],
                [[2], "vn_m60_v_07"]
            ]]
        ];
    } forEach [
        "vn_b_air_ch34_04_01", "vn_b_air_ch34_04_02",
        "vn_b_air_ch34_03_01", "vn_b_air_ch34_04_04"
    ];
};

private _turretData = InA_HeliTurretsControl_TurretData getOrDefault [(typeOf _heli), []];

if (_turretData isEqualTo []) exitWith {};

switch (_oper) do {
    case "toggle": {
        private _turretStatus = (_heli getVariable ["InA_turretsEnabled", true]);

        if (_turretStatus) then {
            {
                _x params ["_turret", "_weapon"];

                private _owner = (_heli turretOwner _turret);

                [_heli, [_weapon, _turret]] remoteExecCall ["removeWeaponTurret", _owner];
            } forEach _turretData;

            _heli setVariable ["InA_turretsEnabled", false, true];
        } else {
            {
                _x params ["_turret", "_weapon"];

                private _owner = (_heli turretOwner _turret);

                [_heli, [_weapon, _turret]] remoteExecCall ["addWeaponTurret", _owner];
            } forEach _turretData;

            _heli setVariable ["InA_turretsEnabled", true, true];
        };
    };

    case "actions": {
        {
            _x params ["_turret", "_weapon"];

            [_heli, [_weapon, _turret]] remoteExecCall ["removeWeaponTurret", _heli];
        } forEach _turretData;

        _heli setVariable ["InA_turretsEnabled", false, true];

        [
            _heli, ["Enable turrets", {
                params ["_target", "_caller", "_actionId", "_arguments"];
                ["toggle", _target] remoteExecCall ["AW_fnc_heliTurretsControl", 2];
                _target vehicleChat "Turret(s) enabled ....";
            }, [], -20, false, true, "", "(_this == (driver _target)) && {(!(_target getVariable ['InA_turretsEnabled', false]))}", -1, false
        ]] remoteExecCall ["addAction", 0, true];

        [
            _heli, ["Disable turrets", {
                params ["_target", "_caller", "_actionId", "_arguments"];
                ["toggle", _target] remoteExecCall ["AW_fnc_heliTurretsControl", 2];
                _target vehicleChat "Turret(s) disabled ....";
            }, [], -20, false, true, "", "(_this == (driver _target)) && {(_target getVariable ['InA_turretsEnabled', false])}", -1, false
        ]] remoteExecCall ["addAction", 0, true];
    };
};
