/*
Description:  Script that displays sidemission sucess message
Author: Unknown
*/

params [
    ["_rewardId", nil, [0]],
    ["_movePos", nil]
];

private _rewardItem = [];
private _rewardDesc = "";

// If no reward is selected chose a random one, else pick the selected one
if (isNil "_rewardId") then {
    _rewardItem = ["RANDOM"] call AW_fnc_rewardsDef;
    _rewardId = (_rewardItem # 0);

    InA_Rewards_PreviousRewards pushBack _rewardId;

    if ((count InA_Rewards_PreviousRewards) > InA_Rewards_PrevRewardCount) then {
        while {(count InA_Rewards_PreviousRewards) > InA_Rewards_PrevRewardCount} do {
            InA_Rewards_PreviousRewards deleteAt 0;
        };
    };

    _rewardDesc = (_rewardItem # 1);
} else {
    _rewardItem = ["GETITEM", _rewardId] call AW_fnc_rewardsDef;
    _rewardDesc = (_rewardItem # 2);
};

if (_rewardItem isEqualTo []) exitWith {
    private _msg = format ["Failed to find SM Reward with ID: %1", _rewardId];
    [_msg, "SMREWARD", true] call AW_fnc_log;
};

// Create the actual vehicle
private _reward = objNull;
if (isNil "_movePos") then {
    private _posData = [] call AW_fnc_getRewardAreaPosition;
    _reward = [_rewardId, (_posData # 0)] call AW_fnc_rewardSpawn;
    _reward setDir (_posData # 1);
    _reward setPos (getPos _reward);
} else {
    _reward = [_rewardId, _movePos] call AW_fnc_rewardSpawn;
};


// Hint or no hint that's the question
private _locText = "You'll find it near the objective you just completed";

if (_reward isKindOf "Plane") then {
    _locText = "You'll find it at an plane spawn area";
};

if ((_reward isKindOf "Helicopter") || (isNil "_movePos")) then {
    _locText = "You'll find it at the nearest reward zone";
};

private _completeText = format ["<t align='center'><t size='2.2'>Side Mission</t><br/><t size='1.5' color='#08b000'>COMPLETE</t><br/>____________________<br/>Fantastic job, lads! The OPFOR stationed on the island won't last long if you keep that up!<br/><br/>Asset received: %1. %2.<br/><br/>Focus on the main objective for now; we'll relay this success to the intel team and see if there's anything else you can do for us. We'll get back to you in 10-15 minutes.</t>", _rewardDesc, _locText];

[_completeText] remoteExec ["AW_fnc_globalHint", 0];
private _rewardtext = format ["Your team received: %1", _rewardDesc];
["SideReward", _rewardtext] remoteExec ["AW_fnc_globalNotification", 0];
