/*
 * Author: Whigital
 * Description:
 * Handler responsible for creating craters based on exploding ammo
 *
 */

params ["_ammo", "_pos"];

if (!isServer) exitWith {};

if (_pos call AW_fnc_isNearBase) exitWith {};

if !(_ammo in InA_ImpactCraterAmmoHash) exitWith {};

private _decals = [
    "Crater",
    "Land_DirtPatch_04_F",
    "Land_DirtPatch_05_F"
];

private _debris = [
    "Land_ShellCrater_02_debris_F"
];

private _ttl = 1800;

private _cratersNear = ((nearestObjects [_pos, _decals, (getTerrainInfo # 2)]) isNotEqualTo []);

if (!_cratersNear) then {
    (InA_ImpactCraterAmmoHash get _ammo) params ["_magnitude", "_radius"];

    private _normal = (surfaceNormal _pos);
    setTerrainHeight [[_pos vectorAdd [0, 0, -_magnitude]]];

    private _decal = (selectRandom _decals) createVehicle _pos;
    _decal setDir (random 359);

    private _debris = (selectRandom _debris) createVehicle _pos;
    _debris setDir (random 359);
    _debris setVectorUp _normal;

    InA_ImpactCraterObjects pushback [(serverTime + _ttl), [_decal, _debris]];

    private _foliage = (nearestTerrainObjects [(ASLToAGL _pos), ["TREE", "SMALL TREE", "BUSH"], _radius, false, true]);

    {
        if (alive _x) then {_x setDamage 1};
    } forEach _foliage;
};
