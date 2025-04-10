/*
author: stanhope
description: small anti-script-kids-script
*/
/*Kick action, for things not too serious or that don't benifit the script kid*/
kickPlayerWithReason = { 
	if (player getVariable ["InA_isZeus", false]) exitWith {};
	
	params ["_reason"];
	private _name = name player;
	private _uid = getPlayerUID player;
	[player, "Automated server message: All my user input has been disabled for hacking."] remoteExecCall ["sideChat", 0];
	private _adminMessage = format["Player %1 (%3) has been kicked for %2 by the anti-script-kiddie script", _name, _reason, _uid];
	[_adminMessage, "anti-script-kidies-script", true] call AW_fnc_log;
	titleText ["<t align='center'><t size='1.8' font='PuristaBold'>Your use of scripts has been detected.<br /> You will be kicked shortly.</t><br /> <t size='1.2' font='PuristaBold'>Your unique ID has been logged along with with your name.</t><br/><br /><t size='1.0' font='PuristaBold'>This message will not go away.</t><br/><br/><t size='0.8' font='PuristaBold'>Your user account will likely be banned for the use of these scripts. Appeal any bans on our forums (forums.ahoyworld.net)</t></t>", "BLACK", 2, true, true];
	
	player enableSimulation false;
	
	[player] spawn {
        waitUntil {!isNull (findDisplay 49)};
        params ["_unit"];
        [_unit] remoteExec ["AW_fnc_handleServerKick", 2];
	};

	[player] spawn {
		params ["_unit"];
	    sleep 30;
	    [_unit] remoteExec ["AW_fnc_handleServerKick", 2];
	};
};

playerDamageDisabledCount = 0;
playerExcessiveSpeedCount = 0;
playerHiddenCount = 0;

/*scrollwheel options to look out for*/	
forbiddenScrollWheelOptions = ["no recoil","no reciol","unlimitied ammo","unlimited ammo","script executor","slient aim","heal self",
	"speed hack","speedhack","god mode","god-mod","godmode","nuke","kill all","kill 2","spam database","delete all database",
	"fuck","deaths dance scroll menu", "kick all", "troll", "-back-", "dick", "hack", "cock", "script menu"];
	
/*The action to be executed in the loop*/
naughtyCheck = {	
	if ((unitRecoilCoefficient player) <= 0.9) exitWith {
		["recoil reduced"] spawn kickPlayerWithReason;
	};
	sleep 0.1;
	
	if ((unitRecoilCoefficient player) > 2) exitWith {
		["recoil increased"] spawn kickPlayerWithReason;
	};
	sleep 0.1;
	
	if ((getAnimSpeedCoef player) <= 0.9) exitWith {
		["anim speed slowed"] spawn kickPlayerWithReason;
	};
	sleep 0.1;
	
	if ((getAnimSpeedCoef player) > 2) exitWith {
		["anim speed increased (speedhack)"] spawn kickPlayerWithReason;
	};
	sleep 0.1;
	
	if (!(isDamageAllowed player) && (lifeState player != "INCAPACITATED")) then {
		playerDamageDisabledCount = playerDamageDisabledCount + 1;
		[] spawn { sleep 600; playerDamageDisabledCount = playerDamageDisabledCount - 1;};
		if (playerDamageDisabledCount > 4) exitWith {
			["damage disabled (godmode)"] spawn kickPlayerWithReason;
		};
	};
	sleep 0.1;
	
	if (isObjectHidden player) then {
		playerHiddenCount = playerHiddenCount + 1;
		[] spawn {sleep 600; playerHiddenCount = playerHiddenCount - 1;};
		if (playerHiddenCount > 1) exitWith {
			["player is hidden"] spawn kickPlayerWithReason;
		};
	};
	
	(uiNamespace getVariable "BIS_AAN") closeDisplay 1;
	sleep 0.1;
	
	onEachFrame {};
	onMapSingleClick {};
	sleep 0.1;
	
	if (vehicle player == player) then {
		_vel = velocity player;
        if ((_vel select 0) > 370 || (_vel select 1) > 370) then {
            playerExcessiveSpeedCount = playerExcessiveSpeedCount + 1;
            [] spawn { sleep 600; playerExcessiveSpeedCount = playerExcessiveSpeedCount - 1;};
        };

		if (playerExcessiveSpeedCount > 6) exitWith {
			["excessive speed"] spawn kickPlayerWithReason;
		};
	};
	sleep 0.1;
	
	/*Check the players scrollwheel options*/
	private _actionTitle = "";
	for "_i" from 0 to (count (actionIDs player) - 1) do {
		{
			_actionTitle = (player actionParams _i) select 0;
			if (! isNil "_actionTitle") then{
				_actionTitle = toLower _actionTitle;
				
				if (_actionTitle find _x > -1) exitWith {
					private _text = format ["Scrollwheel option %1 detected", _x];
					[_text] spawn kickPlayerWithReason;
				};
			};
			sleep 0.1;
		} forEach forbiddenScrollWheelOptions;
		sleep 0.1;
	};
};