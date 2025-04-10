/*
 * Author: Whigital
 *
 * Description:
 * Adds inventory management actions to vehicle
 *
 */

params ["_vehicle"];

if (isNil "InA_Inventory_Stevies") then {
    InA_Inventory_Stevies = [];

    private _stevies = (getArray (missionConfigFile >> worldName >> "arsenalObjects"));

    {
        private _stevie = (missionNamespace getVariable [_x, objNull]);

        if (!isNull _stevie) then {
            InA_Inventory_Stevies pushBackUnique _stevie;
        }
    } forEach _stevies;
};

private _cond = {
    ((driver _target) == _this) && {
        (((_target nearEntities ["Man", 8]) findIf {_x in (InA_Inventory_Stevies select {!isHidden _x})}) != -1)
    }
};

_vehicle addAction [
    "<t color='#00d400' size='1.2' font='PuristaBold'><img size='1.1' image='\a3\missions_f_oldman\data\img\holdactions\holdAction_box_ca.paa' /> Vehicle Inventory</t>",
    {
        params ["_target", "_caller", "_actionId", "_arguments"];

        InA_Inventory_Target = _target;

        private _dlgInvCreated = createDialog "InA_Display_Inventory";

        if (!_dlgInvCreated) exitWith {
            InA_Inventory_Target = nil;
        };
    },
    [],
    99,
    true,
    true,
    "",
    (toString _cond),
    8
];
