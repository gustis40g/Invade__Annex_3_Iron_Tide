/*
 * Author: Whigital
 *
 * Description:
 * Spawns fortifications in/around selected building
 *
 */

params [["_building", objNull]];

private _spawnedObjs = [];

if (isNull _building) exitWith {
    _spawnedObjs
};

if (isNil "InA_BuildingFortificationDefs") then {
    call AW_fnc_fortifyBuildingDefs;
    waitUntil {!isNil "InA_BuildingFortificationDefs"};
};

private _objs = nil;

switch (true) do {
    case (_building isKindOf "Land_i_House_Big_01_V1_F"): {
        _objs = InA_BuildingFortificationDefs get "Land_i_House_Big_01_V1_F";
    };

    case (_building isKindOf "Land_i_House_Big_02_V1_F"): {
        _objs = InA_BuildingFortificationDefs get "Land_i_House_Big_02_V1_F";
    };

    case (_building isKindOf "Land_i_Shop_01_V1_F"): {
        _objs = InA_BuildingFortificationDefs get "Land_i_Shop_01_V1_F";
    };

    case (_building isKindOf "Land_i_Shop_02_V1_F"): {
        _objs = InA_BuildingFortificationDefs get "Land_i_Shop_02_V1_F";
    };

    case (_building isKindOf "Land_i_House_Small_01_V1_F"): {
        _objs = InA_BuildingFortificationDefs get "Land_i_House_Small_01_V1_F";
    };

    case (_building isKindOf "Land_i_House_Small_02_V1_F"): {
        _objs = InA_BuildingFortificationDefs get "Land_i_House_Small_02_V1_F";
    };

    case (_building isKindOf "Land_i_House_Small_03_V1_F"): {
        _objs = InA_BuildingFortificationDefs get "Land_i_House_Small_03_V1_F";
    };

    case (_building isKindOf "Land_i_Stone_Shed_V1_F"): {
        _objs = InA_BuildingFortificationDefs get "Land_i_Stone_Shed_V1_F";
    };

    case (_building isKindOf "Land_i_Stone_HouseSmall_V1_F"): {
        _objs = InA_BuildingFortificationDefs get "Land_i_Stone_HouseSmall_V1_F";
    };

    case (_building isKindOf "Land_i_Stone_HouseBig_V1_F"): {
        _objs = InA_BuildingFortificationDefs get "Land_i_Stone_HouseBig_V1_F";
    };

    case (_building isKindOf "Land_i_Barracks_V1_F"): {
        _objs = InA_BuildingFortificationDefs get "Land_i_Barracks_V1_F";
    };

    case (((typeOf _building) == "Land_i_Addon_02_V1_F") || ((typeOf _building) == "Land_u_Addon_02_V1_F")): {
        _objs = InA_BuildingFortificationDefs get "Land_i_Addon_02_V1_F";
    };

    case (_building isKindOf "Land_i_Garage_V1_F"): {
        _objs = InA_BuildingFortificationDefs get "Land_i_Garage_V1_F";
    };

    case ((typeOf _building) == "Land_GH_House_1_F"): {
        _objs = InA_BuildingFortificationDefs get "Land_GH_House_1_F";
    };

    case ((typeOf _building) == "Land_GH_House_2_F"): {
        _objs = InA_BuildingFortificationDefs get "Land_GH_House_2_F";
    };

    case ((typeOf _building) == "Land_Unfinished_Building_01_F"): {
        _objs = InA_BuildingFortificationDefs get "Land_Unfinished_Building_01_F";
    };

    case ((typeOf _building) == "Land_Unfinished_Building_02_F"): {
        _objs = InA_BuildingFortificationDefs get "Land_Unfinished_Building_02_F";
    };

    case ((typeOf _building) == "Land_i_Shed_Ind_F"): {
        _objs = InA_BuildingFortificationDefs get "Land_i_Shed_Ind_F";
    };

    case ((typeOf _building) == "Land_GH_Gazebo_F"): {
        _objs = InA_BuildingFortificationDefs get "Land_GH_Gazebo_F";
    };
};


if (!isNil "_objs") then {
    private _orgDir = (getDir _building);

    private _flags = (InA_BuildingFortificationDefs get "FLAGS");
    private _banners = (InA_BuildingFortificationDefs get "BANNERS");
    private _decals = (InA_BuildingFortificationDefs get "DECALS");
    private _sandbags_long = (InA_BuildingFortificationDefs get "SANDBAGS_LONG");
    private _sandbags_short = (InA_BuildingFortificationDefs get "SANDBAGS_SHORT");
    private _sandbarricades = (InA_BuildingFortificationDefs get "SANDBARRICADES");

    {
        private _type = (_x # 0);

        private _data = [_building, _x, _orgDir, true] call AW_fnc_spawnRelative;

        _data params ["_pos", "_dir"];

        if (_type == "FLAG") then {
            _type = (selectRandom _flags);
        };

        if (_type == "BANNER") then {
            _type = (selectRandom _banners);
        };

        if (_type == "DECAL") then {
            _type = (selectRandom _decals);
        };

        if (_type == "SANDBAG_LONG") then {
            _type = (selectRandom _sandbags_long);
        };

        if (_type == "SANDBAG_SHORT") then {
            _type = (selectRandom _sandbags_short);
        };

        if (_type == "SANDBARRICADE") then {
            _type = (selectRandom _sandbarricades);
        };

        private _obj = createVehicle [_type, [0, 0, 0], [], 0, "NONE"];
        _obj setDir _dir;
        _obj setPosATL _pos;

        _obj allowDamage false;

        _spawnedObjs pushBack _obj;
    } forEach _objs;
};

_spawnedObjs
