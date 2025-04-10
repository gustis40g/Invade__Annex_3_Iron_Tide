params [
    ["_arsenal", objNull],
    ["_full", false],
    ["_baseArsenal", false],
    ["_base", nil]
];

if (!hasInterface) exitWith {};

if (isNull _arsenal) exitWith {};

waitUntil {sleep 0.1; !isNil "InA_ArsenalRestrictionsInitialized" && {InA_ArsenalRestrictionsInitialized}};

_arsenal lockInventory true;

if (!_full) then {
    private _allowedItemsArray = (InA_ArsenalWhitelistArray # 0);
    private _allowedWeaponsArray = (InA_ArsenalWhitelistArray # 1);
    private _allowedBackpacksArray = (InA_ArsenalWhitelistArray # 2);
    private _allowedMagazinesArray = (InA_ArsenalWhitelistArray # 3);

    // Add allowed equipment to that Virtual Arsenal:
    [_arsenal, _allowedItemsArray, false, false] call BIS_fnc_addVirtualItemCargo;
    [_arsenal, _allowedWeaponsArray, false, false] call BIS_fnc_addVirtualWeaponCargo;
    [_arsenal, _allowedBackpacksArray, false, false] call BIS_fnc_addVirtualBackpackCargo;
    [_arsenal, _allowedMagazinesArray, false, false] call BIS_fnc_addVirtualMagazineCargo;
};

_arsenal addAction [
    format ["<t color='#00dd00' size='1.1' font='PuristaBold'><img size='1.1' image='\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\rearm_ca.paa' /> %1</t>", (localize "STR_A3_Arsenal")], {
        params ["_target", "_caller", "_actionId", "_arguments"];

        _arguments params [["_fullArsenal", false]];

        ["Open", [_fullArsenal, _target, _caller]] call BIS_fnc_arsenal;
    },
    [_full],
    6,
    true,
    true,
    "",
    "true",
    5
];

[
    _arsenal,
    "<t color='#ff4400' size='1.1' font='PuristaBold'>Revive player(s)</t>",
    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_reviveMedic_ca.paa",
    nil,
    "[_target, _this] call AW_fnc_passiveReviveCond",
    "[_target, _this] call AW_fnc_passiveReviveCond",
    nil,
    nil,
    {
        params ["_target", "_caller", "_actionId", "_arguments"];

        [_target] remoteExec ["AW_fnc_passiveRevive", 2];
    },
    nil,
    nil,
    5,
    11,
    false
] call BIS_fnc_holdActionAdd;

_arsenal addAction [
    "<t color='#0044ff' size='1.1' font='PuristaBold'><img size='1.1' image='\a3\ui_f\data\IGUI\Cfg\Actions\bandage_ca.paa' /> Heal</t>", {
        params ["_target", "_caller", "_actionId", "_arguments"];

        _caller playMove "AinvPknlMstpSlayWrflDnon_medic";
        _caller setDamage 0;
    },
    nil,
    10,
    true,
    true,
    "",
    (toString {
        (isNull (objectParent _this)) && {
            (!(_this getVariable ["derp_revive_isCarrying", false]) || !(_this getVariable ["derp_revive_isDragging", false])) && {
                ((((getAllHitPointsDamage _this) # 2) findIf {_x > 0}) != -1)
            }
        }
    }),
    5
];

_arsenal addAction [
    "<t color='#44ff44' size='1.1' font='PuristaMedium'><img size='1.1' image='\a3\ui_f\data\IGUI\Cfg\Actions\reammo_ca.paa' /> Load saved loadout</t>",
    {
        params ["_target", "_caller", "_actionId", "_arguments"];

        private _loadout = (missionNamespace getVariable "InA_PlayerLoadout");
        _caller setUnitLoadout _loadout;
    },
    nil,
    5,
    false,
    true,
    "",
    (toString {
        (isNull (objectParent _this)) && {!isNil {missionNamespace getVariable "InA_PlayerLoadout"}}
    }),
    5
];

_arsenal addAction [
    "<t color='#0088ff' size='1.1' font='PuristaMedium'><img size='1.1' image='\a3\ui_f\data\IGUI\Cfg\IslandMap\iconCamera_ca.paa' /> View Distance Settings</t>",
    {
        [] spawn CHVD_fnc_openDialog;
    },
    nil,
    4,
    false,
    true,
    "",
    "",
    5
];


_arsenal addAction [
	"<t color='#0044ff' size='1.1' font='PuristaBold'><img size='1.1' image='\a3\ui_f\data\igui\cfg\simpletasks\types\takeoff_ca.paa' />Parachute Jump</t>",        // title
    { [] spawn AW_fnc_doParachuteJump; },                                                                                                                            // script
	nil,		                                                                                                                                                    // arguments
	50000,		                                                                                                                                                    // priority
	true,		                                                                                                                                                    // showWindow
	true,		                                                                                                                                                    // hideOnUse
	"",			                                                                                                                                                    // shortcut
	(toString {(isNull (objectParent _this))}),		                                                                                                                // condition
	5		                                                                                                                                                        // radius
];

if (_baseArsenal && {!isNil "_base"}) then {
    [_arsenal, _base] call AW_fnc_baseTeleportSetup;
};
