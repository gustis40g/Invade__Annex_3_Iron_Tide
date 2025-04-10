params ["_rewardId", "_createPos"];
private _vehicle = objNull;
#define CV(veh) createVehicle [veh, _createPos, [], 0, "NONE"]

switch (_rewardId) do {
    /**************/
    /**** Jets ****/
    /**************/

    // F-4C Phantom CAS
    case 101: {
        _vehicle = CV("vn_b_air_f4c_cas");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

     // F-100D CAS
    case 102: {
        _vehicle = CV("vn_b_air_f100d_cas");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // F-4C Phantom CAP
    case 105: {
        _vehicle = CV("vn_b_air_f4c_cap");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // F-100D CAS
    case 106: {
        _vehicle = CV("vn_b_air_f100d_cap");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    /**********************/
    /**** Attack Helis ****/
    /**********************/

    // AH-1G Cobra (APERS)
    case 201: {
        _vehicle = CV("vn_b_air_ah1g_02");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // UH-34 Stinger (APERS)
    case 202: {
        _vehicle = CV("vn_b_air_ch34_04_03");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // AH-1G Cobra (M195/AT)
    case 204: {
        _vehicle = CV("vn_b_air_ah1g_08");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // OH-6A Gunship APERS
    case 205: {
        _vehicle = CV("vn_b_air_oh6a_06");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // UH-1C Gunship
    case 203: {
        _vehicle = CV("vn_b_air_uh1c_02_02");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // UH-1P hornet
    case 206: {
        _vehicle = CV("vn_b_air_uh1c_03_01");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // UH-1E heavy gunship
    case 207: {
        _vehicle = CV("vn_b_air_uh1e_02_04");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // UH-1E gunship
    case 208: {
        _vehicle = CV("vn_b_air_uh1e_01_04");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // UH-1E gunship
    case 209: {
        _vehicle = CV("vn_b_air_uh1d_03_06");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    /*************************/
    /**** Transport Helis ****/
    /*************************/

    /***************/
    /**** Tonks ****/
    /***************/

    // M41A3 Walker Bulldog
    case 601: {
        _vehicle = CV("vn_b_armor_m41_01_02");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };


    /**************/
    /**** IFVs ****/
    /**************/

    // M54 Gun Truck (Minigun)
    case 703: {
        _vehicle = CV("vn_b_wheeled_m54_mg_03");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    // M113A1
    case 704: {
        _vehicle = CV("vn_b_armor_m113_acav_04");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };
    // M113A1
    case 705: {
        _vehicle = CV("vn_b_armor_m113_acav_02");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };
    // M113A1
    case 706: {
        _vehicle = CV("vn_b_armor_m113_acav_06");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };
    // M113A1
    case 707: {
        _vehicle = CV("vn_b_armor_m113_acav_05");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    /****************/
    /**** SPAAGs ****/
    /****************/

    // M55 AA Truck (Quad)
    case 801: {
        _vehicle = CV("vn_b_wheeled_m54_mg_02");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    /***************/
    /**** MRAPs ****/
    /***************/
    //Tow jeep
    case 901: {
        _vehicle = CV("vn_b_wheeled_m151_mg_05");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };
    //Recoiles rifle jeep
    case 902: {
        _vehicle = CV("vn_b_wheeled_m151_mg_06");

        [_vehicle] call AW_fnc_vehicleCustomization;
    };

    /**************/
    /**** Misc ****/
    /**************/

    // Battle Tractor
    case 1202: {
        _vehicle = CV("C_Tractor_01_F");

        private _GMG = CV("vn_b_sf_static_m2_low");
        _GMG attachTo [_vehicle, [0, -0.8, 2]];
        _GMG enableWeaponDisassembly false;

        [[_GMG]] call AW_fnc_addToAllCurators;

        [_vehicle] spawn AW_fnc_vehicleAttachmentKilledEH;
    };
};

_vehicle
