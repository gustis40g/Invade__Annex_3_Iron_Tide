/*
author: stanhope, AW community member.
description: code for jets/helis to engage players

Last modified: 5/06/2019 by stanhope
Modified: initial release

params:
0: _aircraft : vehicle that will be doing the engagement
1: _lowerCounter: lower the global InA_AOReinforceJetCount when/if the aircraft dies/gets deleted
2: _loiterPos: pos around which the aircraft will loiter if it isn't engaging
3: _loiterRadius: radius of the above mentioned loiter
4: _searchRadius: radius in which the aircraft will search for targets;
*/
params [
    "_aircraft",
    ["_lowerCounter", true],
    ["_loiterPos", (getMarkerPos InA_Server_currentAO)],
    ["_loiterRadius", (InA_Server_MainAOSize * 1.5)],
    ["_searchRadius", (InA_Server_MainAOSize * 2.5)]
];

if (isNil "_aircraft") exitWith {};

private _airGrp = group (driver _aircraft);
_aircraft setVariable ["_loiterPos", _loiterPos];
_aircraft setVariable ["_loiterRadius", _loiterRadius];

_aircraft engineOn true;
_aircraft lock 2;
_aircraft allowCrewInImmobile true;
_aircraft setVehicleRadar 1;
_aircraft setVehicleReceiveRemoteTargets true;
_aircraft setVehicleReportRemoteTargets true;
_aircraft setBehaviour "COMBAT";
_aircraft setCombatMode "RED";
_aircraft allowFleeing 0;

private _removeAllWaypointsCode = {
    params ["_aircraft"];
    private _airGrp = group (driver _aircraft);

    while {(count (waypoints _airGrp)) > 0} do{
        deleteWaypoint ((waypoints _airGrp) select 0);
    };
};
_aircraft setVariable ["_removeAllWaypointsCode", _removeAllWaypointsCode];

private _loiterwWaypointCode = {
    params ["_aircraft"];
    private _airGrp = group (driver _aircraft);

    _aircraft setVariable ["_loiterPos", getMarkerPos InA_Server_currentAO];

    private _loiterWp = _airGrp addWaypoint [(_aircraft getVariable "_loiterPos"),0];
    _loiterWp setWaypointType "LOITER";
    _loiterWp setWaypointLoiterRadius (_aircraft getVariable "_loiterRadius");

    if (_aircraft isKindOf "Plane") then {
        _aircraft flyInHeight (250 + random 250);
        _aircraft limitSpeed (300 + (random 200));
    } else {
        _aircraft flyInHeight (75 + (random 75));
        _aircraft limitSpeed (100 + (random 50));
    };
};

_aircraft setVariable ["_loiterwWaypointCode", _loiterwWaypointCode];

//EH to make the jet attack stuff that shoots at it
if (_aircraft isKindOf "Plane") then {
    _aircraft addEventHandler ["IncomingMissile", {
        _this spawn {
            params ["_jet", "", "_shootingVehicle"];

            if (!isDamageAllowed _shootingVehicle) exitWith {};
            if (_jet getVariable ["isEngagingShooter", false]) exitWith {};
            _jet setVariable ["isEngagingShooter", true];

            private _removeAllWaypointsCode = _jet getVariable "_removeAllWaypointsCode";
            [_jet] call _removeAllWaypointsCode;
            private _jetGrp = (group(driver _jet));

            private _attackWP = _jetGrp addWaypoint [getPos _shootingVehicle, -1];

            //if the jet knows about the thing shooting at it engage it.  Otherwise search for it.
            _attackWP setWaypointPosition [((getPos _shootingVehicle) getPos [(50 + random 100), random 360]) , -1];
            _attackWP waypointAttachObject _shootingVehicle;
            _attackWP setWaypointBehaviour "COMBAT";
            _attackWP setWaypointCombatMode "RED";

            if (_jet knowsAbout _shootingVehicle >= 2) then {
                _attackWP setWaypointType "DESTROY";
                _jetGrp reveal [_shootingVehicle,4];
            } else {
                _attackWP setWaypointType "SAD";
            };
            _jet limitSpeed 1000;

            private _timer = 0;
            waitUntil {sleep 5; _timer = _timer + 5; !(alive _jet) || !(alive _shootingVehicle) || _timer > (120 + random(120))};

            if (alive _jet) then {
                _jet setVariable ["isEngagingShooter", false];
                private _loiterwWaypointCode = _jet getVariable "_loiterwWaypointCode";
                [_jet] call _loiterwWaypointCode;
            };
        };
    }];
};

(driver _aircraft) addEventHandler ["GetOutMan", {
	_this spawn {
	    params ["_unit"];
	    while {alive _unit} do {
	        _unit setDamage (damage _unit + 0.05);
	        sleep 0.2;
	    };
	};
}];

(driver _aircraft) addEventHandler ["Killed", {
	private _aircraft = (vehicle (_this select 0));
	[_aircraft] spawn {
	    params ["_aircraft"];
	    while {alive _aircraft} do {
	         _aircraft setDamage (damage _aircraft + 0.05);
             sleep 0.2;
	    };
	};
}];

private _targetAO = InA_Server_currentAO;
private _flyHeight = [(150 + (random 100)), (500 + (random 500))] select (_aircraft isKindOf "Plane");
private _airGrp = (group (driver _aircraft));

