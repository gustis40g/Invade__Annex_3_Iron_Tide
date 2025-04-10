/*
 * Author: Whigital
 * Description:
 * Adds pilot specific actions to unit
 *
 */

params ["_unit"];

// Supplybox load condition code
if (isNil "Cond_HeliLoadSupplybox") then {
    Cond_HeliLoadSupplybox = {
        params ["_unit"];

        private _vehicle = (objectParent _unit);

        // Already has box loaded
        if (_vehicle getVariable ["InA_HasSupplyboxLoaded", false]) exitWith {false};

        // Not in a vehicle
        if (isNull _vehicle) exitWith {false};

        // Not piloting
        if ((driver _vehicle) != _unit) exitWith {false};

        // Not in a heli
        if !(
            (_vehicle isKindOf "Helicopter") ||
            (_vehicle isKindOf "VTOL_02_base_F")
        ) exitWith {false};

        // Not landed
        if (!isTouchingGround _vehicle) exitWith {false};

        // Wrong type of heli
        if (
            (_vehicle isKindOf "Heli_Light_01_base_F") ||
            (_vehicle isKindOf "Heli_Transport_04_base_F") || (
                (!isNil {_vehicle getVariable ["InA_AssetType", nil]}) && {
                    ((_vehicle getVariable "InA_AssetType") == "CAS")
                }
            )
        ) exitWith {false};

        private _pos = (getPosATL _vehicle);

        // Not near a heli pad
        if ((count (_vehicle nearObjects ["Land_HelipadSquare_F", 4])) < 1) exitWith {false};

        // Pad not at base/fob
        if (!([_vehicle, 75] call AW_fnc_isNearBase)) exitWith {false};

        true
    };
};


// Supplybox unload condition code
if (isNil "Cond_HeliDropSupplybox") then {
    Cond_HeliDropSupplybox = {
        params ["_unit"];

        private _vehicle = (objectParent _unit);

        // Not in a vehicle
        if (isNull _vehicle) exitWith {false};

        // No box loaded
        if (!(_vehicle getVariable ["InA_HasSupplyboxLoaded", false])) exitWith {false};

        // Not piloting
        if ((driver _vehicle) != _unit) exitWith {false};

        private _pos = (getPos _vehicle);

        // Over water
        if (surfaceIsWater _pos) exitWith {false};

        // Not landed and too low
        if ((!isTouchingGround _vehicle) && ((_pos # 2) < 50)) exitWith {false};

        // To close to base/fob
        if ([_vehicle] call AW_fnc_isNearBase) exitWith {false};

        true
    };
};


// Ghost Hawk doors action
0 = ["Respawn"] spawn AW_fnc_helicopterDoors;


// Despawn damaged heli
_unit addAction [
    "<t color='#99ffc6'>Despawn damaged helicopter</t>",
    {
        params ["_target", "_caller", "_actionId", "_arguments"];

        if ([_caller] call AW_fnc_isNearBase) then {
            private _vehicle = (vehicle _caller);
            moveOut _caller;
            _vehicle call AW_fnc_delete;
            [parseText format ["<br /><br /><t align='center' font='PuristaBold'><t size='1.2'>Helicopter successfully despawned.</t></t>"], true, nil, 4, 0.5, 0.3] spawn BIS_fnc_textTiles;
        } else {
            [parseText format ["<br /><t align='center' font='PuristaBold'><t size='1.2'>This action is not allowed outside of base.</t><t size='1.0'><br /> Helicopter not despawned</t></t>"], true, nil, 6, 0.5, 0.3] spawn BIS_fnc_textTiles;
        }
    },
    [],
    -100,
    false,
    true,
    "",
    "((vehicle _originalTarget) isKindOf 'Helicopter') && {((speed _target) < 2) && {(count (crew _target) == 1) && {((!canMove _target) || ((fuel _target) <= 0))}}}",
    10
];


// Load supplybox
[
    _unit,
    "<t color='#00dd22' size='1.1' font='PuristaBold'><img size='1.1' image='\a3\data_f_destroyer\data\UI\IGUI\Cfg\holdactions\holdAction_loadVehicle_ca.paa' /> Load Supplybox</t>",
    "\a3\data_f_destroyer\data\UI\IGUI\Cfg\holdactions\holdAction_loadVehicle_ca.paa",
    "\a3\data_f_destroyer\data\UI\IGUI\Cfg\holdactions\holdAction_loadVehicle_ca.paa",
    "[_target] call Cond_HeliLoadSupplybox",
    "[_target] call Cond_HeliLoadSupplybox",
    {},
    {},
    {
        params ["_target", "_caller", "_actionId", "_arguments"];

        private _vehicle = (objectParent _target);
        _vehicle setVariable ["InA_HasSupplyboxLoaded", true, true];
        [parseText "<br/><br/><t align='center' font='PuristaBold'><t size='1.2'>Supplybox loaded</t></t>", true, nil, 2, 0.5, 0.3] spawn BIS_fnc_textTiles;
    },
    {},
    [],
    5,
    100,
    false,
    false,
    false
] call BIS_fnc_holdActionAdd;


// Drop supplybox
[
    _unit,
    "<t color='#00dd22' size='1.1' font='PuristaBold'><img size='1.1' image='\a3\data_f_destroyer\data\UI\IGUI\Cfg\holdactions\holdAction_unloadVehicle_ca.paa' /> Unload Supplybox</t>",
    "\a3\data_f_destroyer\data\UI\IGUI\Cfg\holdactions\holdAction_unloadVehicle_ca.paa",
    "\a3\data_f_destroyer\data\UI\IGUI\Cfg\holdactions\holdAction_unloadVehicle_ca.paa",
    "[_target] call Cond_HeliDropSupplybox",
    "[_target] call Cond_HeliDropSupplybox",
    {},
    {},
    {
        params ["_target", "_caller", "_actionId", "_arguments"];

        private _vehicle = (objectParent _target);
        _vehicle setVariable ["InA_HasSupplyboxLoaded", false, true];
        [_vehicle] remoteExec ["AW_fnc_dropSupplybox", 2];

        [parseText "<br/><br/><t align='center' font='PuristaBold'><t size='1.2'>Supplybox unloaded</t></t>", true, nil, 2, 0.5, 0.3] spawn BIS_fnc_textTiles;
    },
    {},
    [],
    2,
    100,
    false,
    false,
    false
] call BIS_fnc_holdActionAdd;
