params [
    "_unit",
    "_threatPos",
    "_threatRadius",
    "_lifeExpectancy"
];

if (_unit != player) exitWith {};

_unit setVariable ["AW_CBRN_isClientLoopRunning", true, true];

// Contact DLC items
private _suitsDLC = [
    "U_B_CBRN_Suit_01_MTP_F",
    "U_B_CBRN_Suit_01_Tropic_F",
    "U_B_CBRN_Suit_01_Wdl_F"
];

private _apparatusDLC = [
    "B_SCBA_01_F",
    "B_CombinationUnitRespirator_01_F"
];

private _masksDLC = [
    "G_AirPurifyingRespirator_02_black_F",
    "G_AirPurifyingRespirator_02_olive_F",
    "G_AirPurifyingRespirator_02_sand_F",
    "G_AirPurifyingRespirator_01_F",
    "G_AirPurifyingRespirator_01_nofilter_F",
    "G_RegulatorMask_F"
];

// Vanilla items
private _vanillaHeadgear = [
    "H_Shemag_olive",
    "H_Shemag_olive_hs",
    "H_ShemagOpen_khk",
    "H_ShemagOpen_tan"
];

private _vanillaGoggles = [
    "G_Combat",
    "G_Combat_Goggles_tna_F"
];

private _hasDLC = (1021790 in (getDLCs 1));

private _interval = 1;
private _colorGreen = 1;
private _colorRed = 0;

private _maxDamagePerInterval = ((1 / _lifeExpectancy) / _interval);

private _ctrlWidth = 0.75;
private _ctrlHeight = 0.05;
private _xpos = ((safeZoneX + (safeZoneWAbs / 2 )) - (_ctrlWidth / 2));

disableSerialization;

private _ThreatLevelCtrl = (findDisplay 46) ctrlCreate ["RscProgress", -1];
_ThreatLevelCtrl ctrlSetPosition [_xpos, 1, _ctrlWidth, _ctrlHeight];
_ThreatLevelCtrl progressSetPosition 0;
_ThreatLevelCtrl ctrlSetTextColor [_colorRed, _colorGreen, 0, 0.8];
_ThreatLevelCtrl ctrlCommit 0;
_ThreatLevelCtrl ctrlShow false;

while {(alive _unit) && {InA_Client_SideMissionUp && {((getPos (vehicle _unit)) distance _threatPos) < _threatRadius}}} do {
    private _compoundDamage = 0;

    private _playerGear = [
        (uniform _unit),
        (backpack _unit),
        (goggles _unit),
        (headgear _unit)
    ];

    private _hasSuit = ((_suitsDLC findIf {(toLower _x) == (toLower (_playerGear # 0))}) != -1);
    private _hasTank = ((_apparatusDLC findIf {(toLower _x) == (toLower (_playerGear # 1))}) != -1);
    private _hasMask = ((_masksDLC findIf {(toLower _x) == (toLower (_playerGear # 2))}) != -1);

    private _hasBreathProt = ((_vanillaHeadgear findIf {(toLower _x) == (toLower (_playerGear # 3))}) != -1);
    private _hasEyeProt = ((_vanillaGoggles findIf {(toLower _x) == (toLower (_playerGear # 2))}) != -1);

    private _hasOxy = (_hasTank && _hasMask);

    if (!_hasEyeProt && !_hasSuit) then {
        _compoundDamage = (_compoundDamage + (_maxDamagePerInterval / 2));
    };

    if (!_hasBreathProt && !_hasOxy) then {
        _compoundDamage = (_compoundDamage + (_maxDamagePerInterval / 2));
    };

    private _threatDistance = ((getPos _unit) distance _threatPos);

    private _finalDamage = linearConversion [0, _threatRadius, _threatDistance, _compoundDamage, 0];
    private _progress = linearConversion [0, _threatRadius, _threatDistance, 1, 0];

    if (_progress < 0.5) then {
        _colorGreen = 1;
        _colorRed = linearConversion [0, 0.5, _progress, 0, 1];
    } else {
        _colorGreen = linearConversion [0.5, 1, _progress, 1, 0];
        _colorRed = 1;
    };

    _ThreatLevelCtrl progressSetPosition _progress;
    _ThreatLevelCtrl ctrlSetTextColor [_colorRed, _colorGreen, 0, 0.8];

    if (_finalDamage > 0) then {
        if (!ctrlShown _ThreatLevelCtrl) then {
            _ThreatLevelCtrl ctrlShow true;
        };

        {
            private _hpDamage = (_unit getHitPointDamage _x);

            _unit setHitPointDamage [_x, (_hpDamage + _finalDamage)];
        } forEach ["hitface", "hitneck", "hithead", "hitpelvis", "hitabdomen", "hitdiaphragm", "hitchest", "hitbody", "hitarms", "hithands", "hitlegs"];
    } else {
        if (ctrlShown _ThreatLevelCtrl) then {
            _ThreatLevelCtrl ctrlShow false;
        };
    };

    sleep _interval;
};

_unit setVariable ["AW_CBRN_isClientLoopRunning", false, true];

ctrlDelete _ThreatLevelCtrl;
