InA_VehicleInventory_FAK = "FirstAidKit";

InA_VehicleInventory_addWeaponCode = {
    params ["_vehicle"];

    private _weaponCount = [typeOf _vehicle, false] call BIS_fnc_crewCount;

    _vehicle addWeaponCargoGlobal ["SMG_01_Holo_F", _weaponCount];
    _vehicle addMagazineCargoGlobal ["30Rnd_45ACP_Mag_SMG_01", _weaponCount * 3];
    _vehicle addMagazineCargoGlobal ["30Rnd_45ACP_Mag_SMG_01_Tracer_Red", _weaponCount];
};

InA_VehicleInventory_airCode = {
    params ["_vehicle"];

    private _vehicleType = (typeOf _vehicle);
    private _parachuteCount = [_vehicleType, true] call BIS_fnc_crewCount;

    _parachuteCount = _parachuteCount - ([_vehicleType, false] call BIS_fnc_crewCount);

    if (_vehicle isKindOf "Plane") then {
        _parachuteCount = _parachuteCount + 1;
    } else {
        _vehicle addItemCargoGlobal ["ToolKit", 1];
    };

    if (_parachuteCount > 0) then {
        _vehicle addBackpackCargoGlobal ["B_Parachute", _parachuteCount];
    };

    [_vehicle] call InA_VehicleInventory_addWeaponCode;
};

InA_VehicleInventory_landCode = {
    params ["_vehicle"];

    _vehicle addItemCargoGlobal ["ToolKit", 1];

    _vehicle addMagazineCargoGlobal ["SmokeShell", 6];
    _vehicle addMagazineCargoGlobal ["SmokeShellBlue", 4];
    _vehicle addMagazineCargoGlobal ["HandGrenade", 4];
    _vehicle addMagazineCargoGlobal ["MiniGrenade", 4];

    _vehicle addMagazineCargoGlobal ["30Rnd_65x39_caseless_black_mag", 8];
    _vehicle addMagazineCargoGlobal ["30Rnd_65x39_caseless_black_mag_Tracer", 4];
    _vehicle addMagazineCargoGlobal ["30Rnd_556x45_Stanag", 8];
    _vehicle addMagazineCargoGlobal ["30Rnd_556x45_Stanag_Tracer_Red", 4];

    _vehicle addWeaponCargoGlobal ["arifle_MX_Black_ACO_Pointer_F", 2];

    if (_vehicle isKindOf "Truck_F" || _vehicle isKindOf "Tank") then {
        [_vehicle] call InA_VehicleInventory_addWeaponCode;
    };
};

InA_VehicleInventory_Defined = true;
