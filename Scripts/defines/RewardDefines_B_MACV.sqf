InA_Rewards_RewardList = [
     // [<type>, <id>, <desc>, <weight>]

    // Jets
    [100, 101, "F-4C Phantom (CAS)", 1],
    [100, 102, "F-100D (CAS)", 1],
    [100, 105, "F-4C Phantom (CAP)", 1],
    [100, 106, "F-100D (CAP)", 1],

    // Attack Helis
    [200, 201, "AH-1G Cobra (APERS)", 1],
    [200, 202, "UH-34 Stinger", 1],
    [200, 203, "UH-1C Gunship", 2],
    [200, 204, "AH-1G Cobra (M195/AT)", 2],
    [200, 205, "OH-6A Gunship", 3],
    [200, 206, "UH-1P hornet", 1],
    [200, 207, "UH-1E heavy gunship", 1],
    [200, 208, "UH-1E gunship", 1],
    [200, 209, "UH-1D bushranger", 1],

    // Transport Helis

    // MBTs
    [600, 601, "M41A3 Walker Bulldog", 1],

    // IFVs
    [700, 703, "M54 Gun Truck (Minigun)", 3],
    [700, 704, "M113A1 M134", 2],
    [700, 705, "M113A1 M1919", 2],
    [700, 706, "M113A1 M2/M40", 2],
    [700, 707, "M113A1 Mk18", 2],

    // SPAAGs
    [800, 801, "M55 AA Truck (Quad)", 5],

    //MRAPs
    [900, 901, "M151A1 TOW", 5],
    [900, 902, "M151A1 M40A1", 5],

    // I don't even know
    [1200, 1202, "Battle Tractor", 2]
];


// Reward blacklist
InA_Rewards_RewardBlacklist = [];


// Previous rewards blacklist
InA_Rewards_PrevRewardCount = (ceil (((count InA_Rewards_RewardList) - (count InA_Rewards_RewardBlacklist)) / 5));
InA_Rewards_PreviousRewards = [];
