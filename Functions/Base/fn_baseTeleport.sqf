/*
    Author: BACONMOP
    Description: For teleporting to different bases
*/
params ["_unit", "_baseLoc"];

if (!isServer) exitWith {};

private _makerDoesNotExist = {getMarkerColor (_this select 0) == ""};

private _setPosDir = {
    params ["_unit", "_marker"];
    if ([_marker] call _makerDoesNotExist) exitWith {
        ["Something went wrong while trying to teleport you"] remoteExec ["hint", _unit];
        [format ["Failed to teleport to marker %1, it does not exist", _marker], "BASE-TP"] spawn AW_FNC_LOG;
    };
    private _pos = getMarkerPos [_marker, true];
    private _dir = markerDir _marker;
    private _isWater = (surfaceIsWater _pos);

    _unit setDir _dir;

    if (_isWater) then {
        _unit setPosASL (AGLToASL _pos);
    } else {
        _unit setPos _pos;
    };
};

private _fobTpMap = createHashMapFromArray [
    ["BASE","BASE"],

    // Altis
    ["Stadium","sdm_pl_res"],
    ["Terminal","term_pl_res"],
    ["Molos_Airfield","mol_pl_res"],
    ["AAC_Airfield","aac_pl_res"],
    ["AO_Abdera","mikael_pl_res"],

    // Cam Lao Nam
    ["AO_SanBayBan","FOB_Leopard"],
    ["AO_MaiLoc","FOB_Fox"],
    ["AO_PemPatBase","FOB_Crocodile"],
    ["AO_DaoTrai","FOB_Bear"],
    ["AO_PleikuBoatBase","FOB_Dolphin"],

    // Sefrou Ramal
    ["Ramal_Airbase", "Ramal_Airbase_pl_res"],

    // Tanoa
    ["AO_Lifou", "adt_spawn"],
    ["AO_Aerodrome", "lra_spawn"],

    // Malden
    ["AO_Airport","mikael_pl_res"]
];

private _specialTpMap = createHashMapFromArray [
    ["BASE_Docks","BASE_docks_pos"],
    ["Carrier","carrier_tp_pos"],
    ["Pilot","pilot_tp_pos"],
    ["Terminal_Docks", "term_docks_pos"]
];

switch (true) do {
    case (_baseLoc in _specialTpMap): {
         [_unit, _specialTpMap get _baseLoc] call _setPosDir;
    };
    case (_baseLoc in _fobTpMap): {
        if (_baseLoc in InA_Server_controlledZones) then {
            [_unit, _fobTpMap get _baseLoc] call _setPosDir;
        };
    };
    default {
        ["Something went wrong while trying to teleport you"] remoteExec ["hint", _unit];
        diag_log format ["ERROR: Could not recognize %1 as a location to teleport to.", _baseLoc];
    };
};
