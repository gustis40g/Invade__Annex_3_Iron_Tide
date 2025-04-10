// Main AO Settings
class AOSize {
    title = "Main AO Diameter";
    values[] = {200,300,400,500,600,700,800,900,1000};
    texts[] = {"200m","300m","400m","500m","600m","700m","800m","900m","1,000m"};
    default = 800;
};

class AOCompletionCount {
    title = "Main AO completion count";
    values[] = {-1, 20, 30, 40, 50, 60, 70, 80, 90, 100};
    texts[] = {"All", "20", "30", "40", "50", "60", "70", "80", "90", "100"};
    default = 50;
};

class AOSearchRadiusMin {
    title = "Main AO search distance";
    values[] = {-1, 1500, 2000, 2500, 3000, 3500, 4000, 4500, 5000};
    texts[] = {"Random", "1500", "2000", "2500", "3000", "3500", "4000", "4500", "5000"};
    default = 2500;
};

class AOSearchRadiusOuter {
    title = "Main AO search distance reach";
    values[] = {1500, 2000, 2500, 3000, 3500, 4000};
    texts[] = {"1500", "2000", "2500", "3000", "3500", "4000"};
    default = 2500;
};

class AOEnemiesThreshold {
    title = "Main AO enemies treshold";
    values[] = {0, 3, 6, 9, 12, 15, 18, 21};
    texts[] = {"0", "3", "6", "9", "12", "15", "18", "21"};
    default = 6;
};

// General mission settings
class PlayerFaction {
    title = "Player faction, determines rewards, loadouts, arsenal content etc.";
    values[] = {0, 1, 2, 3};
    texts[] = {"Vanilla NATO (BLU_F)", "SOG PF MACV (B_MACV)", "Western Sahara (IDK)", "RHS NATO (RHS_NATO)"};
    default = 3;
};

class EnemyFaction {
    title = "Enemy faction, defines enemy units, groups and vehicles";
    values[] = FACTION_VALUES;
    texts[] = FACTION_TEXTS;
    default = 6;
};

class FactionRandomization {
    title = "Randomize enemy faction";
    values[] = {1, 2};
    texts[] = {"Randomize at mission start", "Randomize each AO"};
    default = 1;
};

class MissionSpawnRange {
    title = "Minimum distance from an AO/F.O.B/Base that a mission can spawn";
    values[] = {1500, 2500, 3000, 4000, 5000, 7500};
    texts[] = {"1.5km", "2.5km", "3km", "4km", "5km", "7.5km"};
    default = 2500;
};

class prioMissions {
    title = "Enable prio missions";
    values[] = {1, 0};
    texts[] = {"Enabled", "Disabled"};
    default = 1;
};

class sideMissions {
    title = "Enable side missions";
    values[] = {1, 0};
    texts[] = {"Enabled", "Disabled"};
    default = 1;
};


// Persistence settings
class AOPersistence {
    title = "Main AO Persistence";
    values[] = {1, 0};
    texts[] = {"Enabled", "Disabled"};
    default = 1;
};

class AOPersistenceWipe {
    title = "Main AO Persistence - WIPE SAVE";
    values[] = {1, 0};
    texts[] = {"WIPE SAVE (cannot be undone)", "Keep data"};
    default = 0;
};


// Priority mission settings
class ArtilleryTargetTickTimeMin {
    title = "MINIMUM Time between Priority Target actions";
    values[] = {60, 120, 180, 240, 300, 360, 420, 480, 540, 600, 660, 720, 780, 840, 900};
    texts[] = {"1 minute", "2 minutes", "3 minutes", "4 minutes", "5 minutes", "6 minutes", "7 minutes", "8 minutes", "9 minutes", "10 minutes", "11 minutes", "12 minutes", "13 minutes", "14 minutes", "15 minutes"};
    default = 300;
};

class ArtilleryTargetTickTimeMax {
    title = "MAXIMUM Time between Priority Target actions";
    values[] = {60, 120, 180, 240, 300, 360, 420, 480, 540, 600, 660, 720, 780, 840, 900};
    texts[] = {"1 minute", "2 minutes", "3 minutes", "4 minutes", "5 minutes", "6 minutes", "7 minutes", "8 minutes", "9 minutes", "10 minutes", "11 minutes", "12 minutes", "13 minutes", "14 minutes", "15 minutes"};
    default = 480;
};


