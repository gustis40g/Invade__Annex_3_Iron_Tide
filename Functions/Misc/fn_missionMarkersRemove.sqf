/*
 * Author: Whigital
 * Description:
 * Remove markers
 *
 */

params ["_markers"];

{
    if ((getMarkerColor _x) != "") then {
        deleteMarker _x;
    };
} forEach _markers;
