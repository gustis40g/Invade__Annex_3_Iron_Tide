/*
 * Author: AgentRev / Adapted for I&A by Whigital
 * Description:
 * Builds a bridge, see https://gist.github.com/AgentRev/abcdf75aceba54510e499a3972d720d1
 *
 */

params [
    ["_startPos", getPosASL vehicle player, [[]]], // always ASL
    ["_startDir", getDir vehicle player, [0,[]]],
    ["_parts", [], [[]]]
];

private _flatHeight = -1.044;
private _rampPlusHeight = 1.740;
private _rampMinusHeight = -2.541;
private _rampUpPlusHeight = 0.256;
private _rampUpMinusHeight = -1.058;
private _rampDownPlusHeight = 0.266;
private _rampDownMinusHeight = -1.047;

private _startHeights = [
    ["flat", _flatHeight],
    ["ramp+", _rampPlusHeight],
    ["ramp-", _rampMinusHeight],
    ["rampUp+", _rampUpPlusHeight],
    ["rampUp-", _rampUpMinusHeight],
    ["rampDown+", _rampDownPlusHeight],
    ["rampDown-", _rampDownMinusHeight]
];

private _diffHeights = [
    ["flat_flat", 0],

    ["ramp+_ramp+", 4.282],
    ["ramp-_ramp-", -4.282],
    ["ramp+_ramp-", 0],
    ["ramp-_ramp+", 0],

    ["rampUp+_rampUp+", 1.313],
    ["rampUp-_rampUp-", -1.313],
    ["rampUp+_rampUp-", 0],
    ["rampUp-_rampUp+", 0],

    ["rampUp+_rampDown+", 1.324],
    ["rampDown+_rampUp+", 1.303],
    ["rampUp+_rampDown-", -0.010],
    ["rampDown-_rampUp+", -0.011],

    ["rampUp-_rampDown+", 0.010],
    ["rampDown+_rampUp-", -0.010],
    ["rampUp-_rampDown-", -1.303],
    ["rampDown-_rampUp-", -1.324],

    ["rampDown+_rampDown+", 1.314],
    ["rampDown-_rampDown-", -1.314],
    ["rampDown+_rampDown-", 0],
    ["rampDown-_rampDown+", 0]
];

private _lampHeights = [
    ["flat", 1.25],
    ["ramp+", 0.55],
    ["ramp-", 0.55],
    ["rampUp+", 0.85],
    ["rampUp-", 0.85],
    ["rampDown+", 0.3],
    ["rampDown-", 0.3]
];

