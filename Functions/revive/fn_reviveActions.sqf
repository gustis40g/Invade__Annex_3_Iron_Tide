/*
* Author: alganthe
* Add the proper actions on unit init, those use cursorObject and are added to the player, no need to add them back after death
*
* Arguments:
* 0: Unit the actions are added to <OBJECT>
*
* Return Value:
* Nothing
*/

params ["_unit"];

if (isNil "derp_revive_medicsOnlyRevive") then {
    derp_revive_medicsOnlyRevive = ([true, false] # (getMissionConfigValue ["derp_revive_everyoneCanRevive", 0]));
};

if (isNil "derp_revive_reviveItems") then {
    derp_revive_reviveItems = ["FirstAidKit", "vn_b_item_firstaidkit", "vn_o_item_firstaidkit"];

    if (getMissionConfigValue ["derp_revive_reviveItem", 0] == 1) then {
        derp_revive_reviveItems = ["Medikit", "vn_b_item_medikit_01"];
    };
};

private _formatAction = {
    params ["_text", "_color", "_icon"];

    (format ["<t font='PuristaBold' size='1.6' color='%2' shadow='2'><img image='%3'/> %1</t>", _text, _color, _icon]);
};

// Revive
_unit addAction [
    (["Revive", "#0025cc", "a3\ui_f\data\igui\cfg\revive\overlayiconsgroup\r100_ca.paa"] call _formatAction),
    {
        params ["", "_caller", "", "_args"];
        _caller playAction "medicStart";
        _caller setVariable ["derp_revive_reviving", true, true];

        [{
            params ["_args", "_pfhID"];
            _args params ["_startingTime", "_unit", "_target"];

            if !(
                (_unit distance _target < 5) && {
                    ((alive _unit) && {alive _target}) && {
                        _unit getVariable ["derp_revive_reviving", false]
                } && {
                    _target getVariable ["derp_revive_downed", false]
                } && {
                    isNull (objectParent _target)
                } && {
                    !(_target getVariable ["derp_revive_isDragged", false])
                } && {
                    !(_target getVariable ["derp_revive_isCarried", false])
                } && {
                    !(_unit getVariable ["derp_revive_isDragging", false])
                } && {
                    !(_unit getVariable ["derp_revive_isCarrying", false])
                }}
            ) then {
                _unit playAction "medicStop";
                _unit setVariable ["derp_revive_reviving", false, true];
                _pfhID call derp_fnc_removePerFrameHandler;
            };

            if (_startingTime + 6 <= time) then {
                if ((getMissionConfigValue ["derp_revive_removeFAKOnUse", 1] == 1) && {getMissionConfigValue ["derp_revive_reviveItem", 0] == 0}) then {
                    if ((derp_revive_reviveItems arrayIntersect (items _target)) isEqualTo []) then {
                        {_unit removeItem _x} forEach derp_revive_reviveItems;
                    } else {
                        {_target removeItem _x} forEach derp_revive_reviveItems;
                    };

                    [_target, "REVIVED"] remoteExecCall ["derp_revive_fnc_switchState", _target];

                    _unit playAction "medicStop";
                    _unit setVariable ["derp_revive_reviving", false, true];
                    _pfhID call derp_fnc_removePerFrameHandler;
                };
            };
        }, 1, [time, _caller, cursorObject]] call derp_fnc_addPerFrameHandler;
    },
    [],
    11,
    true,
    true,
    "",
    (toString {
        (
            ((_this distance cursorObject) < 5) &&
            {(if (derp_revive_medicsOnlyRevive) then {_this getUnitTrait "Medic"} else {true})}
        ) && {
            (
                isNull (objectParent _this) && {
                    !(_this getVariable ["derp_revive_reviving", false]) &&
                    !(_this getVariable ["derp_revive_isDragging", false]) &&
                    !(_this getVariable ["derp_revive_isCarrying", false])
                }
            ) && {
                (
                    isNull (objectParent cursorObject) && {
                        (cursorObject getVariable ["derp_revive_downed", false]) || (lifeState cursorObject) isEqualTo "INCAPACITATED" &&
                        !(cursorObject getVariable ["derp_revive_isDragged", false]) &&
                        !(cursorObject getVariable ["derp_revive_isCarried", false]) &&
                        ([side (group cursorObject), side (group _this)] call BIS_fnc_sideIsFriendly)
                    }
                ) && {
                    ((derp_revive_reviveItems arrayIntersect ((items _this) + (items cursorObject))) isNotEqualTo [])
                }
            }
        }
    })
];

// Stop revive
_unit addAction [
    (["Cancel revive", "#00b300", "a3\ui_f\data\igui\cfg\revive\overlayiconsgroup\d100_ca.paa"] call _formatAction),
    {
        params ["", "_caller", "", "_args"];
        _caller setVariable ["derp_revive_reviving", false, true];
        _caller playAction "medicStop";
    },
    [],
    10,
    true,
    true,
    "",
    "(_this getVariable ['derp_revive_reviving', false])"
];

// Dragging
_unit addAction [
    (["Drag wounded", "#00b300", "a3\ui_f\data\igui\cfg\simpletasks\types\help_ca.paa"] call _formatAction),
    {
        params ["", "_caller", "", "_args"];
        _caller setVariable ["derp_revive_isDragging", true, true];
        cursorObject setVariable ["derp_revive_isDragged", true, true];
        [_caller, cursorObject] call derp_revive_fnc_dragging;
    },
    [],
    10,
    true,
    true,
    "",
    (toString {
        ((_this distance cursorObject) < 5) && {
            isNull (objectParent _this) && {
                (
                    !(_this getVariable ["derp_revive_reviving", false]) &&
                    !(_this getVariable ["derp_revive_isCarrying", false]) &&
                    !(_this getVariable ["derp_revive_isDragging", false])
                ) && {
                    (
                        isNull (objectParent cursorObject) && {
                            (cursorObject getVariable ["derp_revive_downed", false]) || (lifeState cursorObject) isEqualTo "INCAPACITATED" &&
                            !(cursorObject getVariable ["derp_revive_isDragged", false]) &&
                            !(cursorObject getVariable ["derp_revive_isCarried", false]) &&
                            ([side (group cursorObject), side (group _this)] call BIS_fnc_sideIsFriendly)
                        }
                    )
                }
            }
        }
    })
];

// Carrying
_unit addAction [
    (["Carry wounded", "#c27200", "a3\ui_f\data\igui\cfg\simpletasks\types\takeoff_ca.paa"] call _formatAction),
    {
        params ["", "_caller", "", "_args"];
        _caller setVariable ["derp_revive_isCarrying", true, true];
        cursorObject setVariable ["derp_revive_isCarried", true, true];
        [_caller, cursorObject] call derp_revive_fnc_carrying;
    },
    [],
    9,
    true,
    true,
    "",
    (toString {
        ((_this distance cursorObject) < 5) && {
            isNull (objectParent _this) && {
                (
                    !(_this getVariable ["derp_revive_reviving", false]) &&
                    !(_this getVariable ["derp_revive_isCarrying", false]) &&
                    !(_this getVariable ["derp_revive_isDragging", false])
                ) && {
                    (
                        isNull (objectParent cursorObject) && {
                            (cursorObject getVariable ["derp_revive_downed", false]) || (lifeState cursorObject) isEqualTo "INCAPACITATED" &&
                            !(cursorObject getVariable ["derp_revive_isDragged", false]) &&
                            !(cursorObject getVariable ["derp_revive_isCarried", false]) &&
                            ([side (group cursorObject), side (group _this)] call BIS_fnc_sideIsFriendly)
                        }
                    )
                }
            }
        }
    })
];

// Stop dragging
_unit addAction [
    (["Release wounded", "#bd000d", "a3\ui_f\data\igui\cfg\actions\take_ca.paa"] call _formatAction),
    {
        params ["", "_caller", "", "_args"];

        private _wounded = ((attachedObjects _caller) select {_x isKindOf "CAManBase"});

        {
            detach _x;
        } foreach _wounded;

        if (_wounded isEqualTo []) then {
            _caller setVariable ["derp_revive_isDragging", false, true];
        } else {
            [_caller, (_wounded # 0), "DRAGGING"] call derp_revive_fnc_dropPerson;
        };
    },
    [],
    11,
    true,
    true,
    "",
    "(_this getVariable ['derp_revive_isDragging', false])"
];

// Stop carrying
_unit addAction [
    (["Drop wounded", "#bd000d", "a3\ui_f\data\igui\cfg\simpletasks\types\land_ca.paa"] call _formatAction),
    {
        params ["", "_caller", "", "_args"];

        private _wounded = ((attachedObjects _caller) select {_x isKindOf "CAManBase"});

        {
            detach _x;
        } foreach _wounded;

        if (_wounded isEqualTo []) then {
            _caller setVariable ["derp_revive_isCarrying", false, true];
        } else {
            [_caller, (_wounded # 0), "CARRYING"] call derp_revive_fnc_dropPerson;
        };
    },
    [],
    11,
    true,
    true,
    "",
    "(_this getVariable ['derp_revive_isCarrying', false])"
];

// Put in
_unit addAction [
    (["Load wounded", "#0025cc", "a3\ui_f\data\igui\cfg\actions\obsolete\ui_action_getincargo.paa"] call _formatAction),
    {
        params ["", "_caller", "", "_args"];

        private _wounded = ((attachedObjects _caller) select {_x isKindOf "CAManBase"});

        {
            detach _x;
        } foreach ((attachedObjects _caller) select {_x isKindOf "CAManBase"});

        if (_wounded isEqualTo []) then {
            _caller setVariable ["derp_revive_isDragging", false, true];
            _caller setVariable ["derp_revive_isCarrying", false, true];
        } else {
            [_caller, (_wounded # 0), "VEHICLE", cursorObject] call derp_revive_fnc_dropPerson;
        };
    },
    [],
    12,
    true,
    true,
    "",
    (toString {
        ((_this distance cursorObject) < 5) && {
            !(_this getVariable ["derp_revive_reviving", false]) && {
                (
                    (_this getVariable ["derp_revive_isCarrying", false]) ||
                    (_this getVariable ["derp_revive_isDragging", false])
                ) && {
                    (((attachedObjects _this) findIf {_x isKindOf "CAManBase"}) != -1) && {
                        ((cursorObject emptyPositions "cargo") > 0)
                    }
                }
            }
        }
    })
];

// Pull out
_unit addAction [
    (["Unload wounded", "#00b300", "a3\ui_f\data\igui\cfg\actions\unloadincapacitated_ca.paa"] call _formatAction),
    {
        params ["", "_caller", "", "_args"];

        private _wounded = (((crew cursorObject) select {(_x getVariable ['derp_revive_downed', false])}) # 0);
        _wounded moveOut cursorObject;
    },
    [],
    10,
    true,
    true,
    "",
    (toString {
        ((_this distance cursorObject) < 5) && {
            !(_this getVariable ["derp_revive_reviving", false]) && {
                (
                    !(_this getVariable ["derp_revive_isCarrying", false]) &&
                    !(_this getVariable ["derp_revive_isDragging", false])
                ) && {
                    !(cursorObject isKindof "CAManBase") && {
                        ({
                            (_x getVariable ["derp_revive_downed", false]) && {
                                (_x getVariable ["derp_revive_side", west]) == (side _this)
                            }
                        } count (crew cursorObject)) > 0
                    }
                }
            }
        }
    })
];
