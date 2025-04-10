InA_UnitDefines_Loaded = false;

if (isNil "InA_PlayerFaction") then {
    waitUntil {sleep 0.1; !isNil "InA_PlayerFaction"};
};

private _unitHandle = execVM (format ["Scripts\defines\UnitDefines_%1.sqf", InA_PlayerFaction]);
private _rewardHandle = execVM (format ["Scripts\defines\RewardDefines_%1.sqf", InA_PlayerFaction]);

InA_fnc_FactionRewardSpawn = compileFinal preprocessFileLineNumbers (format ["Scripts\reward\RewardSpawn_%1.sqf", InA_PlayerFaction]);

waitUntil {
    sleep 0.1;
    ((scriptDone _unitHandle) && (scriptDone _rewardHandle))
};

InA_UnitDefines_Loaded = true;
