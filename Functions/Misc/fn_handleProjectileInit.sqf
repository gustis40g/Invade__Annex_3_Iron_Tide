/*
 * Author: Whigital
 * Description:
 * Initializes crater creation mechanics
 *
 */

if (!isNil "InA_ImpactCraterInitialized" && {InA_ImpactCraterInitialized}) exitWith {};

if (isServer) then {
    InA_ImpactCraterObjects = [];
};

InA_ImpactCraterAmmoHash = createHashMap;

private _ammoParams = toString {
    ((getText (_x >> "simulation")) in ["shotMissile", "shotShell", "shotRocket", "shotMine"]) && {
        (getNumber (_x >> "hit")) >= 150
    }
};

private _ammoClasses = (_ammoParams configClasses (configFile >> "CfgAmmo"));

{

    private _className = (configName _x);

    // Exclude Zeus Lightning Bolt so we can abuse without lag ....
    if (_className == "LightningBolt") then {continue};

    private _hit = (getNumber (_x >> "hit"));
    private _magnitude = (linearConversion [150, 2000, _hit, 0.25, 2, true]);
    private _radius = (getNumber (_x >> "indirectHitRange"));

    if (_radius < 2) then {_radius = 2};

    InA_ImpactCraterAmmoHash insert [[_className, [_magnitude, _radius]]];
} forEach _ammoClasses;

InA_ImpactCraterProjectileEhIdx = addMissionEventHandler ["ProjectileCreated", {
    params ["_projectile"];

    if (((typeOf _projectile) in InA_ImpactCraterAmmoHash) && {local _projectile}) then {
        _projectile addEventHandler ["Explode", {
            params ["_projectile", "_pos", "_velocity"];

            private _impact = ((!surfaceIsWater _pos) && {((ASLToATL _pos) # 2) < 0.1});

            if (_impact) then {
                [(typeOf _projectile), _pos] remoteExecCall ["AW_fnc_handleProjectileExplosion", 2];
            };
        }];
    };
}];

InA_ImpactCraterInitialized = true;
