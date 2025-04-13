/*
	File: fn_setupPlayer.sqf
	Author: Dom
	Description: Finishes setting up the player in their new role/group
*/
params [
	["_desiredRole","rifleman",[""]],
	["_isRespawn",false,[true]]
];

private _roleConfig = missionConfigFile >> "Dynamic_Roles" >> _desiredRole;
private _defaultLoadout = getArray(_roleConfig >> "defaultLoadout");

if (_isRespawn) then {
	player setUnitLoadout (missionNamespace getVariable ["AW_savedLoadout",_defaultLoadout]);
} else {
	AW_savedLoadout = _defaultLoadout;
	player setUnitLoadout _defaultLoadout;


	private _roleRank = getText(_roleConfig >> "rank");
	player setRank _roleRank;

	private _roleTraits = getArray(_roleConfig >> "traits");
	{
		_x params ["_trait","_value"];
		if (_value isEqualType true && {_value}) then {
			player setUnitTrait [_trait,false];
		};
	} forEach (getAllUnitTraits player);

	{
		_x params ["_trait","_value",["_custom","false"]];
		if (_value in ["true","false"]) then {_value = call compile _value};
		player setUnitTrait [_trait,_value,call compile _custom];
	} forEach _roleTraits;

	private _customVariables = getArray(_roleConfig >> "customVariables");
	{
		player setVariable [_x,nil,true];
	} forEach (missionNamespace getVariable ["AW_myCustomVariables",[]]);

	AW_myCustomVariables = [];
	{
		_x params ["_variable","_value","_global"];
		if (_value in ["true","false"]) then {_value = call compile _value};
		player setVariable [_variable,_value,call compile _global];
		AW_myCustomVariables pushBack _variable;
	} forEach _customVariables;

	player setVariable ["AW_role",_desiredRole,true];

	// Always re-run the arsenal restriction script after setting the role
	[] spawn {
		waitUntil {sleep 0.1; !isNil "InA_PrecompiledArsenalWhitelists"};
		[] execVM "Scripts\arsenal\ArsenalRoleRestrictions.sqf";
		};
	

	// FSG Gunner Artillery Computer
	if (player getVariable ["InA_isFSGGunner", false]) then {
        enableEngineArtillery true;
    } else {
        enableEngineArtillery false;
    };

	// isPilot ?
	if ((player getVariable ["InA_isPilot", false]) && {!(missionNamespace getVariable ["InA_PilotInfo_Confirmed", false])}) then {

		[] spawn {
			sleep 2;

			private _msgParts = [];
			_msgParts pushBack "<t font='PuristaMedium' size='0.8'>";
			_msgParts pushBack "The main duties for pilots are CAS and CAP, when <t font='PuristaBold'>needed</t> and available.<br/><br/>";
			_msgParts pushBack "Any <t color='#ff0000'>Uncalled CAS</t>, <t color='#ff8000'>lack of skill</t>, <t color='#ff8000'>wasting assets</t>, <t color='#f0e80e'>joyriding</t>, <t color='#f0e80e'>not playing your role</t> etc. will get you grounded.<br/><br/>";
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

	if (player getVariable ["InA_isPilot", false]) then {
		// Grounded check
		[player] remoteExecCall ["AW_fnc_pilot_grounding_Check", 2];

		private _spawnpos = getPosATL PilotSpawnPos;
		private _respawnReference = [player, _spawnpos, "Pilot spawn"] call BIS_fnc_addRespawnPosition;

    }else{
		[player ,_respawnReference] call BIS_fnc_removeRespawnPosition;
	};

	// UAV Operator
	if (player getUnitTrait "UAVHacker") then {
    0 = [] spawn {
        waitUntil {!isNull (findDisplay 160)};

        0 = [player, nil, "UAV"] spawn AW_fnc_assetDisclaimer;

        {
            if (!isNull _x) then {
                player disableUAVConnectability [_x, true];
            };
        } forEach InA_BaseAAVehicles;
		};
	};

	// Cut grass action
	player call AW_fnc_cutGrassAction;


};