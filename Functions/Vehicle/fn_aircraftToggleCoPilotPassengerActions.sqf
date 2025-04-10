/*
 * Author: Whigital
 *
 * Description:
 * Actions to enable/disable passengers in the CoPilot seat
 *
 */

params [
    ["_aircraft", objNull]
];

if (isNull _aircraft || !hasInterface) exitWith {};

_aircraft addAction [
    "<t color='#00e000' size='1.2' font='PuristaBold'><img size='1.1' image='\a3\missions_f_oldman\data\img\holdactions\holdAction_follow_start_ca.paa' /> Enable CoPilot Passangers</t>", {
        params ["_target", "_caller", "_actionId", "_arguments"];

        _target setVariable ["InA_AllowCoPilotPassengers", true, true];
    },
    "",
    0,
    false,
    true,
    "",
    "
        (
            ([_this] call AW_fnc_isPilot) && {
                ((_target turretUnit [-1]) == _this) && {
                    !(_target getVariable ['InA_AllowCoPilotPassengers', false])
                }
            }
        )
    ",
    15
];

_aircraft addAction [
    "<t color='#e00000' size='1.2' font='PuristaBold'><img size='1.1' image='\a3\missions_f_oldman\data\img\holdactions\holdAction_follow_stop_ca.paa' /> Disable CoPilot Passangers</t>", {
        params ["_target", "_caller", "_actionId", "_arguments"];

        _target setVariable ["InA_AllowCoPilotPassengers", false, true];
    },
    "",
    0,
    false,
    true,
    "",
    "
        (
            ([_this] call AW_fnc_isPilot) && {
                ((_target turretUnit [-1]) == _this) && {
                    (_target getVariable ['InA_AllowCoPilotPassengers', false])
                }
            }
        )
    ",
    15
];
