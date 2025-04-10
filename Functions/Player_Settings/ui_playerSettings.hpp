#include "playerSettings_macros.hpp"

class Rsc_AW_HeaderText: RscText {
    font = "PuristaBold";
    size = ((safezoneH / 100) * 2.5);
    sizeEx = ((safezoneH / 100) * 2.5);
    x = UI_XPOSLL;
    w = 0.1 * safezoneW;
};

class Rsc_AW_NormalText: RscText {
    font = "PuristaMedium";
    size = ((safezoneH / 100) * 2);
    sizeEx = ((safezoneH / 100) * 2);
    x = UI_XPOSL;
    w = 0.1 * safezoneW;
};

class Rsc_AW_Checkbox: RscCheckbox {
    w = 0.01 * safezoneW * 1.5;
    h = 0.019 * safezoneH * 1.5;
    onCheckedChanged = "_this call AW_fnc_playerSettings_onCheckboxChanged;";
};

class Rsc_AW_Button: RscButton {
    font = "PuristaMedium";
    size = ((safezoneH / 100) * 2.5);
    sizeEx = ((safezoneH / 100) * 2.5);
};

class InA_Player_Dialog {
    idd = IDD_MAIN;
    movingEnabled = false;
    onUnload = "saveProfileNamespace";

    class controls {
        class CtrlBG: RscPicture {
            idc = 1000;
            text = "#(argb,8,8,3)color(0,0,0,1)";
            x = 0.375 * safezoneW + safezoneX;
            y = 0.20 * safezoneH + safezoneY;
            w = 0.25 * safezoneW;
            h = 0.65 * safezoneH;
        };

        class CtrlFrame: RscPicture {
            idc = 1001;
            text = "#(argb,8,8,3)color(0.1,0.1,0.1,1)";
            x = 0.38 * safezoneW + safezoneX;
            y = 0.21 * safezoneH + safezoneY;
            w = 0.24 * safezoneW;
            h = 0.63 * safezoneH;
        };

        class RscTextSettings: RscText {
            idc = 2000;
            style = "0x02";
            text = "Player settings";
            font = "RobotoCondensedBold";
            sizeEx = ((safezoneH / 100) * 5);
            x = 0.375 * safezoneW + safezoneX;
            y = 0.21 * safezoneH + safezoneY;
            w = 0.25 * safezoneW;
            h = 0.1 * safezoneH;
        };


        // AO markers
        class RscTextAOs: Rsc_AW_HeaderText {
            idc = 3000;
            text = "AO Markers";
            y = 0.28 * safezoneH + safezoneY;
            h = 0.05 * safezoneH;
        };

        class RscTextAOCaptured: Rsc_AW_NormalText {
            idc = 3001;
            text = "Captured:";
            y = 0.305 * safezoneH + safezoneY;
            h = 0.05 * safezoneH;
        };

        class RscCheckboxAOCaptured: Rsc_AW_Checkbox {
            idc = IDC_CB_MARK_CAP;
            x = UI_XPOSR;
            y = 0.315 * safezoneH + safezoneY;
            tooltip = "Enable/Disable map markers for captured AO's";
        };

        class RscTextAOhostile: Rsc_AW_NormalText {
            idc = 3002;
            text = "Hostile:";
            y = 0.33 * safezoneH + safezoneY;
            h = 0.05 * safezoneH;
        };

        class RscCheckboxAOhostile: Rsc_AW_Checkbox {
            idc = IDC_CB_MARK_HOST;
            x = UI_XPOSR;
            y = 0.34 * safezoneH + safezoneY;
            tooltip = "Enable/Disable map markers occupied AO's";
        };

        class RscTextAOall: Rsc_AW_NormalText {
            idc = 3003;
            text = "All:";
            y = 0.355 * safezoneH + safezoneY;
            h = 0.05 * safezoneH;
        };

        class RscCheckboxAOall: Rsc_AW_Checkbox {
            idc = IDC_CB_MARK_ALL;
            x = UI_XPOSR;
            y = 0.365 * safezoneH + safezoneY;
            tooltip = "Enable/Disable map markers for all AO's";
        };


        // Player actions
        class RscTextActions: Rsc_AW_HeaderText {
            idc = 4000;
            text = "Actions";
            y = 0.39 * safezoneH + safezoneY;
            h = 0.05 * safezoneH;
        };

        class RscTextActionChemlights: Rsc_AW_NormalText {
            idc = 4001;
            text = "Chemlights:";
            y = 0.415 * safezoneH + safezoneY;
            h = 0.05 * safezoneH;
        };

        class RscCheckboxActChemlights: Rsc_AW_Checkbox {
            idc = IDC_CB_CHEM;
            x = UI_XPOSR;
            y = 0.425 * safezoneH + safezoneY;
            tooltip = "Enable/Disable Chemlight attachment actions";
        };

