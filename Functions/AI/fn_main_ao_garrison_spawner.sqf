params [
    "_AO",
    "_radiusSize",
    ["_factionHash", InA_EnemyFactionHash]
];

if (isNil "InA_Server_Garrison_BuildingCache") then {
    InA_Server_Garrison_BuildingCache = [];
    InA_Server_Garrison_BuildingCacheDirty = [];
};

private _grpList = [];
private _units = [];

if (isNil "InA_Server_Garrison_BuildingArray") then {
    InA_Server_Garrison_BuildingArray = [
        // Altis buildings
        "Land_i_House_Big_01_V1_F",
        "Land_i_House_Big_02_V1_F",
        "Land_i_Shop_01_V1_F",
        "Land_i_House_Small_01_V1_F",
        "Land_i_House_Small_02_V1_F",
        "Land_i_Addon_02_V1_F",
        "Land_u_Addon_02_V1_F",
        "Land_i_Stone_HouseBig_V1_F",
        "Land_i_Stone_HouseSmall_V1_F",
        "Land_i_Stone_Shed_V1_F",
        "Land_i_House_Small_03_V1_F",
        "Land_i_Shop_02_V1_F",
        "Land_Airport_Tower_F",
        "Land_Offices_01_V1_F",
        "Land_Unfinished_Building_01_F",
        "Land_Unfinished_Building_02_F",
        "Land_WIP_F",
        "Land_i_Shed_Ind_F",
        "Land_i_Barracks_V1_F",
        "Cargo_House_base_F",
        "Cargo_HQ_base_F",
        "Cargo_Patrol_base_F",
        "Cargo_Tower_base_F",
        "Land_MilOffices_V1_F",
        "Land_GH_House_2_F",
        "Land_GH_Gazebo_F",
        "Land_GH_House_1_F",
        "Land_CarService_F",
        "Land_i_Garage_V1_F",
        "Land_dp_mainFactory_F",
        "Land_Factory_Main_F",

        // Malden buildings
        "Land_i_House_Big_02_b_blue_F",
        "Land_i_House_Big_01_b_blue_F",
        "Land_i_Shop_02_b_blue_F",
        "Land_Barn_01_brown_F",
        "Land_Barn_01_grey_F",
        "Land_i_House_Small_01_b_blue_F",
        "Land_i_House_Small_02_b_blue_F",
        "Land_i_House_Small_02_c_blue_F",
        "Land_i_Addon_02_b_white_F",
        "Land_Shed_08_brown_F",
        "Land_Shed_08_grey_F",
        "Land_i_Stone_House_Big_01_b_clay_F",
        "Land_i_Stone_Shed_01_b_clay_F",
        "Land_i_Stone_Shed_01_c_clay_F",
        "Land_Supermarket_01_malden_F",
        "Land_Bunker_01_big_F",
        "Land_Bunker_01_HQ_F",
        "Land_Bunker_01_small_F",
        "Land_Bunker_01_tall_F",

        // Tanoa buildings
        "Land_House_Big_04_F",
        "Land_House_Small_04_F",
        "Land_House_Small_05_F",
        "Land_Shop_City_01_F",
        "Land_Shop_City_02_F",
        "Land_Addon_04_F",
        "Land_Shop_City_05_F",
        "Land_Shop_City_04_F",
        "Land_Shop_City_06_F",
        "Land_Shop_City_07_F",
        "Land_School_01_F",
        "Land_House_Big_03_F",
        "Land_SCF_01_boilerBuilding_F",
        "Land_SCF_01_chimney_F",
        "Land_SCF_01_crystallizer_F",
        "Land_SCF_01_diffuser_F",
        "Land_SCF_01_generalBuilding_F",
        "Land_SCF_01_storageBin_big_F",
        "Land_SCF_01_storageBin_medium_F",
        "Land_Warehouse_03_F",
        "Land_GuardHouse_01_F",
        "Land_FuelStation_01_shop_F",
        "Land_FuelStation_01_workshop_F",
        "Land_Hotel_01_F",
        "Land_Hotel_02_F",
        "Land_Supermarket_01_F",
        "Land_House_Small_02_F",
        "Land_House_Big_02_F",
        "Land_House_Small_03_F",
        "Land_House_Small_06_F",
        "Land_House_Big_01_F",
        "Land_Slum_02_F",
        "Land_Slum_01_F",
        "Land_GarageShelter_01_F",
        "Land_Shop_Town_03_F",
        "Land_Shop_Town_01_F",
        "Land_House_Small_01_F",
        "Land_Slum_03_F",
        "Land_Airport_01_controlTower_F",
        "Land_Airport_02_controlTower_F",

        // Livonia buildings
        "Land_CementWorks_01_base_F",
        "Land_Barn_02_F",
        "Land_Barn_03_large_F",
        "Land_Barn_03_small_F",
        "Land_Cowshed_01_A_F",
        "Land_Cowshed_01_B_F",
        "Land_Cowshed_01_C_F",
        "Land_CastleRuins_01_bastion_F",
        "Land_Highway_Pillar_01_garage_F",
        "Land_CoalPlant_01_LoadingHouse_F",
        "Land_CoalPlant_01_MainBuilding_F",
        "Land_Factory_02_F",
        "Land_GarageRow_01_large_F",
        "Land_GarageRow_01_small_F",
        "Land_GarageOffice_01_F",
        "Land_Mine_01_warehouse_F",
        "Land_Sawmill_01_F",
        "Land_Sawmill_01_illuminati_tower_F",
        "Land_IndustrialShed_01_F",
        "Land_i_Shed_Ind_old_F",
        "Land_Smokestack_01_F",
        "Land_Smokestack_02_F",
        "Land_Smokestack_01_factory_F",
        "Land_Workshop_05_F",
        "Land_Workshop_03_F",
        "Land_Workshop_04_F",
        "Land_Workshop_01_F",
        "Land_Workshop_02_F",
        "Land_ControlTower_02_F",
        "Land_Barracks_06_F",
        "Land_Barracks_03_F",
        "Land_Barracks_02_F",
        "Land_Barracks_04_F",
        "Land_Barracks_05_F",
        "Land_ControlTower_01_F",
        "Land_Radar_01_antenna_base_F",
        "Land_Radar_01_kitchen_F",
        "Land_ServiceHangar_01_L_F",
        "Land_ServiceHangar_01_R_F",
        "Land_GuardTower_02_F",
        "Land_GuardTower_01_F",
        "Land_House_1B01_F",
        "Land_House_2B01_F",
        "Land_House_2B02_F",
        "Land_House_2B03_F",
        "Land_House_2B04_F",
        "Land_Camp_House_01_brown_F",
        "Land_VillageStore_01_F",
        "Land_HealthCenter_01_F",
        "Land_PoliceStation_01_F",
        "Land_House_1W01_F",
        "Land_House_1W02_F",
        "Land_House_1W03_F",
        "Land_House_1W04_F",
        "Land_House_1W05_F",
        "Land_House_1W06_F",
        "Land_House_1W07_F",
        "Land_House_1W08_F",
        "Land_House_1W09_F",
        "Land_House_1W10_F",
        "Land_House_1W11_F",
        "Land_House_1W12_F",
        "Land_House_1W13_F",
        "Land_House_2W01_F",
        "Land_House_2W02_F",
        "Land_House_2W03_F",
        "Land_House_2W04_F",
        "Land_House_2W05_F",
        "Land_FuelStation_03_shop_F",
        "Land_PowerStation_01_F",
        "Land_GuardHouse_03_F",
        "Land_GuardHouse_02_F",

        // Cao Lam Nam buildings
        "Land_vn_hootch_01",
        "Land_vn_hootch_02",
        "Land_Barn_02_F",
        "Land_Barn_03_large_F",
        "Land_Barn_03_small_F",
        "Land_Cowshed_01_A_F",
        "Land_Cowshed_01_B_F",
        "Land_Cowshed_01_C_F",
        "Land_CastleRuins_01_bastion_F",
        "Land_Highway_Pillar_01_garage_F",
        "Land_CoalPlant_01_LoadingHouse_F",
        "Land_CoalPlant_01_MainBuilding_F",
        "Land_Factory_02_F",
        "Land_GarageRow_01_large_F",
        "Land_GarageRow_01_small_F",
        "Land_GarageOffice_01_F",
        "Land_Mine_01_warehouse_F",
        "Land_Sawmill_01_F",
        "Land_Sawmill_01_illuminati_tower_F",
        "Land_IndustrialShed_01_F",
        "Land_i_Shed_Ind_old_F",
        "Land_Smokestack_01_F",
        "Land_Smokestack_02_F",
        "Land_Smokestack_01_factory_F",
        "Land_Workshop_05_F",
        "Land_Workshop_03_F",
        "Land_Workshop_04_F",
        "Land_Workshop_01_F",
        "Land_Workshop_02_F",
        "Land_ControlTower_02_F",
        "Land_Barracks_06_F",
        "Land_Barracks_03_F",
        "Land_Barracks_02_F",
        "Land_Barracks_04_F",
        "Land_Barracks_05_F",
        "Land_ControlTower_01_F",
        "Land_vn_airport_01_controltower_f",
        "Land_vn_airport_02_controltower_f",
        "Land_vn_army_hut_int",
        "Land_vn_army_hut2_int",
        "Land_vn_army_hut3_long_int",
        "Land_vn_hut_old02",
        "Land_vn_hlaska",
        "Land_vn_i_barracks_v1_f",
        "Land_vn_barracks_01_dilapidated_f",
        "Land_vn_barracks_06_f",
        "Land_vn_barracks_03",
        "Land_vn_barracks_02",
        "Land_vn_barracks_04",
        "Land_vn_barracks_02_f",
        "Land_vn_barracks_03_f",
        "Land_vn_barracks_04_f",
        "Land_vn_barracks_05_f",
        "Land_vn_controltower_01_f",
        "Land_vn_guardhouse_02_f",
        "Land_vn_guardhouse_03_f",
        "Land_vn_guardtower_01_f",
        "Land_vn_hootch_01",
        "Land_vn_hootch_02",
        "Land_vn_quonset_01",
        "Land_vn_bar_01",
        "Land_vn_mil_barracks_i_ep1",
        "Land_vn_radar_01_antenna_base_f",
        "Land_vn_radar_01_hq_f",
        "Land_vn_radar_01_kitchen_f",
        "Land_vn_hut_mont_02",
        "Land_vn_hut_mont_01",
        "Land_vn_hut_mont_03",
        "Land_vn_hut_mont_04",
        "Land_vn_hut_mont_05",
        "Land_vn_guardtower_02_f",
        "Land_vn_guardtower_04_f",
        "Land_vn_hue_gate_01",
        "Land_vn_hue_gate_pagoda_01",
        "Land_vn_hue_gate_02",
        "Land_vn_hue_gate_pagoda_02",
        "Land_vn_hue_gate_03",
        "Land_vn_hue_gate_pagoda_03",
        "Land_vn_hut_river_03",
        "Land_vn_hut_river_02",
        "Land_vn_hut_river_01",
        "Land_vn_gh_gazebo_f",
        "Land_vn_gh_house_1_f",
        "Land_vn_gh_house_2_f",
        "land_vn_house_city_01_01",
        "land_vn_house_city_02_01",
        "land_vn_house_city_03_01",
        "land_vn_house_city_04_01",
        "land_vn_house_city_05_01",
        "land_vn_house_city_06_01",
        "Land_vn_shop_town_03_f",
        "Land_vn_shop_town_01_f",
        "Land_vn_house_big_04_f",
        "Land_vn_house_small_02_f",
        "Land_vn_house_small_04_f",
        "Land_vn_house_small_05_f",
        "Land_vn_house_big_02_f",
        "Land_vn_house_small_03_f",
        "Land_vn_house_small_06_f",
        "Land_vn_house_big_01_f",
        "Land_vn_shop_city_01_f",
        "Land_vn_shop_city_02_f",
        "Land_vn_hotel_01_f",
        "Land_vn_hotel_02_f",
        "Land_vn_addon_04_f",
        "Land_vn_houseb_tenement",
        "Land_vn_house_small_01_f",
        "Land_vn_a_office01",
        "Land_vn_slum_03_01_f",
        "Land_vn_school_01_f",
        "Land_vn_supermarket_01_f",
        "Land_vn_unfinished_building_01_f",
        "Land_vn_unfinished_building_02_f",
        "Land_vn_wip_f",
        "Land_vn_house_c_1_v2_ep1",
        "Land_vn_house_c_3_ep1",
        "Land_vn_house_c_9_ep1",
        "Land_vn_house_c_11_ep1",
        "Land_vn_house_c_12_ep1",
        "Land_vn_house_big_03_f",
        "Land_vn_housev2_04_interier",
        "Land_vn_hut_04",
        "Land_vn_hut_07",
        "Land_vn_hut_06",
        "Land_vn_hut_05",
        "Land_vn_hut_08",
        "Land_vn_hut_02",
        "Land_vn_hut_01",
        "Land_vn_hut_village_01",
        "Land_vn_hut_village_02",
        "Land_vn_hut_tower_01",
        "Land_vn_hut_tower_03",
        "Land_vn_hut_tower_02",
        "Land_vn_tovarna1",
        "Land_vn_fuelstation_build_f",
        "Land_vn_fuelstation_01_workshop_f",
        "Land_vn_fuelstation_02_workshop_f",
        "Land_vn_b_tower_01",
        "Land_vn_pillboxbunker_02_hex_f",
        "Land_vn_o_tower_01",
        "Land_vn_o_tower_02",
        "Land_vn_o_tower_03",
        "Land_vn_guardhouse_01_f",
        "Land_vn_bunker_big_01",
        "Land_vn_bunker_big_02",
        "Land_vn_bunker_small_01",
        "Land_vn_b_trench_bunker_01_01",
        "Land_vn_b_trench_bunker_02_01",
        "Land_vn_b_trench_bunker_03_01",
        "Land_vn_b_trench_bunker_04_01",
        "Land_vn_o_bunker_02",
        "Land_vn_o_bunker_03",
        "Land_vn_o_shelter_05",
        "Land_vn_o_platform_02",
        "Land_vn_o_platform_01",
        "Land_vn_o_platform_03",
        "Land_vn_o_platform_06",
        "Land_vn_o_platform_05",
        "Land_vn_o_snipertree_04",
        "Land_vn_o_snipertree_03",
        "Land_vn_o_snipertree_02",
        "Land_vn_o_snipertree_01",
        "Land_Radar_01_antenna_base_F",
        "Land_Radar_01_kitchen_F",
        "Land_ServiceHangar_01_L_F",
        "Land_ServiceHangar_01_R_F",
        "Land_GuardTower_02_F",
        "Land_GuardTower_01_F",

        // Sefrou-Ramal buildings
        "Land_House_C_11_EP1_off_lxWS",
        "Land_House_C_5_EP1_off_lxWS",
        "Land_House_C_5_V1_EP1_off_lxWS",
        "Land_House_C_5_V2_EP1_off_lxWS",
        "Land_House_C_5_V3_EP1_off_lxWS",
        "Land_A_Mosque_small_2_EP1_lxWS",
        "land_tower_lxws",
        "Land_House_C_12_EP1_off_lxWS",
        "Land_House_L_7_EP1_lxWS",
        "Land_House_L_8_EP1_lxWS",
        "Land_House_L_3_EP1_lxWS",
        "Land_House_K_1_EP1_lxWS",
        "Land_House_K_3_EP1_lxWS",
        "Land_House_L_9_EP1_lxWS"
    ];
};

