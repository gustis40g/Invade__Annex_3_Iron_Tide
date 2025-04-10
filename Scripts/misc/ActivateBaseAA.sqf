/*
author: stanhope

description: executes the function that controlls the AA

this addAction ['<t color=""#ff1111"">Activate Base Air-Defense</t>',{['base'] execVM 'scripts\misc\ActivateBaseAA.sqf'},[],21,true,true,'','((vehicle player) == player)',5];
this addAction ['<t color=""#ff1111"">Activate Carrier Air-Defense</t>',{['carrier'] execVM 'scripts\misc\ActivateBaseAA.sqf'},[],21,true,true,'','((vehicle player) == player)',5];
*/
params ["_type"];

switch (_type) do {
    case "base": {
        ["BASE", player] remoteExec ["AW_fnc_baseAA", 2];
    };
    case "carrier": {
        ["USS_Freedom", player] remoteExec ["AW_fnc_baseAA", 2];
    };
    default {
        hint "Something went wrong while activating base AA, please inform staff of this.";
    };
};
