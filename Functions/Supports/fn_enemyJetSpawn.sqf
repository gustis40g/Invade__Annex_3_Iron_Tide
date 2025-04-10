/*
  Author: BACONMOP
  Spawns CSAT JET to CAS strike
*/

params [["_scaleLimit", false]];

if (!isServer) exitWith {};

if (!isNil "enemyJetSpawn_isRunning" && {enemyJetSpawn_isRunning}) then {
    waitUntil {sleep 0.1; !enemyJetSpawn_isRunning}
} else {
    enemyJetSpawn_isRunning = true;
};

if (_scaleLimit && {InA_Server_AOReinforceJetCount >= InA_Server_AOReinforceJetLimit}) exitWith {};

if (isNil "InA_AOReinforceJetCounter") then {
    InA_AOReinforceJetCounter = 0;
};

private _jettype = ["#jets"] call AW_fnc_getUnitsFromHash;

if (isNil "InA_JetSpawnPosArray") then {
    InA_JetSpawnPosArray = [
        [(worldSize / 2), worldSize, 2000],             // Upper Middle
        [-5000, (worldSize / 2), 2000],                 // Left Middle
        [(worldSize + 2000), (worldSize / 2), 2000],    // Right Middle
        [0, worldSize, 2000],                           // Upper Left
        [worldSize, worldSize, 2000]                    // Upper Right
    ];
};

private _spawnPos = (InA_JetSpawnPosArray # 0);

InA_JetSpawnPosArray deleteAt 0;
InA_JetSpawnPosArray pushBack _spawnPos;

private _jet = (createVehicle [_jettype, _spawnPos, [], 100, "NONE"]);

waitUntil {
    sleep 0.1;
    !isNull _jet
};

_jet setVariable ["InA_AOReinforceType", "Jet", true];

[_jet] call AW_fnc_enemyReinforceCounterEH;

_jet setDir ((getPos _jet) getDir (getMarkerPos InA_Server_currentAO));
_jet setPos (getPos _jet);

// Randomize loadout
_jet call AW_fnc_vehicleCustomizationOpfor;

// Spawn the pilot and set some other things
private _jetGrp = (createVehicleCrew _jet);

_jetGrp = [_jetGrp] call AW_fnc_changeGroupSide;

InA_Server_AOReinforceJetCount = (InA_Server_AOReinforceJetCount + 1);
InA_AOReinforceJetCounter = (InA_AOReinforceJetCounter + 1);

_jetGrp setGroupIdGlobal [format ["AO-Reinforce-Jet-%1", InA_AOReinforceJetCounter]];

[(units _jetGrp)] call derp_fnc_AISkill;

_jet engineOn true;
_jet lock 2;
_jet allowCrewInImmobile true;
[((units _jetGrp) + [_jet])] call AW_fnc_addToAllCurators;

if (alive _jet) then {
    [_jet] spawn AW_fnc_enemyAirEngagement;
};

enemyJetSpawn_isRunning = false;
