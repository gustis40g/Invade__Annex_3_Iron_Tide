// Init/reset attachment variable
player setVariable ["InA_ShoulderAttachedItem", objNull];


// Global array of items
if (isNil "InA_ChemlightActionsItemsArray") then {
    InA_ChemlightActionsItemsArray = [
        ["Chemlight_blue", "Chemlight_blue", [0.02, -0.03, 0.06]],
        ["Chemlight_green", "Chemlight_green", [0.02, -0.03, 0.06]],
        ["Chemlight_red", "Chemlight_red", [0.02, -0.03, 0.06]],
        ["Chemlight_yellow", "Chemlight_yellow", [0.02, -0.03, 0.06]],
        ["B_IR_Grenade", "B_IRStrobe", [0.065, -0.01, 0.09]]
    ];
};


// Attach actions for each item
{
    _x params ["_mag", "_ammo", "_pos"];

    private _itemText = (getText (configFile >> "CfgMagazines" >> _mag >> "displayName"));
    private _itemIcon = (getText (configFile >> "CfgMagazines" >> _mag >> "picture"));

    private _condition = format ["alive _this && {isNull (_this getVariable ['InA_ShoulderAttachedItem', objNull]) && {((uniformItems _this + backpackItems _this + vestItems _this) find '%1' != -1)}}", _mag];

    player addAction [
        format ["<img size='1.2' image='%1' /><t size='1.1' font='PuristaMedium' color='#33CC33'> Attach <t color='#66CCFF' size='1'>%2</t></t>", _itemIcon, _itemText],
        {
            params ["_target", "_caller", "_actionId", "_args"];

            if (!isNull (player getVariable ["InA_ShoulderAttachedItem", objNull])) exitWith {
                systemChat "Item already attached ....";
            };

            _args params ["_mag", "_ammo", "_pos"];

            _caller removeItem _mag;
            private _item = _ammo createVehicle (getPos _caller);
            _item attachTo [_caller, _pos, "leftshoulder", true];
            _caller setVariable ["InA_ShoulderAttachedItem", _item];
        },
        [_mag, _ammo, _pos],
        -350,
        false,
        true,
        "",
        _condition
    ];
} forEach InA_ChemlightActionsItemsArray;


// Detach action if attached
player addAction [
    "<t size='1.1' font='PuristaMedium' color='#FF3333'>Detach <t color='#33CC33' size='1'>Chemlight/Strobe</t></t>",
    {
        params ["_target", "_caller", "_actionId", "_args"];

        private _item = _caller getVariable ["InA_ShoulderAttachedItem", objNull];

        if (isNull _item) exitWith {
            systemChat "No item to detach ....";
        };

        private _itemType = (typeOf _item);

        detach _item;
        deleteVehicle _item;
        _caller setVariable ["InA_ShoulderAttachedItem", objNull];

        private _itemArrIdx = InA_ChemlightActionsItemsArray findIf {(_x # 1) == _itemType};

        if (_itemArrIdx != -1) then {
            _caller addItem ((InA_ChemlightActionsItemsArray # _itemArrIdx) # 0);
        };
    },
    [],
    -351,
    false,
    true,
    "",
    toString {alive _this && {!isNull (_this getVariable ["InA_ShoulderAttachedItem", objNull])}}
];
