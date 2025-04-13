class CfgRemoteExec {
    class Functions {
        mode = 1;
        jip = 0;


        // Vanilla functions
        class BIS_fnc_deleteTask {
            jip = 1;
        };

        class BIS_fnc_execVM {
            allowedTargets = 2;
        }

        class BIS_fnc_initIntelObject {
            jip = 1;
        };

        class BIS_fnc_initVehicle {
            allowedTargets = 0;
        };

        class BIS_fnc_playSound {
            allowedTargets = 1;
        };

        class BIS_fnc_setTask {
            jip = 1;
        };

        class BIS_fnc_setTaskLocal {
            jip = 1;
        };

        class BIS_fnc_showNotification {
            allowedTargets = 1;
        };

        class BIS_fnc_debugConsoleExec {
            allowedTargets = 0;
        };

        class BIS_fnc_arsenal {
            allowedTargets = 2;
        };

        class BIS_fnc_holdActionAdd {
            allowedTargets = 0;
            jip = 1;
        };

        class BIS_fnc_holdActionRemove {
            allowedTargets = 0;
            jip = 1;
        };

        class BIS_fnc_shakeCuratorCamera {
            allowedTargets = 0;
        };

        class BIS_fnc_advHint {
            allowedTargets = 0;
        };

        class BIS_fnc_moduleRespawnVehicle {
            allowedTargets = 2;
        };

        class BIS_fnc_sayMessage {
            allowedTargets = 0;
        };

        class BIS_fnc_Destroyer01Init {
            allowedTargets = 0;
            jip = 1;
        };

        class BIS_fnc_Carrier01Init {
            allowedTargets = 0;
            jip = 1;
        };

        class BIS_fnc_setDate {
            allowedTargets = 0;
        };

        class BIS_fnc_setFog {
            allowedTargets = 2;
        };

        class BIS_fnc_setOvercast {
            allowedTargets = 2;
        };

        class BIS_fnc_sharedObjectives {};
        class BIS_fnc_setCustomSoundController {};
        class BIS_fnc_setIdentity {};
        class BIS_fnc_callScriptedEventHandler {};
        class BIS_fnc_curatorRespawn {};
        class BIS_fnc_dynamicGroups {};
        class BIS_fnc_effectKilled {};
        class BIS_fnc_effectKilledSecondaries {};
        class BIS_fnc_effectKilledAirDestruction {};
        class BIS_fnc_effectKilledAirDestructionStage2 {};
        class BIS_fnc_error {};
        class BIS_fnc_objectVar {};


        // I&A functions

        class AW_fnc_globalHint {
            allowedTargets = 0;
        };

        class AW_fnc_addToAllCurators {
            allowedTargets = 2;
        };

        class AW_fnc_removeFromAllCurators {
            allowedTargets = 2;
        };

        class AW_fnc_vehicleCustomization {
            allowedTargets = 2;
        };

        class AW_fnc_generalVehicleSettings {
            allowedTargets = 2;
        };

        class AW_fnc_disassembledWeaponEh {
            allowedTargets = 2;
        };

        class AW_fnc_pilot_grounding_Check {
            allowedTargets = 2;
        };

        class AW_fnc_baseTeleport {
            allowedTargets = 2;
        };

        class AW_fnc_cutGrass {
            allowedTargets = 2;
        };

        class AW_fnc_killMessage {
            allowedTargets = 2;
        };

        class AW_fnc_sendDiscordMessage {
            allowedTargets = 2;
        };

        class AW_fnc_enemyJetSpawn {
            allowedTargets = 2;
        };

        class AW_fnc_heliCombatPatrol {
            allowedTargets = 2;
        };

        class AW_fnc_aircraftFieldRepair {
            allowedTargets = 0;
        };

        class AW_fnc_curatorGrpPlacedHandler {
            allowedTargets = 2;
        };

        class AW_fnc_rewardVehicleHandler {
            allowedTargets = 2;
        };

        class AW_fnc_assignZeus {
            allowedTargets = 2;
        };

        class AW_fnc_setPlayerAttribs {
            allowedTargets = 2;
        };

        class AW_fnc_log {
            allowedTargets = 2;
        };

        class AW_fnc_arsenalCreate {
            allowedTargets = 2;
        };

        class AW_fnc_adminChannelMsg {
            allowedTargets = 2;
        };

        class AW_fnc_eventTrigger {
            allowedTargets = 0;
            jip = 1;
        };

        class AW_fnc_repairServiceVehicle {
            allowedTargets = 2;
        };

        class AW_fnc_pilot_grounding_handleOperation {
            allowedTargets = 2;
        };

        class AW_fnc_rewardSpawn {
            allowedTargets = 2;
        };

        class AW_fnc_vehicleReplenish {
            allowedTargets = 2;
        };

        class AW_fnc_taruPodKilledEH {
            allowedTargets = 2;
        };

        class AW_fnc_passiveRevive {
            allowedTargets = 2;
        };

        class AW_fnc_zeusToolsStopMission {
            allowedTargets = 2;
        };

        class AW_fnc_zeusToolsStartMission {
            allowedTargets = 2;
        };

        class AW_fnc_baseManager {
            allowedTargets = 2;
        };

        class AW_fnc_zeusToolsFix {
            allowedTargets = 2;
        };

        class AW_fnc_zeusToolsHint {
            allowedTargets = 2;
        };

        class AW_fnc_zeusToolsToggleHide {
            allowedTargets = 2;
        };

        class AW_fnc_vehicleGetRespawns {
            allowedTargets = 2;
        };

        class AW_fnc_vehicleRequestRespawn {
            allowedTargets = 2;
        };

        class AW_fnc_dropSupplybox {
            allowedTargets = 2;
        };

        class AW_fnc_handleServerKick {
            allowedTargets = 2;
        };
        
        class AW_fnc_addToAdminChannel {
            allowedTargets = 2;
        };

        class AW_fnc_zeusToolsCleanupItems {
            allowedTargets = 2;
        };

        class AW_fnc_handleProjectileExplosion {
            allowedTargets = 2;
        };

        class AW_fnc_baseAA {
            allowedTargets = 2;
        };

        class AW_fnc_heliTurretsControl {
            allowedTargets = 2;
        };


        // Derp
        class derp_revive_fnc_adjustForTerrain {
            allowedTargets = 0;
        };

        class derp_revive_fnc_switchState {
            allowedTargets = 0;
        };


        // Ares|Achilles
        class Ares_fnc_addIntel {
            allowedTargets = 0;
        };

        class Achilles_fnc_chute {
            allowedTargets = 0;
        };

        class Ares_fnc_Weather_Function {
            allowedTargets = 0;
            jip = 1;
        };

        class Ares_fnc_Change_Weather_Function {
            allowedTargets = 0;
            jip = 0;
        };

        class Achilles_fnc_ambientAnim {
            allowedTargets = 0;
        };

        class Ares_fnc_SearchBuilding {
            allowedTargets = 0;
        };

        class Achilles_fnc_spawn {
            allowedTargets = 0;
            jip = 1;
        };

        class Achilles_fnc_spawn_remote {
            allowedTargets = 2;
        };

        class Achilles_fnc_setACEInjury {
            allowedTargets = 0;
        };

        class Achilles_fnc_setVanillaInjury {
            allowedTargets = 0;
        };

        class Achilles_fnc_moduleCAS_server {
            allowedTargets = 2;
        };

        class Achilles_fnc_instantBuildingGarrison {
            allowedTargets = 0;
        };

        class Achilles_fnc_effectFire {
            allowedTargets = 0;
            jip = 1;
        };

        class Achilles_fnc_eject_passengers {
            allowedTargets = 2;
        };

        class Achilles_fnc_switchUnit_exit {
            allowedTargets = 0;
        };

        class Achilles_fnc_surrenderUnit {
            allowedTargets = 0;
        };

        class Achilles_fnc_setTurretAmmo {
            allowedTargets = 0;
        };

        class Achilles_fnc_setUnitAmmoDef {
            allowedTargets = 0;
        };

        class Achilles_fnc_setVehicleAmmo {
            allowedTargets = 0;
        };
        
        class Ares_fnc_updateTeleportMarkerActions {
            allowedTargets = 0;
            jip = 1;
        };


        // Prairie fire
        class vn_fnc_drm_delete_audio {
            allowedTargets = 0;
        };
        class vn_fnc_drm_request_audio {
            allowedTargets = 0;
        };
        class vn_fnc_music_stop {
            allowedTargets = 0;
        };
        class vn_fnc_music_play {
            allowedTargets = 0;
        };
        class vn_fnc_switchableturrets_lock {
            allowedTargets = 0;
        };

        //Dynamic grouos
        class AW_fnc_assignPlayer {
            allowedTargets = 2;         
        };
        class AW_fnc_setupPlayer {
            allowedTargets = 1; 
        }
        class AW_fnc_updateGroups {
            allowedTargets = 1;         
        }; 
    };

    class Commands {
        mode = 1;
        jip = 0;

        class spawn {
            allowedTargets = 0;
        };

        class selectLeader {
            allowedTargets = 1;
        };

        class setShotParents {
            allowedTargets = 0;
            jip = 1;
        };
        class say3d {
            allowedTargets = 0;
            jip = 1;
        };

        class setDir {
            allowedTargets = 0;
            jip = 1;
        };

        class setVectorDirAndUp {
            allowedTargets = 0;
            jip = 1;
        };

        class moveInCargo {
            allowedTargets = 0;
        };

        class switchMove {
            allowedTargets = 0;
            jip = 1;
        };

        class playAction {
            allowedTargets = 0;
        };

        class enableRopeAttach {
            allowedTargets = 0;
        };

        class removeWeaponTurret {
            allowedTargets = 0;
        };

        class addWeaponTurret {
            allowedTargets = 0;
        };

        class deleteVehicleCrew {
            allowedTargets = 0;
        };

        class engineOn {
            allowedTargets = 0;
        };

        class enableSimulationGlobal {
            allowedTargets = 2;
        };

        class sideChat {
            allowedTargets = 0;
        };

        class hint {
            allowedTargets = 0;
        };

        class flyInHeight {
            allowedTargets = 0;
        };

        class swimInDepth {
            allowedTargets = 0;
        };

        class setBehaviour {
            allowedTargets = 0;
        };

        class setSpeedMode {
            allowedTargets = 0;
        };

        class setFormation {
            allowedTargets = 0;
        };

        class setCombatMode {
            allowedTargets = 0;
        };

        class setSkill {
            allowedTargets = 0;
        };

        class setPlateNumber {
            allowedTargets = 0;
        };

        class setName {
            allowedTargets = 0;
            jip = 1;
        };

        class setUnitPos {
            allowedTargets = 0;
        };

        class lock {
            allowedTargets = 0;
        };

        class setFace {
            allowedTargets = 0;
        };

        class setUnitTrait {
            allowedTargets = 0;
        };

        class hideObjectGlobal {
            allowedTargets = 2;
        };

        class setFuel {
            allowedTargets = 0;
        };

        class setHitIndex {
            allowedTargets = 0;
        };

        class setSpeaker {
            allowedTargets = 0;
        };

        class allowFleeing {
            allowedTargets = 0;
        };

        class disableAI {
            allowedTargets = 0;
        };

        class allowDamage {
            allowedTargets = 0;
        };

        class setAmmoOnPylon {
            allowedTargets = 0;
        };

        class loadMagazine {
            allowedTargets = 0;
        };

        class reportRemoteTarget {
            allowedTargets = 0;
        };

        class removeAllActions {
            allowedTargets = 0;
        };

        class setPitch {
            allowedTargets = 0;
            jip = 1;
        };

        class linkItem {
            allowedTargets = 0;
        };

        class unassignVehicle {
            allowedTargets = 0;
        };

        class hintSilent {
            allowedTargets = 0;
        };

        class hintCadet {
            allowedTargets = 0;
        };

        class setVehicleRadar {
            allowedTargets = 0;
        };

        class setVehicleReportRemoteTargets {
            allowedTargets = 0;
        };

        class setVehicleReceiveRemoteTargets {
            allowedTargets = 0;
        };

        class addCuratorEditableObjects {
            allowedTargets = 2;
        };

        class removeAllWeapons {
            allowedTargets = 0;
        };

        class setFormDir {
            allowedTargets = 0;
        };

        class commandArtilleryFire {
            allowedTargets = 0;
        };
        
        class setTimeMultiplier {
            allowedTargets = 2;
        };

        class globalChat {
            allowedTargets = 0;
        };

        class commandChat {
            allowedTargets = 0;
        };

        class vehicleChat {
            allowedTargets = 0;
        };
        
        class removeCuratorEditableObjects {
            allowedTargets = 2;
        };
    };
};
