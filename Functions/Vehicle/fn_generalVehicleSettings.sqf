params ["_veh"];

if (!isServer) exitWith {};

if (!alive _veh) exitWith {
    ["Dead or null vehicle passed to fn_generalVehicleSettings", "Veh setup", false] call AW_Fnc_log;
};

[_veh] spawn AW_fnc_vehicleInventory;
[_veh] spawn AW_fnc_slingloadEH;

[_veh] remoteExec ["AW_fnc_repairAddServiceActions", 0, true];

if ((_veh isKindOf "Land") && {!((typeOf _veh) in ["Quadbike_01_base_F", "Kart_01_Base_F", "vn_bicycle_base"])}) then {
    [_veh] remoteExec ["AW_fnc_invAddActions", 0, true];
};

//=====fuel function
[   _veh,
    [
        "<t color='#d4d400' size='1.2' font='PuristaBold'><img size='1.1' image='\a3\ui_f\data\IGUI\Cfg\Actions\refuel_ca.paa' /> Refuel vehicle</t>",
        {
            params ["_target", "_caller", "_actionId", "_arguments"];

            _caller playMove "AinvPknlMstpSnonWnonDr_medicUp1";
            playSound3D ["a3\sounds_f\sfx\ui\vehicles\vehicle_refuel.wss", _target, false, (AGLToASL (_caller modelToWorld [0, 0.5, 0.5])), 1, 1, 15];
            [_target, 0.1] call AW_fnc_vehicleFieldRefuel;
        },
        "",
        6,
        true,
        true,
        "",
        "
            (isNull (objectParent _this)) && {
                !(_target getVariable ['InA_Service_VehicleIsServicing', false]) && {
                    ((fuel _target) < 0.1) && {
                        (_this getUnitTrait 'engineer') && {
                            'ToolKit' in (items _this)
                        }
                    }
                }
            }
        ",
        5
    ]
] remoteExecCall ["addAction", 0, true];

// Pilot field repair actions
if ((_veh isKindOf "Helicopter") || (_veh isKindOf "VTOL_Base_F")) then {
    [_veh] remoteExec ["AW_fnc_aircraftFieldActions", 0, true];
    [_veh, false] remoteExec ["enableCopilot", 0, true];

    [_veh] remoteExec ["AW_fnc_aircraftToggleCoPilotPassengerActions", 0, true];
};

