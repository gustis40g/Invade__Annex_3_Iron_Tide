InA_Rewards_RewardList = [
    // [<type>, <id>, <desc>, <weight>]

    // Jets
    [100, 101, "A-10A Thunderbolt II (CAS)", 1],
    [100, 102, "Su-57 Felon (CAS)", 1],
    [100, 103, "Su-57 Felon (Stealth)", 1],
    [100, 104, "F-22A Raptor (CAS)", 1],
    [100, 106, "F-22A Raptor (CAP)", 1],
    [100, 107, "F-16C Fighting Falcon (CAP)", 2],
    [100, 108, "F-16C Fighting Falcon (CAS)", 2],
    [100, 109, "Mirage V (CAS)", 2],
    [100, 110, "Mirage V (CAP)", 2],
    [100, 111, "Su-25SM Frogfoot", 2],

    // Attack Helis
    [200, 201, "AH-64D Apache", 2],
    [200, 202, "AH-1Z Viper", 2],
    [200, 203, "Ka-52 Hokum-B", 2],
    [200, 204, "Mi-28N Havoc", 2],
    [200, 205, "Mi-24G Super Hind", 2],
    [200, 206, "AH-6M Little Bird", 2],
    [200, 207, "UH-60M Black Hawk (ESSS)", 2],
    [200, 208, "AW159 Wildcat AH1 (CAS - Hellfire)", 2],


    // VTOLs (There are none D:)


    // Transport Helis


    // UAVs/UGVs
    [500, 501, "UCAV Sentinel", 3],

    // MBTs
    [600, 610, "M1A2SEPv2", 2],
    [600, 611, "M1A2SEPv1 (TUSK II)", 2],
    [600, 602, "Enhanced M1A2SEPv2", 2],
    [600, 607, "T-90M", 2],
    [600, 603, "Enhanced T-90M", 2],
    [600, 609, "T-80UM", 2],
    [600, 608, "M60S Pantera", 2],

    // IFVs
    [700, 703, "FV-107 Scimitar", 3],
    [700, 701, "FV-101 Scorpion", 2],
    [700, 704, "M2A3", 3],
    [700, 706, "M2A3 (BUSK III)", 3],
    [700, 707, "Enhanced M2A3 (BUSK III)", 3],
    [700, 708, "BMD-4M(A)", 3],
    [700, 709, "Enhanced BMD-4M(A)", 3],
    [700, 710, "ASCOD Pizarro SLE", 3],
    [700, 714, "BMD-2M", 3],
    [700, 711, "Enhanced BMD-2M", 3],
    [700, 712, "FV-510 Warrior", 3],

    // SPAAGs
    [800, 801, "M6A2", 3],
    [800, 802, "2S6M Tunguska", 3],
    [800, 803, "M-163A3 Machbet", 3],

    // APCs
    [900, 901, "VEC-MGS", 3],
    [900, 902, "VEC-M1", 3],
    [900, 903, "M88 Hercules", 3],
    [900, 904, "BMR-600 TOW ATGM", 3],
    [900, 905, "BMR-600 ATGM", 3],
    [900, 906, "BMR-600 20MM", 3],
    [900, 907, "Stryker TOW", 3],


    // MRAPs
    [1000, 1001, "M1117 ASV", 4],
    [1000, 1002, "Humvee TOW", 4]


    // Cars


    // I don't even know

];


// Reward blacklist
InA_Rewards_RewardBlacklist = [
    501, //UCAV Sentinel
    111, //Su-25SM
    109, //Mirage CAP they are both broken when they spawn on carrier and get stuck, and overall pretty buggy
    110 //Mirage CAS
];


// Previous rewards blacklist
InA_Rewards_PrevRewardCount = (ceil (((count InA_Rewards_RewardList) - (count InA_Rewards_RewardBlacklist)) / 5));
InA_Rewards_PreviousRewards = [];
