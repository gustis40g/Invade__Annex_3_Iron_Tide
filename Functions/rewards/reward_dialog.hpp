class InA_Rewards_Button: RscButton {
    colorText[] = {1,1,1,1};
    colorDisabled[] = {1,1,1,0.25};
    colorBackground[] = {0,0,0,0.5};
    colorBackgroundDisabled[] = {0,0,0,0.5};
    colorBackgroundActive[] = {1,0.5,0,1};
    colorFocused[] = {1,0,0,1};
    colorShadow[] = {0,0,0,0};
    colorBorder[] = {0,0,1,1};
    font = "PuristaMedium";
    period = 0;
    sizeEx = GUI_TEXT_SIZE_SMALL;
    offsetPressedX = "pixelW * -4";
    offsetPressedY = "pixelH * 4";
    onButtonClick = "_this call AW_fnc_rewardsMenu_Spawn;";
};

class InA_Rewards_Dialog {
    idd = 9000;
    movingEnabled = false;

    class controls {
        class InA_Reward_BG: RscPicture {
            idc = 9001;
            text = "#(argb,8,8,3)color(0.1,0.1,0.1,1)";
            x = 0.381065 * safezoneW + safezoneX;
            y = 0.311971 * safezoneH + safezoneY;
            w = 0.237869 * safezoneW;
            h = 0.357256 * safezoneH;
        };

        class InA_Rewards_SpawnCapition: RscText {
            idc = 9002;
            text = "Select reward to spawn:";
            x = 0.381065 * safezoneW + safezoneX;
            y = 0.321971 * safezoneH + safezoneY;
            w = 0.237869 * safezoneW;
            h = 0.037006 * safezoneH;
            style = ST_CENTER;
            font = "EtelkaMonospacePro";
            sizeEx = GUI_TEXT_SIZE_LARGE;
        };

        class InA_Rewards_Tree: RscTree {
            idc = 9003;
            x = 0.451545 * safezoneW + safezoneX;
            y = 0.358977 * safezoneH + safezoneY;
            w = 0.158579 * safezoneW;
            h = 0.291446 * safezoneH;
            colorBackground[] = {0,0,0,1};
            colorSelect[] = {1,0.5,0,0.7};
            colorSelectText[] = {0.1,0.1,0.1,1};
            colorArrow[] = {0.8,0.8,0.8,1};
            colorLines[] = {0.8,0.8,0.8,1};
            font = "EtelkaMonospacePro";
            sizeEx = GUI_TEXT_SIZE_SMALL * 0.75;
            disableKeyboardSearch = 1;
            onTreeSelChanged = "_this call AW_fnc_rewardsMenu_onTreeSelChanged; false;";
        };

        class InA_Rewards_SpawnBase: InA_Rewards_Button {
            idc = 9004;
            text = "Base";
            x = 0.39428 * safezoneW + safezoneX;
            y = 0.358978 * safezoneH + safezoneY;
            w = 0.0440498 * safezoneW;
            h = 0.0376059 * safezoneH;
        };

        class InA_Rewards_SpawnPos: InA_Rewards_Button {
            idc = 9005;
            text = "Near";
            x = 0.39428 * safezoneW + safezoneX;
            y = 0.434189 * safezoneH + safezoneY;
            w = 0.0440498 * safezoneW;
            h = 0.0376059 * safezoneH;
        };

        class InA_Rewards_SpawnCursor: InA_Rewards_Button {
            idc = 9006;
            text = "Cursor";
            x = 0.39428 * safezoneW + safezoneX;
            y = 0.509401 * safezoneH + safezoneY;
            w = 0.0440498 * safezoneW;
            h = 0.0376059 * safezoneH;
        };

        class InA_Rewards_SpawnExit: InA_Rewards_Button {
            idc = 9007;
            text = "Exit";
            x = 0.39428 * safezoneW + safezoneX;
            y = 0.584613 * safezoneH + safezoneY;
            w = 0.0440498 * safezoneW;
            h = 0.0376059 * safezoneH;
            onButtonClick = "closeDialog 0";
        };
    };
};
