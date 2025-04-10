/*
 * Author: Whigital
 * 
 * Description:
 * Enables/disables buttons based on listbox selection.
 *
 */

params ["_ctrl", "_idx"];

private _value = (_ctrl lnbText [_idx, 1]);
private _enable = (_value != "");

private _idc = (ctrlIDC _ctrl);
private _dsp = (findDisplay 18000);

switch (_idc) do {
    case 18105: {
        {
            private _btn = (_dsp displayCtrl _x);
            _btn ctrlEnable _enable;
        } forEach [18106, 18107];
    };

    case 18205: {
        private _btn = (_dsp displayCtrl 18206);
        _btn ctrlEnable _enable;
    };
};
