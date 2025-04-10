// Main -> Group
MENU(Group) = [
    ["Group", true],
    ["I Join Him",      [0], "", -5, [["expression", "[player] join (group cursorTarget)"]], "", ""],
    ["Leave my Group",  [0], "", -5, [["expression", "[player] join grpNull"]], "", ""],
    ["Take Lead",       [0], "", -5, [["expression", "(group player) selectLeader player"]], "", ""],
    ["You Join Me",     [0], "", -5, [["expression", "[cursorTarget] join (group player)"]], "", ""]
];
