/*
 * Author: Whigital
 * Description:
 * Adds "Cut grass" action to applicable roles
 *
 */

params ["_unit"];

private _roleDesc = (roleDescription _unit);

private _isAutorifleman = ((_roleDesc find "Autorifleman") != -1);
private _isMarksman = ((_roleDesc find "Marksman") != -1);
private _isSniper = (((_roleDesc find "Sniper") != -1) && ((_roleDesc find "Spotter") == -1));
private _isSpotter = ((_roleDesc find "Spotter") != -1);

if (!_isAutorifleman && !_isMarksman && !_isSniper && !_isSpotter) exitWith {};

if (isNil "AW_fnc_cutGrassAction_canCut") then {
    AW_fnc_cutGrassAction_canCut = {
        params ["_unit"];

        if ((getTerrainGrid > 48) || ((stance _unit) != "PRONE") || ([_unit] call AW_fnc_isNearBase)) exitWith {false};

        if (((getPosATL _unit) # 2) > 0.3) exitWith {false};

        private _surfaceType = (surfaceType (_unit getPos [2.5, (getDir _unit)]));

        private _surfaceTypes = [
            "grass",
            "thorn",
            "forest",
            "dirt",
            "soil",
            "stonythistle"
        ];

        if (((_surfaceTypes findIf {_x in (toLower _surfaceType)}) == -1)) exitWith {false};

        if ((count ((getPos _unit) nearObjects ["Land_ClutterCutter_medium_F", 2.5])) > 0) exitWith {false};

        true
    };
};

_unit addAction [
    "<t size='1.2' font='PuristaBold' color='#38610b'><img image='\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\attack_ca.paa'/> Cut grass/plants</t>",
    {
        params ["_target", "_caller", "_actionId", "_arguments"];

        private _animParams = ["AinvPpneMstpSnonWnonDnon_Putdown_AmovPpneMstpSnonWnonDnon", 1.2];

        switch (currentWeapon _caller) do {
            case "": {
                _animParams = ["AinvPpneMstpSnonWnonDnon_Putdown_AmovPpneMstpSnonWnonDnon", 1.2];
            };

            case (primaryWeapon _caller): {
                _animParams = ["AinvPpneMstpSrasWrflDnon_Putdown_AmovPpneMstpSrasWrflDnon", 1.7];
            };

            case (handgunWeapon _caller): {
                _animParams = ["AinvPpneMstpSrasWpstDnon_Putdown_AmovPpneMstpSrasWpstDnon", 1.7];
            };

            case (binocular _caller): {
                _animParams = ["AinvPpneMstpSoptWbinDnon_Putdown_AmovPpneMstpSoptWbinDnon", 1.9];
            };
        };

        _animParams params ["_anim", "_sleep"];

        disableUserInput true;

        // Failsafe to re-enable userInput ....
        0 = [] spawn {
            sleep 3;

            if (userInputDisabled) then {
                disableUserInput false;
            };
        };

        _caller playMove _anim;
        sleep _sleep;
        [_caller] remoteExec ["AW_fnc_cutGrass", 2];

        disableUserInput false;
    },
    [],
    0,
    false,
    true,
    "",
    "[_target] call AW_fnc_cutGrassAction_canCut",
    0,
    false
];
