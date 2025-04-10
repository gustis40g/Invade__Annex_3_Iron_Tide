/*
* Author: alganthe
* Handles the bleeding timer
*
* Arguments:
* Unit the timer follows, should always be the local player <OBJECT>
*
* Return Value:
* Nothing
*/
params ["_unit"];

derp_revive_bleedOutTimer = 0;

[{
    params ["_args", "_pfhID"];
    _args params ["_unit", "_timerLength"];

    // Check if unit is still downed
    if (!alive _unit || {!(_unit getVariable ["derp_revive_downed", false])}) then {
        derp_revive_bleedOutTimer = nil; // For the next death
        _pfhID call derp_fnc_removePerFrameHandler;

        if (!isNil "derp_revive_ppColor") then {
            {_x ppEffectEnable false} forEach [derp_revive_ppColor, derp_revive_ppVig, derp_revive_ppBlur];
        };
    };

    // Check if timer reached 0
    if (derp_revive_bleedOutTimer >= _timerLength) then {

        derp_revive_bleedOutTimer = nil; // For the next death
        _unit setDamage 1;
        _pfhID call derp_fnc_removePerFrameHandler;

        if (!isNil "derp_revive_ppColor") then {
            {_x ppEffectEnable false} forEach [derp_revive_ppColor, derp_revive_ppVig, derp_revive_ppBlur];
        };
    } else {
        // Draw timer and medic info
        private _nearMedics = ((allPlayers - [_unit]) select {
            ((alive _x) && !(_x getVariable ["derp_revive_downed", false])) && {
                (_x getUnitTrait "Medic") && {
                    ((_x distance _unit) < 1000)
                }
            }
        });

        private _txtMedic = "<t font='PuristaMedium' size='1.6'>No medics nearby</t>";

        if (_nearMedics isNotEqualTo []) then {
            private _nearMedicsSorted = (_nearMedics apply {[(_x distance _unit), _x]});
            _nearMedicsSorted sort true;

            private _nearestMedic = (_nearMedicsSorted # 0);

            _txtMedic = format ["<t font='PuristaMedium' size='1.6'>Closest Medic is <t font='PuristaBold' color='#2874a6'>%1</t>, %2m away</t>", (name (_nearestMedic # 1)), (round (_nearestMedic # 0))];
        };

        "derp_revive_bleedoutText" cutText [(format ["<t font='PuristaMedium' size='2.5' shadow='2'>Bleedout timer: <t font='PuristaBold' color='#a93226'>%1</t></t><br/><br/>%2", (_timerLength - derp_revive_bleedOutTimer), _txtMedic]), "PLAIN DOWN", 0.1, false, true];
        derp_revive_bleedOutTimer = (derp_revive_bleedOutTimer + 1);
    };
}, 1, [_unit, (getMissionConfigValue ["derp_revive_bleedOutTimer", 300])]] call derp_fnc_addPerFrameHandler;
