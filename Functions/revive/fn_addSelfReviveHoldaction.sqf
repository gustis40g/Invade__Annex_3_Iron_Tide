params
[
	["_unit", objNull, [objNull]]
];

private _selfReviveCond = toString {
	alive _target && {
		_target getvariable ["derp_revive_downed", false] || lifeState _target == "INCAPACITATED"
	} && {
		(missionNamespace getVariable ["derp_revive_bandage_item", []]) findIf {
			private _item = _x;
			count ((items _target) apply {
				_item == _x
			}) >= (missionNamespace getVariable ["derp_revive_withstand_amount", 1])
		} > -1 || (items _target) findIf {
			private _item = _x;
			(missionNamespace getVariable ["derp_revive_revive_item", []]) findIf {
				_x == _item && {
					tolower _x find "medikit" > -1
				}
			} > -1
		} > -1
	} 
};

selfReviveID = [
	_unit,
	"Withstand",
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_revive_ca.paa",
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_revive_ca.paa",
	_selfReviveCond,
	_selfReviveCond,
	{},
	{},
	{
		params ["_target", "_caller", "_actionId", "_arguments"];

		private _removeitem = (missionNamespace getVariable ["derp_revive_bandage_item_remove", false]);
		private _items = (missionNamespace getVariable ["derp_revive_bandage_item", []]);
		private _amount = (missionNamespace getVariable ["derp_revive_withstand_amount", 1]);

		if (_removeitem) then {
			private _has_medikit = (items _target) findIf {
				private _item = _x;
				_items findIf {
					_x == _item
				} > -1 && {
					tolower _x find "medikit" > -1
				}
			} > -1;
			if !_has_medikit then
			{
				private _count = 0;
				{
					if (_count < _amount) then {
						private _item = _x;
						if (_items findIf {
							_x == _item
						} > -1) then
						{
							_target removeItem _x;
							_count = _count + 1;
						};
					};
				} forEach (items _target);
				hint format["U have used %1 First Aid Kit(s) to Withstand", _count];
			} else {
				hint "U used ur Medikit to Withstand, it has not been consumed";
			};
		};

		[_target, "REVIVED"] remoteExec ["derp_revive_fnc_switchState", _target];
	},
	{},
	[],
	[8, 4] select (player getUnitTrait "Medic"),
	875,
	false,
	true
] call BIS_fnc_holdActionAdd;