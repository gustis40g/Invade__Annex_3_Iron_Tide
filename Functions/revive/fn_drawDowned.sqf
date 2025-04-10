/*
	* Author: alganthe
	* Event handling the drawing of icons on downed units for medics or for everyone (depending on setting)
	* do not call THIS. This should only be called once on player init
	*
	* Arguments:
	* Nothing
	*
	* Return Value:
	* Nothing
*/

addMissionEventHandler ["Draw3D", {
	{
		private _unit = _x;
		private _name = name _unit;
		private _dist = (round (player distance _unit));
		private _alpha = (1 - (_dist / 1000));
		private _colorRed = [0.90, 0.00, 0.00, 1.00];
		private _positionChest = _unit modelToWorldVisual (_unit selectionPosition "spine3");
		private _downedIcon = "a3\ui_f\data\igui\cfg\holdactions\holdaction_revivemedic_ca.paa";

		drawIcon3D [
			_downedIcon,
			_colorRed,
			_positionChest,
			_alpha,
			_alpha,
			0,
			format["(Incapacitated) %1", _name],
			2,
			0.04
		];
	} forEach ((allPlayers - [player]) select {
		(alive _x) && {
			(_x getVariable ["derp_revive_downed", false] || (lifeState _x) isEqualTo "INCAPACITATED")
		} && {
			((_x distance player) <= 1000)
		} && {
			(player getUnitTrait "Medic")
		} && {
			([side (group player), side (group _x)] call BIS_fnc_sideIsFriendly)
		}
	});
}];