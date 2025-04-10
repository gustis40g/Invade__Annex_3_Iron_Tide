#include "inv_macros.hpp"
/*
 * Author: Whigital
 *
 * Description:
 * Handler for Vehicle Inventory UI, modified version of RscAttributeInventory
 * function from Zeus
 *
 */

params ["_oper", "_params", ["_entity", objNull]];

private _filterIDCs = [
    INV_IDC_TAB0,
    INV_IDC_TAB1,
    INV_IDC_TAB2,
    INV_IDC_TAB3,
    INV_IDC_TAB4,
    INV_IDC_TAB5,
    INV_IDC_TAB6,
    INV_IDC_TAB7,
    INV_IDC_TAB8,
    INV_IDC_TAB9,
    INV_IDC_TAB10,
    INV_IDC_TAB11,
    INV_IDC_TAB12
];

if (isNull _entity) then {
    _entity = InA_Inventory_Target;
};

private _config_from_class = {
    params ["_item"];

    switch (true) do {
        case (isClass (configFile >> "CfgMagazines" >> _item)): {"CfgMagazines"};
        case (isClass (configFile >> "CfgWeapons" >> _item)): {"CfgWeapons"};
        case (isClass (configFile >> "CfgVehicles" >> _item)): {"CfgVehicles"};
        case (isClass (configFile >> "CfgGlasses" >> _item)): {"CfgGlasses"};
    };
};

private _get_mass = {
    params ["_config"];

    private _mass = 10;

    switch (true) do {
        case (isNumber (_config >> "WeaponSlotsInfo" >> "mass")): {
            _mass = (getNumber (_config >> "WeaponSlotsInfo" >> "mass"));
        };

        case (isNumber (_config >> "ItemInfo" >> "mass")): {
            _mass = (getNumber (_config >> "ItemInfo" >> "mass"));
        };

        case (isNumber (_config >> "mass")): {
            _mass = (getNumber (_config >> "mass"));
        };
    };

    _mass
};

if (isNil "InA_Inventory_MassMap") then {
    InA_Inventory_MassMap = createHashMap;
};