        class RscTextActionSlingweapon: Rsc_AW_NormalText {
            idc = 4002;
            text = "Sling weapon:";
            y = 0.44 * safezoneH + safezoneY;
            h = 0.05 * safezoneH;
        };

        class RscCheckboxActSling: Rsc_AW_Checkbox {
            idc = IDC_CB_SLING;
            x = UI_XPOSR;
            y = 0.45 * safezoneH + safezoneY;
            tooltip = "Enable/Disable Sling weapon actions";
        };

        class RscTextActionGHdoors: Rsc_AW_NormalText {
            idc = 4003;
            text = "Ghosthawk doors:";
            y = 0.465 * safezoneH + safezoneY;
            h = 0.05 * safezoneH;
        };

        class RscCheckboxActGHdoors: Rsc_AW_Checkbox {
            idc = IDC_CB_GHD;
            x = UI_XPOSR;
            y = 0.475 * safezoneH + safezoneY;
            tooltip = "Enable/Disable GhostHawk door actions (only available for pilots)";
        };


        // HUB toggle
        class RscTextHUD: Rsc_AW_HeaderText {
            idc = 5000;
            text = "Passanger HUD:";
            y = 0.5 * safezoneH + safezoneY;
            h = 0.05 * safezoneH;
        };

        class RscCheckboxHUD: Rsc_AW_Checkbox {
            idc = IDC_CB_HUD;
            x = UI_XPOSR;
            y = 0.51 * safezoneH + safezoneY;
            tooltip = "Enable/Disable Extended passanger HUB";
        };


        // Weapon sway
        class RscTextWeaponSway: Rsc_AW_HeaderText {
            idc = 6000;
            text = "Weapon sway:";
            y = 0.54 * safezoneH + safezoneY;
            h = 0.05 * safezoneH;
        };

        class RscTextSwayPct: Rsc_AW_NormalText {
            idc = IDC_SWAY_VALUE;
            x = UI_XPOSR;
            y = 0.542 * safezoneH + safezoneY;
            w = 0.05 * safezoneW;
            h = 0.05 * safezoneH;
        };

        class RscSliderSway: RscXSliderH {
            idc = IDC_SWAY_SLD;
            style = "0x400 + 0x10";
            x = 0.4 * safezoneW + safezoneX;
            y = 0.582 * safezoneH + safezoneY;
            w = 0.2 * safezoneW;
            h = 0.025 * safezoneH;
            onSliderPosChanged = "_this call AW_fnc_playerSettings_onSliderSwayChanged;";
        };


        // Earplugs attenuation
        // class RscTextAtt: Rsc_AW_HeaderText {
        //     idc = 6100;
        //     text = "Earplug attenuation:";
        //     y = 0.61 * safezoneH + safezoneY;
        //     h = 0.05 * safezoneH;
        //     w = 0.125 * safezoneW;
        // };

        // class RscTextAttPct: Rsc_AW_NormalText {
        //     idc = IDC_ATT_VALUE;
        //     x = UI_XPOSR;
        //     y = 0.612 * safezoneH + safezoneY;
        //     w = 0.05 * safezoneW;
        //     h = 0.05 * safezoneH;
        //     text = "100%";
        // };

        // class RscSliderAtt: RscXSliderH {
        //     idc = IDC_ATT_SLD;
        //     style = "0x400 + 0x10";
        //     x = 0.4 * safezoneW + safezoneX;
        //     y = 0.652 * safezoneH + safezoneY;
        //     w = 0.2 * safezoneW;
        //     h = 0.025 * safezoneH;
        //     onSliderPosChanged = "_this call AW_fnc_playerSettings_onSliderAttChanged;";
        // };


        // Buttons
        class RscBtnViewdistance: Rsc_AW_Button {
            idc = 7000;
            text = "View Distance";
            x = 0.395 * safezoneW + safezoneX;
            y = 0.702 * safezoneH + safezoneY;
            w = 0.09 * safezoneW;
            h = 0.05 * safezoneH;
            onButtonClick = "closeDialog 1; [] spawn CHVD_fnc_openDialog;";
        };

        class RscBtnRespawn: Rsc_AW_Button {
            idc = 7001;
            text = "Respawn Timers";
            x = 0.515 * safezoneW + safezoneX;
            y = 0.702 * safezoneH + safezoneY;
            w = 0.09 * safezoneW;
            h = 0.05 * safezoneH;
            onButtonClick = "closeDialog 1; ['HINT'] remoteExec ['AW_fnc_vehicleGetRespawns', 2];";
        };

        class RscBtnClose: Rsc_AW_Button {
            idc = 10000;
            text = "Close";
            x = 0.46 * safezoneW + safezoneX;
            y = 0.772 * safezoneH + safezoneY;
            w = 0.08 * safezoneW;
            h = 0.05 * safezoneH;
            onButtonClick = "closeDialog 1;";
        };
    };
};
