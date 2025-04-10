/*
 * Author: Whigital
 * Description:
 * Faction validation based on requiredAddons
 *
 */

params ["_faction"];

if (_faction in ["CSAT", "CSAT_T", "AAF"]) exitWith {
    _faction
};

if !(_faction in InA_FactionMappings) then {
    [(format ["Faction '%1' not defined in FactionMapping, defaulting to CSAT ....", _faction]), _fnc_scriptName] call AW_fnc_log;
    _faction = "CSAT";
};

private _factionHash = (InA_FactionMappings get _faction);
private _addons = (_factionHash getOrDefault ["#addons", ["#MISSING#"]]);

_addons = (_addons apply {toLower _x});

private _cfgPatches = (("true" configClasses (configFile >> "CfgPatches")) apply {toLower (configName _x)});

private _hasRequiredAddons = ((_addons arrayIntersect _cfgPatches) isEqualTo _addons);

if (!_hasRequiredAddons) then {
    [(format ["Required addon(s) (%2) for faction '%1' not loaded, defaulting to CSAT ....", _faction, _addons]), _fnc_scriptName] call AW_fnc_log;
    _faction = "CSAT";
};

_faction
