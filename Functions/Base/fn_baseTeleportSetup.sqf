/* description: to set up base teleport on objects */
params ["_obj", "_currLoc"];

if (!hasInterface) exitWith {};

private _addTPaction = {
    params [
        "_obj",
        "_name",
        "_dest",
        ["_cond", "true"]
    ];

    _obj addAction [
        format ["<t color='#009ACD'>Teleport to %1</t>", _name],
        {
            params ["_target", "_caller", "_actionId", "_arguments"];

            cutText ["","BLACK OUT"];
            sleep 1;
            [_caller, _arguments] remoteExec ["AW_fnc_baseTeleport", 2];
            sleep 1;
            cutText ["","BLACK IN"];
        },
        _dest,
        -100,
        false,
        true,
        "",
        _cond,
        5
    ];
};


// General locations
if (_currLoc != "BASE") then {
    [
        _obj,
        "Main Base",
        "BASE"
    ] call _addTPaction;
};

if (_currLoc != "Pilot") then {
    private _cond = "(player getVariable ['AW_role',''] == 'pilot')";
    
    [
        _obj,
        "Pilot Spawn",
        "Pilot",
        _cond
    ] call _addTPaction;
};

if (_currLoc != "Carrier") then {
     private _cond = "(player getVariable ['AW_role',''] in ['pilot','uav']) || (_this getVariable ['InA_isZeus', false])";
    
    [
        _obj,
        "USS Freedom",
        "Carrier",
        _cond
    ] call _addTPaction;
};


// Altis FOBs
if ((toLower worldName) == "altis") then {
    if (_currLoc != "AAC_Airfield") then {
        private _cond = "('AAC_Airfield' in InA_Client_controlledZones)";

        [
            _obj,
            "FOB Martian",
            "AAC_Airfield",
            _cond
        ] call _addTPaction;
    };

    if (_currLoc != "Stadium") then {
        private _cond = "('Stadium' in InA_Client_controlledZones)";

        [
            _obj,
            "FOB Marathon",
            "Stadium",
            _cond
        ] call _addTPaction;
    };

    if (_currLoc != "Terminal") then {
        private _cond = "('Terminal' in InA_Client_controlledZones)";

        [
            _obj,
            "FOB Guardian",
            "Terminal",
            _cond
        ] call _addTPaction;
    };

    if (_currLoc != "Molos_Airfield") then {
        private _cond = "('Molos_Airfield' in InA_Client_controlledZones)";

        [
            _obj,
            "FOB Last Stand",
            "Molos_Airfield",
            _cond
        ] call _addTPaction;
    };

    if (_currLoc != "AO_Abdera") then {
        private _cond = "('AO_Abdera' in InA_Client_controlledZones)";

        [
            _obj,
            "FOB Mikael",
            "AO_Abdera",
            _cond
        ] call _addTPaction;
    };
};


// Cam Lao Nam FOBs
if ((toLower worldName) == "cam_lao_nam") then {
    if (_currLoc != "AO_SanBayBan") then {
        private _cond = "('AO_SanBayBan' in InA_Client_controlledZones)";

        [
            _obj,
            "FOB Leopard",
            "AO_SanBayBan",
            _cond
        ] call _addTPaction;
    };

    if (_currLoc != "AO_MaiLoc") then {
        private _cond = "('AO_MaiLoc' in InA_Client_controlledZones)";

        [
            _obj,
            "FOB Fox",
            "AO_MaiLoc",
            _cond
        ] call _addTPaction;
    };

    if (_currLoc != "AO_PemPatBase") then {
        private _cond = "('AO_PemPatBase' in InA_Client_controlledZones)";

        [
            _obj,
            "FOB Crocodile",
            "AO_PemPatBase",
            _cond
        ] call _addTPaction;
    };

    if (_currLoc != "AO_DaoTrai") then {
        private _cond = "('AO_DaoTrai' in InA_Client_controlledZones)";

        [
            _obj,
            "FOB Bear",
            "AO_DaoTrai",
            _cond
        ] call _addTPaction;
    };
    if (_currLoc != "AO_PleikuBoatBase") then {
        private _cond = "('AO_PleikuBoatBase' in InA_Client_controlledZones)";

        [
            _obj,
            "FOB Dolphin",
            "AO_PleikuBoatBase",
            _cond
        ] call _addTPaction;
    };
};


// Sefrou Ramal FOBs
if ((toLower worldName) == "sefrouramal") then {
    if (_currLoc != "Ramal_Airbase") then {
        private _cond = "('Ramal_Airbase' in InA_Client_controlledZones)";

        [
            _obj,
            "FOB Good Hope",
            "Ramal_Airbase",
            _cond
        ] call _addTPaction;
    };
};


// Tanoa
if ((toLower worldName) == "tanoa") then {
    if (_currLoc != "AO_Lifou") then {
        private _cond = "('AO_Lifou' in InA_Client_controlledZones)";

        [
            _obj,
            "FOB Stronghold",
            "AO_Lifou",
            _cond
        ] call _addTPaction;
    };

    if (_currLoc != "AO_Aerodrome") then {
        private _cond = "('AO_Aerodrome' in InA_Client_controlledZones)";

        [
            _obj,
            "FOB Copperhead",
            "AO_Aerodrome",
            _cond
        ] call _addTPaction;
    };
};

// Malden 
if ((toLower worldName) == "malden") then {
    if (_currLoc != "AO_Airport") then {
        private _cond = "('AO_Airport' in InA_Client_controlledZones)";

        [
            _obj,
            "FOB Mikael",
            "AO_Airport",
            _cond
        ] call _addTPaction;
    };
};
