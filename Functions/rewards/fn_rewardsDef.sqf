/*
 * Author: Whigital
 *
 * Reward Defenitions. Data used for populating Rewards dialogs and
 * as input for AW_fnc_rewardSpawn. Actual classes and customization
 * defined in AW_fnc_rewardSpawn.
 *
 */

params [
    ["_returnType", "COMPLETE"],
    ["_Id", nil]
];

private _rewardTypes = [
    [100, "Jets"],
    [200, "Attack Helis"],
    [300, "VTOLs"],
    [400, "Transport Helis"],
    [500, "UAVs"],
    [600, "Tanks"],
    [700, "IFVs"],
    [800, "SPAAGs"],
    [900, "APCs"],
    [1000, "MRAPs"],
    [1100, "Cars"],
    [1200, "Misc"]
];

private _return = [];

switch (_returnType) do {
    case "WEIGHTED": {
        private _typeArray = [];
        private _weightArray = [];

        {
            _x params ["_type", "_id", "_desc", "_weight"];

            _typeArray pushBack [_id, _desc];
            _weightArray pushBack _weight;
        } forEach InA_Rewards_RewardList;

        _return = [_typeArray, _weightArray];
    };

    case "GETTYPES": {
        _return = _rewardTypes;
    };

    case "RANDOM": {
        private _rewardBlacklist = (InA_Rewards_RewardBlacklist + InA_Rewards_PreviousRewards);
        private _rewardList = (InA_Rewards_RewardList select {!((_x # 1) in _rewardBlacklist)});

        private _rndItem = (_rewardList selectRandomWeighted (_rewardList apply {_x # 3}));
        private _rewardId = (_rndItem # 1);
        private _rewardDesc = (_rndItem # 2);

        _return = [_rewardId, _rewardDesc];
    };

    case "GETITEM": {
        if ((typeName _Id) == "SCALAR") then {
            private _item = (InA_Rewards_RewardList select {(_x # 1) == _Id});

            if ((count _item) > 0) then {
                _return = (_item # 0);
            };
        };
    };

    case "GETBYTYPE": {
        if ((typeName _Id) == "SCALAR") then {
            _return = (InA_Rewards_RewardList select {(_x # 0) == _Id});
        };
    };

    case "COMPLETE": {
        _return = InA_Rewards_RewardList;
    };
};

_return
