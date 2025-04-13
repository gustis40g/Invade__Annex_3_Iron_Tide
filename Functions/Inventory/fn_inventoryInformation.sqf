private _role = player getVariable ["AW_role", ""];
private _isEngineer = (_role in ["repair", "engineer"]);
private _isMedic = (_role in ["medic", "rmedic"]); 
private _isFSG = (_role == "mortar");
private _isUAV = (_role == "uav");

private _items = (items player);

if (!_isMedic && {"Medikit" in _items}) then {
    systemChat "Warning: The Medkit(s) you are carrying can only be used by Medics.";
};

if (!_isEngineer && {"ToolKit" in _items}) then {
    systemChat "Warning: The Toolkit(s) you are carrying can only be used by Engineers, Explosive Specialists and Repair Specialists.";
};

private _backpack = (backpack player);

private _uavBackpacks = [
    "B_UAV_01_backpack_F",
    "B_UAV_06_backpack_F",
    "B_UAV_06_medical_backpack_F",
    "B_Static_Designator_01_weapon_F",
    "B_W_Static_Designator_01_weapon_F",
    "B_UGV_02_Demining_backpack_F",
    "B_UGV_02_Science_backpack_F",
    "B_HMG_01_A_weapon_F",
    "B_GMG_01_A_weapon_F"
];

private _fsgBackpacks = [
    "B_Mortar_01_support_F",
    "B_Mortar_01_weapon_F"
];

// UAV backpacks
if ((_backpack in _uavBackpacks) && {!_isUAV}) then {
    systemChat "Warning: You are carrying an UAV backpack that can only be controlled by UAV Operators.";
};

// FSG backpacks
if ((_backpack in _fsgBackpacks) && {!_isFSG}) then {
    systemChat "Warning: The artillery computer of the mortar you're carrying can only be used by the FSG gunner";
};

if (isStaminaEnabled player && (loadAbs player >= getNumber (configFile >> "CfgInventoryGlobalVariable" >> "maxSoldierLoad"))) then {
	systemChat "Warning: Your movement speed is currently limited because you are carrying too much.";
};