private _findInPairs = {
    params ["_arr", "_key"];

    (((_arr select {(_x # 0) == _key}) # 0) # 1)
};

private _findHeight = {
    params ["_name", "_heights", "_code"];

    ([_heights, _name] call _code)
};

_diffHeights append [
    ["flat_ramp+", _rampPlusHeight - _flatHeight],
    ["ramp+_flat", -_rampMinusHeight + _flatHeight],

    ["flat_ramp-", _rampMinusHeight - _flatHeight],
    ["ramp-_flat", -_rampPlusHeight + _flatHeight],

    ["flat_rampUp+", _rampUpPlusHeight - _flatHeight],
    ["rampUp+_flat", -_rampUpMinusHeight + _flatHeight],

    ["flat_rampUp-", _rampUpMinusHeight - _flatHeight],
    ["rampUp-_flat", -_rampUpPlusHeight + _flatHeight],

    ["flat_rampDown+", _rampDownPlusHeight - _flatHeight],
    ["rampDown+_flat", -_rampDownMinusHeight + _flatHeight],

    ["flat_rampDown-", _rampDownMinusHeight - _flatHeight],
    ["rampDown-_flat", -_rampDownPlusHeight + _flatHeight],

    ["ramp+_rampUp+", _rampUpPlusHeight - _rampMinusHeight],
    ["rampUp+_ramp+", -_rampUpMinusHeight + _rampPlusHeight],

    ["ramp+_rampUp-", _rampUpMinusHeight - _rampMinusHeight],
    ["rampUp-_ramp+", -_rampUpPlusHeight + _rampPlusHeight],

    ["ramp+_rampDown+", _rampDownPlusHeight - _rampMinusHeight],
    ["rampDown+_ramp+", -_rampDownMinusHeight + _rampPlusHeight],

    ["ramp+_rampDown-", _rampDownMinusHeight - _rampMinusHeight],
    ["rampDown-_ramp+", -_rampDownPlusHeight + _rampPlusHeight],

    ["ramp-_rampUp+", _rampUpPlusHeight - _rampPlusHeight],
    ["rampUp+_ramp-", -_rampUpMinusHeight + _rampMinusHeight],

    ["ramp-_rampUp-", _rampUpMinusHeight - _rampPlusHeight],
    ["rampUp-_ramp-", -_rampUpPlusHeight + _rampMinusHeight],

    ["ramp-_rampDown+", _rampDownPlusHeight - _rampPlusHeight],
    ["rampDown+_ramp-", -_rampDownMinusHeight + _rampMinusHeight],

    ["ramp-_rampDown-", _rampDownMinusHeight - _rampPlusHeight],
    ["rampDown-_ramp-", -_rampDownPlusHeight + _rampMinusHeight]
];

private _partsList = [
    ["flat", ["a3\structures_f_exp\infrastructure\bridges\bridgesea_01_f.p3d", 48, 0, [-0.013,0.0839,0]]],
    ["ramp+", ["a3\structures_f_exp\infrastructure\bridges\bridgesea_01_ramp_f.p3d", 48, 180, [-0.006,0.0855,0]]],
    ["ramp-", ["a3\structures_f_exp\infrastructure\bridges\bridgesea_01_ramp_f.p3d", 48, 0, [-0.006,0.0855,0]]],
    ["rampUp+", ["a3\structures_f_exp\infrastructure\bridges\bridgesea_01_ramp_up_f.p3d", 24, 180, [0.0410,0.0165,0]]],
    ["rampUp-", ["a3\structures_f_exp\infrastructure\bridges\bridgesea_01_ramp_up_f.p3d", 24, 0, [0.0410,0.0165,0]]],
    ["rampDown+", ["a3\structures_f_exp\infrastructure\bridges\bridgesea_01_ramp_down_f.p3d", 24, 180, [0.0395,0.0425,0]]],
    ["rampDown-", ["a3\structures_f_exp\infrastructure\bridges\bridgesea_01_ramp_down_f.p3d", 24, 0, [0.0395,0.0425,0]]]
];

private _buildPillarStack = {
    params ["_partName", "_partPos", "_partDir", ["_dirOffset",0], ["_nextPartName",""]];

    private _pillarOffset = [];
    private _pillarStackOffset = [0,0,-39.5];
    private _pillarBottomOffset = [0,0,-19.75];
    private _pillarBottom = [0,0,1e11];
    private _prevPillarPos = [];

    _pillarOffset = (switch (true) do {
        case (_partName == "flat" && _nextPartName != "" && _nextPartName != "flat"): {
            [0, 24, -20.2]
        };

        case (_partName == "flat" && _nextPartName == ""): {
            [0, -24, -20.2]
        };

        case ((_partName == "ramp+" || _partName ==  "ramp-") && _nextPartName == ""): {
            [0, 0, -20.8]
        };

        case (_partName == "rampUp+" && _nextPartName == "rampUp-"): {
            [0, 12, -20.2]
        };

        case (_partName == "rampUp-" && _nextPartName == "rampUp+"): {
            [0, 12, -21.4]
        };

        case (_partName == "rampDown+" && _nextPartName == "rampDown-"): {
            [0, 12, -20.2]
        };

        case (_partName == "rampDown-" && _nextPartName == "rampDown+"): {
            [0, 12, -21.5]
        };

        default {nil};
    });

    if (!isNil "_pillarOffset") then {
        private _pillarPos = [];

        while {_pillarBottom select 2 > 0} do {
            if (_prevPillarPos isEqualTo []) then {
                _pillarPos = _partPos vectorAdd ([_pillarOffset, -_partDir] call BIS_fnc_rotateVector2D);
            } else {
                _pillarPos = _prevPillarPos vectorAdd _pillarStackOffset;
            };

            private _pillar = createSimpleObject ["a3\structures_f_exp\infrastructure\bridges\bridgesea_01_pillar_f.p3d", _pillarPos];
            _pillar setDir (_partDir + _dirOffset);

            _pillarBottom = ASLtoATL (_pillarPos vectorAdd _pillarBottomOffset);
            _prevPillarPos = _pillarPos;
        };
    };
};


private _prevPart = [];
private _partPos = [0,0,0];

{
    private _partOptions = (_x splitString "_");
    private _lampOption = (_partOptions deleteAt (_partOptions findIf {_x select [0,4] == "lamp"}));
    private _rightLamp = (!isNil "_lampOption" && {_lampOption == "lampR"});

    _partOptions params [
        ["_partName", "", [""]],
        ["_partCount", "1", [""]],
        ["_arcAngle", "0", [""]]
    ];

    _partCount = (1 max (parseNumber _partCount));
    _arcAngle = (parseNumber _arcAngle);

    ([_partsList, _partName] call _findInPairs) params [
        ["_partModel", "", [""]],
        ["_partLength", 0, [0]],
        ["_partDirRel", 0, [0]],
        ["_partOffset", [0,0,0], [[]]]
    ];

    private _partDirAbs = _startDir;
    _partDir = _partDirAbs + _partDirRel;

    for "_i" from 1 to _partCount do {
        private _pivotAngle = 0;

        if (_prevPart isEqualTo []) then {
            _partPos = _startPos vectorAdd ([[0, _partLength / 2, ([_partName, _startHeights, _findInPairs] call _findHeight) - (_partOffset select 2)], -_startDir] call BIS_fnc_rotateVector2D);
        } else {
            _prevPart params ["_prevPartName", "_prevPartPos", "_prevPartLength", "_prevPartDir"];

            [_prevPartName, _prevPartPos, _prevPartDir, 0, _partName] call _buildPillarStack;

            private _pairName = (format ["%1_%2", _prevPartName, _partName]);
            private _pivotTemp = ([_pairName, _diffHeights, _findInPairs] call _findHeight);

            if (_arcAngle != 0 && _i > 1) then {
                _pivotAngle = _arcAngle / ((_partCount - 1) max 1);

                private _pivotOffset = 7.042 * ([1,-1] select (_pivotAngle > 0));
                private _pivotVector = [-_pivotOffset, _partLength / 2, _pivotTemp];
                private _pivotPos = _prevPartPos vectorAdd ([[_pivotOffset, _prevPartLength / 2, 0], -_prevPartDir] call BIS_fnc_rotateVector2D);
                _partPos = _pivotPos vectorAdd ([_pivotVector, -(_prevPartDir + _pivotAngle)] call BIS_fnc_rotateVector2D);

                _startDir = _startDir + _pivotAngle;
                _partDirAbs = _startDir;
                _partDir = _partDirAbs + _partDirRel;

                _partPos = _partPos vectorAdd [0, 0, 0.002 * ([-1, 1] select (_i % 2))];
            } else {
                _partPos = _prevPartPos vectorAdd ([[0, (_partLength + _prevPartLength) / 2, _pivotTemp], -_startDir] call BIS_fnc_rotateVector2D);
            };
        };

        private _partPosOff = _partPos vectorAdd ([_partOffset, -_partDir] call BIS_fnc_rotateVector2D);

        _partObj = createSimpleObject [_partModel, _partPosOff];
        _partObj setDir _partDir;

        if (!isNil "_lampOption") then {
            private _lampPos = ASLtoATL (_partPosOff vectorAdd ([[5.7 * ([-1,1] select _rightLamp), 0, [_lampHeights,_partName] call _findInPairs], -_partDirAbs] call BIS_fnc_rotateVector2D));
            private _lampObj = createVehicle ["Land_LampStreet_F", _lampPos, [], 0, "CAN_COLLIDE"];
            _lampObj setDir (_partDirAbs + ([90, -90] select _rightLamp));
            _lampObj setPosATL _lampPos;
            _lampObj allowDamage false;
        };

        [_partName, _partPos, _partDirAbs, -_pivotAngle / 2] call _buildPillarStack;

        _prevPart = [_partName, _partPos, _partLength, _partDirAbs];
    };
} forEach _parts;