switch (_oper) do {
    case "onLoad": {
        private _types = [
            ["AssaultRifle", "Shotgun", "Rifle", "SubmachineGun"],
            ["MachineGun"],
            ["SniperRifle"],
            ["Launcher", "MissileLauncher", "RocketLauncher"],
            ["Handgun"],
            ["UnknownWeapon"],
            ["AccessoryMuzzle", "AccessoryPointer", "AccessorySights", "AccessoryBipod"],
            ["Uniform"],
            ["Vest"],
            ["Backpack"],
            ["Headgear", "Glasses"],
            ["Binocular", "Compass", "FirstAidKit", "GPS", "LaserDesignator", "Map", "Medikit", "MineDetector", "NVGoggles", "Radio", "Toolkit", "Watch", "UAVTerminal"]
        ];

        if (isNil "InA_Inventory_List") then {
            private _ArsenalWeapons = (
                InA_AllowedArsenal_underWaterGun +
                InA_AllowedArsenal_generalPistols +
                InA_AllowedArsenal_generalSMGs +
                InA_AllowedArsenal_generalCarbines +
                InA_AllowedArsenal_pilotCarbines +
                InA_AllowedArsenal_generalAssaultRifles +
                InA_AllowedArsenal_assaultRiflesUGL +
                InA_AllowedArsenal_Machineguns +
                InA_AllowedArsenal_marksmanRifles +
                InA_AllowedArsenal_sniperRifles +
                InA_AllowedArsenal_launchersLight +
                InA_AllowedArsenal_launchersHeavy +
                InA_AllowedArsenal_reconRifles
            );

            private _ArsenalMagazines = (
                InA_AllowedArsenal_generalMagazines +
                InA_AllowedArsenal_Explosives
            );

            private _ArsenalBackpacks = (
                InA_AllowedArsenal_backpackStatics +
                InA_AllowedArsenal_backpackDrones
            );

            InA_ArsenalWhitelistArray params [
                "_allowedItemsArray",
                "_allowedWeaponsArray",
                "_allowedBackpacksArray",
                "_allowedMagazinesArray",
                "_allowedWeaponPickupArray"
            ];

            private _invArray = [];

            {
                _invArray append (_x apply {toLower _x});
            } forEach [
                _allowedItemsArray,
                _allowedWeaponsArray,
                _allowedBackpacksArray,
                _allowedMagazinesArray
            ];

            private _magazines = [];
            private _list = [[], [], [], [], [], [], [], [], [], [], [], []];

            {
                private _item = _x;

                ([(toLower _item)] call BIS_fnc_itemType) params ["_itemTypeCategory", "_itemTypeSpecific"];

                private _itemTypeID = -1;

                {
                    if (_itemTypeSpecific in _x) exitWith {_itemTypeID = _forEachIndex};
                } forEach _types;

                if (_itemTypeCategory != "VehicleWeapon" && _itemTypeID >= 0) then {
                    private _configPath = ([_item] call _config_from_class);
                    private _itemConfig = (configFile >> _configPath >> _item);
                    private _itemPublic = (getNumber (_itemConfig >> "scope") == 2);

                    if ((toLower _item) in _invArray) then {
                        private _displayName = getText (_itemConfig >> "displayName");
                        private _picture = getText (_itemConfig >> "picture");

                        private _displayNameShort = _displayName;
                        private _displayNameShortArray = (toArray _displayNameShort);

                        if (count _displayNameShortArray > 40) then {
                            _displayNameShortArray resize 40;
                            _displayNameShort = ((toString _displayNameShortArray) + "....");
                        };

                        private _type = if (getNumber (_itemConfig >> "type") in [4096, 131072]) then {1} else {0};
                        private _mass = _itemConfig call _get_mass;

                        InA_Inventory_MassMap insert [[(toLower _item), _mass]];

                        private _itemArray = [_displayName, _displayNameShort, (toLower _item), _picture, _type, false];
                        private _current = (_list # _itemTypeID);
                        _current pushBack _itemArray;

                        _list set [_itemTypeID, _current];
                    };

                    if (_itemPublic || _item in ["Throw", "Put"]) then {
                        {
                            private _muzzle = if (_x == "this") then {_itemConfig} else {_itemConfig >> _x};

                            private _magazinesList = getArray (_muzzle >> "magazines");

                            {
                                {
                                    _magazinesList append (getArray _x);
                                } forEach (configProperties [(configFile >> "CfgMagazineWells" >> _x), "isArray _x"]);
                            } forEach (getArray (_muzzle >> "magazineWell"));

                            {
                                if !((toLower _x) in _invArray) then {continue};

                                private _mag = _x;

                                if (((_list # _itemTypeID) findIf {((_x # 2) == _mag)}) isEqualTo -1) then {
                                    private _magCfg = (configFile >> "CfgMagazines" >> _mag);

                                    if (getNumber (_magCfg >> "scope") isEqualTo 2) then {
                                        private _displayName = getText (_magCfg >> "displayName");
                                        private _picture = getText (_magCfg >> "picture");
                                        private _mass = _magCfg call _get_mass;

                                        InA_Inventory_MassMap insert [[(toLower _mag), _mass]];

                                        private _magArray = [_displayName, _displayName, (toLower _mag), _picture, 2, (_mag in _magazines)];
                                        private _current = (_list # _itemTypeID);
                                        _current pushBackUnique _magArray;

                                        _list set [_itemTypeID, _current];
                                    };
                                };
                            } forEach _magazinesList;
                        } forEach (getArray (_itemConfig >> "muzzles"));
                    };
                };
            } forEach (_ArsenalWeapons + _ArsenalMagazines + _ArsenalBackpacks + _allowedItemsArray + ["Put", "Throw"]);

            {
                _x sort true;
            } forEach _list;

            InA_Inventory_List = _list;
        };

        private _cargo = [
            (getWeaponCargo _entity),
            (getMagazineCargo _entity),
            (getItemCargo _entity),
            (getBackpackCargo _entity)
        ];

        InA_Inventory_Cargo = [[], []];

        {
            InA_Inventory_Cargo set [0, (InA_Inventory_Cargo # 0) + (_x # 0)];
            InA_Inventory_Cargo set [1, (InA_Inventory_Cargo # 1) + (_x # 1)];
        } forEach _cargo;

        private _classes = (InA_Inventory_Cargo # 0);

        {
            _classes set [_forEachIndex, (tolower _x)];
        } forEach _classes;

        private _cfgEntity = (configFile >> "CfgVehicles" >> (typeOf _entity) >> "maximumLoad");
        private _maxLoad = 1e10;

        if (isNumber _cfgEntity) then {
            _maxLoad = (getNumber _cfgEntity);
        };

        InA_Inventory_MaxLoad = _maxLoad;

        private _display = (_params # 0);

        {
            private _ctrl = (_display displayCtrl _x);
            _ctrl ctrlAddEventHandler [
                "ButtonClick",
                format ["['filterChanged', [(ctrlParent (_this # 0)), %1], objnull] call AW_fnc_invDialogHandler", _forEachIndex]
            ];
        } foreach _filterIDCs;

        InA_Inventory_Selected = 0;
        ["filterChanged", [_display], objNull] call AW_fnc_invDialogHandler;

        private _ctrlButtonOK = (_display displayCtrl INV_DISPLAY_OK);
        _ctrlButtonOK ctrlAddEventHandler ["ButtonClick", {
            params ["_control"];
            private _display = (ctrlParent _control);
            ["confirmed", [_display], objNull] call AW_fnc_invDialogHandler;
        }];

        private _ctrlList = (_display displayCtrl INV_IDC_LIST);
        _ctrlList ctrlAddEventHandler ["LBSelChanged", {
            params ["_control", "_lbCurSel", "_lbSelection"];
            private _display = (ctrlParent _control);
            ["listSelect", [_display], objNull] call AW_fnc_invDialogHandler;
        }];

        _ctrlList ctrlAddEventHandler ["LBDblClick", {
            params ["_control", "_selectedIndex"];
            private _display = (ctrlParent _control);
            ["listModify", [_display, +1], objNull] call AW_fnc_invDialogHandler;
        }];

        private _ctrlArrowLeft = (_display displayCtrl INV_IDC_ARROWLEFT);
        _ctrlArrowLeft ctrlAddEventHandler ["ButtonClick", {
            params ["_control"];
            private _display = (ctrlParent _control);
            ["listModify", [_display, -1], objNull] call AW_fnc_invDialogHandler;
        }];

        private _ctrlArrowRight = (_display displayCtrl INV_IDC_ARROWRIGHT);
        _ctrlArrowRight ctrlAddEventHandler ["ButtonClick", {
            params ["_control"];
            private _display = (ctrlParent _control);
            ["listModify", [_display, +1], objNull] call AW_fnc_invDialogHandler;
        }];

        private _ctrlButtonClear = (_display displayCtrl INV_DISPLAY_CLEAR);
        _ctrlButtonClear ctrlAddEventHandler ["ButtonClick", {
            params ["_control"];
            private _display = (ctrlParent _control);
            ["clear", [_display], objNull] call AW_fnc_invDialogHandler;
        }];

        private _ctrlButtonCancel = (_display displayCtrl INV_DISPLAY_CANCEL);
        _ctrlButtonCancel ctrlAddEventHandler ["ButtonClick", {
            closeDialog 2;
        }];
    };

    case "filterChanged": {
        _params params ["_display", "_filterIdx"];
        private _cursel = (if (!isNil "_filterIdx") then {_filterIdx} else {InA_Inventory_Selected});
        InA_Inventory_Selected = _cursel;

        private _ctrlList = (_display displayCtrl INV_IDC_LIST);
        private _ctrlLoad = (_display displayCtrl INV_IDC_LOAD);
        private _ctrlFilterBackground = (_display displayCtrl INV_IDC_FILTERBG);

        private _list = InA_Inventory_List;
        private _items = [];

        if (_cursel > 0) then {
            _items = (_list # (_cursel - 1));
        } else {
            {
                _items = (_items + _x);
            } forEach _list;

            _items sort true;
        };

        lnbClear _ctrlList;

        {
            private _types = _x;

            {
                _x params ["_displayName", "_displayNameShort", "_class", "_picture", "_type", "_isDuplicate"];

                if ((_type in _types) && (!_isDuplicate && (_cursel >= 0))) then {
                    private _classes = (InA_Inventory_Cargo # 0);
                    private _values = (InA_Inventory_Cargo # 1);
                    private _index = (_classes find _class);
                    
                    private _value = if (_index < 0) then {
                        _index = (count _classes);
                        _classes set [_index, _class];
                        _values set [_index, 0];
                        0
                    } else {
                        (_values # _index)
                    };

                    if ((_cursel == 0 && _value != 0) || (_cursel > 0)) then {
                        private _lnbAdd = _ctrlList lnbAddRow ["", _displayNameShort, if (_value < 0) then {""} else {str _value}, ""];
                        _ctrlList lnbSetData [[_lnbAdd, 0], _class];
                        _ctrlList lnbSetValue [[_lnbAdd, 0], _value];
                        _ctrlList lnbSetValue [[_lnbAdd, 1], _type];
                        _ctrlList lnbSetPicture [[_lnbAdd, 0], _picture];

                        private _alpha = if (_value != 0) then {1} else {0.5};

                        _ctrlList lnbSetColor [[_lnbAdd, 1], [1,1,1, _alpha]];
                        _ctrlList lnbSetColor [[_lnbAdd, 2], [1,1,1, _alpha]];
                        _ctrlList lbSetTooltip [_lnbAdd, _displayName];

                        if (_cursel == 0 && _value != 0) then {
                            private _mass = (InA_Inventory_MassMap getOrDefault [_class, 10]);
                            _ctrlLoad progressSetPosition ((progressPosition _ctrlLoad) + ((_value max 0) * (_mass / InA_Inventory_MaxLoad)));
                        };
                    };
                };
            } forEach _items;
        } forEach [[0,1,3], [2]];

        _ctrlList lnbSetCurSelRow 0;

        ["listSelect", [_display], objNull] call AW_fnc_invDialogHandler;

        {
            private _ctrl = (_display displayCtrl _x);
            private _color = [1,1,1,0.5];
            private _scale = 0.75;

            if (_forEachIndex == _cursel) then {
                _color = [1,1,1,1];
                _scale = 1;
            };

            _ctrl ctrlSetTextColor _color;

            private _pos = [_ctrl, _scale, 0] call BIS_fnc_ctrlSetScale;

            if (_forEachIndex == _cursel) then {
                _ctrlFilterBackground ctrlSetposition _pos;
                _ctrlFilterBackground ctrlCommit 0;
            };
        } forEach _filterIDCs;
    };

    case "listModify": {
        _params params ["_display", "_add"];

        private _ctrlList = _display displayCtrl INV_IDC_LIST;
        private _ctrlLoad = _display displayCtrl INV_IDC_LOAD;
        private _cursel = lnbCurSelRow _ctrlList;
        private _class = _ctrlList lnbData [_cursel, 0];
        private _value = _ctrlList lbValue (_cursel * 4);
        private _type = _ctrlList lbValue (_cursel * 4 + 1);

        private _classes = (InA_Inventory_Cargo # 0);
        private _values = (InA_Inventory_Cargo # 1);
        private _index = (_classes find _class);

        if (_index >= 0) then {
            private _mass = (InA_Inventory_MassMap getOrDefault [_class, 10]);
            _value = _value + _add;
            private _load = ((progressPosition _ctrlLoad) + (_add * (_mass / InA_Inventory_MaxLoad)));

            if ((_load <= 1) && (_value >= 0)) then {
                if (_value > 0 || (_value == 0 && _add < 0)) then {_ctrlLoad progressSetPosition _load};
                _values set [_index, _value];
                _ctrlList lnbSetValue [[_cursel, 0], _value];
                _ctrlList lnbSetText [[_cursel, 2], (str _value)];
                private _alpha = if (_value != 0) then {1} else {0.5};
                _ctrlList lnbSetColor [[_cursel, 1], [1,1,1, _alpha]];
                _ctrlList lnbSetColor [[_cursel, 2], [1,1,1, _alpha]];
                ["listSelect", [_display], objNull] call AW_fnc_invDialogHandler;
            };
        };
    };

    case "listSelect": {
        private _display = (_params # 0);
        private _ctrlList = (_display displayCtrl INV_IDC_LIST);
        private _ctrlLoad = _display displayCtrl INV_IDC_LOAD;
        private _cursel = (lnbCurSelRow _ctrlList);
        private _value = (_ctrlList lbValue (_cursel * 4));
        private _class = _ctrlList lnbData [_cursel, 0];

        private _ctrlArrowLeft = (_display displayCtrl INV_IDC_ARROWLEFT);
        _ctrlArrowLeft ctrlEnable (_value > 0);
        
        private _mass = (InA_Inventory_MassMap getOrDefault [_class, 10]);
        private _load = ((progressPosition _ctrlLoad) + ((_mass / InA_Inventory_MaxLoad)));
        private _ctrlArrowRight = (_display displayCtrl INV_IDC_ARROWRIGHT);
        _ctrlArrowRight ctrlEnable (_load < 1);
    };

    case "clear": {
        private _values = (InA_Inventory_Cargo # 1);

        {
            _values set [_forEachIndex, 0];
        } forEach _values;

        ["filterChanged", _params, objNull] call AW_fnc_invDialogHandler;

        private _display = (_params # 0);
        private _ctrlLoad = (_display displayCtrl INV_IDC_LOAD);
        _ctrlLoad progressSetPosition 0;
    };

    case "confirmed": {
        private _display = (_params # 0);

        clearWeaponCargoGlobal _entity;
        clearMagazineCargoGlobal _entity;
        clearBackpackCargoGlobal _entity;
        clearItemCargoGlobal _entity;

        private _classes = (InA_Inventory_Cargo # 0);
        private _values = (InA_Inventory_Cargo # 1);

        private _items = [];
        private _weapons = [];
        private _magazines = [];
        private _backpacks = [];

        {
            if (_x != 0) then {
                private _class = (_classes # _forEachIndex);

                switch (true) do {
                    case (getNumber (configFile >> "CfgWeapons" >> _class >> "type") in [4096, 131072]): {
                        if (_x < 0) then {
                            _items set [(count _items), _class];
                        } else {
                            _entity addItemCargoGlobal [_class, (abs _x)];
                        };
                    };

                    case (isClass (configFile >> "CfgWeapons" >> _class)): {
                        if (_x < 0) then {
                            _weapons set [(count _weapons), _class];
                        } else {
                            _entity addWeaponCargoGlobal [_class, (abs _x)];
                        };
                    };

                    case (isClass (configFile >> "CfgMagazines" >> _class)): {
                        if (_x < 0) then {
                            _magazines set [(count _magazines), _class];
                        } else {
                            _entity addMagazineCargoGlobal [_class, (abs _x)];
                        };
                    };

                    case (isClass (configFile >> "CfgVehicles" >> _class)): {
                        if (_x < 0) then {
                            _backpacks set [(count _backpacks), _class];
                        } else {
                            _entity addBackpackCargoGlobal [_class, (abs _x)];
                        };
                    };
                };
            };
        } forEach _values;

        closeDialog 1;
    };

    case "onUnload": {
        InA_Inventory_Target = nil;
        InA_Inventory_Cargo = nil;
        InA_Inventory_Selected = nil;
        InA_Inventory_MaxLoad = nil;
    };
};
