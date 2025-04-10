/*
 * Author: Whigital
 * Description:
 * Faction / Group / Unit / Vehicle definitions
 *
 */

if (!isServer) exitWith {};

scriptName "factionDefines";

InA_FactionMappingsDefined = false;

InA_FactionMappings = createHashMap;

/*
Faction hash format:

[<faction_key>, <hash>] (HashMap)
    ["#name", <faction_name>] (HashMap)
    ["#side", <faction_side>] (HashMap)
    ["#infantry", <hash>] (HashMap)
        ["#squads", <array>] (HashMap)
        ["#specop_squads", <array>] (HashMap)
        ["#viper_squads", <array>] (HashMap)
        ["#teams", <array>] (HashMap)
        ["#specop_teams", <array>] (HashMap)
        ["#viper_teams", <array>] (HashMap)
        ["#at_teams", <array>] (HashMap)
        ["#aa_teams", <array>] (HashMap)
        ["#aa_teams", <array>] (HashMap)
        ["#sniper_teams", <array>] (HashMap)
    ["#vehicles", <hash>] (HashMap)
        ["#mraps", <array>] (HashMap)
        ["#ifvs", <array>] (HashMap)
        ["#spaas", <array>] (HashMap)
        ["#mbts", <array>] (HashMap)
        ["#helis", <array>] (HashMap)
        ["#cas_helis", <array>] (HashMap)
        ["#jets", <array>] (HashMap)
*/

// Vanilla factions
#include "factions\CSAT.sqf"
#include "factions\AAF.sqf"
#include "factions\FIA.sqf"
#include "factions\SYND.sqf"
#include "factions\CSAT_T.sqf"

// Prairie Fire factions
#include "factions\PAVN.sqf"
#include "factions\VC_M.sqf"
#include "factions\VC_L.sqf"

// Western Sahara factions
#include "factions\SFIA.sqf"
#include "factions\TURA.sqf"

// RHS Factions
#include "factions\AFRF.sqf"
#include "factions\CDF.sqf"
#include "factions\RACS.sqf"


private _factionIdx = (["EnemyFaction", -1] call BIS_fnc_getParamValue);
private _faction = (_factionIdx call AW_fnc_factionsGetByIdx);

if (isNil "InA_EnemyFactionRandomizationData") then {
    InA_EnemyFaction = _faction;
    InA_EnemyFactionHash = (InA_FactionMappings get InA_EnemyFaction);
    InA_EnemyFactionSide = (InA_EnemyFactionHash getOrDefault ["#side", east]);
} else {
    call AW_fnc_factionsSetRandom;
    [(format ["Faction '%1' randomized for mission", InA_EnemyFaction]), "FACTION"] call AW_fnc_log;
};

InA_FactionMappingsDefined = true;