// Environment
class NightTimeMultiplier {
    title = "Nighttime multiplier amount";
    texts[] = {"1","6","12","24","60", "120"};
    values[] = {1, 6, 12, 24, 60, 120};
    default = 24;
};

class NoNightTimeOverCast {
    title = "Remove all overcast during nighttime";
    texts[] = {"Remove", "Don't change"};
    values[] = {1, 0};
    default = 1;
};


// Skills
class UseServerSkillSettings {
    title = "Use Servers skills settings";
    texts[] = {"Yes", "No"};
    values[] = {1, 0};
    default = 0;
};

class AIAimingAccuracy {
    title = "AI aiming accuracy";
    values[] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
    texts[] = {"0.1", "0.2", "0.3", "0.4", "0.5", "0.6", "0.7", "0.8", "0.9", "1"};
    default = 2;
};

class AIAimingShake {
    title = "AI aiming shake";
    values[] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
    texts[] = {"0.1", "0.2", "0.3", "0.4", "0.5", "0.6", "0.7", "0.8", "0.9", "1"};
    default = 2;
};

class AIAimingSpeed {
    title = "AI aiming speed";
    values[] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
    texts[] = {"0.1", "0.2", "0.3", "0.4", "0.5", "0.6", "0.7", "0.8", "0.9", "1"};
    default = 2;
};

class AISpottingDistance {
    title = "AI spotting distance";
    values[] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
    texts[] = {"0.1", "0.2", "0.3", "0.4", "0.5", "0.6", "0.7", "0.8", "0.9", "1"};
    default = 5;
};

class AISpottingSpeed {
    title = "AI spotting speed";
    values[] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
    texts[] = {"0.1", "0.2", "0.3", "0.4", "0.5", "0.6", "0.7", "0.8", "0.9", "1"};
    default = 5;
};

class AICourage {
    title = "AI courage";
    values[] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
    texts[] = {"0.1", "0.2", "0.3", "0.4", "0.5", "0.6", "0.7", "0.8", "0.9", "1"};
    default = 10;
};

class AIReloadSpeed {
    title = "AI reload speed";
    values[] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
    texts[] = {"0.1", "0.2", "0.3", "0.4", "0.5", "0.6", "0.7", "0.8", "0.9", "1"};
    default = 5;
};

class AICommandingSkill {
    title = "AI commanding skill";
    values[] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
    texts[] = {"0.1", "0.2", "0.3", "0.4", "0.5", "0.6", "0.7", "0.8", "0.9", "1"};
    default = 7;
};

class AIGeneralSkill {
    title = "AI general skill";
    values[] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
    texts[] = {"0.1", "0.2", "0.3", "0.4", "0.5", "0.6", "0.7", "0.8", "0.9", "1"};
    default = 8;
};


// Misc. settings
class TransferZeusUnitsToHC {
    title = "Transfer Zeus spawned units to Headless client";
    texts[] = {"Yes", "No"};
    values[] = {1, 0};
    default = 1;
};

class VehicleRespawnDistance {
    title = "Distance from players that vehicles won't respawn";
    values[] = {10, 50, 100, 200, 300, 400, 500, 1000, 2000, 5000, 10000};
    texts[] = {"10m", "50m", "100m", "200m", "300m", "400m", "500m", "1km", "2km", "5km", "10km"};
    default = 1000;
};


// Player settings
class GearRestriction {
    title = "Arsenal / Gear Restrictions";
    texts[] = {"Active", "None"};
    values[] = {1, 0};
    default = 1;
};

class Fatigue {
    title = "Enable Fatigue";
    texts[] = {"Yes","No"};
    values[] = {1, 0};
    default = 1;
};

class PlayerAimingCoefSetting {
    title = "Enable Aiming Coefficient setting";
    texts[] = {"Default", "Mission", "Player settable"};
    values[] = {-1, 0, 1};
    default = 0;
};

class PlayerAimingCoef {
    title = "Player Aiming Coefficient (Weapon sway)";
    texts[] = {"Default", "90%", "80%", "70%", "60%", "50%"};
    values[] = {100, 90, 80, 70, 60, 50};
    default = 50;
};

class derp_revive_downedDamageThreshold {
    title = "Player downed damage treshold";
    texts[] = {"500%", "400%","default (300%)", "200%", "vanilla (100%)", "80%"};
    values[] = {5,4,3,2,1,0.8};
    default = 3;
};

class derp_revive_selfrevive {
    title = "Enable Self Revive";
    texts[] = {"Yes","No"};
    values[] = {1, 0};
    default = 0;
};