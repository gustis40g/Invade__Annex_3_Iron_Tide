/*
    file: fn_spawnAIGroup.sqf
    Spawns an AI group in a given position

    params:
        unitTypes   - array     - an array of unit types to spawn
        position    - array     - the position to spawn the group

    returns:
    group - the group that was created
*/

params [
    "_unitTypes",
    "_pos",
    ["_useSleep", true, [true]],
    ["_side", InA_EnemyFactionSide]
];

private _tmpGrp = (createGroup _side);

{
    private _unit = (_tmpGrp createUnit [_x, _pos, [], 5, "NONE"]);

    if (_useSleep) then {
        sleep 0.05;
    };
} forEach _unitTypes;

_tmpGrp = [_tmpGrp] call AW_fnc_changeGroupSide;

_tmpGrp
