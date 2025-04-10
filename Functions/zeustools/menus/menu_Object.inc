// Main -> Object
MENU(Object) = [
    ["Object", true],
    ["Disable damage",  [0], "", -5, [["expression", "[cursorTarget, false] remoteExec ['allowDamage', cursorTarget]; cutText ['Damage disabled', 'PLAIN'];"]], "1", "1"],
    ["Enable damage",   [0], "", -5, [["expression", "[cursorTarget, true] remoteExec ['allowDamage', cursorTarget]; cutText ['Damage enabled', 'PLAIN'];"]], "1", "1"],
    ["Kill that",       [0], "", -5, [["expression", "cursorTarget setDamage 1; cutText ['Target killed', 'PLAIN'];"]], "1", "1"],
    ["Delete that",     [0], "", -5, [["expression", "deleteVehicle cursorTarget"]], "1", "1"],
    ["Unflip that",     [0], "", -5, [["expression", "cursorTarget setVectorUp [0,0,1]; _pos = (getPos cursorTarget); _pos set [2, 0.5]; cursorTarget setPos _pos; cutText ['Object set straight', 'PLAIN'];"]], "1", "1"]
];
