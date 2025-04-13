class AW {
    tag = "AW";
    class functions {
        file = "functions";
    };

    class Groups {
		file = "functions\Groups";
		class assignPlayer {};
		class handleDisconnect {};
		class initGroupMenu {};
		class onGroupMenuTvSelectChange {};
		class onRespawn {};
		class removeFromGroup {};
		class selectPosition {};
		class setupPlayer {};
		class updateGroups {};
	};

    class AI {
        file = "functions\AI";
        class main_ao_calculate_enemy_numbers {};
        class main_ao_garrison_spawner {};
        class main_ao_spawn_specific {};
    };

    class vehicleFunctions {
        file = "functions\Vehicle";
        class vBasemonitor {};
        class vehicleInventory {};
        class slingloadEH {};
        class generalVehicleSettings {};
        class rewardVehicleHandler {};
        class disassembledWeaponEh {};
        class aircraftFieldActions {};
        class aircraftFieldRepair {};
        class vehicleFieldRefuel {};
        class setPylonLoadout {};
        class handleCorpse {};
        class vehicleCustomization {};
        class vehicleCustomizationOpfor {};
        class vehicleAttachmentKilledEH {};
        class vehicleReplenish {};
        class vehicleLookup {};
        class vehicleDataLinkSettings {};
        class vehicleUAVTurretCtrlAction {};
        class vehicleGetRespawns {};
        class vehicleRequestRespawn {};
        class aircraftToggleCoPilotPassengerActions {};
        class vehicleApperanceDefines {preInit = 1;};
        class vehicleApperanceLookup {};
        class vehicleApperanceApply {};
        class heliTurretsControl {};
        class vehicleFuelEh {};
    };

    class unitFunctions {
        file = "functions\Units";
        class buildingDefenders {};
        class initUnitTraits {};
        class taskCircPatrol {};
        class spawnAIGroup {};
        class spawnAIVehicle {};
        class getUnitsFromHash {};
        class spawnEnemyUnits {};
        class transferGroupHC {};
        class taskRndPatrol {};
        class changeGroupSide {};
    };

    class supportFunctions {
        file = "functions\Supports";
        class enemyJetSpawn {};
        class artyStrike {};
        class enemyAirEngagement {};
        class heliCombatPatrol {};
        class paraReinforce {};
        class airCav {};
        class enemyReinforceCounterEH {};
    };

    class locationFunctions {
        file = "functions\Location";
        class aoMarkers {};
        class getAo {};
        class findSafePos {};
        class findSideMissionPos {};
        class getCurrentAOName {};
        class getFuzzyPos {};
        class isNearBase {};
        class playersNear {};
        class getClosestBase {};
    };

    class messageFunctions {
        file = "functions\Messages";
        class adminChannelMsg {};
        class assetDisclaimer {};
        class getFOBDisplayName {};
        class getRespawnVehicleDisplayName {};
        class getStatsMsg {};
        class globalHint {};
        class globalnotification {};
        class joinHint {};
        class killMessage {};
        class log {};
        class sendDiscordMessage {};
        class SMhintSUCCESS {};
        class toggleVehicleHUD {};
        class welcomeTitle {};
    };

    class eventFunctions {
        file = "functions\events";
        class eventRegister {};
        class eventTrigger {};
        class eventUnregister {};
        class eventInit {preInit = 1;};
    };

    class cleanupFunctions {
        file = "functions\Cleanup";
        class delete {};
        class uavCleanup {};
        class finishTask {};
    };

    class CustomPlayerActions {
        file = "functions\CustomPlayerActions";
        class clearVehicleInventory {};
        class helicopterDoors {};
        class slingWeapon {};
        class chemlightActions {};
        class chemlightActionsInit {};
        class chemlightActionsToggle {};
        class chemlightActionsCleanup {};
        class cutGrassAction {};
        class pilotActions {};
    };

    class Defines {
        file = "functions\Defines";
        class defineUnits {postInit = 1;};
        class fortifyBuildingDefs {preInit = 1;};
    };

    class baseFunctions {
        file = "functions\Base";
        class BaseManager {};
        class baseTeleport {};
        class baseTeleportSetup {};
        class baseAAInit {postInit = 1;};
        class baseAA {};
        class baseVehicleInit {};
    };

    class miscFunctions {
        file = "functions\Misc";
        class addActionGetIntel {};
        class addActionSurrender {};
        class cookoff {};
        class ServerCommand {};
        class onTKFunc {};
        class setPlayerAttribs {};
        class spawnRelative {};
        class fortifyBuilding {};
        class passiveRevive {};
        class passiveReviveCond {};
        class updateVehicleThresholds {};
        class cutGrass {};
        class dropSupplybox {};
        class factionsGetByIdx {};
        class factionsSetRandom {};
        class factionsGetPlayerByIdx {};
        class factionsValidate {};
        class isPilot {};
        class handleServerKick {};
        class genUUID {};
        class handleProjectileInit {postInit = 1;};
        class handleProjectileExplosion {};
        class missionPersistenceLoad {};
        class missionPersistenceSave {};
        class missionMarkersCreate {};
        class missionMarkersRemove {};
        class garrisonGridManager {};
    };

    class paraChuteFunctions {
        file = "functions\Parachute";
        class doParachuteJump {};
    }
    
    class inventoryFunctions {
        file = "functions\Inventory";
        class cleanInventory {};
        class inventoryInformation {};
        class arsenalCreate {};
        class arsenalSetup {};
        class persistentLoadoutGet {};
        class persistentLoadoutSet {};
        class invAddActions {};
        class invDialogHandler {};
    };

    class seatRestrictionFunctions {
        file = "functions\seatRestrictions";
        class restrictedAircraftSeatsCheck {};
    };

    class zeusFunctions {
        file = "functions\zeus";
        class addToAllCurators {};
        class removeFromAllCurators {};
        class curatorGrpPlacedHandler {};
        class updateEditableObjects {};
        class getEditableObjects {};
        class zeusKeyBinds {};
        class assignZeus {};
        class zeusKeyBindEh {};
        class isZeus {};
        class isStaff {};
        class curatorEHs {};
        class addToAdminChannel {};
    };

    class CBRN {
        file = "functions\cbrn";
        class CBRNClientLoop {};
        class CBRNTriggerWrapper {};
    };

    class Rewards {
        file = "functions\rewards";
        class rewardsDef {};
        class rewardSpawn {};
        class rewardsMenu_Open {};
        class rewardsMenu_onTreeSelChanged {};
        class rewardsMenu_Spawn {};
        class getRewardAreaPosition {};
        class getRewardJetPosition {};
    };

    class TaruPods {
        file = "functions\tarupods";
        class taruPodInit {};
        class taruPodAttach {};
        class taruPodCanAttach {};
        class taruPodDetach {};
        class taruPodCanDetach {};
        class taruPodKilledEH {};
    };

    class Player_Settings {
        file = "functions\Player_Settings";
        class playerSettings_onSliderAttChanged {};
        class playerSettings_onSliderSwayChanged {};
        class playerSettings_onCheckboxChanged {};
        class playerSettings_openSettings {};
    };

    class pilot_grounding {
        file = "functions\pilot_grounding";
        class pilot_grounding_AirframeCounter {};
        class pilot_grounding_Check {};
        class pilot_grounding_openDialog {};
        class pilot_grounding_onLBSelChanged {};
        class pilot_grounding_handleClick {};
        class pilot_grounding_handleOperation {};
    };

    class repair {
        file = "functions\repair";
        class repairInit {postInit = 1;};
        class repairInitGroundServicePoint {};
        class repairInitAirServicePoint {};
        class repairDrawServicePointIcons {};
        class repairServiceVehicle {};
        class repairAddServiceActions {};
    };

    class zeustools {
        file = "functions\zeustools";
        class zeusToolsAddAction {};
        class zeusToolsFix {};
        class zeusToolsMenu {};
        class zeusToolsHint {};
        class zeusToolsToggleHide {};
        class zeusToolsStopMission {};
        class zeusToolsStartMission {};
        class zeusToolsCleanupItems {};
        class zeusTools_DlgOpen {};
        class zeusTools_DlgNextAOonLoad {};
        class zeusTools_DlgNextAOonUnload {};
        class zeusTools_DlgNextAOLbSelChanged {};
        class zeusTools_DlgNextAOBtnConfirm {};
        class zeusTools_DlgVehRespawnonLoad {};
        class zeusTools_DlgVehRespawnLbSelChanged {};
        class zeusTools_DlgVehRespawnBtnRespawn {};
    };
};