// Send to the AO
private _aoWP = _airGrp addWaypoint [_loiterPos, 0];
_aoWP setWaypointType "LOITER";
_aoWP setWaypointLoiterRadius _loiterRadius;
_aircraft flyInHeight _flyHeight;

private _engageDistance = [1500, 3000] select (_aircraft isKindOf "Plane");

// Wait until close to the AO to start engaging
while {sleep 5; ((_aircraft distance2D (getMarkerPos _targetAO)) > _engageDistance)} do {
    if (_targetAO != InA_Server_currentAO) then {
        _targetAO = InA_Server_currentAO;

        [_aircraft] call _removeAllWaypointsCode;
        [_aircraft] call _loiterwWaypointCode;
    };
};

[_aircraft] call _removeAllWaypointsCode;
[_aircraft] call _loiterwWaypointCode;
private _laser = objNull;

//main attack loop
while {alive _aircraft} do {

    private _entitiesToTarget = [];
    switch (true) do {
        case ((_aircraft isKindOf "Helicopter") || ((typeOf _aircraft) find "VTOL" != -1)): {
            _entitiesToTarget = ["Helicopter", "Tank", "Ship", "Car", "StaticWeapon", "Man"];
        };
        case (_aircraft isKindOf "Plane"): {
            _entitiesToTarget = ["Plane", "Helicopter", "Tank", "Ship", "Car", "StaticWeapon"];
        };
        default {
            _entitiesToTarget = ["Plane", "Helicopter", "Tank", "Ship", "Car", "StaticWeapon", "Man"];
        };
    };

	//Find someone or something to attack
	private _accepted = false;
	private _target = objNull;
	private _i = 0;

	while {!_accepted} do {
	    if (!alive _aircraft) exitWith {};
		private _targetList = (_aircraft getVariable ["_loiterPos", (getMarkerPos InA_Server_currentAO)]) nearEntities [_entitiesToTarget, _searchRadius];
        private _acceptedTargets = [];

        {
            private _targ = _x;
            switch (true) do {
                case (!alive _targ);
                case (side _targ != west);
                case (((east knowsAbout _targ) < 2) && ((independent knowsAbout _targ) < 2));
                case (!(isPlayer (driver _targ)) && !(isPlayer (gunner _targ)) && !(isPlayer (commander _targ)));
                case ([_x] call AW_fnc_isNearBase): {
                    /*Don't add it to the list*/
                };
                default {
                    _acceptedTargets pushBackUnique _targ;
                };
            };
            sleep 0.1;
        } forEach _targetList;

		if ( (count _acceptedTargets) > 0) then {
            private _targIndex = -1;
            {
                private _targType = _x;
                _targIndex = _acceptedTargets findIf {_x isKindOf _targType};
                if (_targIndex != -1) exitWith {
                    _target = _acceptedTargets select _targIndex;
                    _accepted = true;
                };
                sleep 0.1;
            } forEach _entitiesToTarget;
		} else {
			sleep 5;

            if (_targetAO != InA_Server_currentAO) then {
                _targetAO = InA_Server_currentAO;
                [_aircraft] call _removeAllWaypointsCode;
                [_aircraft] call _loiterwWaypointCode;
            };

			_i = _i + 1;
			if (_i > 10) then {
			    _entitiesToTarget = ["Plane", "Helicopter", "Tank", "Ship", "Car", "StaticWeapon", "Man"];
			};
		};

        waitUntil {sleep 1; !(_aircraft getVariable ["isEngagingShooter", false])};
	};

	if (!alive _aircraft) exitWith {};

	[_aircraft] call _removeAllWaypointsCode;
	_airGrp reveal [_target,4];

	//Attack the target:
	if (! isNil "_laser") then {
        _laser call AW_fnc_delete;
    };
	_laser = "LaserTargetW" createVehicle (getPos _target);
	_laser attachTo [_target,[0,0,0]];
	_aircraft doTarget _target;

	private _attackWP = _airGrp addWaypoint [getPos _target, -1];
	_attackWP waypointAttachObject _target;
    _attackWP setWaypointType "DESTROY";
    _attackWP setWaypointBehaviour "COMBAT";
    _attackWP setWaypointCombatMode "RED";
    _attackWP setWaypointTimeout [120, 240, 300];

    if (_aircraft isKindOf "Plane") then {
        _aircraft limitSpeed 1000;
    } else {
        _aircraft limitSpeed 250;
    };

	//Let him continiue attacking for the duration of the timeout or until the target or the jet is dead
	private _timer = 0;
	waitUntil {_timer = _timer + 5; sleep 5; !(alive _aircraft) || !(alive _target) || _timer > (120 + random(120)) || _aircraft getVariable ["isEngagingShooter", false] || ([_target] call AW_fnc_isNearBase)};
	waitUntil {sleep 1; !(_aircraft getVariable ["isEngagingShooter", false])};

	//delete the current waipoints of the jet and the laser:
	_laser call AW_fnc_delete;
	if (!alive _aircraft) exitWith {};

	[_aircraft] call _removeAllWaypointsCode;

	//let him loiter for 2 minutes then attack the next thing
	[_aircraft] call _loiterwWaypointCode;
	
	sleep 120;
	waitUntil {sleep 1; !(_aircraft getVariable ["isEngagingShooter", false])};
};

if (! isNil "_laser") then {
    _laser call AW_fnc_delete;
};
