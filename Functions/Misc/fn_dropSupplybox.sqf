/*
 * Author: Stanhope, Whigital
 * Description:
 * Drop supplybox, either by parachute or at groundlevel
 *
 */

params ["_vehicle"];

if (!isServer) exitWith {};

if (!canSuspend) exitWith {
    _this spawn AW_fnc_dropSupplybox;
};

private _fillCrate = {
    params ["_crate"];

    clearWeaponCargoGlobal _crate;
    clearMagazineCargoGlobal _crate;
    clearItemCargoGlobal _crate;
    clearBackpackCargoGlobal _crate;

    _crate addMagazineCargoGlobal ["20Rnd_762x51_Mag", 16];
    _crate addMagazineCargoGlobal ["30Rnd_556x45_Stanag", 30];
    _crate addMagazineCargoGlobal ["30Rnd_65x39_caseless_black_mag", 30];
    _crate addMagazineCargoGlobal ["100Rnd_65x39_caseless_black_mag", 4];
    _crate addMagazineCargoGlobal ["30Rnd_762x39_AK12_Mag_F", 16];
    _crate addMagazineCargoGlobal ["30Rnd_762x39_Mag_F", 16];
    _crate addMagazineCargoGlobal ["75Rnd_762x39_Mag_F", 2];
    _crate addMagazineCargoGlobal ["75rnd_762x39_AK12_Mag_F", 2];
    _crate addMagazineCargoGlobal ["30Rnd_545x39_Mag_F", 8];
    _crate addMagazineCargoGlobal ["10Rnd_50BW_Mag_F", 4];
    _crate addMagazineCargoGlobal ["150Rnd_556x45_Drum_Mag_F", 4];
    _crate addMagazineCargoGlobal ["30Rnd_65x39_caseless_msbs_mag", 16];
    _crate addMagazineCargoGlobal ["200Rnd_65x39_cased_Box", 8];
    _crate addMagazineCargoGlobal ["150Rnd_762x54_Box", 4];
    _crate addMagazineCargoGlobal ["150Rnd_93x64_Mag", 4];
    _crate addMagazineCargoGlobal ["130Rnd_338_Mag", 4];
    _crate addMagazineCargoGlobal ["200Rnd_556x45_Box_F", 4];
    _crate addMagazineCargoGlobal ["10Rnd_Mk14_762x51_Mag", 8];
    _crate addMagazineCargoGlobal ["5Rnd_127x108_Mag", 10];
    _crate addMagazineCargoGlobal ["5Rnd_127x108_APDS_Mag", 6];
    _crate addMagazineCargoGlobal ["7Rnd_408_Mag", 10];
    _crate addMagazineCargoGlobal ["10Rnd_338_Mag", 14];
    _crate addMagazineCargoGlobal ["10Rnd_127x54_Mag", 8];
    _crate addMagazineCargoGlobal ["10Rnd_93x64_DMR_05_Mag", 8];

    _crate addMagazineCargoGlobal ["NLAW_F", 2];
    _crate addMagazineCargoGlobal ["RPG7_F", 4];
    _crate addMagazineCargoGlobal ["RPG32_F", 2];
    _crate addMagazineCargoGlobal ["RPG32_HE_F", 2];
    _crate addMagazineCargoGlobal ["MRAWS_HEAT_F", 4];
    _crate addMagazineCargoGlobal ["MRAWS_HE_F", 2];
    _crate addMagazineCargoGlobal ["Titan_AA", 2];
    _crate addMagazineCargoGlobal ["Titan_AT", 4];
    _crate addMagazineCargoGlobal ["Titan_AP", 2];
    _crate addMagazineCargoGlobal ["Vorona_HEAT", 4];
    _crate addMagazineCargoGlobal ["Vorona_HE", 2];

    _crate addMagazineCargoGlobal ["1Rnd_HE_Grenade_shell", 12];
    _crate addMagazineCargoGlobal ["UGL_FlareWhite_F", 2];
    _crate addMagazineCargoGlobal ["UGL_FlareGreen_F", 2];
    _crate addMagazineCargoGlobal ["UGL_FlareRed_F", 2];
    _crate addMagazineCargoGlobal ["UGL_FlareYellow_F", 2];
    _crate addMagazineCargoGlobal ["UGL_FlareCIR_F", 2];

    _crate addMagazineCargoGlobal ["MiniGrenade", 8];
    _crate addMagazineCargoGlobal ["SmokeShellYellow", 4];
    _crate addMagazineCargoGlobal ["SmokeShellBlue", 4];
    _crate addMagazineCargoGlobal ["SmokeShell", 8];
    _crate addMagazineCargoGlobal ["SmokeShellGreen", 4];

    _crate addMagazineCargoGlobal ["Chemlight_green", 2];
    _crate addMagazineCargoGlobal ["Chemlight_red", 2];
    _crate addMagazineCargoGlobal ["Chemlight_yellow", 2];
    _crate addMagazineCargoGlobal ["Chemlight_blue", 2];

    _crate addMagazineCargoGlobal ["DemoCharge_Remote_Mag", 4];
    _crate addMagazineCargoGlobal ["Laserbatteries", 4];

    _crate addItemCargoGlobal ["FirstAidKit", 16];
};