class RYK {
    tag = "RYK";
    class tfarFunctions {
        file = "functions\TFAR";
        class TFAR_SR {};
        class TFAR_LR {};
    };
};


class derp {
    tag = "derp";

    class CBA {
        file = "functions\portedFuncs\cba";
        class pfhPreInit {preInit = 1;};
        class addPerFrameHandler {};
        class removePerFrameHandler {};
        class execNextFrame {};
        class waitAndExecute {};
        class waitUntilAndExecute {};
        class pfhPostInit {postInit = 1;};
        class directCall {};
    };

    class AI {
        file = "functions\AI";
        class mainAOSpawnHandler {};
        class AISkill {};
    };
};


class derp_revive {
    class Revive {
        file = "functions\revive";
        class onPlayerKilled {};
        class onPlayerRespawn {};
        class executeTemplates {};
        class switchState {};
        class reviveTimer {};
        class reviveActions {};
        class startDragging {};
        class startCarrying {};
        class dragging {};
        class carrying {};
        class dropPerson {};
        class hotkeyHandler {};
        class uiElements {};
        class animChanged {};
        class drawDowned {};
        class handleDamage {};
        class ace3Check {};
        class diaryEntries {};
        class adjustForTerrain {};
        class syncAnim {};
        class heartBeatPFH {};
        class addSelfReviveHoldaction {};
    };
};


class CHVD {
    tag = "CHVD";
    class functions {
        file = "functions\CHVD";
        class onCheckedChanged {};
        class onSliderChange {};
        class onLBSelChanged {};
        class onEBinput {};
        class onEBterrainInput {};
        class selTerrainQuality {};
        class updateTerrain {};
        class updateSettings {};
        class openDialog {};
        class init {postInit = 1;};
    };
};


class chatcom {
    tag = "RWT";
    class functions {
        file = "functions\chatcom";
        class chatcomExec {};
        class chatcomProcess {};
        class chatcomVerify {};
    };
};
