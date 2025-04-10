params ["_vehicle"];

private _cond = {
    ((driver _target) == _this) && ((_target distance2D liftZonePad) < 8) 
};

_vehicle addAction [
    "<t color='#00d400' size='1.2' font='PuristaBold'><img size='1.1' image='\a3\missions_f_oldman\data\img\holdactions\holdAction_box_ca.paa' /> Vehicle Inventory</t>",
    {
        params ["_target", "_caller", "_actionId", "_arguments"];

        0 spawn {
            disableSerialization;
            _map = findDisplay 46 createDisplay "RscCredits" ctrlCreate ["RscMapControl", -1];
            _map  ctrlSetPosition [0,0,1,1];
            _map  ctrlCommit 0;

            _map  ctrlAddEventHandler ["MouseButtonDblClick", {
                _ctrl = _this select 0;
                _x = _this select 2;
                _y = _this select 3;

                _pos = _ctrl ctrlMapScreenToWorld [_x, _y];
                hint format ["pos: %1", _pos];
                (vehicle player) setPosAtl [_pos select 0, _pos select 1, 200];
            
                _chute = createVehicle ["B_Parachute_02_F", ( position vehicle player), [], 0, "CAN_COLLIDE"];
                _chute disableCollisionWith vehicle player;
                vehicle player attachTo [_chute, [0, 0, -0.45]];
 
            }];

        };
        
    },
    [],
    99,
    true,
    true,
    "",
    (toString _cond),
    8
];