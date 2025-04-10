InA_Rewards_RewardList = [
    // [<type>, <id>, <desc>, <weight>]

    // Jets
    [100, 101, "A-164 Wipeout (CAS)", 1],
    [100, 102, "To-201 Shikra", 1],
    [100, 103, "To-201 Shikra (Stealth)", 1],
    [100, 105, "F/A-181 Black/ Wasp II (CAS)", 1],
    [100, 106, "F/A-181 Black Wasp II (Stealth)", 1],
    [100, 107, "A-149 Gryphon (CAS)", 2],
    [100, 108, "A-149 Gryphon (CAP)", 2],
    [100, 109, "A-143 Buzzard (CAS)", 2],
    [100, 110, "A-143 Buzzard (CAP)", 2],
    [100, 111, "F/A-181 Black/ Wasp II (CAP)", 1],

    // Attack Helis
    [200, 201, "MI-48 Kajman", 2],
    [200, 202, "AH-99 Blackfoot", 2],
    [200, 203, "PO-30 Orca", 2],
    [200, 204, "AH-9 Pawnee", 2],
    [200, 205, "WY-55 Hellcat", 2],

    // VTOLs
    [300, 301, "V-44 X Blackfish (Armed)", 1],
    [300, 302, "Y-32 Xi'an (Infantry Transport, unarmed)", 2],
    [300, 303, "Y-32 Xi'an (Infantry Transport, Armed)", 1],
    [300, 304, "Y-32 Xi'an (Vehicle Transport, unarmed)", 2],
    [300, 305, "Y-32 Xi'an (Vehicle Transport, Armed)", 1],

    // Transport Helis
    [400, 401, "MI-290 Taru (Bench)", 4],
    [400, 402, "MI-290 Taru (Heavy Lifter)", 4],
    [400, 403, "CH-49 Mohawk", 4],
    [400, 404, "WY-55 Hellcat (Unarmed)", 4],

    // UAVs/UGVs
    [500, 501, "UCAV Sentinel", 3],
    [500, 502, "Praetorian 1C (AMV-7 Marshall mounted)", 2],
    [500, 503, "Mk49 Spartan (AFV-4 Gorgon mounted)", 2],
    [500, 504, "Mk21 Centurion (FV-720 Mora mounted)", 2],

    // MBTs
    [600, 610, "M2A4 Slammer", 2],
    [600, 611, "M2A4 Slammer (Urban Purpose)", 2],
    [600, 602, "Enhanced M2A4 Slammer (Urban Purpose)", 2],
    [600, 607, "T-100 Varsuk", 2],
    [600, 603, "Enhanced T-100 Varsuk", 2],
    [600, 609, "MBT-52 Kuma", 2],
    [600, 604, "Enhanced MBT-52 Kuma", 2],
    [600, 608, "T-140 Angara", 2],
    [600, 605, "Enhanced T-140 Angara", 2],
    [600, 601, "T-140K Angara", 2],
    [600, 606, "Enhanced T-140K Angara", 2],

    // IFVs
    [700, 703, "AWC 301 Nyx (AT)", 3],
    [700, 714, "AWC 302 Nyx (AA)", 3],
    [700, 701, "AWC 303 Nyx (Recon)", 2],
    [700, 704, "AWC 304 Nyx (Autocannon)", 3],
    [700, 706, "FV-720 Mora", 3],
    [700, 707, "Enhanced FV-720 Mora", 3],
    [700, 708, "BTR-K Kamysh", 3],
    [700, 709, "Enhanced BTR-K Kamysh", 3],
    [700, 710, "AFV-4 Gorgon", 3],
    [700, 711, "Enhanced AFV-4 Gorgon", 3],
    [700, 712, "AMV-7 Marshall", 3],
    [700, 713, "Enhanced AMV-7 Marshall", 3],

    // SPAAGs
    [800, 801, "IFV-6a Cheetah", 3],
    [800, 802, "ZSU-39 Tigris", 3],

    // APCs
    [900, 901, "CRV-6e Bobcat", 3],
    [900, 902, "MSE-3 Marid", 3],
    [900, 903, "CRV-6e Bobcat (Minigun)", 3],
    [900, 904, "Rhino MGS", 3],
    [900, 905, "Rhino MGS (Urban Purpose)", 3],

    // MRAPs
    [1000, 1006, "Strider HMG", 6],
    [1000, 1004, "Strider GMG", 6],
    [1000, 1001, "Strider (Lynx)", 1],
    [1000, 1003, "Strider (Minigun)", 2],
    [1000, 1002, "Hunter (Minigun)", 2],
    [1000, 1005, "Hunter (Titan AT)", 4],

    // Cars
    [1100, 1101, "Van (Services)", 2],
    [1100, 1102, "Offroad (Repair)", 2],
    [1100, 1114, "Offroad (Repair, Mortar)", 2],
    [1100, 1103, "Offroad (AT)", 2],
    [1100, 1104, "Offroad (Titan AT)", 2],
    [1100, 1105, "Offroad (Titan AA)", 2],
    [1100, 1106, "Offroad (HMG)", 2],
    [1100, 1107, "Offroad (Minigun)", 2],
    [1100, 1108, "Offroad (GMG)", 2],
    [1100, 1109, "MB 4WD (AT)", 2],
    [1100, 1110, "MB 4WD (LMG)", 2],
    [1100, 1111, "Qilin (Minigun)", 2],
    [1100, 1113, "Qilin (AT)", 2],
    [1100, 1112, "Prowler (AT)", 2],

    // I don't even know
    [1200, 1201, "Battle Bus", 1],
    [1200, 1202, "Battle Tractor", 2]
];


// Reward blacklist
InA_Rewards_RewardBlacklist = [
    302,    //Y-32 Xi'an (Infantry Transport, unarmed)
    304,    //Y-32 Xi'an (Vehicle Transport, unarmed)
    401,    // MI-290 Taru (Bench)
    402,    // MI-290 Taru (Heavy Lifter)
    403,    // CH-49 Mohawk
    404,    // WY-55 Hellcat (Unarmed)
    501,    // UCAV Sentinel
    903,    // CRV-6e Bobcat (Minigun)
    1114,   // Offroad (Repair, Mortar)
    1006,   // Strider HMG
    1004,   // Strider GMG
    1001,   // Strider (Lynx)
    1003,   // Strider (Minigun)
    1002,   // Hunter (Minigun)
    1005,   // Hunter (Titan AT)
    1114,   // Offroad (Repair, Mortar)
    1104,   // Offroad (Titan AT)
    1105,   // Offroad (Titan AA)
    1107,   // Offroad (Minigun)
    1108,   // Offroad (GMG)
    1109,   // MB 4WD (AT)
    1110,   // MB 4WD (LMG)
    1111,   // Qilin (Minigun)
    1113,   // Qilin (AT)
    1112,   // Prowler (AT)
    1201,   // Battle Bus
    1202    // Battle Tractor
];


// Previous rewards blacklist
InA_Rewards_PrevRewardCount = (ceil (((count InA_Rewards_RewardList) - (count InA_Rewards_RewardBlacklist)) / 5));
InA_Rewards_PreviousRewards = [];
