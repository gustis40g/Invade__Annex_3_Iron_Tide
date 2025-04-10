/*
fn_getFOBDisplayName.sqf

params: _base: AO marker name

returns: human readable name for the FOB
*/
params ["_base"];

private _config = (missionConfigFile >> worldName >> "AOs" >> _base);

private _baseName = (getText (_config >> "nameAlt"));

if (_baseName == "") then {
    _baseName = (getText (_config >> "name"));
};

_baseName
