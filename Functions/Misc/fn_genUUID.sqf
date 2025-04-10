/*
 * Author: BaerMitUmlaut
 * Description: Generated a unique ID, carbon copy of CBA implementation
 *
 */

private _hexDigits = [
    "0", "1", "2", "3", "4", "5", "6", "7", "8", "9",
    "a", "b", "c", "d", "e", "f"
];

private _versionByte = "4";
private _variantByte = selectRandom ["8", "9", "a", "b"];

private _uuid = [];

for "_i" from 0 to 29 do {
    _uuid pushBack (selectRandom _hexDigits);
};

_uuid insert [8, ["-"]];
_uuid insert [13, ["-", _versionByte]];
_uuid insert [17, ["-", _variantByte]];
_uuid insert [22, ["-"]];

_uuid joinString ""