private _unitTypes = [
    "#riflemen", "#machinegunners", "#marksmen",
    "#engineers", "#medics", "#teamleaders",
    "#heavygunners", "#sharpshooters", "#lats"
];

private _AOType = (missionConfigFile >> worldName >> "AOs" >> _AO >> "type") call BIS_fnc_getCfgData;
private _fortObjs = [];

private _factions = (_factionHash get "#guer_factions");

if (_AOType == "Military") then {
    _factions = [(_factionHash get "#name")];
};

private _filterBuildings = {
    params ["_list"];

    private _filteredBuildings = [];

    {
        private _building = _x;

        if ((typeOf _building) in InA_Server_Garrison_BuildingCacheDirty) then {continue};

        if ((_building buildingPos -1) isEqualTo []) then {
            InA_Server_Garrison_BuildingCacheDirty pushBackUnique (typeOf _building);
            continue;
        };

        if ((typeOf _building) in InA_Server_Garrison_BuildingCache) then {
            _filteredBuildings pushBack _building;
            continue;
        };

        if ((InA_Server_Garrison_BuildingArray findIf {_building isKindOf _x}) != -1) then {
            InA_Server_Garrison_BuildingCache pushBackUnique (typeOf _building);
            _filteredBuildings pushBack _building;
            continue;
        };

        // Add building type to dirty cache for faster lookups
        InA_Server_Garrison_BuildingCacheDirty pushBackUnique (typeOf _building);
    } forEach _list;

    _filteredBuildings
};

