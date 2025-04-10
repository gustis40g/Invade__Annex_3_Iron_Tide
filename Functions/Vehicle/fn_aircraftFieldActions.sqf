params [
    ["_aircraft", objNull]
];

if (isNull _aircraft || !hasInterface) exitWith {};

// Repair action ....
private _cond = {
    ((isNull (objectParent _this)) && (isTouchingGround _target)) && {
        !(_target getVariable ["InA_Service_VehicleIsServicing", false]) && {
            (_this getUnitTrait "fieldMechanic") && {
                (("ToolKit" in (items _this)) || ("vn_b_item_toolkit" in (items _this))) && {
                    ((((getAllHitPointsDamage _target) # 2) findIf {_x > 0.6}) != -1)
                }
            }
        }
    }
};

_aircraft addAction [
    "<t color='#e00000' size='1.2' font='PuristaBold'><img size='1.1' image='\a3\ui_f\data\IGUI\Cfg\Actions\repair_ca.paa' /> Field repair</t>", {
        params ["_target", "_caller", "_actionId", "_arguments"];

        _caller playMove "AinvPknlMstpSnonWnonDnon_medicUp3";
        playSound3D ["a3\sounds_f\sfx\ui\vehicles\vehicle_repair.wss", _target, false, (AGLToASL (_caller modelToWorld [0, 0.5, 0.5])), 1, 1, 15];
        [_target] call AW_fnc_aircraftFieldRepair;
    },
    "",
    7,
    true,
    true,
    "",
    (toString _cond),
    5
];


// Refuel action ....
_cond = {
    ((isNull (objectParent _this)) && (isTouchingGround _target)) && {
        !(_target getVariable ['InA_Service_VehicleIsServicing', false]) && {
            ((fuel _target) < 0.05) && {
                (_this getUnitTrait 'fieldMechanic') && {
                    (("ToolKit" in (items _this)) || ("vn_b_item_toolkit" in (items _this)))
                }
            }
        }
    }
};

_aircraft addAction [
    "<t color='#d4d400' size='1.2' font='PuristaBold'><img size='1.1' image='\a3\ui_f\data\IGUI\Cfg\Actions\refuel_ca.paa' /> Emergency refuel</t>", {
        params ["_target", "_caller", "_actionId", "_arguments"];

        _caller playMove "AinvPknlMstpSnonWnonDr_medicUp1";
        playSound3D ["a3\sounds_f\sfx\ui\vehicles\vehicle_refuel.wss", _target, false, (AGLToASL (_caller modelToWorld [0, 0.5, 0.5])), 1, 1, 15];
        [_target, 0.05] call AW_fnc_vehicleFieldRefuel;
    },
    "",
    6,
    true,
    true,
    "",
    (toString _cond),
    5
];
