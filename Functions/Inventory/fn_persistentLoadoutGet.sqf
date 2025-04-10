/*
 * Author: Whigital
 * Description:
 * Gets role based persisted loadout from profileNamespace
 *
 */

params ["_unit"];

private _loadoutHash = (profileNamespace getVariable ["InA_PersistedLoadouts", []]);

if !(_loadoutHash isEqualType createHashMap) exitWith {
    []
};

private _factionHash = (_loadoutHash getOrDefault [InA_PlayerFaction, []]);

if !(_factionHash isEqualType createHashMap) exitWith {
    []
};

private _unitType = (typeOf _unit);

private _classLoadout = (_factionHash getOrDefault [_unitType, []]);

_classLoadout
