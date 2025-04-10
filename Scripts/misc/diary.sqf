/*
| Author:
|	Quiksilver.
|_____
| Description:
|
|	Created: 26/11/2013.
|	Coded for I&A and hosted on allfps.com.au servers.
|	You may use and edit the code.
|	You may not remove any entries from Credits without first removing the relevant author's contributions,
|	or asking permission from the mission authors/contributors.
|	You may not remove the Credits tab, without consent of Ahoy World or allFPS.
| 	Feel free to re-format or make it look better.
|_____
| Usage:
|
|	Search below for the diary entries you would like to edit.
|	DiarySubjects appear in descending order when player map is open.
|	DiaryRecords appear in ascending order when selected.
|_____
| Credit:
|	Invade & Annex 2.00 was developed by Rarek [ahoyworld.co.uk] with hundreds of hours of work
|	The current version was developed by Quiksilver with hundreds more hours of work.
|
|	Contributors: Razgriz33 [AW], Jester [AW], Kamaradski [AW], David [AW], chucky [allFPS], Stanhope [AW].
|
|	Please be respectful and do not remove credit.
*/

if (!hasInterface) exitWith {};

waitUntil {!isNull player};

player createDiarySubject ["rules", "Rules"];
player createDiarySubject ["discord", "Discord"];
player createDiarySubject ["mods", "Mods"];
player createDiarySubject ["teamspeak", "Teamspeak"];
player createDiarySubject ["faq", "FAQ"];
player createDiarySubject ["changelog", "Change Log"];
player createDiarySubject ["Settings", "Settings"];
player createDiarySubject ["credits", "Credits"];

//-------------------------------------------------- Rules

