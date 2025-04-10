/**
    fn_delete.sqf

    Functoin to safely delete anything and everything

    params:
    _toDelete: anything

    return:
    true for success
*/

params ["_toDelete"];

if (isNil "_toDelete") exitWith { false };

if (typeName _toDelete == typeName []) exitWith {
    // if it's an array of things call this function on every element of the array
    {
        _x call AW_fnc_delete;
    } forEach _toDelete;
    true
};

if (typeName _toDelete == typeName grpNull) exitWith {
    //if a group is passed, call this function on every unit in the group and finally delete the group
    {
        _x call AW_fnc_delete;
    } forEach units _toDelete;

    deleteGroup _toDelete;

    true
};

if (!(isNull attachedTo _toDelete)) then {
    detach _toDelete;
};

if (count attachedObjects _toDelete != 0) then {
    {
        detach _x;
        _x call AW_fnc_delete;
    } forEach attachedObjects _toDelete;
};

if (_toDelete isKindOf "Man") exitWith {
    //if it's a man delete him properly depending on if he's in a vehicle or not
    if (vehicle _toDelete != _toDelete) then {
        if (local vehicle _toDelete) then {
            (vehicle _toDelete) deleteVehicleCrew _toDelete;
        } else {
            _toDelete remoteExec ["AW_fnc_delete", (vehicle _toDelete)];
        };

    } else {
        deleteVehicle _toDelete
    };

    true
};

if (_toDelete isKindOf "AllVehicles" && !(_toDelete isKindOf "Man")) exitWith {
    if (!local _toDelete) then {
        _toDelete remoteExec ["AW_fnc_delete", _toDelete];
    };
    //If it's a vehicle, delete the crew first
    private _crew = crew _toDelete;
    if (!isNil "_crew" && {count _crew != 0}) then {
        {
            _toDelete deleteVehicleCrew _x;
        } forEach _crew;
    };

    deleteVehicle _toDelete;

    true
};

//In case it's not a man, vehicle or group
deleteVehicle _toDelete;

true