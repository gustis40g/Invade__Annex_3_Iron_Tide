#include "repair_macros.hpp"
/*
 * Author: Whigital
 *
 * Description: Initial setup for Servicing functionality
 *
 */

GVAR(Air_Distance) = 5;
GVAR(Ground_Distance) = 3;
GVAR(IconHeight) = 4;
GVAR(IconHeightService) = 5;

if (isServer) then {
    GVAR(AirPads) = [];
    GVAR(GroundPads) = [];

    publicVariable QGVAR(AirPads);
    publicVariable QGVAR(GroundPads);

    0 = [] spawn {
        waitUntil {
            sleep 1;
            !isNil "InA_Server_BaseArray";
        };

        {
            private _airRepairMarkers = (getArray (missionConfigFile >> worldName >> "AOs" >> _x >> "ServicePads" >> "Air"));
            private _groundRepairMarkers = (getArray (missionConfigFile >> worldName >> "AOs" >> _x >> "ServicePads" >> "Ground"));

            {
                _x call AW_fnc_repairInitAirServicePoint;
            } forEach _airRepairMarkers;

            {
                _x call AW_fnc_repairInitGroundServicePoint;
            } forEach _groundRepairMarkers;
        } forEach InA_Server_BaseArray;
    };
};

if (hasInterface) then {
    GVAR(DrawIcons) = true;
    0 = [] spawn AW_fnc_repairDrawServicePointIcons;
};
