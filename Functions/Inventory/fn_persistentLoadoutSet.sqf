/*
 * Author: Whigital
 * Description:
 * Sets role based persisted loadout in profileNamespace
 *
 */

params ["_unit"];

private _unitType = (typeOf _unit);

private _loadoutHash = (profileNamespace getVariable ["InA_PersistedLoadouts", []]);

if !(_loadoutHash isEqualType createHashMap) then {
    _loadoutHash = createHashMapFromArray [
        [InA_PlayerFaction, createHashMap]
    ];
};

private _factionHash = (_loadoutHash getOrDefault [InA_PlayerFaction, createHashMap]);

if (_factionHash isEqualType createHashMap) then {
    _factionHash set [_unitType, (getUnitLoadout _unit)]
};

profileNamespace setVariable ["InA_PersistedLoadouts", _loadoutHash];

saveProfileNamespace
