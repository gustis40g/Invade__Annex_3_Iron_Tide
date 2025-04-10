//    VAS EARPLUGS v2.0   //
//scripts\VAS\Earplugs.sqf//
//      MykeyRM [AW]      //
////////////////////////////

sleep 10;

private _PlugsTakenHint  = "<t color='#ff9d00' size='1.3' shadow='1' shadowColor='#000000' align='center'>*** Earplugs received ***  </t>";   //Item taken hint.
private _howtoHint = "<t  size='1' shadow='1' shadowColor='#000000' align='center'>   [Pause/Break] key to Insert and Remove </t>";          //Instructions hint.
  
 //hint parseText (_PlugsTakenHint + _howtoHint);
[parseText format ["<br />%1<br />%2", _PlugsTakenHint, _howtoHint], true, nil, 10, 1, 0.3] spawn BIS_fnc_textTiles;

InA_Client_EarplugsAttenuation = ((profileNamespace getVariable ["InA_Client_EarplugsAttenuationPct", 20]) / 100);

InA_EarplugsEhIdx = (findDisplay 46) displayAddEventHandler ["KeyDown", {
    params ["_displayOrControl", "_key", "_shift", "_ctrl", "_alt"];

    if (_key == 197) then { //pause break key
        if (isNil "InA_EarplugsFitted") then {InA_EarplugsFitted = false};

        switch (InA_EarplugsFitted) do {
            case true: {
                InA_EarplugsFitted = false;
                2 fadeSound 1;
                [parseText format ["<br/><t size='1.6' font='PuristaBold' align='center'>*** earplugs removed *** </t>"], true, [10,5], 2, 0.5, 0.3] spawn BIS_fnc_textTiles;
            };

            case false: {
                InA_EarplugsFitted = true;
                2 fadeSound InA_Client_EarplugsAttenuation;
                [parseText format ["<br/><t size='1.6' font='PuristaBold' align='center'>*** earplugs fitted *** </t>"], true, [10,5], 2, 0.5, 0.3] spawn BIS_fnc_textTiles;
            };
        };
    };
}];
