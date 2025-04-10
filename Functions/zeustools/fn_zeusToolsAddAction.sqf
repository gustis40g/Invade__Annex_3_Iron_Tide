/*
 * Author: Whigital
 * Description:
 * Adds zeusTools action
 *
 */

params ["_unit"];

_unit addAction [
    "<t color='#FF9D00'>Spartan/Mod Tools</t>",
    {
        0 = [] spawn AW_fnc_zeusToolsMenu;
    },
    [],
    -100,
    false,
    true
];
