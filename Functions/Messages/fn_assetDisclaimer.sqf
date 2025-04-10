/*
 * Author: Whigital
 *
 * Description:
 * Displays disclaimer/warning when a pilot enters a CAS/CAP asset
 *
 */

params [
    "_unit",
    ["_vehicle", objNull],
    ["_assetType", nil]
];

if (isNil "_assetType") then {
    _assetType = (_vehicle getVariable ["InA_AssetType", "UNSPECIFIED"]);
};

if ((typeOf _vehicle) == "B_Mortar_01_F") then {
    _assetType = "FSG";
};

if (!(_assetType in ["CAP", "CAS", "FSG", "UAV"])) exitWith {};

if (!(((assignedVehicleRole _unit) # 0) in ["driver", "turret"])) exitWith {};

private _agreed = (missionNamespace getVariable [format ["InA_AssetAgreement%1", _assetType], false]);

if (_agreed) exitWith {};

// Add a delay to see if unit was ejected by seat restrictions
private _timer = 0.25;
private _counter = 0;

while {_counter < _timer} do {
    if (isNull (objectParent _unit)) exitWith {};

    sleep 0.05;

    _counter = (_counter + 0.05);
};

// If already ejected, do nothing
if ((isNull (objectParent _unit)) && {(_assetType in ["CAP", "CAS", "FSG"])}) exitWith {};

private _message = nil;

switch (_assetType) do {
    case "CAS": {
        _message = "<t font='PuristaMedium' size='0.8'>This is a CAS (Air-to-Ground) asset, and <t font='PuristaBold'>CAS needs to be called in by forces on the ground.</t><br/><br/>Any engagements, not called in, are in breach of server rules and approprite actions can and will be taken by staff to ensure compliance with the rules.</t>";
    };

    case "CAP": {
        _message = "<t font='PuristaMedium' size='0.8'>This is a CAP (Air-to-Air) asset, <t font='PuristaBold'>NOT CAS</t> (Air-to-Ground). CAS is not within the parameters of this asset.<br/><br/>Any CAS engagements will be considered reckless, and actions can and will be taken by staff to restrict destructive behavior.</t>";
    };

    case "FSG": {
        _message = "<t font='PuristaMedium' size='0.8'>This is a FSG (Fire Support Group) support weapon, and <t font='PuristaBold'>needs to be called in by forces on the ground.</t><br/><br/>Any engagements, not called in, are in breach of server rules and approprite actions can and will be taken by staff to ensure compliance with the rules.</t>";
    };

    case "UAV": {
        _message = "<t font='PuristaMedium' size='0.8'>UAV's are CAS assets, and <t font='PuristaBold'>needs to be called in by forces on the ground.</t><br/><br/>Any engagements, not called in, are in breach of server rules and approprite actions can and will be taken by staff to ensure compliance with the rules.</t>";
    };
};

if (_assetType in ["CAP", "CAS"]) then {
    _vehicle enableSimulation false;
};

private _ans = [_message, format ["%1 Disclaimer", _assetType], "Agree", "Decline"] call BIS_fnc_guiMessage;

if (!simulationEnabled _vehicle) then {
    _vehicle enableSimulation true;
};

if (_ans) then {
    missionNamespace setVariable [format ["InA_AssetAgreement%1", _assetType], true];
} else {
    if (_assetType == "UAV") then {
        // Close UAV Terminal
        (findDisplay 160) closeDisplay 1;

        0 = [] spawn {
            // Wait for UAV Terminal to close
            waitUntil {isNull (findDisplay 160)};

            // Wait for UAV Terminal to open
            waitUntil {!isNull (findDisplay 160)};
            [player, nil, "UAV"] spawn AW_fnc_assetDisclaimer;
        };
    } else {
        moveOut _unit;
    };
};
