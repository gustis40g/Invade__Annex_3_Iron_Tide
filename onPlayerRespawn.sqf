// Make sure player is initialized
waitUntil {alive player};

if (!hasInterface) exitWith {};

// Fallback in case something else fails
if (!isNil "kickOnRespawn") then {
  [player] remoteExecCall ["AW_fnc_handleServerKick", 2];
};

// Load last known loadout
if (!isNil {missionNamespace getVariable "InA_PlayerLoadout"}) then {
    private _loadout = (missionNamespace getVariable "InA_PlayerLoadout");
    player setUnitLoadout _loadout;
};

// Fatigue settings
if ((["Fatigue", 1] call BIS_fnc_getParamValue) == 1) then {
    player enableFatigue true;
} else {
    player enableFatigue false;
};

// Weapon sway
if ((getCustomAimCoef player) != InA_Client_AimingCoef) then {
    player setCustomAimCoef InA_Client_AimingCoef;
};

// Pilot actions
if ([player] call AW_fnc_isPilot) then {
    [player] call AW_fnc_pilotActions;
};

// Cut grass action
player call AW_fnc_cutGrassAction;

// Chemlight attach actions
// call AW_fnc_chemlightActionsInit;

// Sling weapon action
// 0 = ["Respawn"] spawn AW_fnc_slingWeapon;

// UAV Operator
if (player getUnitTrait "UAVHacker") then {
    {
        if (!isNull _x) then {
            player disableUAVConnectability [_x, true];
        };
    } forEach InA_BaseAAVehicles;
};

// Clear vehicle inventory action
player addAction [
    "<t color='#ff0000'>Clear vehicle inventory</t>",
    {
        [] call AW_fnc_clearVehicleInventory
    },
    [],
    -101,
    false,
    true,
    "",
    "
        (player == driver vehicle player) && {
            ((vehicle player) != player) && {(
                count itemCargo vehicle player != 0 ||
                count weaponCargo vehicle player != 0 ||
                count magazineCargo vehicle player != 0 ||
                count backpackCargo vehicle player != 0
            )}
        }
    "
];


// Assign Zeus
0 = [] spawn {
    [player] remoteExec ["AW_fnc_assignZeus", 2];

    waitUntil {sleep 0.2; !isNil {player getVariable ["InA_isZeus", nil]}};

    [player] call AW_fnc_welcomeTitle;

    /*Launch the naughtyCheck*/
    waitUntil {sleep 0.5; !isNil "naughtyCheck"};
    if !(player getVariable ["InA_isZeus", false]) then {
        0 = [] spawn {
            while {alive player} do {
                0 = [] spawn naughtyCheck;
                sleep 30;
            };
        };
    };
};

// Add player to Zeus:
[[player]] remoteExec ["AW_fnc_addToAllCurators", 2];


// Reset the amount of pings someone has
player setVariable ["zeusPingLimit", 0];

// VON | TFAR settings
if (!(isClass (configFile >> "CfgPatches" >> "task_force_radio"))) then {
    // Disable VON in certain channels
    0 enableChannel [false, false];     // Global
    1 enableChannel [true, false];      // Side
    2 enableChannel [true, false];      // Command
} else {
    //--------- Add TFAR event handlers
    if ( isNil "tfarEH" ) then {
        tfarEH = ["tfarUpdate", "OnRadiosReceived", {
            0 = [] spawn {
                sleep 1;
                if ( call TFAR_fnc_haveSWRadio ) then {	call RYK_fnc_TFAR_SR; };
                if ( call TFAR_fnc_haveLRRadio ) then {	call RYK_fnc_TFAR_LR; };
            };
        }, player] call TFAR_fnc_addEventHandler;
    };

    // Setup radios in case TFAR eventhandlers never work again :(
    if ( call TFAR_fnc_haveSWRadio ) then {	call RYK_fnc_TFAR_SR; };
    if ( call TFAR_fnc_haveLRRadio ) then {	call RYK_fnc_TFAR_LR; };

    // Chat
    0 enableChannel [false, false];
    1 enableChannel [true, false];
    2 enableChannel [true, false];
    3 enableChannel [true, false];
    4 enableChannel [true, false];
    5 enableChannel [true, false];
};


if (([player] call AW_fnc_isPilot) && {!(missionNamespace getVariable ["InA_PilotInfo_Confirmed", false])}) then {
    [] spawn {
        sleep 2;

        private _msgParts = [];
        _msgParts pushBack "<t font='PuristaMedium' size='0.8'>";
        _msgParts pushBack "The main duties for pilots are transport and logistics, but also include CAS and CAP, when <t font='PuristaBold'>needed</t> and available.<br/><br/>";
        _msgParts pushBack "Any <t color='#ff0000'>uncalled CAS</t>, <t color='#ff8000'>lack of skill</t>, <t color='#ff8000'>wasting assets</t>, <t color='#f0e80e'>joyriding</t>, <t color='#f0e80e'>not playing your role</t> etc. will get you grounded.<br/><br/>";
        _msgParts pushBack "<t font='PuristaSemibold'>Consider your skill before playing this role!</t><br/><br/>";
        _msgParts pushBack "<t size='0.6'>- Crashing 3 airframes within 30 minutes will get you grounded for 45 minutes.</t><br/>";
        _msgParts pushBack "<t size='0.6'>- Crashing 4 airframes within 60 minutes will get you grounded for 60 minutes.</t><br/><br/>";
        _msgParts pushBack "</t>";
        private _msg = _msgParts joinString "";

        player enableSimulation false;
        private _ans = [_msg, "Pilot info", "Understood", false] call BIS_fnc_guiMessage;
        player enableSimulation true;

        if (_ans) then {
            missionNamespace setVariable ["InA_PilotInfo_Confirmed", true];
        };
    };
};

// Earplugs reset
// if (!isNil "InA_EarplugsFitted" && {InA_EarplugsFitted}) then {
//     2 fadeSound 1;
//     InA_EarplugsFitted = false;
// };

// Moar TFAR
if (isClass (configFile >> "CfgPatches" >> "task_force_radio")) then {
    private _teamSpeakMessage = "This server requires that you are connected and communicating with other players through our Teamspeak server. Please fix whatever issues you are having and connect to our Teamspeak at ts.ahoyworld.net:9987 - once you are connected this message will disappear.";

    if ( !([] call TFAR_fnc_isTeamSpeakPluginEnabled) ) then {
        titleText [_teamSpeakMessage, "BLACK", 2];
        waitUntil { sleep 2; (([] call TFAR_fnc_isTeamSpeakPluginEnabled) || (player getVariable ["InA_isZeus", false]) || !isNil "adminTFARbypass")};
        titleFadeOut 2;
    };
};
