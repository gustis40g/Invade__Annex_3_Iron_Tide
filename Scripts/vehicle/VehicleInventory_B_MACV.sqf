InA_VehicleInventory_FAK = "vn_b_item_firstaidkit";

InA_VehicleInventory_addWeaponCode = {
    params ["_vehicle"];

    private _weaponCount = [typeOf _vehicle, false] call BIS_fnc_crewCount;

    _vehicle addWeaponCargoGlobal ["vn_sten", _weaponCount];
    _vehicle addMagazineCargoGlobal ["vn_sten_mag", _weaponCount * 4];
    _vehicle addMagazineCargoGlobal ["vn_sten_t_mag", _weaponCount];
};

InA_VehicleInventory_airCode = {
    params ["_vehicle"];

    private _vehicleType = (typeOf _vehicle);
    private _parachuteCount = [_vehicleType, true] call BIS_fnc_crewCount;

    _parachuteCount = _parachuteCount - ([_vehicleType, false] call BIS_fnc_crewCount);

    if (_vehicle isKindOf "Plane") then {
        _parachuteCount = _parachuteCount + 1;
    } else {
        _vehicle addItemCargoGlobal ["vn_b_item_toolkit", 1];
        _vehicle addBackpackCargoGlobal ["vn_b_pack_lw_01", 2];
    };

    if (_parachuteCount > 0) then {
        _vehicle addBackpackCargoGlobal ["B_Parachute", _parachuteCount];
    };

    [_vehicle] call InA_VehicleInventory_addWeaponCode;
};

InA_VehicleInventory_landCode = {
    params ["_vehicle"];

    _vehicle addWeaponCargoGlobal ["vn_m127", 2];
    _vehicle addMagazineCargoGlobal ["vn_m127_mag", 12];

    _vehicle addItemCargoGlobal ["vn_b_item_toolkit", 1];

    _vehicle addMagazineCargoGlobal ["vn_m18_white_mag", 6];
    _vehicle addMagazineCargoGlobal ["vn_m18_purple_mag", 4];
    _vehicle addMagazineCargoGlobal ["vn_m61_grenade_mag", 4];
    _vehicle addMagazineCargoGlobal ["vn_m67_grenade_mag", 4];

    _vehicle addMagazineCargoGlobal ["vn_m16_40_mag", 16];
    _vehicle addMagazineCargoGlobal ["vn_m16_40_t_mag", 4];
    _vehicle addMagazineCargoGlobal ["vn_m60_100_mag", 4];
    _vehicle addMagazineCargoGlobal ["vn_carbine_30_mag", 16];

    if (_vehicle isKindOf "Truck_F" || _vehicle isKindOf "Tank") then {
        [_vehicle] call InA_VehicleInventory_addWeaponCode;
    };

    _vehicle addBackpackCargoGlobal ["vn_b_pack_lw_01", 2];
};

InA_VehicleInventory_Defined = true;