private _lowPop = (InA_Server_PlayerCount <= 10);
private _garrisonRadius = (_radiusSize * ([0.5, 0.25] select _lowPop));

private _uncleanedBuildings = (nearestObjects [(getMarkerPos _AO), ["house", "building"], _garrisonRadius]);
private _buildings = [_uncleanedBuildings] call _filterBuildings;

if (_buildings isEqualTo []) exitWith {};

_buildings = (_buildings call BIS_fnc_arrayShuffle);

private _garrisonedBuildings = [];
private _maxUnits = ([40, 20] select _lowPop);
private _unitCount = 0;

{
    if (_unitCount >= _maxUnits) then {
        break;
    };

    private _infBuilding = _x;

    /*
    // Only on Altis for now ....
    if (worldName == "Altis") then {
        private _fortifications = (_infBuilding call AW_fnc_fortifyBuilding);
        _fortObjs append _fortifications;
        _garrisonedBuildings pushBack _infBuilding;
    };
    */

    private _infbuildingpos = (_infBuilding buildingPos -1);
    private _posCount = (count _infbuildingpos);

    _infbuildingpos = (_infbuildingpos call BIS_fnc_arrayShuffle);

    private _faction = (selectRandom _factions);
    private _enemyFactionHash = (InA_FactionMappings get _faction);

    private _fillPct = (1 max (ceil (_posCount / ([2, 3] select _lowPop))));

    private _garrisonGroup = (createGroup InA_EnemyFactionSide);

    {
        private _unitType = ([(selectRandom _unitTypes), _enemyFactionHash] call AW_fnc_getUnitsFromHash);
        private _unit = (_garrisonGroup createUnit [_unitType, _x, [], 0, "CAN_COLLIDE"]);

        _unit disableAI "PATH";
        _unit setUnitPos "UP";
        _units pushBack _unit;

        _unitCount = (_unitCount + 1);

        sleep 0.05;

        if ((count (units _garrisonGroup)) >= (8 min _fillPct)) then {break};
    } forEach _infbuildingpos;

    _garrisonGroup = [_garrisonGroup] call AW_fnc_changeGroupSide;
    _garrisonGroup setGroupIdGlobal [format ["AO-Inf-Garrison%1", (_forEachIndex + 1)]];
    _garrisonGroup setVariable ["InA_isGarrisoned", true];

    _grpList pushBack _garrisonGroup;

    _garrisonGroup setCombatMode "YELLOW";
    _garrisonGroup setBehaviourStrong "AWARE";

    [_garrisonGroup] call AW_fnc_transferGroupHC;

    ["ADD", [_infBuilding, _garrisonGroup]] call AW_fnc_garrisonGridManager;

    sleep 0.1;
} forEach _buildings;

["INIT"] call AW_fnc_garrisonGridManager;

[_grpList] call derp_fnc_AISkill;
[_units] call AW_fnc_addToAllCurators;

{
    InA_Server_mainAOUnits append _x;
} forEach [_units, _fortObjs];

/*
// Set garrisoned building to invulnerable for the duration of the AO
if (_garrisonedBuildings isNotEqualTo []) then {
    0 = [_garrisonedBuildings] spawn {
        params ["_buildings"];

        {
            [_x, false] remoteExec ["allowDamage", 0, true];
        } forEach _buildings;

        waitUntil {
            sleep 5;
            InA_Server_MainAO_Completed
        };

        {
            [_x, true] remoteExec ["allowDamage", 0, true];
        } forEach _buildings;
    };
};
*/
