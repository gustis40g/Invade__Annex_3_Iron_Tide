#include "zeustools_macros.hpp"

class GVAR(NextAO_Dialog) {
    idd = IDD_NEXTAO_DLG;
    movingEnabled = false;
    onLoad = "_this call AW_fnc_zeusTools_DlgNextAOonLoad";
    onUnload = "_this call AW_fnc_zeusTools_DlgNextAOonUnload";

    class Controls {
        class GVAR(NextAO_BG): RscPicture {
            idc = 20001;
            text = "#(argb,8,8,3)color(0.1,0.1,0.1,1)";
            x = 0.325 * safezoneW + safezoneX;
            y = 0.3 * safezoneH + safezoneY;
            w = 0.35 * safezoneW;
            h = 0.41 * safezoneH;
        };

        class GVAR(NextAO_Header): RscText {
            idc = 20002;
            text = "Select next AO";
            font = "EtelkaMonospacePro";
            sizeEx = GUI_TEXT_SIZE_LARGE;
            colorBackground[] = {0,0,0,0};
            style = ST_CENTER;
            x = 0.45 * safezoneW + safezoneX;
            y = 0.31 * safezoneH + safezoneY;
            w = 0.1 * safezoneW;
            h = 0.03 * safezoneH;
        };

        class GVAR(NextAO_LbLabel): RscText {
            idc = 20003;
            text = "Available AOs";
            font = "PuristaMedium";
            sizeEx = GUI_TEXT_SIZE_SMALL;
            colorBackground[] = {0,0,0,0};
            style = ST_CENTER;
            x = 0.335 * safezoneW + safezoneX;
            y = 0.33 * safezoneH + safezoneY;
            w = 0.1 * safezoneW;
            h = 0.015 * safezoneH;
        };

        class GVAR(NextAO_LbZones): RscListbox {
            idc = IDC_NEXTAO_LB;
            period = 0;
            font = "EtelkaMonospacePro";
            sizeEx = GUI_TEXT_SIZE_SMALL * 0.75;
            onLBSelChanged = "_this call AW_fnc_zeusTools_DlgNextAOLbSelChanged";
            colorBackground[] = {0,0,0,1};
            colorSelectBackground[] = {1,0.5,0,1};
            colorSelectBackground2[] = {1,0.5,0,1};
            colorSelect[] = {0,0,0,1};
            colorSelect2[] = {0,0,0,1};
            x = 0.335 * safezoneW + safezoneX;
            y = 0.35 * safezoneH + safezoneY;
            w = 0.1 * safezoneW;
            h = 0.3 * safezoneH;
        };

        class GVAR(NextAO_BtnConfirm): RscButton {
            idc = 20005;
            text = "Confirm";
            period = 0;
            colorBackground[] = {0,0,0,1};
            font = "PuristaMedium";
            offsetPressedX = "pixelW * -4";
            offsetPressedY = "pixelH * 4";
            colorBackgroundActive[] = {1,0.5,0,1};
            colorFocused[] = {1,0,0,1};
            colorShadow[] = {0,0,0,0};
            colorBorder[] = {0,0,1,1};
            sizeEx = GUI_TEXT_SIZE_SMALL;
            x = 0.335 * safezoneW + safezoneX;
            y = 0.66 * safezoneH + safezoneY;
            w = 0.0475 * safezoneW;
            h = 0.03 * safezoneH;
            onButtonClick = "_this call AW_fnc_zeusTools_DlgNextAOBtnConfirm";
        };

        class GVAR(NextAO_Map): RscMapControl {
            idc = IDC_NEXTAO_MAP;
            maxSatelliteAlpha = 0;
            alphaFadeStartScale = 0;
            alphaFadeEndScale = 0;
            x = 0.44 * safezoneW + safezoneX;
            y = 0.35 * safezoneH + safezoneY;
            w = 0.225 * safezoneW;
            h = 0.338 * safezoneH;
        };

        class GVAR(NextAO_BtnExit): RscButton {
            idc = 20007;
            text = "Exit";
            period = 0;
            colorBackground[] = {0,0,0,1};
            font = "PuristaMedium";
            offsetPressedX = "pixelW * -4";
            offsetPressedY = "pixelH * 4";
            colorBackgroundActive[] = {1,0.5,0,1};
            colorFocused[] = {1,0,0,1};
            colorShadow[] = {0,0,0,0};
            colorBorder[] = {0,0,1,1};
            sizeEx = GUI_TEXT_SIZE_SMALL;
            x = 0.3875 * safezoneW + safezoneX;
            y = 0.66 * safezoneH + safezoneY;
            w = 0.0475 * safezoneW;
            h = 0.03 * safezoneH;
            onButtonClick = "closeDialog 0";
        };
    };
};


class GVAR(VehRespawn_Dialog) {
    idd = IDD_VEHRESPAWN_DLG;
    movingEnabled = false;
    onLoad = "_this call AW_fnc_zeusTools_DlgVehRespawnonLoad";