private _crate = objNull;

if (!isTouchingGround _vehicle) then {
    private _pos = (_vehicle modelToWorld [0, 0, -5]);

    private _crate = createVehicle ["B_supplyCrate_F", _pos, [], 0, "NONE"];
    private _chute = createVehicle ["B_Parachute_02_F", _crate, [], 0, "CAN_COLLIDE"];

    _chute disableCollisionWith _crate;

    _crate attachTo [_chute, [0, 0, -0.45]];

    [_crate] spawn {
        params ["_crate"];

        waitUntil {
            sleep 0.1;
            ((((getPosATL _crate) # 2) < 1) || (!alive _crate))
        };

        detach _crate;
    };

    [_crate] spawn _fillCrate;
} else {
    private _pos = (getPos _vehicle);
    _crate = createVehicle ["B_supplyCrate_F", _pos, [], 8, "NONE"];
    [_crate] spawn _fillCrate;
};

if (alive _crate) then {
    private _smoke = createVehicle ["SmokeShellOrange_Infinite", position _crate, [], 0, "NONE"];
    _smoke attachTo [_crate, [0, 0, 0.5]];

    // Kill smoke after 2 minutes, or crate destruction
    [_crate, _smoke] spawn {
        params ["_crate", "_smoke"];

        private _timer = (serverTime + 120);

        waitUntil {
            sleep 1;
            ((!alive _crate) || (serverTime > _timer))
        };

        detach _smoke;
        deleteVehicle _smoke;
    };

    if (sunOrMoon < 0.5) then {
        private _chemlight = "Chemlight_yellow_Infinite" createVehicle (position _crate);
        _chemlight attachTo [_crate, [0, 0, 0.48]];

        // Remove Chemligt after 5 minutes, or crate destruction
        [_crate, _chemlight] spawn {
            params ["_crate", "_chemlight"];

            private _timer = (serverTime + 300);

            waitUntil {
                sleep 1;
                ((!alive _crate) || (serverTime > _timer))
            };

            detach _chemlight;
            deleteVehicle _chemlight;
        };
    };
};

[_crate] spawn {
    params ["_crate"];

    if (!alive _crate) exitWith {};

    [[_crate]] call AW_fnc_addToAllCurators;

    private _iter = 0;

    waitUntil {
        sleep 60;

        if (!alive _crate) then {break};

        private _playersNear = (((allPlayers - (entities "HeadlessClient_F")) findIf {(_x distance2D _crate) < 250}) != -1);

        if (!_playersNear) then {
            _iter = (_iter + 1);
        } else {
            _iter = 0;
        };

        (!_playersNear && {_iter >= 10})
    };

    deleteVehicle _crate;
};