player createDiaryRecord ["rules", ["Player Report", "
<br/>If you see any player breaking the rules and you can`t find an admin in-game or on Teamspeak, please use the following procedure:
<br/>1. Go to forums.ahoyworld.net
<br/>2. In navigation menu look for Player Tools button, it opens a drop-down menu
<br/>3. Select Player report option
<br/>4. Fill in a player report, be honest and provide enough evidence
"]];
player createDiaryRecord ["rules", ["Enforcement", "
<br/>The purpose of the above rules is to ensure a fun and relaxing environment for public players.
<br/>
<br/>Server rules are in place merely as a means to that end.
<br/>
<br/>Guideline for enforcement:
<br/>
<br/>-	Innocent rule violation and disruptive behaviour:
<br/>
<br/>		= Verbal / Written request to cease, or warning.
<br/>
<br/>-	Minor or first-time rule violation:
<br/>
<br/>		= Kick, or 0 - 3 day ban.
<br/>
<br/>-	Serious or repetitive rule violation:
<br/>
<br/>		= 3 - 7 day ban.
<br/>
<br/>-	Administrative ban (hack/exploit/verbal abuse/serious offense):
<br/>
<br/>		= permanent or 30 day.
<br/>
<br/>
<br/>The above is subject to discretion.
"]];

rules = { [] spawn { [format ["<t align=\'center\' href='https://forums.ahoyworld.net/topic/8378-the-rules-of-ahoyworld/'>Click here to open your web browser and find the rules</t>"], "AHOWYWORLD RULES"] call BIS_fnc_guiMessage; }; };

player createDiaryRecord ["rules", ["General", "
<br/>This is a short summary of the rules.  The full rules can be found <execute expression='call rules'>here</execute>.
<br/>Or alternatively at: http://www.ahoyworld.net/index/rules/
<br/>But the first link is always up to date while the second might not be
<br/>
<br/>
<br/>Short summary of the rules:
<br/>
<br/>-AhoyWorld is a welcoming community that respects its members and visitors. We expect everyone to maintain this environment and will take action against those who jeopardise that community spirit. Admins reserve the right to warn/kick/ban users whose behaviour is deemed disruptive or aggressive and not conducive to a place of tolerance/friendship/comradery. Whether the behaviour is disruptive or not will be determined on a case-by-case basis on the judgment of the admin/admins present.
<br/>
<br/>-Racism or hate speech of any kind is not tolerated.
<br/>
<br/>-Do not intentionally kill another player on your side.  If you accidently teamkill someone, apologize immediately.
<br/>
<br/>-Play the mission as intended.
<br/>
<br/>-Consider your skill as a pilot before taking a Pilot slot.
<br/>    -The primary role of a pilot is to provide logistical support to the infantry on the ground.  Examples of logistical support are: transporting people, ammo, fuel, vehicles, …
<br/>    -In case of poor ability, a pilot may be asked to leave the slot.
<br/>
<br/>-Play your role.
<br/>    -If you are operating a support asset like a mortar or a CAS plane/helicopter you are not allowed to kill the entire AO.  Support assets are there to support the infantry this means that infantry must call these support assets in.
<br/>
<br/>-Do not waste assets.
<br/>
<br/>-Respect game immersion.
<br/>    -Refrain from spamming the side global and command chats.  Ask yourself if what you have to say is useful information for everyone.  It might be more sensible to use group, vehicle or direct chat.
<br/>    -Do not talk in global, side and command channels.  Use group, vehicle and direct chat for voice communications.
<br/>    -Playing music in global, side, command and group channels is forbidden.  You may play music in direct and vehicle channels, unless another player asks you not to.
<br/>
<br/>-Trolling in any way will be dealt with swiftly and harshly.
<br/>
<br/>-Being AFK for prolonged periods of time in the server is not acceptable.
<br/>
<br/>Upon entering an AhoyWorld invade and annex server you agree to abide by the following rules.  Any breaking of the rules can result in sanction being applied by a member of staff.  These sanctions can include, but are not limited to, warning, in-game punishment, kicking, temporary ban and permanent ban.  Which action should be taken will be determined on a case-by-case basis by the staff member(s) present at the time and left to the discretion of this/these member(s) of staff.
"]];

//-------------------------------------------Discord
discordLink = { [] spawn { [format ["<t align=\'center\' href='https://discord.gg/N7w3wKj'>Click here to open your web browser and join the server</t>"], "AHOWYWORLD DISCORD"] call BIS_fnc_guiMessage; }; };

player createDiaryRecord ["discord", ["Discord", "
<br/>You can find us on discord at: <execute expression='call discordLink'>here</execute>
<br/>Or go to our forum at forums.ahoyworld.net and look for the discord logo in the sidebar.
"]];

//-------------------------------------------------- Mods
player createDiaryRecord ["mods", ["Serverside", "
<br/> Mods currently running on server (subject to change without notice):<br/><br/>

<br/>- None at this time.
"]];

modsForumPost = { [] spawn { [format ["<t align=\'center\' href='https://forums.ahoyworld.net/topic/9331-ia-accepted-addons-repository-info/'>Click here to open your web browser and see the forum topic with allowed mods</t>"], "AHOWYWORLD DISCORD"] call BIS_fnc_guiMessage; }; };

player createDiaryRecord ["mods", ["Mods Allowed", "
<br/> Mods currently allowed (subject to change without notice):<br/>
<br/> Note that this list might be out of date. Visit <execute expression='call modsForumPost'>this topic on our forum</execute> for the most up to date list.
<br/>
<br/>-CBA
<br/>-ShackTac UI
<br/>-DUI - Squad Radar
<br/>-outlaw magrepack
<br/>-tao foldmap
<br/>
<br/>-Discord Rich Presence
<br/>
<br/>-DynaSound 2
<br/>-Enhanced Soundscape
<br/>-JSRS SOUNDMOD
<br/>-Blastcore
"]];

//-------------------------------------------------- Teamspeak
player createDiaryRecord ["teamspeak", ["TS3", "
<br/> You can download Teamspeak here:<br/>
<br/> http://www.teamspeak.com/?page=downloads
<br/>
"]];
player createDiaryRecord ["teamspeak", ["AHOY WORLD", "
<br/> Teamspeak IP-address for the AW server:
<br/> ts.ahoyworld.net
<br/>
<br/> Visitors and guests welcome!
"]];

//-------------------------------------------------- FAQ
player createDiaryRecord ["faq", ["UAVs", "
<br/><font size='16'>Q:</font> Can I use the UAVs?<br/>
<br/><font size='16'>A:</font> Yes, however you must be in the UAV Operator role and you must have a UAV Terminal.
<br/>
<br/><font size='16'>Q:</font> Why do I get the don't troll hint when using my UAV?<br/>
<br/><font size='16'>A:</font> Because our base protection is a bit too eager to stop trolls, until we can come up with a fix for this you'll have to sit somewhere outside of base protection.
<br/>
<br/><font size='16'>Q:</font> Why can't I connect to the UAV?<br/>
<br/><font size='16'>A:</font> Sometimes the UAVs are still connected to the prior Operators Terminal. If he disconnects or dies, sometimes the Terminal does not delete properly. The only solution at this time is to destroy the UAV, and you yourself must respawn.
"]];

player createDiaryRecord ["faq", ["Squads", "
<br/><font size='16'>Q:</font> How do I join or create a squad?<br/>
<br/><font size='16'>A:</font>
<br/> 1. Press 'U' to open BI Squad Management.
<br/> 2. If you receive a squad invite from another player, hold 'U' to accept it.
<br/>
"]];

player createDiaryRecord ["faq", ["Bipod", "
<br/><font size='16'>Q:</font> How do I deploy bipod or rest my weapon?<br/>
<br/><font size='16'>A:</font> Press C (default) to rest your weapon or deploy the bipod.
"]];

player createDiaryRecord ["faq", ["Medics", "
<br/><font size='16'>Q:</font> Why can't I heal him?<br/>
<br/><font size='16'>A:</font> There are three conditions you must pass in order to revive a fallen comrade.
<br/> 1. You must be in a Medic / Paramedic role.
<br/> 2. You must have a Medkit.
<br/> 3. You must have at least one First Aid Kit.
"]];

player createDiaryRecord ["faq", ["Mortars", "
<br/><font size='16'>Q:</font> Can I use the Mortars?
<br/><font size='16'>A:</font> Yes, however if you are not in the mortar gunner role you will not have access to the Artillery Computer.<br/>
<br/><font size='16'>Q:</font> How do I use the Mortar without the computer?
<br/><font size='16'>A:</font> You have to manually find the target with the sight. Here are some steps to use the mortar.
<br/> 1. Press the F key to select the firing distance.
<br/> 2. If you are in line-of-sight just put the cursor on the target and use the page up and page down keys to change the elevation.
<br/> 3. Fire!<br/>
<br/><font size='16'>Here is a YouTube video that can explain in more detail.<br/>
<br/> https://www.youtube.com/watch?v=SCCvXfwzeAU
"]];

player createDiaryRecord ["faq", ["Rangefinder", "
<br/><font size='16'>Q:</font> Why doesn't my rangefinder display the range?
<br/><font size='16'>A:</font> Since the Jets DLC update there is a key you have to press to display the range.
<br/>You can find this key-bind under:
<br/>Esc-configure-controls-weapons-lase range
<br/>
"]];
player createDiaryRecord ["faq", ["CBRN", "
<font face='EtelkaMonospacePro' size='10' color='#FFD700'>
<br/><font size='14' color='#FF8C00'>CBRN mission gear</font>
<br/>
<br/><font size='12' color='#32CD32'>    Owners of Contact DLC:</font>
<br/><font size='12' color='#32CD32'>        Facemasks:</font>
<br/>            APR [NATO]
<br/>            APR (Black) [CSAT]
<br/>            APR (Olive) [CSAT]
<br/>            APR (Sand) [CSAT]
<br/>            Regulator Facepiece
<br/>
<br/><font size='12' color='#32CD32'>        Uniforms:</font>
<br/>            CBRN Suite (MTP) [NATO]
<br/>            CBRN Suite (Tropic) [NATO]
<br/>            CBRN Suite (Woodland) [NATO]
<br/>
<br/><font size='12' color='#32CD32'>        Backpacks:</font>
<br/>            Combination Unit Respirator
<br/>            Self-Contained Breathing Apparatus
<br/>
<br/><font size='12' color='#4682B4'>    Contact DLC not owned:</font>
<br/><font size='12' color='#4682B4'>        Headgear:</font>
<br/>            Shemag (Olive)
<br/>            Shemag (Olive, Headset)
<br/>            Shemag (Tan)
<br/>            Shemag (White)
<br/>
<br/><font size='12' color='#4682B4'>        Faceware:</font>
<br/>            Combat Goggles
<br/>            Combat Goggles (Green)
<br/>
</font>
"]];

player createDiaryRecord ["faq", ["Service", "
<font face='EtelkaMonospacePro' size='8' color='#FFD700'>
<br/><font size='14' color='#FF8C00'>Vehicle Servicing</font>
<br/>
<br/><font size='12' color='#32CD32'>Conditions:</font>
<br/>- Vehicle needs to be stationary
<br/>- Vehicle engine needs to be off
<br/>- You need to be outside the vehicle
<br/>- You need to be within 5m of the vehicle
<br/>- UAV operators can request UAV service remotely
<br/>
<br/><font size='12' color='#32CD32'>Servicing</font>
<br/>- Vehicle needs to remain on the pad
<br/>- Vehicle will be locked during service
<br/>- Crew/passangers will be ejected at start (if any)
<br/>- Servicing ETA is time of day (use wristwatch or GPS clock)
<br/>- Servicing times based on vehicle damage and fuel/ammo status
</font>
"]];

player createDiaryRecord ["faq", ["Backpack on chest", "
<font face='EtelkaMonospacePro' size='8' color='#FFD700'>
<br/><font size='14' color='#FF8C00'>Backpack on chest</font>
<br/>
<br/>You will automatically receive a parachute when getting out of any aircraft (rotary or fixed wing) when this aircraft is more than 3 meters of the ground. You will receive your backpack (if you had one) back when you drop the parachute.
</font>
"]];

player createDiaryRecord ["faq", ["Vehicle Inventory", "
<font face='EtelkaMonospacePro' size='8' color='#FFD700'>
<br/><font size='14' color='#FF8C00'>Vehicle Inventory</font>
<br/>
<br/><font size='12' color='#32CD32'>Conditions:</font>
<br/>
<br/>- Be in the driver seat of the vehicle.
<br/>- Be within 8 meters of an Arsenal Quartermaster (Steve).
</font>
"]];

//-------------------------------------------------- Custom settings accessible from the diary
player createDiaryRecord [
    "Settings", [
        "Player Settings",
        "<br/>Click <execute expression = '[] spawn AW_fnc_playerSettings_openSettings;'>here</execute> to open the settings menu.<br/>You can also bind it through:<br/><br/>Controls -> KEYBOARD -> Custom controls -> 'Use Action 20'"
    ]
];

//-------------------------------------------------- Change Log

{ player createDiaryRecord ["changelog", _x]; } forEach [
    ["3.00", "<br/><font size='16'>- Initial Altis and Tanoa Release</font>"],
    ["3.00.06", "
    <br/>- Includes Changelog for versions 3.00.00 to 3.00.06
    <br/>
    <br/>- [Added] Spotters Should now be able to get Ghillies.
    <br/>- [Added] Some checks in Main AO for which faction is mainFaction.
    <br/>- [Added][Altis] Expanded Safezone to include hill north of Main Spawn.
    <br/>- [Fixed] Turret Control.
    <br/>- [Fixed] Friendly Fire Messages.
    <br/>- [Fixed] FOB AO's not completing.
    <br/>- [Fixed] Priority Arty not spawning enemies.
    <br/>- [Fixed] Enemy heli reinforcements for main AO.
    <br/>- [Fixed] FOB's not having arsenal and not spawning their Vehicles.
    <br/>- [Fixed] AI at main AO would trap themselves in their formation and not move.
    <br/>- [Fixed] script error with earplugs and now add ability to get earplugs from start.
    <br/>- [Fixed][Altis] Hunter Spawn was spawning Prowlers.
    <br/>- [Fixed][Tanoa] Enemy Cas spawn on Tanoa.
    <br/>- [Tweaked] Teleport AddActions should now only appear when FOB has been captured.
    <br/>- [Updated] Revive.
    <br/>- [Updated] Mission will end after X amount of AO's.
    <br/>- [Replaced] TAW VD with CHVD."],
    ["3.00.07", "
    <br/>- [Added] Added radio sounds to supports.
    <br/>- [Fixed] Underwater Mission not deleting enemies once done.
    <br/>- [Fixed] View distance now on only arsenal men.
    <br/>- [Fixed] Addaction to spawn in hunter/prowler back to Arsenal man.
    <br/>- [Tweaked] Friendly Fire messages now come from Crossroads.
    <br/>- [Removed][Tanoa] Removed Yanukka AO."],
    ["3.00.08", "
    <br/>- [Fixed] Player spamming radio callouts.
    <br/>- [Tweaked] UAV respawn is now 5 minutes.
    <br/>- [Tweaked] Arty should now take longer between firing.
    <br/>- [Tweaked] Rewrote pilot restriction."],
	["3.00.09", "
    <br/>- [Fixed] Huge error in the priority arty causing massive rpt spam.
    <br/>- [Tweaked] Chopper Down message delay reduced."],
	["3.00.10", "
    <br/>- [Fixed][Tanoa] AO's not working properly.
    <br/>- [Fixed][Tanoa] FOB Comms Bravo."],
	["3.1.1", "
    <br/>- [Added] Safezone to main base
    <br/>- [Added] Added Prowlers to the respawn Vehicles
    <br/>- [Added] TK protection
    <br/>- [Fixed][Altis] AO's not working properly.
    <br/>- [Tweaked] Rewrote pilot restriction.
    <br/>- [Tweaked] UAV and plane repair pad's"],
	["3.1.2", "
    <br/>- [Added] Prio AA mission
    <br/>- [Added] Runway light's
    <br/>- [Added] Refuelling options for smaller helis
    <br/>- [Fixed][Altis] AO's not working properly.
    <br/>- [Tweaked] Derp_revive
    <br/>- [Tweaked] Moved Vehicle pickup and Blackfish spawn added arsenal to vehicle lift"],
	["3.1.3", "
    <br/>- [Added] clear vehicle inventory option
    <br/>- [Added] new side mission
    <br/>- [Fixed] AOs will no longer enter deadlock
    <br/>- [Fixed] AA side mission clean-up
    <br/>- [Fixed] Certain units spawning damaged
    <br/>- [Fixed][Altis] Frini woods bugging out
    <br/>- [Tweaked] Zeus related stuff
    <br/>- [Tweaked] Under the hood stuff for AO and side missions"],
	["3.1.4", "
    <br/>- [Added] USS Freedom
    <br/>- [Added] Black wasp and UCAV to the Freedom
    <br/>- [Added] Black wasp (both versions) and UCAV to side mission rewards
    <br/>- [Tweaked] Rescue the pilot side mission bleed-out timer is now 15 minutes"],
	["3.1.5", "
    <br/>- [Added] squad XML hint
    <br/>- [Added] Side mission reward: Hemtt mounted praetorian and spartan
    <br/>- [Added] Side mission reward: Unarmed inf transport Xi’an
    <br/>- [Added] Side mission reward: LAT hellcat
    <br/>- [Added] Side mission reward: AT, AA and .50 off-road
    <br/>- [Added] Side mission reward: Armed Qilin
    <br/>- [Fixed] UAV rearm pad not working for certain UAVs
    <br/>- [Fixed] Rewards spawning damaged
    <br/>- [Fixed] Pawnee camos not displaying correctly
    <br/>- [Tweaked] Side mission reward spawn rate"],
	["3.2.0", "
    <br/>- <font size='16'>Initial release Malden Invade and Annex</font><br/>
    <br/>- [Added] Random ghosthawk camos
    <br/>- [Added] Random black wasp camos
    <br/>- [Added] AA for the USS freedom
    <br/>- [Added] Random loadouts for respawning jets
    <br/>- [Added] NATO or black skins for some FOB vehicles
    <br/>- [Added] System that prevents unplayable levels of fog
    <br/>- [Added] NATO or black skins for some side mission rewards
    <br/>- [Fixed] Typo in earplugs hint
    <br/>- [Tweaked] Service pad speed
    <br/>- [Tweaked] UCAV respawn timer
    <br/>- [Tweaked] Prio AA now spawns 3x AA assets
    <br/>- [Tweaked] Black wasp respawn timer and loadout
    <br/>- [Tweaked] Ammo in AT/AA off road (side mission reward)
    <br/>- [Tweaked] Base AA is now a Praetorian 1C (AAA turret)
    <br/>- [Tweaked] Under the hood stuff for Zeus
    <br/>- [Tweaked] Under the hood stuff for main AO
    <br/>- [Tweaked] Under the hood stuff for side missions
    <br/>- [Tweaked] Under the hood stuff for side mission rewards
    <br/>- [Tweaked] Under the hood stuff for prio AA and arty objective
    <br/>- [Tweaked] Under the hood stuff for teleporting to the carrier
    <br/>- [Tweaked][Altis][Tanoa] Placements of the carrier
    <br/>- [Tweaked][Altis][Tanoa] Placements of things on the carrier
    <br/>- [Removed][Altis] Arsenal on the carrier"],
	["3.2.1", "
    <br/>- [Added] Random Huron camos
    <br/>- [Added] Billboards advertising AWE
    <br/>- [Added] Two new ground vehicle rewards
    <br/>- [Fixed] Destroyed radio towers now despawn
    <br/>- [Fixed] Incorrect link appeared when you spawn
    <br/>- [Fixed] [Malden] Le Port AO bugging out
    <br/>- [Tweaked] Pilot spawn restricted to pilots
    <br/>- [Tweaked] Under the hood stuff for Zeus
    <br/>- [Tweaked] Under the hood stuff for carrier AA
    <br/>- [Tweaked] Under the hood stuff for side missions
    <br/>- [Tweaked] Under the hood stuff for prio AA objective
    <br/>- [Tweaked] Under the hood stuff for blacklisting co-pilots
    <br/>- [Tweaked][Malden] Moved some stuff around in base"],
	["3.2.2", "
    <br/>Hotfix
    <br/>- [Fixed] Prio AA objective bugging out"],
	["3.2.3", "
    <br/>- [Added] New side mission rewards
    <br/>- [Added] New side mission, the old Kavala/Pyrgos CQC mission
    <br/>- [Added][Altis] Vehicle service station at FOB guardian
    <br/>- [Fixed] Side missions will not spawn on FOBs any more
    <br/>- [Fixed] Jet service notification displaying the wrong number
    <br/>- [Tweaked] Side mission rewards spawn rate"],
	["3.2.4", "
    <br/>- [Added] New priority objective, factory
    <br/>- [Tweaked] TK messages
    <br/>- [Tweaked] Under the hood things for Zeus
    <br/>- [Tweaked] Under the hood things for the CQC side mission
    <br/>- [Tweaked] Various other under the hood tweaks
    <br/>- [Fixed][Altis] AOs near FOB guardian bugging out"],
	["3.2.5", "
    <br/>- [Added] Actual FOB things to the FOBs
    <br/>- [Tweaked] AO spawn order
    <br/>- [Tweaked] CQC side mission
    <br/>- [Tweaked] Protect UN forces side mission
    <br/>- [Tweaked] Various things for the prio factory mission
    <br/>- [Tweaked] Multiple under the hood changes to several things"],
	["3.2.6", "
    <br/>- [Added] New sub-objective: HQ
    <br/>- [Added] Several new side mission rewards
    <br/>- [Added] 2 new side missions: militia camp and capture intel
    <br/>- [Tweaked] Main AO garrisoned infantry
    <br/>- [Tweaked] The way vehicles spawn in at FOBs
    <br/>- [Tweaked] General tweaks to several side missions
    <br/>- [Tweaked] General tweaks to main AO spawn handler
    <br/>- [Tweaked] Random loadout from the wasp (non-stealth)
    <br/>- [Tweaked] General tweaks to several behind the screen’s things
    <br/>- [Tweaked][Altis] FOB layout
    <br/>- [Tweaked][Altis] Vehicles that spawn at FOBs
    <br/>- [Fixed][Altis] AO bugging out"],
	["3.2.7", "
    <br/>- [Tweaked] Arty firing loop
    <br/>- [Fixed][Altis] FOB triggers not working as intended"],
	["3.2.8", "
    <br/>- [Tweaked] General tweaks to several behind the screen’s things
    <br/>- [Fixed] Arty not de-spawning"],
	["3.2.9", "
    <br/>- [Added] Respawnable transport van at base
    <br/>- [Added] Side mission reward: service van
    <br/>- [Tweaked] Arsenal blacklist
    <br/>- [Tweaked] Tweaked side mission code
    <br/>- [Tweaked] Random loadouts of vehicles tweaked
    <br/>- [Tweaked] Tweaked all the priority missions code
    <br/>- [Tweaked] Various minor tweaks to multiple things
    <br/>- [Fixed] several behind the screen bugs
    <br/>- [Fixed] hint spam at militia camp mission
    <br/>- [Fixed] spelling mistakes in search and rescue mission"],
	["3.3.0", "
    <br/>- [Added][Malden] service pads to FOBs
    <br/>- [Added] New side mission: rescue IDAP
    <br/>- [Added] New side mission: secure asset
    <br/>- [Added] New sub objective: goalkeeper
    <br/>- [Added] New sub objective: T-100 section
    <br/>- [Added] Unflip vehicle option, requires 4 people to use
    <br/>- [Added] Action that allows pilots to despawn damaged helis in base
    <br/>- [Added] A function that allows max 3 teamkills. On your 2nd teamkill you will receive a final warning. 10 minutes after a teamkill it will be forgotten and forgiven
    <br/>- [Tweaked][Altis] FOB design
    <br/>- [Tweaked] Pilot restriction code
    <br/>- [Tweaked] Various behind the screen tweaks
    <br/>- [Tweaked] The code for all the prio objectives
    <br/>- [Tweaked] Air- and ground-vehicle service script
    <br/>- [Tweaked] No shooting in base hint will display your name
    <br/>- [Tweaked] Spawn points of FOBs will now get the name of said FOB
    <br/>- [Tweaked] Various spelling mistakes corrected (and new ones made)
    <br/>- [Tweaked] Some hints have been replaced by a fancier looking box with text
    <br/>- [Tweaked] The code for all the side missions (except the secure intel mission)
    <br/>- [Fixed] Refuel option for engineers
    <br/>- [Fixed] No shooting in base hint will not show up when controlling UAVs or when using flares
    <br/>- [Removed] Side mission: secure chopper
    <br/>- [Removed][Altis] Some main AOs that were too close to FOBs"],
	["3.3.1", "
    <br/>- [Tweaked] Service script, rewrote the rearm section
    <br/>- [Tweaked] Vehicle unflip action.  Now allows for 4 player or a bobcat
    <br/>- [Fixed] Side missions not spawning
    <br/>- [Fixed] Save gear option not showing up
    <br/>- [Fixed] TK-script displaying wrong messages
    <br/>- [Fixed] Radio tower completion hint displaying wrong AO name format
    <br/>- [Fixed] (hopefully) Cache subobjective shouldn’t bug out and if it does the AO should still be completable"],
	["3.3.2", "
    <br/>- [Fixed] (hopefully) Side missions not spawning"],
	["3.3.3", "
    <br/>- [Fixed] Rearm script getting stuck in a loop when the vehicle has nothing to rearm
    <br/>- [Fixed] Several side missions not completing"],
	["3.3.4", "
    <br/>- [Added] Radio tower sub-obj will spawn with minefield
    <br/>- [Fixed] Side mission objective marker not despawning
    <br/>- [Tweaked] Unflip vehicle action range increased
    <br/>- [Tweaked] Radio tower jet made more deadly.
    <br/>- [Tweaked] Jets and UAVs don’t have a laser.  They will need to rely on infantry to designate things.
    <br/>- [Tweaked] Units spawned by the main AO.  Now: 1x MBT, 2x-4x Tigris, 2x-4x APC/IFV, 3x-5x car/MRAP, 8x normal inf group, 3x AA team, 3x AT team, 4x recon squad, max 15 garrisoned buildings in the center of the AO."],
	["3.3.5", "<br/>-several bug fixes"],
	["3.3.6", "
    <br/>- [Fixed] Error in cache sub-objective
    <br/>- [Fixed] Side mission doors not opening
    <br/>- [Fixed] Massive error spam in prio-AA objective
    <br/>- [Fixed] Side mission rewards not having refuel and flip actions
    <br/>- [Tweaked] Performance of TK-script increased
    <br/>- [Tweaked] Minimum required number of players for prio objective to spawn increased"],
	["3.3.7", "
    <br/>- [Added] Sling weapon script
    <br/>- [Added] I and A progress saver
    <br/>- [Added] Vanilla-based arsenal
    <br/>- [Added] Ghost hawk door script
    <br/>- [Added] Automatic server restarter
    <br/>- [Added] Option to add supply crates to helis
    <br/>- [Added] time multiplier for during night-time
    <br/>- [Added] Intel mechanic for urban cache side mission
    <br/>- [Added] Some checks to prevent some of the script-kids
    <br/>- [Added] Positive feedback system for prio missions (will prevent no prio mission spawning for prolonged periods of time)
    <br/>
    <br/>- [Fixed] Side mission spawning 2 rewards
    <br/>- [Fixed] Fixed ground service (hopefully)
    <br/>- [Fixed] Prototype tank side mission clean-up not running
    <br/>- [Fixed] Cache sub-objective hold action not working as intended
    <br/>
    <br/>- [Tweaked] Arsenal restrictions
    <br/>- [Tweaked] Init-scripts tweaked
    <br/>- [Tweaked] FOB-vehicle respawn timers
    <br/>- [Tweaked] HQ sub objective will now spawn jets
    <br/>- [Tweaked] Rewrote base AA for more performance
    <br/>- [Tweaked] Rescue pilot mission (changes for performance)
    <br/>- [Tweaked] Vehicle respawn script (changes for performance)
    <br/>- [Tweaked] The same side mission won't spawn 2 times in a row
    <br/>- [Tweaked] Sub objectives are now sub objectives of the main objective
    <br/>- [Tweaked] Research side mission won't spawn with documents anymore, only laptops
    <br/>- [Tweaked] Prio objectives will only spawn when there are at least 15 infantry on the server
    <br/>- [Tweaked] General tweaks, both for visuals and for performance to several scripts/functions/missions
    <br/>
    <br/>- [Removed] Derp arsenal
    <br/>- [Removed] Stomper, 2x prowler and 1 hunter HMG from base vehicle pool
    <br/>- [Removed] Custom vehicle HUD (the green names on the left side of the screen)"],
	["3.3.7.10", "
    <br/>- [Added] Tanks DLC vehicles as side mission rewards
    <br/>- [Added] Update arsenal to include MAAWS for all and medics have access to rifles
    <br/>- [Added] Update arsenal to include Vorona for AT
    <br/>- [Added] Update arsenal to include Rifles for medic
    <br/>
    <br/>- [Fixed] Arsenal issue present in 3.3.7.09
    <br/>
    <br/>- [Tweaked] Restarter code to ensure reliability
    <br/>
    <br/>- [Removed] VcomAI code"],
	["3.3.8", "
    <br/>- [Tweaked] Arsenal restrictions
    <br/>- [Tweaked] FSG and AT re-balance
    <br/>- [Added] Co-pilot seat without aircraft control for everybody"],
	["3.3.8.1", "
    <br/>Lukewarm hotfix.
    <br/>- You now respawn with your (automatically) saved gear again. Sorry for the inconvenience 3.3.8 caused there.
    <br/>- [Added] The extended passenger information HUD has been added to the diary / map settings.
    <br/>- [Added] The Sling Weapon and Ghost Hawk doors actions can now be toggled from the diary / map settings too.
    <br/>- Some of the invisible things have... changed. Can you feel it too? A few functions are now a few nano- or even milliseconds faster! They are also wearing new makeup."],
	["3.3.9", "
    <br/>- Hotfix for warlords update"],
	["3.3.10", "
    <br/>- Fixes to the previous hotfix.
    <br/>- Small fixes here and there"],
	["3.3.11", "
    <br/>- Security patch."],
	["3.3.12", "
    <br/>- [Added] a new role: rifleman LAT (one in each regular squad)
    <br/>- [Updated] the security patch.
    <br/>- [Updated] the teamkilling script.
    <br/>- [Updated] the default loadouts to fit the above-mentioned restrictions
    <br/>- [Updated] the units that are spawn by the AO.
    <br/>          T-140 and T-140K can now spawn as MBTs as well
    <br/>          Nyx (AT, autocannon and AA) can now spawn as IFVs/APCs as well
    <br/>- [Updated] the secure asset mission.
    <br/>          Added T-140, T-140K, Nyx AT, Nyx AA and Nyx autocannon as potential to secure assets
    <br/>- [Updated] the arsenal restrictions.
    <br/>          [Added]: ADR-97 SMGs to all roles that already has SMGs available
    <br/>          [Added]: LAT capabilities to certain roles (TL, SL, Engineer, Explosive Specialist, Rifleman LAT)
    <br/>          [Fixed]: FSG team leader now has access to the same weapons as other TLs as well as the FSG weapons
    <br/>          [Removed]: HAT capabilities from FSG (still has LAT and MAT capabilities + static HAT launchers)
    <br/>          [Removed]: weapons with OPFOR camouflage if a BLUFOR camouflaged alternative is available (not for all weapons)
    <br/>          [Removed]: OPFOR laser designator
    <br/>- [Fixed] missions spawning too close to FOBs
    <br/>- [Fixed] secure intel unit side mission (2nd decoy wasn't spawning)
    <br/>- [Removed] one AR slot in each regular squad"],
	["3.3.13", "
    <br/>- [Removed] a debug hint
    <br/>- [Tweaked] More tweaks to the security patch
    <br/>- [Tweaked] the spawn position of priority missions (they'll spawn closer to the AO)"],
	["3.3.14", "
    <br/>- [Fixed] bug in prio factory mission
    <br/>- [Fixed] bug in militia camp mission
    <br/>- [Fixed] bug in side mission rewards code
    <br/>- [Fixed] an error that was spamming client side RPTs
    <br/>- [Fixed] base AA script incorrectly displaying hints about carrier AA
    <br/>- [Tweaked] Small tweaks to the TK script to increase performance
    <br/>- [Tweaked] Further increased distance between bases and spawning missions (from 800 to 1500)
    <br/>- [Updated][Fixed] and fixes to the security patch"],
	["3.3.15", "
    <br/>- [Added] MAAWS mod 1 to the LAT role
    <br/>- [Fixed] missions spawning on bases
    <br/>- [Fixed] another error that was spamming client side RPTs"],
	["3.3.16", "
    Due to a bug that could not be located in 3.3.15 development was rolled back to 3.3.13 from where several fixes were reapplied.
    <br/>- [Fixed] base AA script incorrectly displaying hints about carrier AA
    <br/>- [Fixed] missions spawning on base/FOBs
    <br/>- [Fixed] security patch
    <br/>- [Fixed] small bug with reward vehicles
    <br/>- [Updated] TK script
    <br/>- [Tweaked] sub objectives for better performance"],
	["3.3.17", "
    <br/>- [Added] the MAAWS mod 1 to the LAT role again (fingers crossed that it doesn't break anything)
    <br/>- [Fixed] another error that was spamming client side RPTs (again)
    <br/>- [Added] Reapplied some fixes to base layout that got undone due to the previous update"],
	["3.3.18", "
    <br/>- [Added] Nyx AA to reward vehicles
    <br/>- [Added] discord invite link to this diary
    <br/>- [Added] flags to non-NATO respawning and reward vehicles
    <br/>- [Added] camonet, slat cages, ... to reward vehicles (reward will spawn with either camonet or slat cages, not both)
    <br/>- [Fixed] error in TK messages
    <br/>- [Tweaked] the rules
    <br/>- [Tweaked] reward frequency
    <br/>- [Tweaked] Disabled VON in command chat
    <br/>- [Tweaked] Slight tweak to admin and Zeus tools
    <br/>- [Tweaked] Slight tweak to pilot restriction code
    <br/>- [Tweaked] Slight tweak to base/carrier AA activation code"],
	["3.3.19", "
    <br/>- [Added] MB 4D AT/HMG; prowler AT and hunter AT to the reward pool
    <br/>- [Fixed] error in TK messages (hopefully for real this time)
    <br/>- [Fixed] a debug value that was never changed in the arty mission
    <br/>- [Fixed] a bug causing decoys not to spawn in secure intel mission
    <br/>- [Tweaked] Further tweaked reward frequency
    <br/>- [Tweaked] Loadouts now have the black mags for the black MX
    <br/>- [Tweaked] Improved enhanced t-100 reward (added a bit more ammo)
    <br/>- [Tweaked] Zeus/admin tools for these new rewards and added an extra hint
    <br/>- [Tweaked] Eased of gunner seat restrictions, anyone who has access to LATs or above has access to gunner seats of vehicles with launchers now"],
	["3.3.20", "
    <br/>- [Added] persistence for vehicle HUD preference
    <br/>- [Fixed] more errors in TK messages
    <br/>- [Fixed] bug in static weapon seat restriction
    <br/>- [Fixed] some message related to admin seat restrictions
    <br/>- [Tweaked] general code clean-up"],
	["3.3.21", "
    <br/>- [Added] some stuff to the admin/Zeus tools
    <br/>- [Tweaked] more code clean-up
    <br/>- [Tweaked] more code optimization
    <br/>- [Tweaked] everyone but pilots now have access to the underwater gun
    <br/>- [Tweaked] the mission now has a proper ending when the required number of AOs are captured
    <br/>- [Tweaked] ever so slightly increased the chance of molos airfield being the next AO when the AOs are up there
    <br/>- [Tweaked] the hint for side missions with friendly forces to differentiate between enemies killing the friendlies and players killing them
    <br/>- [Fixed] bug in AI waypoint script
    <br/>- [Fixed] bug in secure asset mission
    <br/>- [Fixed] bug in ground service script
    <br/>- [Fixed] potential bug in arsenal restriction code
    <br/>- [Fixed] some spelling mistakes (and probably made some more)
    <br/>- [Fixed] (side mission reward) GMG off road also getting a mortar
    <br/>- [Fixed] no goofing in base hint displaying while not shooting in base
    <br/>- [Removed] some (a lot of) obsolete code"],
	["3.3.22", "
    <br/>- [Added] sensor support for vehicles that support this
    <br/>- [Added] some more functionality to the admin and Zeus tools
    <br/>- [Fixed] bug in admin/Zeus tools
    <br/>- [Fixed] loading saved loadouts from the arsenal not working (hopefully)
    <br/>- [Fixed] protect friendly forces being able to fail and succeed at the same time
    <br/>- [Fixed] (hopefully) side mission research data showing an empty notification on completion
    <br/>- [Tweaked] base AA a bit
    <br/>- [Tweaked] the goalkeeper sub-objective
    <br/>- [Tweaked] base layout a little bit
    <br/>- [Tweaked] HQ subobj for performance
    <br/>- [Tweaked] how vehicles respawn to avoid abuse
    <br/>- [Tweaked] T-100 section sub-objective to a tank sub-objective
    <br/>- [Tweaked] backend code from main AOs and sub-objective
    <br/>- [Tweaked] some code to (hopefully) increase performance
    <br/>- [Tweaked] some stuff to rename the respawn point at main base
    <br/>- [Tweaked] Init scripts to get a slight increase in performance
    <br/>- [Tweaked] code for prio factory mission (for performance and readability)
    <br/>- [Tweaked] base and carrier AA, they will now turn their radar off when they go into cooldown
    <br/>- [Removed] friendly arty"],
	["3.3.23", "
    <br/>- [Added] 15 second delay between prio AA objective spawning and the AA turrets coming online
    <br/>- [Fixed] bug in prio AA mission
    <br/>- [Fixed] loadouts not reapplying after respawning
    <br/>- [Fixed] vehicles sometimes being slightly damaged when respawning
    <br/>- [Tweaked] base protection
    <br/>- [Tweaked] reward Xi’an is now grey and the pylons are removed, not just the ammo
    <br/>- [Tweaked] vehicle inventories will now be consistent in what it contains (no CSAT gear etc)"],
	["3.3.24", "
    <br/>- [Added] capture progress marker
    <br/>- [Added] map action to show how long it'll take for vehicles to respawn
    <br/>- [Fixed] vehicles spawning on top of sheds they're supposed to spawn under (hopefully)
    <br/>- [Fixed] fail message of secure asset mission incorrectly having the 'sub-objective update' title
    <br/>- [Tweaked] reward Tarus don't spawn with hex camo but black camo instead."],
	["3.3.25", "
    <br/>- [Fixed] arty not firing
    <br/>- [Fixed] whitelist for squad xml
    <br/>- [Fixed] bug with secure radar side mission
    <br/>- [Fixed] bug that occurs with arsenal sometimes
    <br/>- [Fixed] Last stand spawning apex slammer instead of a regular one
    <br/>- [Tweaked] security update
    <br/>- [Tweaked] main AO spawn function for performance
    <br/>- [Tweaked] arsenal restriction code to prevent abuse (from LH5)
    <br/>- [Tweaked] air service script so the VTOL doesn't have a 10-minute service + added checks for if the vehicles has already been serviced.
    <br/>- [Removed] obsolete code"],
	["3.3.26", "
    <br/>- [Added] Zeus ping limit
    <br/>- [Added] functionalities to the admin tools
    <br/>- [Tweaked] base layout slightly
    <br/>- [Tweaked] further security updates
    <br/>- [Tweaked] heli supply crate can now also be deployed on the ground
    <br/>- [Fixed] re-fuel function (hopefully)"],
	["3.3.27", "
    <br/>- [Added] admin tool functionality
    <br/>- [Added] ghosthawk guns are now locked by default
    <br/>- [Fixed] bug in TK script
    <br/>- [Fixed] ghosthawk guns not locking
    <br/>- [Fixed] militia camp mission action not working properly
    <br/>- [Fixed] spotters now have gillies like they're supposed to have
    <br/>- [Fixed] vehicles getting more flares than they're supposed to get
    <br/>- [Fixed] TK script not detecting people killing themselves correctly
    <br/>- [Fixed] bug in admin/Zeus tools caused by the previous security patch
    <br/>- [Fixed] several things not working due to a change in the latest update
    <br/>- [Tweaked] security patch
    <br/>- [Tweaked] Zeus ping limit code
    <br/>- [Tweaked] arsenal restriction code
    <br/>- [Tweaked] code clean-up and optimization
    <br/>- [Tweaked] no more floating H-barrier in base
    <br/>- [Tweaked] Paradrop crate action (time reduced)
    <br/>- [Tweaked] vehicle respawn should no longer be able to bug out
    <br/>- [Tweaked] statics on reward vehicles can no longer be disassembled
    <br/>- [Tweaked] replaced pilot billboard picture so it has a screenshot from Arma instead of GTA (thanks LH5)
    <br/>- [Tweaked] cache sub-objective charges planted hint now displays the name of the person who planted the charges
    <br/>- [Tweaked] overhauled how enemy jets and helis decide which players to attack.  A word of caution: if you shoot at a jet or heli, it's going to shoot back.
    <br/>- [Removed] obsolete code, functions, ...
    <br/>- [Removed] Apers mine-dispensers for security reasons"],
	["3.3.28", "
    <br/>- [Fixed] bug in TK-script
    <br/>- [Tweaked] Intel mission briefing text"],
	["3.3.29", "
    <br/>- [Added] More side mission rewards
    <br/>- [Added] Admin/Zeus tool functionality
    <br/>- [Added] Forward compatibility for arsenal restrictions for contact DLC
    <br/>- [Fixed] Bug in TK script
    <br/>- [Fixed] Random FOB vehicles not being random
    <br/>- [Fixed] Vehicles respawning on incorrect positions
    <br/>- [Tweaked] Side mission reward frequency
    <br/>- [Tweaked] Stuff to hopefully improve performance
    <br/>- [Removed] Unneeded FAQ entry
    <br/>- [Removed] Vehicle gunner seat and static weapon seat restrictions"],
	["3.3.30", "
    <br/>- [Fixed] Minor bug in admin tools
    <br/>- [Fixed] Minor bug caused by making the mission HC compatible
    <br/>- [Tweaked] Code to hopefully fix units not spawning when HC is being used"],
	["3.3.31", "
    <br/>- [Fixed] units in AO not despawning on AO completion
    <br/>- [Tweaked] general code clean-up
    <br/>- [Tweaked] Code to hopefully fix units not spawning when HC is being used"],
	["3.3.32", "
    <br/>- [Added] Some missing optics
    <br/>- [Added] Tractor as a side mission reward
    <br/>- [Fixed] arsenal loadouts not being able to be loaded
    <br/>- [Tweaked] backend code
    <br/>- [Tweaked] Admin/Zeus tools"],
	["3.3.33", "
    <br/>- [Fixed] some minor issues from HC compatibility
    <br/>- [Fixed] enemy vehicles being unlocked and friendly vehicles being locked
    <br/>- [Tweaked] AI group behaviour
    <br/>- [Tweaked] colour of certain side mission rewards
    <br/>- [Tweaked] earplug code to hopefully fix the reported issue"],
	["3.3.34", "
    <br/>- [Added] Side mission rewards will be spawned at the side mission but moved back to base if nobody claims it within 10 minutes
    <br/>- [Fixed] Main AO clean-up
    <br/>- [Fixed] Zeus related code
    <br/>- [Fixed] AO helis patrolling the wrong area
    <br/>- [Fixed] Prio missions spawning way too far
    <br/>- [Fixed] Outdated things in Zeus/admin tools
    <br/>- [Fixed] UAV crews not listening to new UAV operators (hopefully)
    <br/>- [Tweaked] Reward t-140 camo
    <br/>- [Tweaked] Mine detector for everyone
    <br/>- [Tweaked] General code clean-up/improvements
    <br/>- [Tweaked] FOB names will no longer have the underscore in the hint
    <br/>- [Tweaked] Halved tractor reward spawn frequency + mounted a .50 to its roof
    <br/>- [Tweaked] AT specialists can no longer get LAT and MAT weapons out of the arsenal (they can still use them; they just can't get them out of the arsenal)
    <br/>- [Removed] obsolete code"],
	["3.3.35", "
    <br/>- [Fixed] main AO not spawning on server start
    <br/>- [Tweaked] HQ subobjective (randomized officer spawn pos)
    <br/>- [Tweaked] increased distance from the side objective a reward spawns to avoid potentially blowing those rewards up"],
	["3.3.36", "
    <br/>- [Tweaked] Join hint
    <br/>- [Tweaked] Admin tools
    <br/>- [Tweaked] Arsenal restrictions (added missing bipods, removed mar-10 from snipers)
    <br/>- [Tweaked] Reward spawn to prevent people being able to get in before the reward is moved to the side mission.
    <br/>
    <br/>- Created a TFAR version of I&A3"],
	["3.3.37", "
    <br/>- [Added] MAAWS 55 HEAT round and extra uniform to the arsenal
    <br/>- [Fixed] Main AO not spawning on server start (attempt 2)
    <br/>- [Tweaked] HQ sub objective now has mines
    <br/>- [Tweaked] General code clean-up/improvement
    <br/>- [Removed] Obsolete code"],
	["3.3.38", "
    <br/>- [Fixed] Minor bug in the admin/Zeus tools
    <br/>- [Fixed] Minor bug in side mission reward spawn
    <br/>- [Fixed] Mines at HQ sub-objective being undetectable
    <br/>- [Fixed] Main AO not spawning on server start (attempt 3)
    <br/>- [Fixed] Lush bipod not being in the arsenal due to incorrect class name (thanks LH5)
    <br/>- [Tweaked] Jet and heli numbers for the main AO
    <br/>- [Tweaked] Secure intel (unit) side mission, slightly weighed down the officer
    <br/>- [Tweaked] Added some extra checks to prevent the goalkeeper from spawning as blufor
    <br/>- [Tweaked] New side mission cannot be the same as the previous 2 instead of previous one now"],
	["3.3.39", "
    <br/>- [Fixed] Minor bug in the admin/Zeus tools
    <br/>- [Fixed] Some main AO units not despawning
    <br/>- [Fixed] Potential exploit of arsenal restrictions
    <br/>- [Fixed] Ammo crate (subobj) spawning under ground
    <br/>- [Tweaked] Added MAAWS ammo to the heli supply crate
    <br/>- [Tweaked] HQ subobj; fixed floating H-barriers and both the officer and building now have to be destroyed (officer first, then building)"],
	["3.3.40", "
    <br/>- [Fixed] Units from subobj not being cleaned up
    <br/>- [Fixed] Side mission rewards sometimes spawning locked
    <br/>- [Fixed] Main AO not spawning on server start (attempt 4)
    <br/>- [Tweaked] Reduced the amount of jets upon AO spawn slightly
    <br/>- [Tweaked] Side mission reward spawn to prevent them from blowing up upon spawn
    <br/>- [Tweaked] Partially reverted changes to secure intel (unit) side mission from update 3.3.38"],
	["3.3.41", "
    <br/>- [Fixed] FOBs not spawning
    <br/>- [Tweaked] Lowered Nyx side mission reward spawn chance"],
	["3.3.42", "
    <br/>- [Fixed] Main AO not spawning on server start (attempt 5)
    <br/>- [Tweaked] Member join hint whitelist"],
	["3.3.43", "
    <br/>- [Added] Extra logging
    <br/>- [Added] New side mission reward: Qilin AT
    <br/>- [Added] Promet DMR to the weapons pool for marksmen
    <br/>- [Added] Action on all arsenal to revive and heal players that are close
    <br/>- [Fixed] FOB jets not being random
    <br/>- [Fixed] Minor bug in the admin tools
    <br/>- [Fixed] Certain units not despawning
    <br/>- [Fixed] Not being able to pick certain weapons up from enemies even though they're in the arsenal
    <br/>- [Tweaked] General code clean-up, improvements and fixes
    <br/>- [Tweaked] Tweaks to prevent side mission intel recovered hint
    <br/>- [Tweaked] No goofing in base hint will now also show up when activating mines
    <br/>- [Tweaked] APERS bounding mines can now also spawn at both the HQ and RT subobjectives
    <br/>- [Removed] Obsolete code"],
	["3.3.44", "
    <br/>- [Fixed] Vehicle respawn
    <br/>- [Fixed] 2 camos of a suppressor not being available
    <br/>- [Tweaked] Goalkeeper from subobj will now be green instead of grey"],
	["3.3.45", "
    <br/>- [Added] Action to load your previously saved loadout
    <br/>- [Fixed] Some RPT spam
    <br/>- [Fixed] Heli despawn action
    <br/>- [Fixed] Spelling mistakes (and made new ones)
    <br/>- [Fixed] Some stuff not despawning when mission completes
    <br/>- [Tweaked] Prio factory win condition
    <br/>- [Tweaked] Small tweak to admin/zeus tools
    <br/>- [Tweaked] Removed APERS bounding mines again
    <br/>- [Tweaked] Added error handling in a side mission
    <br/>- [Tweaked] Randomized the appearance of some vehicles
    <br/>- [Tweaked] Changed transport van in base to an ambulance
    <br/>- [Removed] Obsolete code"],
	["3.3.46", "
    <br/>- [Added] Armed xi'an to the side mission reward pool
    <br/>- [Fixed] Some RPT spam
    <br/>- [Tweaked] GH will now also have sand and tropic camo
    <br/>- [Tweaked] Factory task will now complete upon destroying the building
    <br/>- [Tweaked] The jet will not engage friendlies too close to the FOBs/base"],
	["3.3.47", "
    <br/>- [Added] Xi'an (unarmed) added to FOB Martian respawn pool
    <br/>- [Fixed] Bug with TK script
    <br/>- [Fixed] Bug with certain GH texture
    <br/>- [Fixed] FSG squad leader arsenal restrictions
    <br/>- [Fixed] Spelling mistakes (and probably made some new ones)
    <br/>- [Fixed] The other versions of the MAR-10 are now also avaible for snipers
    <br/>- [Tweaked] Copilot taking control fully disabled
    <br/>- [Removed] Pawnee from FOB Martian respawn pool"],
	["3.3.48", "
	<br/>- [Added] para-military uniforms have been added to the arsenal
	<br/>- [Fixed] Vehicle seat restrictions
	<br/>- [Fixed] Teleportation inconsistencies
	<br/>- [Fixed] Enemy firing at their own goalkeeper
	<br/>- [Tweaked] Code cleanup
	<br/>- [Tweaked] Cleanup script
	<br/>- [Tweaked] TK detection script
	<br/>- [Removed] Code that wasn't working
	"],
	["3.3.49", "
    <br/>- [Fixed] Teleportation not working at FOBs
    <br/>- [Tweaked] Code cleanup
    "],
    ["3.3.50", "
    <br/>- [Fixed] Various fixes and improvements
    "],
    ["3.3.51", "
    <br/>- [Added] LDF barret
    <br/>- [Fixed] Various fixes and improvements
    <br/>- [Fixed] Typo's (and probably made some new ones)
    <br/>- [Fixed] Teleportation to pilot spawn working for non-pilots
    <br/>- [Tweaked] Code cleanup
    <br/>- [Tweaked] Guardian LZ layout
    <br/>- [Removed] Obsolete code
    "],
    ["3.3.52", "
    <br/>- [Added] Shemags have been added to the arsenal
    <br/>- [Fixed] Safezone positioning
    <br/>- [Fixed] Too many jets spawning
    <br/>- [Fixed] Extreme weather not being changed
    <br/>- [Fixed] Typo's (and probably made some new ones)
    <br/>- [Fixed] Jets orbiting old AOs instead of current one
    <br/>- [Tweaked] TK script
    "],
	["3.3.53", "
	<br/>- [Added] Heavy AT teams to AO enemies
	<br/>- [Added] Gendermerie stuff and new .50s have been added to the arsenal
	<br/>- [Fixed] AA-Buzzard pylon loadout not being realistic enough
	<br/>- [Fixed] Secure asset side objective fail condition not being triggered in certain cases
	"],
	["3.3.54", "
	<br/>- [Added] Chemlight actions
	<br/>- [Tweaked] Back-end logging
	<br/>- [Tweaked] Arsenal restrictions
	"],
	["3.3.55", "
    <br/>- [Fixed] Bug in gear restirctions
    <br/>- [Fixed] Tank section subobjective not being able to complete sometimes
    <br/>- [Fixed] Various other small bugs
    "],
    ["3.3.56", "
    <br/>- [Fixed] Bug in tank sectin subobjective
    <br/>- [Fixed] Various other small bugs
    "],
    ["3.3.57", "
    <br/>- [Fixed] Prio arty not cleaning up properly
    "],
    ["3.3.58", "
    <br/>- [Added] New arsenal items
    <br/>- [Tweaked] Typo in tank subobj
    <br/>- [Tweaked] Suboj reinforcements
    <br/>- [Tweaked] Subobj HQ window is now closed
    "],
    ["3.3.59", "
    <br/>- [Added] Enhanced t-140 and t-140k side mission rewards
    <br/>- [Tweaked] Minimum mission spawn distance
    <br/>- [Tweaked] Cleanup script (Will not delete backpacks near you)
    <br/>- [Fixed] Revive action (on arsenal) not working
    <br/>- [Fixed] Slingloaded cargo desyncing and detaching
    <br/>- [Fixed] Chemlight action duplicating in certain situations
    <br/>- [Removed] Some Aos near Abdera airfield that were too close together
    "],
    ["3.3.60", "
    <br/>- [Tweaked] Optimized cleanup script
    <br/>- [Tweaked] Chemlight attachment script
    "],
    ["3.3.61", "
    <br/>- [Fixed] AOs getting stuck
    <br/>- [Fixed] Cleanupscript not working properly
    "],
    ["3.3.62", "
    <br/>- [Added] Battle bus side mission reward
    "],
    ["3.3.63", "
    <br/>- [Fixed] Script error in function that was called on respawning vehicles and rewards
    "],
    ["3.3.64", "
    <br/>- [Added] Forward compatibility for future side mission(s)
    <br/>- [Tweaked] Tweaked chemlight attach script
    <br/>- [Tweaked] Free IDAP side mission defenders no longer have explosives
    <br/>- [Tweaked] Mora reward vehicle will spawn with Livonia camo instead of AAF camo
    <br/>- [Fixed] Enhanced t-140 reward not spawning correctly
    "],
    ["3.3.65", "
    <br/>- [Added] Zeus Down/Revive hotkeys
    <br/>- [Added] Ability for pilots to repair/refuel their ship
    <br/>- [Added] Reward vehicles moved back to reward area when abandoned
    <br/>- [Tweaked] Arsenal setup scripts
    <br/>- [Tweaked] Artillary prio mission
    <br/>- [Tweaked] CSAT APC/AA/IFV reward cosmetics
    <br/>- [Tweaked] Intel sidemission groupnames
    <br/>- [Tweaked] Disable Main OAs that are almost overlapping
    <br/>- [Tweaked] Task and Loadingscreen image sizes
    <br/>- [Tweaked] AAA Prio mission optimizations
    <br/>- [Fixed] MainAO HQ building ruins not getting deleted
    <br/>- [Fixed] Error trying to find suitable position for HQ Coast sidemission
    <br/>- [Fixed] Items getting past Arsenal Restrictions on respawn
    "],
    ["3.3.66", "
    <br/>- [Added] CBRN Radiological sidemission
    <br/>- [Added] Enemy CAS/CAP aircraft now has random loadouts
    <br/>- [Added] Removal of bodies from vehicles on player respawn/disconnect
    <br/>- [Tweaked] Prio mission Arty firing interval and rounds
    <br/>- [Tweaked] Spartan/Praetorian rewards
    <br/>- [Tweaked] MainAO HQ ruins cleanup
    <br/>- [Tweaked] Inventory warnings about unusable items for some roles
    <br/>- [Fixed] Sidemission Militia Camp not being able to complete
    <br/>- [Fixed] Manually spawned rewards not being moved back to base when abandoned
    <br/>- [Fixed] Explosives dropped in/near base not getting removed
    <br/>- [Fixed] BattleBus statics not being properly aligned
    "],
    ["3.3.67", "
    <br/>- [Added] Static weapon cleanup (no player within 500m)
    <br/>- [Added] Enhanced BTR-K Kamysh
    <br/>- [Added] SPAR-16 and MXC carbines for pilots
    <br/>- [Added] Disable assembling Static Weapons near Base/FOBs (300m)
    <br/>- [Added] Compact NVGs (green) and Avenger Helmet (green)
    <br/>- [Tweaked] Position finding overhaul for Side and Prio missions
    <br/>- [Tweaked] CBRN Radiological sidemission (Guards, Awareness, Damage)
    <br/>- [Tweaked] Reworked the way pilots can repair their ship (Heli/VTOL only)
    <br/>- [Tweaked] Main AO Radiotower ruins now stay until AO finishes
    <br/>- [Tweaked] How placing explosives at base gets caught
    <br/>- [Tweaked] Globalize Pylon loadouts on aircrafts
    <br/>- [Fixed] Gear and Seat restriction messages
    <br/>- [Fixed] Sidemission HQ Coast boat had patrol route on land, now patrols in water
    <br/>- [Fixed] Normalize skills for all AI to adhere to mission settings
    <br/>- [Fixed] How dead players gets removed/ejected from vehicles
    <br/>- [Removed] SDAR from Sniper, Spotter, FSG, AUR and Marksman roles
    <br/>- [Removed] LAT from Engineer, FSG and Explosive Spec. roles
    "],
    ["3.3.68", "
    <br/>- [Added] Zeus Prio/Side exclusion zones
    <br/>- [Added] Zeus rewards dialog
    <br/>- [Added] Main AO subobjective: Command and Control
    <br/>- [Added] Main AO subobjective: Communications Hub
    <br/>- [Added] Steve's nephew Steve to FOB Last Stand
    <br/>- [Added] Steve's distant cousin Steve to FOB Marathon
    <br/>- [Added] Functionality for mission persistance
    <br/>- [Tweaked] BLUFOR vehicle customization scripts
    <br/>- [Tweaked] Arsenal/item restriction scripts
    <br/>- [Tweaked] Pilot and engineer refuel actions
    <br/>- [Tweaked] Dead player body ejection from vehicles
    <br/>- [Removed] CAS helis from Main AO
    <br/>- [Removed] Main AO subobjective: HQ Building
    <br/>- [Removed] Main AO subobjective: Supply Cache
    <br/>- [Removed] Infantry and Heli CAS from Prio: Factory
    "],
    ["3.3.69", "
    <br/>- [Added] FAQ for CBRN sidemission
    <br/>- [Added] Zeus spawned units gets mission skills
    <br/>- [Added] Main AO SubObj task pictures
    <br/>- [Tweaked] Main AO SubObj comositions
    <br/>- [Tweaked] Available Arsenal items
    <br/>- [Tweaked] Allowed mods info
    <br/>- [Tweaked] Pilot and engineer refuel actions
    <br/>- [Tweaked] Heli CAS now uses same engagement script as Jets
    <br/>- [Tweaked] CuratorObjectPlaced eventhandlers
    <br/>- [Tweaked] Don't run generalVehicleSettings on Static Weapons
    <br/>- [Tweaked] Main AO SubObj occurrence (every 3 times)
    <br/>- [Tweaked] Sidemission occurrence (every 6 times)
    <br/>- [Fixed] Sidemission reward descriptions
    <br/>- [Fixed] Offroad AT vehicle customization
    <br/>- [Fixed] Gorgon vehicle customization
    <br/>- [Fixed] Error in Priority AA mission
    <br/>- [Fixed] Zeus spawned units now gets transferred to Headless client
    <br/>- [Fixed] CBRN sidemission required gear logic
    "],
    ["3.3.70", "
    <br/>- [Added] Vehicle Repair/Rearm/Refuel pads now handles attached turrets
    <br/>- [Added] Safe delete function
    <br/>- [Added] Zeus hotkey to unflip vehicle (Shift+F)
    <br/>- [Added] Zeus hotkey for vehicle repair/rearm/refuel (Shift+R)
    <br/>- [Tweaked] Zeus assignment
    <br/>- [Tweaked] Vehicles no longer respawn if close to any base/FOB
    <br/>- [Tweaked] Vehicle positions at FOB Marathon (Stadium)
    <br/>- [Tweaked] BLUFOR Shikra loadouts
    <br/>- [Tweaked] Reward vehicle spawn positions
    <br/>- [Tweaked] OPFOR jet spawning positions
    <br/>- [Tweaked] Unify skins for friendly OPFOR air assets (Grey/GreyHex)
    <br/>- [Tweaked] Ghosthawk turret actions
    <br/>- [Tweaked] Backend logging
    <br/>- [Tweaked] Added initial timer before Artillery starts engaging
    <br/>- [Fixed] Zeus spawned units transfer to HC
    <br/>- [Fixed] Copilot controls in helis/VTOLs
    <br/>- [Fixed] Heli/plane missing weapons related to incompatible weapons
    <br/>- [Fixed] Rewards with attached turrets now gets destroyed when turret is killed
    <br/>
    <br/> Hotfix 1
    <br/>- [Tweaked] Added initial delay in SubObjs Command and Comms
    <br/>- [Fixed] Zeus assignment
    <br/>
    <br/> Hotfix 2
    <br/>- [Fixed] Error in welcomeTitle function halting initPlayerLocal/onPlayerRespawn
    "],
    ["3.3.71", "
    <br/>- [Added] Admin menu ZEN module unlock/lock
    <br/>- [Fixed] Player initialization
    <br/>- [Fixed] Safe delete function pasta
    <br/>- [Fixed] Zeus Admin channel assignment
    <br/>- [Fixed] Zeus assignment logging
    <br/>- [Tweaked] CBRN sidemission task not getting deleted
    <br/>- [Tweaked] CBRN sidemission distance checking (no longer 2D)
    <br/>- [Tweaked] More ways to prevent explosives near base
    <br/>- [Tweaked] Artillery priomission code cleanup
    <br/>
    <br/> Hotfix 1
    <br/>- [Fixed] Artillery priomission cooldown
    <br/>- [Fixed] Zeus interface hotkey activation
    <br/>- [Tweaked] Force respawn uninitialized players
    <br/>- [Tweaked] Zeus module initialization params
    <br/>
    <br/> Hotfix 2
    <br/>- [Removed] Force respawn uninitialized players
    "],
    ["3.3.72", "
    <br/>- [Added] Added discord rich presence compatibility (see forums.ahoyworld.net for more info)
    <br/>- [Added] Debug messages to figure out why people are spawning in the ocean
    <br/>- [Fixed] Some script errors
    <br/>- [Fixed] Arty computer logic
    <br/>- [Tweaked] Camp layout of militia camp side mission
    <br/>- [Removed] Unneeded debug messages
    "],
    ["3.3.73", "
    <br/>- [Added] Discord rich presence
    <br/>- [Added] Transport heli to FOB Guardian
    <br/>- [Added] Vanbulance to FOB Guardian
    <br/>- [Added] FOB vehicle randomization
    <br/>- [Added] Main AO garrison building blacklist
    <br/>- [Added] Allow storing weapon in backpack
    <br/>- [Added] Enhancements based on Main AO type
    <br/>- [Added] Drone despawn action for UAV Op
    <br/>- [Added] Homebase to vehicle respawn timer list
    <br/>- [Fixed] Ghosthawk turret action
    <br/>- [Fixed] Main AO Tank SubObj cleanup
    <br/>- [Tweaked] Randomization of OPFOR vehicle appearances
    <br/>- [Tweaked] Pylon loadout function
    <br/>- [Tweaked] OPFOR unit definitions for Main AO, Side and Prio
    <br/>- [Tweaked] Vehicle beacon/sirens
    <br/>- [Tweaked] Vehicle respawn/despawn
    <br/>- [Tweaked] Reward vehicle pool
    <br/>- [Tweaked] Main AO selection
    <br/>- [Tweaked] Allow AT to pick up enemy LAT launchers
    <br/>- [Removed] Twin 20mm cannon from Orca CAS
    <br/>
    <br/> Hotfix 1
    <br/>- [Fixed] Main AO HC spawning
    "],
    ["3.4.00", "
    <br/><font size='16'>-Cam Loa Nam release</font>
    <br/>
    <br/>- [Tweaked] AO init
    <br/>- [Tweaked] Main AO selection
    <br/>- [Tweaked] How the code is structred in the mission
    <br/>- [Tweaked] Patrol script water patrol compatibility
    <br/>- [Tweaked][Altis] FOB vehicle placement
    "],
    ["3.4.01", "
    <br/>- [Added] Ability to see which AOs have been captured (map > settings > AO Markers)
    <br/>- [Added][Cam Loa Nam] Bicycles to main base
    <br/>- [Added][Cam Loa Nam] FOB Fox and FOB Leopard
    <br/>- [Fixed][Cam Loa Nam] Carrier jet having the wrong loadout
    <br/>- [Tweaked][Cam Loa Nam] Main base design
    <br/>- [Tweaked][Cam Loa Nam] Night time time multiplier
    <br/>- [Tweaked][Cam Loa Nam] AO reinforcement helicopters
    <br/>- [Tweaked][Cam Loa Nam] Gave flare launcher to everyone
    "],
    ["3.4.02", "
    <br/>- [Tweaked] How certain side missions are spawned in
    <br/>- [Fixed][Cam Loa Nam] Whitelisted some missing arsenal items
    <br/>- [Fixed][Cam Loa Nam] Pilots being unable to repair helicopters
    <br/>- [Tweaked][Cam Loa Nam] Enabled side missions
    <br/>- [Tweaked][Cam Loa Nam] Ejection seat added to cleanup script
    <br/>- [Removed][Cam Loa Nam] Removed grenades and CS gas from helicopters
    "],
    ["3.4.03", "
    <br/>- [Added] Destroyer side mission
    <br/>- [Added] Map param to remove overcast at night (off on altis, on on Cam Loa Nam)
    <br/>- [Fixed] Prio arty ammo truck not being cleaned up
    <br/>- [Fixed] Jets on which the ejection seat was used not being cleaned up
    <br/>- [Tweaked] Made tank platoon subobjective compatible for all maps
    <br/>- [Tweaked] Weapon shipment side mission: civies are now more random
    <br/>- [Tweaked] Range from the center at which squads will patrol in the main AO
    <br/>- [Tweaked] Side missions will spawn a given distance away from a base or FOB
    <br/>- [Tweaked] Expanded the garrison blacklist for the main AO to include prisoner cages
    <br/>- [Tweaked] AO garrison: buildings will have a max garrison of 50%, max 40 garrison units will be created
    <br/>- [Added][Altis] Prairie Fire billboard
    <br/>- [Tweaked][Cam Loa Nam] Changed classnames of player units
    <br/>- [Tweaked][Cam Loa Nam] Infantry can be copilot in the AH-1 and UH-1
    <br/>- [Tweaked][Cam Loa Nam] Set mission date to have a full moon
    <br/>- [Tweaked][Cam Loa Nam] Main base layout (just a bit this time)
    <br/>- [Tweaked][Cam Loa Nam] AA weapons of F4s are assigned to the copilot again
    <br/>- [Tweaked][Cam Loa Nam] Default vehicle loadouts now include backpacks and flare launchers
    <br/>- [Tweaked][Cam Loa Nam] Arsenal restriction: Added mission weapon for grenadier and more face and headgear
    <br/>- [Removed][Cam Loa Nam] Seahorse from the side mission rewards list
    "],
    ["3.4.04", "
    <br/>- [Added] Taru pod functionality
    <br/>- [Fixed] Copy paste error in vehicle initialization
    <br/>- [Tweaked] Destroyer spawn script
    <br/>- [Tweaked] Enemies that can be left in an AO when it completes made map specific
    <br/>- [Added][Cam Loa Nam] More AOs and FOBs
    <br/>- [Tweaked][Cam Loa Nam] Enemy weapons can now be used by the recon squad
    <br/>- [Tweaked][Cam Loa Nam] Enemy weapons can now be picked up in the field by any unit
    "],
    ["3.4.05", "
    <br/>- [Fixed] Typo
    <br/>- [Fixed] Briefing for rescue pilot mission
    <br/>- [Fixed] Destroyer not despawning on completion
    <br/>- [Tweaked] Radio tower subobj can now spawn on all maps
    <br/>- [Added][Cam Loa Nam] More AOs
    <br/>- [Tweaked][Cam Loa Nam] Missing AK ammo added to arsenal
    <br/>- [Tweaked][Cam Loa Nam] RKG-3 has been added to the arsenal
    "],
    ["3.4.06", "
    <br/>- [Added] Disclaimer message when entering a CAP/CAS/FSG asset
    <br/>- [Added] Cleanup of player spawned drones when UAV disconnects
    <br/>- [Added][Altis] Fortifications for garrisoned building
    <br/>- [Fixed] Anti-Air Artillery Prio cleanup
    <br/>- [Fixed] Destroyer sidemission spawning on land
    <br/>- [Fixed] Position finding function parameters
    <br/>- [Fixed] Milita Camp sidemission ending prematurely
    <br/>- [Tweaked] Main AO fortifications set to invulnerable
    <br/>- [Tweaked] Repair/Refuel/Unflip vehicle actions
    <br/>- [Tweaked] Taru Pod attachment
    <br/>- [Tweaked] Destroyer sidemission
    <br/>- [Tweaked] SubObj Tanksection spawning
    <br/>- [Tweaked] Main AO garrison faction based on AO type
    <br/>- [Tweaked] Mission positioning blacklist functionality
    <br/>- [Tweaked] Airframe pylon function
    <br/>- [Tweaked][Altis] Rewards list
    <br/>- [Tweaked][Altis] Allow AT to pick up LAT launchers
    <br/>- [Removed][Altis] Ability to slingload the Taru Pods at FOB Guardian
    "],
    ["3.4.07", "
    <br/>- [Added] Disclaimer message when opening UAV Terminal
    <br/>- [Added] Chance for ATGMs on UAVs
    <br/>- [Added] Next AO hint and spawn delay
    <br/>- [Added] Revive actions for medical vehicles
    <br/>- [Added] Backend Discord functionality
    <br/>- [Added][Altis] Mainbase teleporter to docks
    <br/>- [Added][Altis] Main AO SubObj Mortar Team
    <br/>- [Added][Altis] Main AO SubObj AA Fortification
    <br/>- [Added][Altis] Main AO SubObj AAA Fortification
    <br/>- [Fixed] Sidemission Destroyer not despawning
    <br/>- [Fixed] Downed player medical icon Z position
    <br/>- [Tweaked] Sidemission SecureAsset holdaction range
    <br/>- [Tweaked] Enemy CAS jet type probability
    <br/>- [Tweaked] Abandoned vehicles moved to spawnpoint get health and fuel
    <br/>- [Tweaked] Repair/Refuel actions
    <br/>- [Tweaked] Supplycrate contents and drop actions
    <br/>- [Tweaked][Altis] Main AO garrisoned building set to indestructible
    <br/>- [Tweaked][Altis] Helicopter respawn delay increased (2 -> 5 min.)
    <br/>- [Tweaked][Altis] Main AO SubObj Comms nearObjects range
    <br/>- [Removed] Deprecated defines
    "],
    ["3.4.08", "
    <br/>- [Added] Prio mission Depot
    <br/>- [Added] Prio mission Enemy F.A.R.P
    <br/>- [Added] Player settings menu ([Home] key)
    <br/>- [Fixed] Taru Pod destruction eventhandler
    <br/>- [Fixed] Main AO SubObj Mortar disassembly
    <br/>- [Fixed] Vehicle respawn script Taru Pod handling
    <br/>- [Fixed] Don't draw medic icon on self if down
    <br/>- [Tweaked] Main AO SubObj Mortar firing loop
    <br/>- [Tweaked] Main AO SubObj repetition
    <br/>- [Tweaked] Sidemission Destroyer despawn
    <br/>- [Tweaked] Vehicle unflip action
    <br/>- [Tweaked] Main AO garrison buildings
    <br/>- [Tweaked] Seat restrictions (player moved to cargo if seat is restricted)
    <br/>- [Tweaked] Re-enabled Main AO heli spawns
    <br/>- [Tweaked] AO reinforcement logic overhaul (Prio Factory/Depot/F.A.R.P)
    <br/>- [Tweaked] Enemy air engagement function
    <br/>- [Tweaked] Vehicle engine off if driver is killed/gets out/disconnects
    <br/>- [Tweaked] Dead player bodies deletion from vehicles on disconnect
    <br/>- [Tweaked] Main AO SubObjs Command and Comms
    <br/>- [Tweaked] Prio mission repetition
    <br/>- [Removed] Prio mission Vehicle Factory
    <br/>- [Removed] Prio mission Heli Factory
    <br/>- [Removed] Prio mission Infantry Factory
    "],
    ["3.4.09", "
    <br/>- [Added] Respawn vehicle admin option
    <br/>- [Added] Sidemission Destroy Weapons Shipment: Officers/SQLs/TLs now drop intel
    <br/>- [Added][Altis] Main AO faction randomization
    <br/>- [Fixed] Enemy F.A.R.P not spawning any CAS helis
    <br/>- [Fixed] CAS heli patrol script
    <br/>- [Fixed] Prio Depot destruction timer
    <br/>- [Tweaked] Size of Settings menu increased
    <br/>- [Tweaked] Hotkey for Settings menu (Custom control 'Use Action 20')
    <br/>- [Tweaked] Vehicle engine shut off when player dies/disconnects
    <br/>- [Tweaked] Aiming coefficient lowered to 70% of Vanilla
    <br/>- [Tweaked] SubObj Depot holdaction distance increased
    <br/>- [Tweaked] Enemy fleeing value set to 0 (disabled)
    <br/>- [Tweaked][Altis] F.O.B H-Barrier and helipads adjusted
    <br/>- [Tweaked] Sensor and datalink settings for vehicles
    <br/>- [Tweaked] Sidemission reward weight and blacklist
    <br/>- [Tweaked] Backend code for how factions are handled
    <br/>- [Tweaked] Backend code for how enemy groups and vehicles are spawned
    <br/>- [Tweaked] Sidemission Destroyer cleanup code
    "],
    ["3.4.10", "
    <br/>- [Added] Mk21 Centurion mounted Mora
    <br/>- [Added] Workaround for respawn GUI not loading at mission start
    <br/>- [Fixed] Sidemission Free IDAP cleanup
    <br/>- [Fixed] Main AO remaining enemy logic
    <br/>- [Fixed] Main AO name
    <br/>- [Tweaked] Normalize Enhanced Rewards magazine count
    <br/>- [Tweaked] Garrison building blacklist
    <br/>- [Tweaked] Enemy group compositions
    <br/>- [Tweaked] Chemlight attach/detach actions
    "],
    ["3.4.11", "
    <br/>- [Added] Ability for Snipers, Marksmen and Autoriflemen to cut grass
    <br/>- [Added] Earplug attenuation
    <br/>- [Added] Pilot airframe limitations
    <br/>- [Added] Pilot role duty description on join
    <br/>- [Added] Ability to load supplybox at Base/FOB helipads (Huron/GH/Orca/Hellcat)
    <br/>- [Fixed] Main AO SubObj Comms HQ made invincible
    <br/>- [Fixed] Prio mission marker cleanup
    <br/>- [Fixed] Main AO SubObj Mortar attacking nearby Base/FOBs
    <br/>- [Tweaked] Backend logging
    <br/>- [Tweaked] Show asset disclaimers each session
    <br/>- [Tweaked] Arsenal items for Prairie Fire DLC v1.1
    <br/>- [Tweaked] Increased Grayhawk UAV respawn timers
    <br/>- [Tweaked] AI patrol function
    <br/>- [Tweaked] Mission params and global variables
    <br/>- [Tweaked] Disable simulation when CAP/CAS disclaimer shown
    <br/>- [Tweaked] Show CBRN sidemission threat meter only if exposed
    <br/>- [Tweaked] Use sidemission Secure Asset vehicle as reward
    <br/>- [Removed] Unused functions
    "],
    ["3.4.12", "
    <br/>- [Fixed] A149 Gryphon CAS classification
    <br/>- [Fixed] Supplybox helipad loading
    <br/>- [Tweaked] Decouple Loadouts, Arsenal and Rewards from map type
    <br/>- [Tweaked] Consolidate map specific assets
    <br/>- [Tweaked] Dead body ejection from vehicles
    <br/>- [Tweaked] Tasks and Notifications
    <br/>- [Tweaked] Mission spawn distance blacklist
    <br/>- [Tweaked] MainAO SubObj Comms position finding
    "],
    ["3.4.13", "
    <br/>- [Added] Functions for commonly used snippets
    <br/>- [Fixed] Automatic Pilot Grounding mechanics
    <br/>- [Fixed] Added missing surface type for grass cutting
    <br/>- [Tweaked] Aircraft seat restrictions
    <br/>- [Tweaked] Main AO SubObj Comms tower despawn
    <br/>- [Removed] Mk82 unguided bombs from all air loadouts
    "],
    ["3.4.14", "
    <br/>- [Added] Boats at Terminal docks (available with F.O.B Guardian)
    <br/>- [Added] Reward section for F.O.B Guardian
    <br/>- [Fixed] Shikra classed as CAP asset
    <br/>- [Fixed] Supplybox loading for Base/F.O.B helipads
    <br/>- [Fixed] Disable ViV loading of rewards with UAV attached turrets
    <br/>- [Fixed] Urban sidemission location selection
    <br/>- [Tweaked] Default enemy awareness set to AWARE
    <br/>- [Tweaked] Award asset selection
    <br/>- [Tweaked] Retextured non-NATO asset alpha color
    <br/>- [Tweaked] Enemy jet weighted towards CAS loadouts (except for Shikra Stealth)
    "],
    ["3.4.15", "
    <br/>- [Added] New vehicle servicing functionality
    <br/>- [Added] Prio mission SAM
    <br/>- [Added] Prio mission Rocket Artillery
    <br/>- [Fixed] Side mission Secure Asset reward handler
    <br/>- [Tweaked] Main AO garrison building blacklist
    <br/>- [Tweaked] Prio mission Depot destruction
    <br/>- [Tweaked] Main AO Sub Goalkeeper
    <br/>- [Tweaked] CSAT group composition
    <br/>- [Tweaked] Prio mission F.A.R.P
    <br/>- [Removed] A few Main AOs
    "],
    ["3.4.16", "
    <br/>- [Added] RemoteExec function filters
    <br/>- [Added] Ability for pilots to unlock co-pilot seat for passangers
    <br/>- [Added] Armed Xi'an Infantry transport reward
    <br/>- [Added] F/A-181 Black Wasp II CAP reward
    <br/>- [Added] Prio Mission: Shore bombardment Relay station
    <br/>- [Added] Side Mission: Lost convoy
    <br/>- [Added] Persist player loadouts between sessions
    <br/>- [Added] Kart to FOB Guardian
    <br/>- [Fixed] Vehicle servicing not fixing all hitpoints
    <br/>- [Fixed] Vehicle servicing not handling attached turrets
    <br/>- [Fixed] CAS Buzzard not having 20mm gun
    <br/>- [Fixed] Vehicle servicing action for Blackfish VTOLs
    <br/>- [Fixed] Capture progress counter
    <br/>- [Fixed] Garrisoning of houses without defined positions
    <br/>- [Fixed] Object duplication when spawning Destroyer
    <br/>- [Tweaked] Revive action condition on medical vehicles
    <br/>- [Tweaked] Heal and Revive actions on Arsenals
    <br/>- [Tweaked] Headless client transfer functions
    <br/>- [Tweaked] Every mission unit now gets handled by Headless client
    <br/>- [Tweaked] Base teleportation
    <br/>- [Tweaked] Vehicle service now shows time remaining (MM:SS)
    <br/>- [Tweaked] UAV servicing condition (engine now allowed on)
    <br/>- [Tweaked] Field repair now fixes Xi'an fans to 75%
    <br/>- [Tweaked] Spartan/Admin Tools reworked
    <br/>- [Tweaked] Prio Mission: SAM
    <br/>- [Tweaked] Prio Mission: Rocket Artillery
    <br/>- [Tweaked] Switched Green RPG42 for Hex (DLC restriction)
    <br/>- [Tweaked] LOADS of under-the-hood changes
    <br/>- [Tweaked] BLU_F default loadouts
    <br/>- [Tweaked] Main AO selection algorithm
    <br/>- [Tweaked] AO reinforcement behavior
    <br/>- [Tweaked] Prio Mission Depot and F.A.R.P tasks
    <br/>- [Tweaked] Main AO thread shutdown process
    <br/>- [Tweaked] Cleanup/Stats/Weather script
    <br/>- [Tweaked] Revive system
    <br/>
    <br/> ** Hotfix 1 **
    <br/> - [Fixed] Vehicle mag duplication on service
    <br/> - [Fixed] Insta-death instead of going unconscious
    <br/> - [Fixed] Zeus tools not applied after respawn
    <br/> - [Fixed] UAVs locked after service
    <br/> - [Fixed] Empty groups not being cleaned up
    <br/>
    <br/> ** Hotfix 2 **
    <br/> - [Fixed] Setting vehicle emission control breaking service pads
    <br/> - [Fixed] Teleport to FOB Marathon transfers you to FOB Martian
    <br/> - [Fixed] Loadout restrictions not being applied when exiting Arsenal
    <br/> - [Fixed] Supplybox loading at helipads broken
    <br/> - [Fixed] Side Mission Destroyer units spawning in the water
    <br/> - [Fixed] Base AA available to UAV Operator
    <br/> - [Fixed] Task synchronization broken
    "],
    ["3.4.17", "
    <br/>- [Added] Zeus vehicle customization hotkey (LShift+C)
    <br/>- [Added] Anyone can now pick up enemy assault rifles in the field
    <br/>- [Added] LAT/AT can now pick up enemy launchers in the field
    <br/>- [Added] Any backpack can now be pickup in the field
    <br/>- [Added] Extra MX rifles to vehicle inventories
    <br/>- [Fixed] Side Mission Free IDAP task cleanup
    <br/>- [Fixed] Supplybox spawning and cleanup
    <br/>- [Fixed] Side Mission Secure asset reward unlocking
    <br/>- [Fixed] GhostHawk turret unlock/lock
    <br/>- [Fixed] Derp Revive divide-by-zero condition
    <br/>- [Tweaked] Side Mission Lost Convoy
    <br/>- [Tweaked] Default loadouts
    <br/>- [Tweaked] Prio SAM disable UAV hacking
    <br/>- [Tweaked] HC xfer function
    <br/>- [Tweaked] Curator placed unit/object handlers
    "],
    ["3.4.18", "
    <br/>- [Added] AdminChannel addition in Zeus tools
    <br/>- [Added][Cam Loa Nam] PF 1.2 assets and equipment
    <br/>- [Fixed] TK auto kicking
    <br/>- [Fixed] Reward spawning RE issue
    <br/>- [Fixed][Cam Loa Nam] Teleport to Carrier
    <br/>- [Tweaked] Conditional HC transfer
    <br/>- [Tweaked] Kill messages
    <br/>- [Tweaked] Field Repair/Refuel actions
    <br/>- [Tweaked] Zeus checking function
    <br/>- [Tweaked] Vehicle respawn script logging
    "],
    ["3.4.19", "
    <br/>- [Added][Cam Lao Nam] FOB Dolphin
    <br/>- [Added] Memorial for Mikael
    <br/>- [Fixed][Cam Lao Nam] Pilot and Carrier teleports
    <br/>- [Tweaked] RemoteExec whitelist
    <br/>- [Tweaked][Cam Lao Nam] Unit loadouts
    <br/>- [Tweaked][Cam Lao Nam] Main base moved
    <br/>- [Tweaked][Cam Lao Nam] Randomize jet loadouts
    <br/>- [Tweaked][Cam Lao Nam] Rewards
    <br/>- [Tweaked][Cam Lao Nam] Derp Revive damage thresholds
    <br/>- [Tweaked][Altis] FOB Heli spawns
    <br/>- [Tweaked] Derp Revive variable reset
    "],
    ["3.4.20", "
     <br/>- [Added] Bootleg backpack on chest script (see FAQ)
     <br/>- [Tweaked][Altis] Main AO persistance has been turned on (Cam Lao Nam already had this)
     <br/>- [Tweaked] AOs will now favour heading towards FOBs
     <br/>- [Tweaked] 2 hunters at main base were changed to striders
     <br/>- [Tweaked] Vehicle unflip script (requires 1 person but takes 10 seconds now)
     <br/>- [Tweaked] On low player count (less than 10)
     <br/>    - No AA vehicles or AA teams will spawn in AO (AA infantry can still spawn garrisoned in buildings)
     <br/>    - A maximum of 10 (instead of 15) buildings will be garrisoned in the AO
     <br/>    - Only the inner 20% (instead of 50%) of the AO will contain garrisoned units
    "],
    ["3.4.21", "
    <br/>- [Added] Invade and Annex for Sefrou Ramal (Western Sahara CDLC)
    <br/>- [Added] Invade and Annex for Tanoa (Apex DLC)
    <br/>- [Added] Invade and Annex for Malden
    <br/>- [Added] Reward vehicles to persistance data
    <br/>- [Added] Vehicle inventory customization (see FAQ)
    <br/>- [Tweaked] Side Mission Lost Convoy briefing
    <br/>- [Tweaked] Prevent crates from being created near bases
    <br/>- [Tweaked] Vehicle apperance data restructure
    <br/>- [Tweaked] Restructure of faction definitions
    <br/>- [Tweaked] Side and Prio mission spawning timeouts
    <br/>- [Tweaked] Service pad commands RE'd where vehicle is local
    <br/>
    <br/> Hotfix 1
    <br/>- [Fixed] Main AO reinforcement params
    <br/>- [Tweaked] Switch Tanoa persistence on
    <br/>
    <br/> Hotfix 2
    <br/>- [Fixed] Mohawk texture
    "],
    ["3.4.22", "
    <br/>- [Added] New service functionality for Cam Lao Nam service pads
    <br/>- [Added] Cam Lao Nam heli turrets can now be locked/unlocked
    <br/>- [Added] Bridges between isolated islands on Tanoa
    <br/>- [Added] Occupational grid for garrisoned building at Main AO
    <br/>- [Added] Black Carryall backpack
    <br/>- [Added] Support for using random units as paratroopers
    <br/>- [Added] Support for using random factions per Mission or AO
    <br/>- [Fixed] Mohawk textures yet again
    <br/>- [Fixed] Arsenal creation nil parameter
    <br/>- [Fixed] Decreased SubObj Radiotower empty checking radius
    <br/>- [Fixed] Servicing UAV's backed out the requester and not the controller
    <br/>- [Fixed] Admin Channel message duplication
    <br/>- [Fixed] BIS_fnc_findOverwatch wanting Position3D as parameter
    <br/>- [Fixed] Whitelist BI's Weather module in RE filters
    <br/>- [Fixed] Vehicles running out of fuel on long running missions
    <br/>- [Tweaked] Mission markers are now dynamically created and removed
    <br/>- [Tweaked] Main AO SubObj spawning logic for higher fault tolerance
    <br/>- [Tweaked] Revive actions on Vanbulance/Arsenals and while carrying/dragging
    <br/>- [Tweaked] Blacklist certain island on Tanoa
    <br/>- [Tweaked] Unify completion marker location (always 300/-300 from topleft)
    <br/>- [Tweaked] Spawned enemies/groups now belong to the same side as the main faction
    <br/>- [Tweaked] Updated QS BFT from 2.1.0 -> 2.5.0
    <br/>- [Tweaked] When 15 or less patrols remain in the AO, they rush for the center
    <br/>- [Removed] Purple and Red smoke grenades from the Arsenal
    <br/>- [Removed] Fortifications for garrisoned buildings at Main AO
    "]];

//-------------------------------------------------- Credits
player createDiaryRecord ["credits", ["I & A 3", "
<br/>Mission authors:
<br/>
<br/>	- <font size='16'>BACONOP</font>
<br/>
<br/>
<br/>Contributors:
<br/>
<br/>	- alganthe - Ahoy World (ahoyworld.net)
<br/>	- Quicksilver
<br/>	- PERO - Ahoy World (ahoyworld.net)
<br/>	- Zissou - Ahoy World (ahoyworld.net)
<br/>	- Stanhope - Ahoyworld member (ahoyworld.net)
<br/>	- Ryko - Ahoyworld (ahoyworld.net)
<br/>
<br/>With the help of:
<br/>
<br/>	- Pfc. Christiansen - Ahoy World (ahoyworld.net)
<br/>	- <font size='16'>The AhoyWorld community</font>
<br/>
<br/>Other:
<br/>
<br/>	Ordinance Script
<br/>		- Wolfenswarm
<br/>	CHVD
<br/>		- Champ-1
<br/>   Chat logging
<br/>       -longbow
"]];
