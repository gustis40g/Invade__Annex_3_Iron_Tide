#include "inv_macros.hpp"

class InA_Display_Inventory {
	idd = INV_DISPLAY;
	movingenable = 0;
    onLoad = "['onLoad', _this] call AW_fnc_invDialogHandler";
    onUnload = "['onUnload', _this] call AW_fnc_invDialogHandler";

    class Controls {
        class Background: RscText {
            colorBackground[] = {0,0,0,0.7};
            idc = INV_DISPLAY_BG;
            x = "6.5 * 					(			((safezoneW / safezoneH) min 1.2) / 40) + 		(safezoneX + (safezoneW - 					((safezoneW / safezoneH) min 1.2))/2)";
            y = "9.5 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + 		(safezoneY + (safezoneH - 					(			((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
            w = "27 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
            h = "19.5 * 				(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
        };

        class Title: RscText {
            colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.13])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.54])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.21])","(profilenamespace getvariable ['GUI_BCG_RGB_A',0.8])"};
            idc = INV_DISPLAY_TITLE;
            text = "Vehicle Inventory";
            x = "6.5 * 					(			((safezoneW / safezoneH) min 1.2) / 40) + 		(safezoneX + (safezoneW - 					((safezoneW / safezoneH) min 1.2))/2)";
            y = "8.4 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + 		(safezoneY + (safezoneH - 					(			((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
            w = "27 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
            h = "1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
        };

        class Content: RscControlsGroupNoScrollbars {
            idc = INV_DISPLAY_CONTENT;
            x = "7 * 					(			((safezoneW / safezoneH) min 1.2) / 40) + 		(safezoneX + (safezoneW - 					((safezoneW / safezoneH) min 1.2))/2)";
            y = "10 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + 		(safezoneY + (safezoneH - 					(			((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
            w = "26 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
            h = "18 *  				    (			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";

            class Controls {
                class ListBackground: RscText {
                    idc = INV_IDC_LISTBG;
                    x = "0 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                    y = "2 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                    w = "26.0092 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                    h = "13.498 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                    colorBackground[] = {1,1,1,0.1};
                };

                class FilterBackground: RscText {
                    idc = INV_IDC_FILTERBG;
                    x = "1 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                    y = "-2 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                    w = "2 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                    h = "2 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                    colorBackground[] = {1,1,1,0.1};
                };

                class CurrentCargo: RscActivePicture {
                    idc = INV_IDC_TAB0;
                    text = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeInventory\filter_0_ca.paa";
                    x = "0 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                    y = "0 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                    w = "2 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                    h = "2 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                    tooltip = "Current";
                };

                class Rifles: CurrentCargo {
                    idc = INV_IDC_TAB1;
                    text = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeInventory\filter_1_ca.paa";
                    x = "2 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                    y = "0 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                    w = "2 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                    h = "2 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                    tooltip = "Rifles";
                };

                class Machineguns: CurrentCargo {
                    idc = INV_IDC_TAB2;
                    text = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeInventory\filter_2_ca.paa";
                    x = "4 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                    y = "0 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                    w = "2 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                    h = "2 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                    tooltip = "Machineguns";
                };

                class SniperRifles: CurrentCargo {
                    idc = INV_IDC_TAB3;
                    text = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeInventory\filter_3_ca.paa";
                    x = "6 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                    y = "0 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                    w = "2 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                    h = "2 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                    tooltip = "Sniper Rifles";
                };

                class Launchers: CurrentCargo {
                    idc = INV_IDC_TAB4;
                    text = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeInventory\filter_4_ca.paa";
                    x = "8 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                    y = "0 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                    w = "2 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                    h = "2 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                    tooltip = "Launchers";
                };

                class Handguns: CurrentCargo {
                    idc = INV_IDC_TAB5;
                    text = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeInventory\filter_5_ca.paa";
                    x = "10 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                    y = "0 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                    w = "2 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                    h = "2 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                    tooltip = "Handguns";
                };

                class Misc: CurrentCargo {
                    idc = INV_IDC_TAB6;
                    text = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeInventory\filter_6_ca.paa";
                    x = "12 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                    y = "0 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                    w = "2 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                    h = "2 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                    tooltip = "Misc Weapons";
                };

                class Accessories: CurrentCargo {
                    idc = INV_IDC_TAB7;
                    text = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeInventory\filter_7_ca.paa";
                    x = "14 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                    y = "0 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                    w = "2 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                    h = "2 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                    tooltip = "Weapon Accessories";
                };

                class Uniforms: CurrentCargo {
                    idc = INV_IDC_TAB8;
                    text = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeInventory\filter_8_ca.paa";
                    x = "16 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                    y = "0 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                    w = "2 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                    h = "2 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                    tooltip = "Uniforms";
                };

                class Vests: CurrentCargo {
                    idc = INV_IDC_TAB9;
                    text = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeInventory\filter_9_ca.paa";
                    x = "18 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                    y = "0 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                    w = "2 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                    h = "2 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                    tooltip = "Vests";
                };

                class Backpacks: CurrentCargo {
                    idc = INV_IDC_TAB10;
                    text = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeInventory\filter_10_ca.paa";
                    x = "20 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                    y = "0 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                    w = "2 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                    h = "2 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                    tooltip = "Backpacks";
                };

                class Headgear: CurrentCargo {
                    idc = INV_IDC_TAB11;
                    text = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeInventory\filter_11_ca.paa";
                    x = "22 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                    y = "0 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                    w = "2 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                    h = "2 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                    tooltip = "Headgear";
                };

                class Items: CurrentCargo {
                    idc = INV_IDC_TAB12;
                    text = "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeInventory\filter_12_ca.paa";
                    x = "24 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                    y = "0 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                    w = "2 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                    h = "2 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                    tooltip = "Items";
                };

                class ArrowLeft: RscButtonMenu {
                    class Attributes {
                        font = "RobotoCondensed";
                        color = "#ffffff";
                        align = "center";
                        shadow = "false";
                    };

                    class TextPos {
                        left = 0;
                        top = 0;
                        right = 0;
                        bottom = 0;
                    };

                    idc = INV_IDC_ARROWLEFT;
                    text = "-";
                    x = "0 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                    y = "-1 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                    w = "1 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                    h = "1 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                };

                class ArrowRight: ArrowLeft {
                    idc = INV_IDC_ARROWRIGHT;
                    text = "+";
                    x = "25 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                    y = "-1 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                    w = "1 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                    h = "1 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                };

                class List: RscListNBox {
                    columns[] = {0.05,0.15,0.85,0.85};
                    drawSideArrows = 1;
                    idcLeft = INV_IDC_ARROWLEFT;
                    idcRight = INV_IDC_ARROWRIGHT;
                    colorSelect2[] = {0.95,0.95,0.95,1};
                    colorSelectBackground[] = {1,1,1,0.25};
                    colorSelectBackground2[] = {1,1,1,0.25};
                    idc = INV_IDC_LIST;
                    x = "0 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                    y = "2 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                    w = "26 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                    h = "13.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                };

                class Load: RscProgress {
                    texture = "";
                    textureExt = "";
                    colorBar[] = {0.9,0.9,0.9,0.9};
                    colorExtBar[] = {1,1,1,1};
                    colorFrame[] = {1,1,1,1};
                    idc = INV_IDC_LOAD;
                    x = "0 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                    y = "16 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                    w = "26 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
                    h = "1 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                    colorBackground[] = {1,1,1,0.75};
                };
            };
        };

        class ButtonOK: RscButtonMenuOK {
            idc = INV_DISPLAY_OK;
            x = "28.5 * 					(			((safezoneW / safezoneH) min 1.2) / 40) + 		(safezoneX + (safezoneW - 					((safezoneW / safezoneH) min 1.2))/2)";
            y = "27.6 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + 		(safezoneY + (safezoneH - 					(			((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
            w = "5 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
            h = "1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
        };

        class ButtonClear: RscButtonMenu {
            idc = INV_DISPLAY_CLEAR;
            x = "23.4 * 					(			((safezoneW / safezoneH) min 1.2) / 40) + 		(safezoneX + (safezoneW - 					((safezoneW / safezoneH) min 1.2))/2)";
            y = "27.6 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + 		(safezoneY + (safezoneH - 					(			((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
            w = "5 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
            h = "1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            text = "CLEAR";
        };

        class ButtonCancel: RscButtonMenuCancel {
            idc = INV_DISPLAY_CANCEL;
            x = "6.5 * 					(			((safezoneW / safezoneH) min 1.2) / 40) + 		(safezoneX + (safezoneW - 					((safezoneW / safezoneH) min 1.2))/2)";
            y = "27.6 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + 		(safezoneY + (safezoneH - 					(			((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
            w = "5 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
            h = "1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
        };
    };
};
