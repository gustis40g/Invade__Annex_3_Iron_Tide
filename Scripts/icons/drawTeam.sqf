/*
    https://community.bistudio.com/wiki/Arma_3:_CfgMarkerColors Arma 3 Vanilla
    https://www.rapidtables.com/web/color/RGB_Color.html for more colors
*/

// Draw on Map or GPS
if (isDedicated || !hasInterface) exitWith {};

waitUntil {
    uiSleep 0.1;
    !(isNull (findDisplay 12)) || visibleMap || ("MinimapDisplay" in ((infoPanel "left") + (infoPanel "right")))
};

(findDisplay 12 displayCtrl 51) ctrlAddEventHandler ["Draw", {
    params ["_ctrl"];

    private _isMiniMap =
        ("MinimapDisplay" in ((infoPanel "left") + (infoPanel "right"))) &&
        {!visibleMap};

    {
        private _unit = _x;
        private _vehicle = vehicle _unit;
        private _crew = crew _vehicle select {isPlayer _x};
        private _name = name _unit;
        private _unitColor = [0,0,0,0];

        private _colorIndependent = [0.00, 0.48, 1.00, 1.00];
        private _colorOrange = [0.90, 0.60, 0.00, 1.00];
        private _colorGrey = [0.10, 0.10, 0.10, 1.00];

        private _healthState = lifeState _unit;
        private _incapacitated = (
            (alive _unit) && (
                (_unit getVariable ["spe_revive_incap", false]) ||
                (_unit getVariable ["ACE_isUnconscious", false]) ||
                (_healthState == "INCAPACITATED")
            )
        );

        private _vehicleIcon = getText(configFile >> "CfgVehicles" >> typeOf _vehicle >> "icon");
        private _vehicleName = getText(configFile >> "CfgVehicles" >> typeOf _vehicle >> "displayName");
        private _roleName = getText(missionConfigFile >> "Dynamic_Roles" >> (_unit getVariable ["AW_role", "rifleman"]) >> "name");
        private _roleIcon = "iconMan";

        switch (_roleName) do {
            case "Rifleman": {_roleIcon = "iconMan"};
            case "Squad Leader": {_roleIcon = "iconManOfficer"};
			case "Recon Team Leader";
			case "Team Leader": {_roleIcon = "iconManLeader"};
			case "Recon Medic";
            case "Medic": {_roleIcon = "iconManMedic"};
            case "Autorifleman": {_roleIcon = "iconManMG"};
			case "Light Anti-Tank";
			case "Recon Heavy Anti-Tank";
            case "Heavy Anti-Tank": {_roleIcon = "iconManAT"};
            case "Sniper": {_roleIcon = "iconManRecon"};
			case "Repair Specialist";
            case "Engineer": {_roleIcon = "iconManEngineer"};
			case "Recon Explosive Specialist";
            case "Explosive Specialist": {_roleIcon = "iconManExplosive"};
			case "UAV Operator";
			case "Mortar Gunner": {_roleIcon = "iconManVirtual"};
            case "Pilot": {_roleIcon = "iconMan"};
        };

        if (!alive _unit) then {
            _unitColor = _colorGrey;
        } else {
            _unitColor = if (_incapacitated) then {_colorOrange} else {_colorIndependent};
        };

        private _distance = _unit distance player;
        if (!_isMiniMap || {_distance <= 1000}) then {
            if (_vehicle != _unit) then {
                private _crewCount = count _crew;
                private _crewDisplay = if (_crewCount > 1) then {format [" + %1", (_crewCount - 1)]} else {""};

                _ctrl drawIcon [
                    _vehicleIcon,
                    _unitColor,
                    getPosASLVisual _vehicle,
                    24,
                    24,
                    getDirVisual _vehicle,
                    format ["%1 (%2%3)", _vehicleName, name (_crew select 0), _crewDisplay],
                    1,
                    0.03,
                    "TahomaB",
                    "right"
                ];
            } else {
                _ctrl drawIcon [
                    _roleIcon,
                    _unitColor,
                    getPosASLVisual _unit,
                    24,
                    24,
                    getDirVisual _unit,
                    format ["%1: %2", _roleName, _name],
                    1,
                    0.03,
                    "TahomaB",
                    "right"
                ];
            };
        };
    } forEach (allPlayers - (entities "HeadlessClient_F"));

    {
        private _mobileRespawn = _x;
        private _icon = "\A3\ui_f\data\map\markers\military\end_CA.paa";

        _ctrl drawIcon [
            _icon,
            [0.00, 0.50, 0.00, 1.00],
            getPosASLVisual _mobileRespawn,
            24,
            24,
            0,
            format ["MHQ: %1", _forEachIndex + 1],
            1,
            0.03,
            "TahomaB",
            "left"
        ];
    } forEach (missionNamespace getVariable ["AW_mobileRespawns", []]);
}];
