/*
* Author: alganthe
* Handles the revive states
*
* Arguments:
* 0: Unit to switch state <OBJECT>
* 1: State <ALIVE, DOWNED, REVIVED>
*
* Return Value:
* Nothing
*/
params ["_unit", "_state"];

if (isNull _unit) exitWith {};

_state = (toUpper _state);

if !(_state in ["ALIVE", "DOWNED", "REVIVED"]) exitWith {};

private _resetState = {
    params ["_unit"];

    if (!isNil "derp_revive_KeyDownEhIdx") then {
        (findDisplay 46) displayRemoveEventHandler ["KeyDown", derp_revive_KeyDownEhIdx];
        derp_revive_KeyDownEhIdx = nil;
    };

    [_unit, false] call derp_revive_fnc_animChanged;

    if (!isNil "derp_revive_drawMedicIconsEhIdx") then {
        removeMissionEventHandler ["Draw3D", derp_revive_drawMedicIconsEhIdx];
        derp_revive_drawMedicIconsEhIdx = nil;
    };

    if (!isNil "derp_revive_actionID") then {
        _unit removeAction derp_revive_actionID;
        derp_revive_actionID = nil;
    };

    if (!isNil "selfReviveID") then {
        [_unit, selfReviveID] call BIS_fnc_holdActionRemove;
        selfReviveID = nil;
    };
};


switch (_state) do {
    case "DOWNED": {
        // Save the side before using setCaptive.
        //_unit setVariable ["derp_revive_side", (side _unit), true];

        // Ragdoll and fade if direct call instead of from HD Eh
        if ((lifeState _unit) != "INCAPACITATED") then {
            _unit setUnconscious true;
            cutText ["", "BLACK", 1];
            _unit allowDamage false;
        };

        _unit setCaptive true;
        _unit setVariable ["derp_revive_downed", true, true];

        if ((["derp_revive_selfrevive", 1] call BIS_fnc_getParamValue) == 1) then {
            [_unit] call derp_revive_fnc_addSelfReviveHoldaction; 
        };    
        
        derp_revive_actionID = (_unit addAction ["", {}, "", 0, false, true, "DefaultAction"]);

        [_unit] call derp_revive_fnc_reviveTimer;
            //call derp_revive_fnc_hotkeyHandler;
        call derp_revive_fnc_uiElements;

    };

    case "ALIVE": {
        _unit setVariable ["derp_revive_reviving", false, true];
        _unit setVariable ["derp_revive_downed", false, true];

        _unit setVariable ["derp_revive_isDragging", false, true];
        _unit setVariable ["derp_revive_isDragged", false, true];

        _unit setVariable ["derp_revive_isCarrying", false, true];
        _unit setVariable ["derp_revive_isCarried", false, true];

        // Remove revive EHs end effects, restore actions
        [_unit] call _resetState;

        if !(isNil "derp_revive_ppColor") then {
            {_x ppEffectEnable false} forEach [derp_revive_ppColor, derp_revive_ppVig, derp_revive_ppBlur];
        };

        // Restore HUD elements
        showHUD derp_revive_hudElements;

        _unit setCaptive false;
        remoteExec ["", (str _unit + "animChangedJIPID")];
    };

    case "REVIVED": {
        {_unit setHitPointDamage [_x, 0]} forEach ((getAllHitPointsDamage _unit) # 0);
        _unit setDamage 0;

        _unit setVariable ["derp_revive_downed", false, true];

        _unit setUnconscious false;
        _unit allowDamage true;
        // Remove revive EHs end effects, restore actions
        [_unit] call _resetState;

        if (!isNil "derp_revive_ppColor") then {
            {_x ppEffectEnable false} forEach [derp_revive_ppColor, derp_revive_ppVig, derp_revive_ppBlur];
        };
        // Restore HUD elements
        showHUD derp_revive_hudElements;

        [_unit] spawn {
            params ["_unit"];
            sleep 10;
            _unit setCaptive false;
        };

    };
};
