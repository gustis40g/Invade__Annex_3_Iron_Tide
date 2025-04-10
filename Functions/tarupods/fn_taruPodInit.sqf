/*
 * Author: Whigital
 *
 * Description:
 * Adds Taru cargo pod attach/detach actions
 *
 */

params [
    "_heli"
];

if (!hasInterface) exitWith {};

// Attach action
_heli addAction ["<img size='1.5' color='#00CC00' shadow='1' image='\a3\data_f_destroyer\data\UI\IGUI\Cfg\holdactions\holdAction_unloadVehicle_ca.paa' /><t size='1.3' shadow='2' color='#00CC00'> Attach Cargo</t>", {
        params ["_target", "_caller", "_actionId", "_arguments"];

        [_target] call AW_fnc_taruPodAttach;
    },
    nil,
    20,
    true,
    true,
    "",
    "[_target, _this, _originalTarget] call AW_fnc_taruPodCanAttach;",
    5
];

// Detach action
_heli addAction ["<img size='1.5' color='#CC0000' shadow='1' image='\a3\data_f_destroyer\data\UI\IGUI\Cfg\holdactions\holdAction_loadVehicle_ca.paa' /><t size='1.3' shadow='2' color='#CC0000'> Detach Cargo</t>", {
        params ["_target", "_caller", "_actionId", "_arguments"];

        [_target] call AW_fnc_taruPodDetach;
    },
    nil,
    20,
    true,
    true,
    "",
    "[_target, _this, _originalTarget] call AW_fnc_taruPodCanDetach;",
    5
];
