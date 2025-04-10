/*
 * Author: Whigital
 * Description:
 * Server components of AW_fnc_curatorGrpPlacedEh that does the HC
 * checks and actual transfer
 *
 */

params ["_curator", "_group"];

if (!isServer) exitWith {};

if (isNull _group) exitWith {};

// Add to all other curators
[(units _group)] spawn AW_fnc_addToAllCurators;

private _hcOnline = (InA_Server_HeadlessClients isNotEqualTo []);
private _hcTransferEnabled = (!isNil "InA_Server_TransferZeusUnitsToHC" && {InA_Server_TransferZeusUnitsToHC});

if (!_hcOnline || !_hcTransferEnabled) exitWith {};

private _curatorName = (name (getAssignedCuratorUnit _curator));
private _rndGrpId = format ["%1-%2", _curatorName, (round (random 1000))];

_group setGroupIdGlobal [_rndGrpId];

// Set AI skills
[_group] spawn derp_fnc_AISkill;

// Transfer to HC if
[_group] spawn AW_fnc_transferGroupHC;
