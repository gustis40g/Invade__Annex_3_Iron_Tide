/*
 * Author: Whigital
 * Description:
 * Set random faction from InA_EnemyFactionRandomizationData
 *
 */

if (!isServer) exitWith {};

if (isNil "InA_EnemyFactionRandomizationData") exitWith {};

private _factions = (InA_EnemyFactionRandomizationData get "#factions");

InA_EnemyFaction = (selectRandom _factions);
InA_EnemyFactionHash = (InA_FactionMappings get InA_EnemyFaction);
InA_EnemyFactionSide = (InA_EnemyFactionHash getOrDefault ["#side", east]);
