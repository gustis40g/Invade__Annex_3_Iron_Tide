if (diag_tickTime < (player getVariable ["jump_cooldown",-1])) exitWith { 
    hint (format ['U cant Jump yet!\nPlease wait %1 more seconds',(round ((player getVariable ["jump_cooldown",-1]) - diag_tickTime))]); // display hint with cooldown remaning
};

if(InA_Server_PlayerCount > 10) exitWith {hint "Parachute jump disabled to many players"};

private _dialog = createDialog "AW_parachuteMenu";

dojump = 0;
halo_position = getpos player;

hint "Press Left Mouse Button to set ur Parachute Jump Location\nPress Deploy to jump\nDont forget u have to open ur Parachute on ur own";

[ "halo_map_event", "onMapSingleClick", { halo_position = _pos } ] call BIS_fnc_addStackedEventHandler;

"spawn_marker" setMarkerTextLocal "Jump Location";

waitUntil { dialog };
while { dialog && alive player && dojump == 0 } do {
	"spawn_marker" setMarkerPosLocal halo_position;
	sleep 0.1;
};

if ( dialog ) then {
	closeDialog 0;
	sleep 0.1;
};

"spawn_marker" setMarkerPosLocal [99999,99999,0];
"spawn_marker" setMarkerTextLocal "";

[ "halo_map_event", "onMapSingleClick" ] call BIS_fnc_removeStackedEventHandler;

if ( dojump > 0 ) then {

	private _jumpCooldown = diag_tickTime + 60;
	player setVariable ["jump_cooldown", _jumpCooldown, true];

    titleText ["Deploying", "BLACK", 1];
	sleep 1;
	titleText ["Deploying", "BLACK IN", 1];

	private _jump_location = [halo_position select 0, halo_position select 1, 300];

	private _backpack = backpack player;
	private _backpackcontents = [];

	if ( _backpack != "" && _backpack != "B_Parachute" ) then {
		_backpackcontents = backpackItems player;
		removeBackpack player;
		sleep 0.1;
	};

	player addBackpack "B_Parachute";

	player setpos _jump_location;

	waitUntil { !alive player || isTouchingGround player };
	if ( _backpack != "" && _backpack != "B_Parachute" ) then {
		sleep 2;
		player addBackpack _backpack;
		clearAllItemsFromBackpack player;
		{ player addItemToBackpack _x } foreach _backpackcontents;
	};

};