    class Controls {
        class GVAR(VehRespawn_BG): RscPicture {
            idc = 21001;
            text = "#(argb,8,8,3)color(0.1,0.1,0.1,1)";
            x = 0.375 * safezoneW + safezoneX;
            y = 0.3 * safezoneH + safezoneY;
            w = 0.25 * safezoneW;
            h = 0.27 * safezoneH;
        };

        class GVAR(VehRespawn_Title): RscText {
            idc = 21002;
            text = "Respawn Vehicle";
            font = "EtelkaMonospacePro";
            sizeEx = GUI_TEXT_SIZE_LARGE;
            colorBackground[] = {0,0,0,0};
            style = ST_CENTER;
            x = 0.45 * safezoneW + safezoneX;
            y = 0.3075 * safezoneH + safezoneY;
            w = 0.1 * safezoneW;
            h = 0.025 * safezoneH;
        };


        // Header
        class GVAR(VehRespawn_HeaderFrame): RscPicture {
            idc = 21003;
            text = "#(argb,8,8,3)color(1,0.5,0,0.75)";
            x = 0.385 * safezoneW + safezoneX;
            y = 0.34 * safezoneH + safezoneY;
            w = 0.23 * safezoneW;
            h = 0.022 * safezoneH;
        };

        class GVAR(VehRespawn_HeaderList): RscListNBox {
            idc = 21004;
            columns[] = {-0.01, 0.4, 0.85};
            disableOverflow = 1;
            idcLeft = -1;
            idcRight = -1;
            font = "PuristaBold";
            sizeEx = GUI_TEXT_SIZE_SMALL * 1.2;
            x = 0.385 * safezoneW + safezoneX;
            y = 0.342 * safezoneH + safezoneY;
            w = 0.23 * safezoneW;
            h = 0.022 * safezoneH;

            class Items {
                class Type {
                    text = "Type";
                };

                class Base {
                    text = "Base";
                };

                class Timer {
                    text = "Timer";
                };
            };
        };


        // List
        class GVAR(VehRespawn_RespawnFrame): RscPicture {
            idc = 21005;
            text = "#(argb,8,8,3)color(0,0,0,1)";
            x = 0.385 * safezoneW + safezoneX;
            y = 0.365 * safezoneH + safezoneY;
            w = 0.23 * safezoneW;
            h = 0.15 * safezoneH;
        };

        class GVAR(VehRespawn_RespawnList): RscListNBox {
            idc = IDC_VEHRESPAWN_LB;
            x = 0.385 * safezoneW + safezoneX;
            y = 0.365 * safezoneH + safezoneY;
            w = 0.23 * safezoneW;
            h = 0.15 * safezoneH;
            rowHeight = 0.02 * safezoneH;
            columns[] = {-0.01, 0.4, 0.85};
            disableOverflow = 1;
            idcLeft = -1;
            idcRight = -1;
            font = "PuristaMedium";
            sizeEx = GUI_TEXT_SIZE_SMALL;
            onLBSelChanged = "_this call AW_fnc_zeusTools_DlgVehRespawnLbSelChanged";
        };


        class GVAR(VehRespawn_BtnRespawn): RscButton {
            idc = IDC_VEHRESPAWN_BTN;
            text = "Respawn";
            period = 0;
            colorBackground[] = {0,0,0,1};
            font = "PuristaMedium";
            offsetPressedX = "pixelW * -4";
            offsetPressedY = "pixelH * 4";
            colorBackgroundActive[] = {1,0.5,0,1};
            colorFocused[] = {1,0,0,1};
            colorShadow[] = {0,0,0,0};
            colorBorder[] = {0,0,1,1};
            sizeEx = GUI_TEXT_SIZE_SMALL;
            x = 0.453 * safezoneW + safezoneX;
            y = 0.526 * safezoneH + safezoneY;
            w = 0.0475 * safezoneW;
            h = 0.03 * safezoneH;
            onButtonClick = "_this call AW_fnc_zeusTools_DlgVehRespawnBtnRespawn";
        };

        class GVAR(VehRespawn_BtnExit): RscButton {
            idc = 21008;
            text = "Exit";
            period = 0;
            colorBackground[] = {0,0,0,1};
            font = "PuristaMedium";
            offsetPressedX = "pixelW * -4";
            offsetPressedY = "pixelH * 4";
            colorBackgroundActive[] = {1,0.5,0,1};
            colorFocused[] = {1,0,0,1};
            colorShadow[] = {0,0,0,0};
            colorBorder[] = {0,0,1,1};
            sizeEx = GUI_TEXT_SIZE_SMALL;
            x = 0.505 * safezoneW + safezoneX;
            y = 0.526 * safezoneH + safezoneY;
            w = 0.0475 * safezoneW;
            h = 0.03 * safezoneH;
            onButtonClick = "closeDialog 0";
        };
    };
};
