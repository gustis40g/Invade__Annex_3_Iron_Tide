/*
* Author: alganthe
* Set the mission parameter defined skill values for an array of units.
*
* Arguments:
* 0: Array of units to change <ARRAY>
*
* Return Value:
* NOTHING
*/

params [
    ["_unitArray", []],
    ["_boostPct", 0],
    ["_rndPct", 25]
];

if (_unitArray isEqualTo []) exitWith {};

if (InA_Server_AISkillsFromServer) exitWith {};

// Randomization block
private _randomizeSkill = {
    params ["_base", "_boostPct", "_rndPct"];

    private _skill = ((_base + (_base * (_boostPct / 100))) min 1);
    private _skillDiff = (_skill * (_rndPct / 100));
    private _skillFloor = (_skill - (_skillDiff / 2));

    private _skillFinal = ((parseNumber ((_skillFloor + (random _skillDiff)) toFixed 2)) min 1);

    _skillFinal
};

// Sanitization block
if (isNil "AISkills_sanitizeInput") then {
    AISkills_sanitizeInput = {
        params ["_input"];

        private _outArray = [];

        private _type = (typeName _input);

        if (_type == "ARRAY") then {
            {
                _outArray append ([_x] call AISkills_sanitizeInput);
            } forEach _input;
        };

        if (_type == "OBJECT") then {
            if (_input isKindOf "Man") then {
                _outArray pushBack _input;
            };

            if ((_input isKindOf "LandVehicle") || (_input isKindOf "Air") || (_input isKindOf "Ship")) then {
                {_outArray pushBack _x} forEach ((crew _input) select {alive _x});
            };
        };

        if (_type == "GROUP") then {
            {_outArray pushBack _x} forEach ((units _input) select {alive _x});
        };

        _outArray
    };
};


private _general        = (("AIGeneralSkill" call BIS_fnc_getParamValue) / 10);
private _aimingAccuracy = (("AIAimingAccuracy" call BIS_fnc_getParamValue) / 10);
private _aimingShake    = (("AIAimingShake" call BIS_fnc_getParamValue) / 10);
private _aimingSpeed    = (("AIAimingSpeed" call BIS_fnc_getParamValue) / 10);
private _spotDistance   = (("AISpottingDistance" call BIS_fnc_getParamValue) / 10);
private _spotTime       = (("AISpottingSpeed" call BIS_fnc_getParamValue) / 10);
private _courage        = (("AICourage" call BIS_fnc_getParamValue) / 10);
private _reloadSpeed    = (("AIReloadSpeed" call BIS_fnc_getParamValue) / 10);
private _commanding     = (("AICommandingSkill" call BIS_fnc_getParamValue) / 10);

private _arrayFinal = [];

{
    _arrayFinal pushBackUnique _x;
} forEach ([_unitArray] call AISkills_sanitizeInput);

{
    _x setSkill ["general",         ([_general, _boostPct, _rndPct] call _randomizeSkill)];
    _x setSkill ["aimingAccuracy",  ([_aimingAccuracy, _boostPct, _rndPct] call _randomizeSkill)];
    _x setSkill ["aimingShake",     ([_aimingShake, _boostPct, _rndPct] call _randomizeSkill)];
    _x setSkill ["aimingSpeed",     ([_aimingSpeed, _boostPct, _rndPct] call _randomizeSkill)];
    _x setSkill ["spotDistance",    ([_spotDistance, _boostPct, _rndPct] call _randomizeSkill)];
    _x setSkill ["spotTime",        ([_spotTime, _boostPct, _rndPct] call _randomizeSkill)];
    _x setSkill ["courage",         ([_courage, _boostPct, _rndPct] call _randomizeSkill)];
    _x setSkill ["reloadSpeed",     ([_reloadSpeed, _boostPct, _rndPct] call _randomizeSkill)];
    _x setSkill ["commanding",      ([_commanding, _boostPct, _rndPct] call _randomizeSkill)];

    _x allowFleeing 0;
} forEach _arrayFinal;
