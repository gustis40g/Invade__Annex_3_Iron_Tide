/*
fn_getCurrentAOName.sqf

Returns the name of the current AO
*/

private _aoName = "";

if (!isNil "InA_Server_currentAO") then {
    _aoName = (missionConfigFile >> worldName >>  "AOs" >> InA_Server_currentAO >> "name") call BIS_fnc_getCfgData;
};

_aoName
