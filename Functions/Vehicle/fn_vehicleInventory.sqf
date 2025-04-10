/*
author: stanhope, AW community member.

description: tweaks the vehicle inventory
*/
params ["_vehicle"];

if (!alive _vehicle) exitWith {};

if (!canSuspend) exitWith {
    _this spawn AW_fnc_vehicleInventory;
};

if (isNil "InA_PlayerFaction") then {
    waituntil {
        sleep 0.1;
        (!isNil "InA_PlayerFaction")
    };
};

if (isNil "InA_VehicleInventory_Defined") then {
    execVM (format ["Scripts\vehicle\VehicleInventory_%1.sqf", InA_PlayerFaction]);
    waitUntil {sleep 0.1; !isNil "InA_VehicleInventory_Defined" && {InA_VehicleInventory_Defined}};
};

clearWeaponCargoGlobal _vehicle;
clearItemCargoGlobal _vehicle;
clearMagazineCargoGlobal _vehicle;
clearBackpackCargoGlobal _vehicle;

private _vehicleType = (typeOf _vehicle);
private _FAKCount = ([_vehicleType, true] call BIS_fnc_crewCount) max 5;
_vehicle addItemCargoGlobal [InA_VehicleInventory_FAK, _FAKCount];

switch (true) do {
    case (_vehicle isKindOf "UAV"): {
        /*We don't want to do anything with a UAV*/
    };

    case (_vehicle isKindOf "Air"): {
       [_vehicle] call InA_VehicleInventory_airCode;
    };

    case (_vehicle isKindOf "Quadbike_01_base_F"): {
        /*We don't want to do anything with a quad*/
    };

    case (_vehicle isKindOf "Kart_01_Base_F"): {
        /*We don't want to do anything with a kart*/
    };

    case (_vehicle isKindOf "vn_bicycle_base"): {
        /*We don't want to do anything with a bike*/
    };

    case (_vehicle isKindOf "Land"): {
       [_vehicle] call InA_VehicleInventory_landCode;
    };
};
