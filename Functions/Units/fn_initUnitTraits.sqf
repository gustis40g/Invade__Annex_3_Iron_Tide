/*
    Sets up unit traits based of their role description
*/
params ["_unit", "_roleDesc"];

if (!local _unit) exitWith {
    [_this] remoteExecCall ["AW_fnc_initUnitTraits", _unit];
};

_roleDesc = toLower(_roleDesc);

private _isRepairSpec = ("repair specialist" in _roleDesc) || ("engineer" in _roleDesc);
private _isDemo = ("explosive specialist" in _roleDesc) || ("engineer" in _roleDesc);
private _isMedic = ("medic" in _roleDesc);
private _isUAVop = ("uav operator" in _roleDesc);

_unit setUnitTrait ["engineer", _isRepairSpec];
_unit setUnitTrait ["explosiveSpecialist ", _isDemo];
_unit setUnitTrait ["medic", _isMedic];
_unit setUnitTrait ["UAVHacker", _isUAVop];