//====unflip function
[
    _veh,
    "<t color='#00dd22' size='1.5' font='PuristaBold'><img size='1.1' image='\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\repair_ca.paa' /> Unflip vehicle</t>",
    "\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\repair_ca.paa",
    "\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\repair_ca.paa",
    "(speed _target) < 1 && {(abs ((_target call BIS_fnc_getPitchBank) # 1) > 65)}",
    "(speed _target) < 1 && {(abs ((_target call BIS_fnc_getPitchBank) # 1) > 65)}",
    { },
    {
        params ["", "", "", "", "_progress", "_maxProgress"];
        hintSilent format["Flipping vehicle %1%2", round((_progress/_maxProgress)*100), "%"];
    },
    {
        params ["_targetVehicle"];
        _targetVehicle setVectorUp (surfaceNormal (getPosATL _targetVehicle));
        _targetVehicle setPosATL [((getPosATL _targetVehicle) # 0), ((getPosATL _targetVehicle) # 1), 0.1];
        hintSilent "";
    },
    {
        hint "Unflipping stopped";
    },
    [],
    10,
    0,
    false,
    false,
    false
] remoteExecCall ["BIS_fnc_holdActionAdd", 0, true];

// Revive action on medical vehicles
if ((_veh isKindOf "B_Truck_01_medical_F") || (_veh isKindOf "C_Van_02_medevac_F") || (_veh isKindOf "B_Slingload_01_Medevac_F") || (_veh isKindOf "Land_Pod_Heli_Transport_04_medevac_F")) then {
    [
        _veh,
        "<t color='#ff4400' size='1.1' font='PuristaBold'>Revive player(s)</t>",
        "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_reviveMedic_ca.paa",
        nil,
        "[_target, _this] call AW_fnc_passiveReviveCond",
        "[_target, _this] call AW_fnc_passiveReviveCond",
        nil,
        nil,
        {
            params ["_target", "_caller", "_actionId", "_arguments"];

            [_target] remoteExec ["AW_fnc_passiveRevive", 2];
        },
        nil,
        nil,
        5,
        11,
        false
    ] remoteExecCall ["BIS_fnc_holdActionAdd", 0, true];
};

//====Flag function
if ( _veh isKindOf "LandVehicle" && (((typeOf _veh) find "B_" == -1) || ((typeOf _veh) find "B_G_" != -1))) then {
	_veh forceFlagTexture "\A3\Data_F\Flags\Flag_nato_CO.paa";
};

//====Plates
if (isClass (configFile >> "CfgVehicles" >> typeOf _veh >> "PlateInfos")) then {
    private _plates = [];
    _plates pushBack format ["Terminator %1", round (random 8) + 1];
    _plates pushBack format ["Devastator %1", round (random 8) + 1];
    _plates pushBack format ["Lifesaver %1", round (random 8) + 1];
    _plates pushBack format ["Big Gun %1", round (random 8) + 1];
    _plates pushBack format ["Angel %1", round (random 8) + 1];

    _veh setPlateNumber (selectRandom _plates);
};

//====UAV crew
if (_veh isKindOf "UAV") then {
    {_x call AW_fnc_delete} forEach (crew _veh);
    [_veh] spawn {
        params ["_uav"];

        sleep 2;
        createVehicleCrew _uav;
        (group (driver _uav)) setGroupIdGlobal [format ['UAV-%1', round(random 500)]];
        [(crew _uav) + [_uav]] call AW_fnc_addToAllCurators;
        _uav setAutonomous false;
    };

    [
        _veh,
        [
            "<t color='#ff2222'>Despawn UAV</t>", {
                params ["_target", "_caller", "_actionId", "_arguments"];

                [_target] remoteExec ["AW_fnc_delete", 2];
            },
            nil,
            -100,
            false,
            true,
            "",
            "(_this getUnitTrait 'UAVHacker')",
            8
        ]
    ] remoteExec ["addAction", 0, true];
};

if ( _veh isKindOf "Air" ) then {
    //===Remove laser designators
    {
        _weaponlist = weapons _veh;
        if (_x in _weaponlist) then {
            _veh removeWeapon _x
        };
    } forEach ["Laserdesignator_pilotCamera","Laserdesignator_mounted"];

    if (!(_veh isKindOf "Helicopter") && !(_veh isKindOf "VTOL_Base_F")) then {
        _veh addEventHandler ["GetOut", {
            params ["_vehicle", "_role", "_unit"];

            if (!alive _vehicle) exitWith {};
            if (_role != "driver" && _role != "gunner") exitWith {};

            private _ejectionSeats = [
                "B_Ejection_Seat_Plane_Fighter_01_F",
                "B_Ejection_Seat_Plane_CAS_01_F",
                "O_Ejection_Seat_Plane_CAS_02_F",
                "O_Ejection_Seat_Plane_Fighter_02_F",
                "I_Ejection_Seat_Plane_Fighter_04_F",
                "I_Ejection_Seat_Plane_Fighter_03_F",
                "vn_b_air_f4b_ejection_seat_01"
            ];

            if (typeOf vehicle _unit in _ejectionSeats) then {
                [_vehicle] spawn {
                    sleep 5;
                    (_this select 0) setDamage 1;
                };
            };
        }];
    };
};

// Respawn script last used timer EH (VehicleRespawn.sqf/isAbandoned)
_veh addEventHandler ["GetOut", {
    params ["_vehicle", "_role", "_unit"];

    if ((count (crew _vehicle)) == 0) then {
        _vehicle setVariable ["InA_VehicleLastTimeUsed", serverTime];
    };
}];

if (_veh isKindOf "vn_helicopter_base") then {
    {
        _veh removeWeaponTurret [_x, [-1]];
    } forEach ["vn_v_launcher_m61", "vn_v_launcher_m7"];
};

// Disable slingloading of Taru pods, as a Ghosthawk can sling them, which
// seems a little OP. With slingloading disabled, you have to use the Taru
// Heavy Lifter attach functionality.
if ((_veh isKindOf "Pod_Heli_Transport_04_base_F") || (_veh isKindOf "Pod_Heli_Transport_04_crewed_base_F")) then {
    [_veh, false] remoteExec ["enableRopeAttach", _veh];
};

//=== Zues
[[_veh]] call AW_fnc_addToAllCurators;
