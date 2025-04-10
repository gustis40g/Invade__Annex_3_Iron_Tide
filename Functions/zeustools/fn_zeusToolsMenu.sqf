#include "zeustools_macros.hpp"
/*
 * Author: Whigital
 * Description:
 * Generates zeusTools commandingMenu
 *
 */

private _active = (format ["%1", ([0, 1] select (player getVariable ["InA_isAdmin", false]))]);


// Main menu
MENU(Main) = [
    ["Zeus Tools", true],
    ["Global hints",    [0], USERMENU(Hints),       -5, [["expression", ""]], "1", "1"],
    ["Invade & Annex",  [0], USERMENU(InA),         -5, [["expression", ""]], "1", _active],
    ["Mission related", [0], USERMENU(Mission),     -5, [["expression", ""]], "1", "1"],
    ["World",           [0], USERMENU(World),       -5, [["expression", ""]], "1", "1"],
    ["Object",          [0], USERMENU(Object),      -5, [["expression", ""]], "1", "1"],
    ["Admin",           [0], USERMENU(Admin),       -5, [["expression", ""]], "1", _active],
    ["Abilites",        [0], USERMENU(Abilities),   -5, [["expression", ""]], "1", "1"],
    ["Group",           [0], USERMENU(Group),       -5, [["expression", ""]], "1", "1"]
];


// Main -> Global hints
#include "menus\menu_Hints.inc"

// Main -> Invade & Annex
#include "menus\menu_InA.inc"

// Main -> Mission related
#include "menus\menu_Mission.inc"

// Main -> World related
#include "menus\menu_World.inc"

// Main -> Object
#include "menus\menu_Object.inc"

// Main -> Admin
#include "menus\menu_Admin.inc"

// Main -> Abilities
#include "menus\menu_Abilities.inc"

// Main -> Group
#include "menus\menu_Group.inc"


// Show the menu
showCommandingMenu USERMENU(Main);
