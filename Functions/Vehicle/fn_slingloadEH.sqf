/*
 * Basically KPLIB_fnc_addRopeAttachEh with some tweaks ....
 *
 * Adds RopeAttach EH on server to transfer cargo to pilot
 *
 */

params [
    ["_vehicle", objNull]
];

if (isNull _vehicle) exitWith {};

if (getNumber (configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "slingLoadMaxCargoMass") > 0) then {
    _vehicle addEventHandler ["RopeAttach", {
        params [
            "_heli",
            "_rope",
            "_cargo"
        ];

        private _heliOwner = (owner _heli);
        private _cargoOwner = (owner _cargo);

        // Make sure the vehicle is empty (setOwner doesn't work when crewed),
        // and check that it's not already local ....
        if (((count (fullCrew _cargo)) == 0) && {!(_cargoOwner isEqualTo _heliOwner)}) then {
            _cargo setOwner _heliOwner;
        };
    }];
};
