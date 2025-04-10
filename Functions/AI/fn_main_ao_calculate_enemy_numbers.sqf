/*
file fn_main_ao_calculate_enemy_numbers.sqf
author: stanhope

Calculates how many enemies should be spawned in the main AO

*/

private _playerCount = InA_Server_PlayerCount;

// Defaults (<= 10 players)
private _MBTs = 1;
private _AAVics = 0;
private _IFVs = 1;
private _Cars = 2;
private _mainInf = 3;
private _AAinf = 1;
private _ATinf = 2;
private _recon = 1;
private _helis = 0;
private _jet = 0;
private _boats = 0;
private _fortifications = 1;

switch (true) do {
    // 11-20 players
    case (_playerCount > 10 && _playerCount <= 20): {
        _MBTs = 1;
        _AAVics = 1;
        _IFVs = (1 + round (random 1));
        _Cars = (1 + round (random 1));
        _mainInf = 5;
        _AAinf = 1;
        _ATinf = 1;
        _recon = 2;
        _helis = 1;
        _jet = 0;
        _boats = 1;
        _fortifications = 2;
    };

    // 21-30 players
    case (_playerCount > 20 && _playerCount <= 30): {
        _MBTs = 1;
        _AAVics = (1 + round (random 1));
        _IFVs = (1 + round (random 1));
        _Cars = (1 + round (random 2));
        _mainInf = 5;
        _AAinf = 2;
        _ATinf = 2;
        _recon = 1;
        _helis = 1;
        _jet = 0;
        _boats = (1 + round (random 1));
        _fortifications = 3;
    };

    // 31-40 players
    case (_playerCount > 30 && _playerCount <= 40): {
        _MBTs = 1;
        _AAVics = 2;
        _IFVs = 2;
        _Cars = 3;
        _mainInf = 6;
        _AAinf = 2;
        _ATinf = 2;
        _recon = 2;
        _helis = selectRandom[1,2];
        _jet = 1;
        _boats = (1 + round (random 2));
        _fortifications = 4;
    };

    // 41-50 players
    case (_playerCount > 40 && _playerCount <= 50): {
        _MBTs = 1;
        _AAVics = (2 + round (random 1));
        _IFVs = (2 + round (random 1));
        _Cars = (3 + round (random 1));
        _mainInf = 7;
        _AAinf = 2;
        _ATinf = 2;
        _recon = 3;
        _helis = 2;
        _jet = 1;
        _boats = (2 + round (random 2));
        _fortifications = 5;
    };

    // > 50 players
    case (_playerCount > 50): {
        _MBTs = 2;
        _AAVics = (2 + round (random 2));
        _IFVs = (2 + round (random 2));
        _Cars = (3 + round (random 2));
        _mainInf = 8;
        _AAinf = 3;
        _ATinf = 3;
        _recon = 4;
        _helis = 2;
        _jet = 2;
        _boats = 4;
        _fortifications = 6;
    };
};

[_MBTs, _AAVics, _IFVs, _Cars, _mainInf, _AAinf, _ATinf, _recon, _helis, _jet, _boats, _fortifications]
