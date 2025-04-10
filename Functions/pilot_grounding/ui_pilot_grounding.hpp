class InA_PilotGrounding_Dialog {
    idd = 18000;
    movingEnabled = false;

    class Controls {
        class InA_PilotGrounding_CtrlBG: RscPicture {
            idc = 18001;
            text = "#(argb,8,8,3)color(0,0,0,1)";
            x = 0.375 * safezoneW + safezoneX;
            y = 0.20 * safezoneH + safezoneY;
            w = 0.25 * safezoneW;
            h = 0.65 * safezoneH;
        };

        class InA_PilotGrounding_CtrlFrame: RscPicture {
            idc = 18002;
            text = "#(argb,8,8,3)color(0.1,0.1,0.1,1)";
            x = 0.38 * safezoneW + safezoneX;
            y = 0.21 * safezoneH + safezoneY;
            w = 0.24 * safezoneW;
            h = 0.63 * safezoneH;
        };

        class InA_PilotGrounding_TextHeader: RscText {
            idc = 18003;
            style = ST_CENTER;
            text = "Pilot grounding menu";
            font = "RobotoCondensedBold";
            sizeEx = ((safezoneH / 100) * 4);
            x = 0.38 * safezoneW + safezoneX;
            y = 0.185 * safezoneH + safezoneY;
            w = 0.24 * safezoneW;
            h = 0.1 * safezoneH;
        };


        // Grounded list
        class InA_PilotGrounding_GroundedText: RscText {
            idc = 18101;
            style = ST_LEFT;
            text = "Grounded pilots:";
            font = "RobotoCondensedBold";
            sizeEx = ((safezoneH / 100) * 2.5);
            x = 0.39 * safezoneW + safezoneX;
            y = 0.25 * safezoneH + safezoneY;
            w = 0.24 * safezoneW;
            h = 0.1 * safezoneH;
        };

        class InA_PilotGrounding_GroundedHeaderFrame: RscPicture {
            idc = 18102;
            text = "#(argb,8,8,3)color(0.2,0.5,0.2,1)";
            x = 0.385 * safezoneW + safezoneX;
            y = 0.32 * safezoneH + safezoneY;
            w = 0.23 * safezoneW;
            h = 0.023 * safezoneH;
        };

        class InA_PilotGrounding_GroundedHeader: RscListNBox {
            idc = 18103;
            x = 0.385 * safezoneW + safezoneX;
            y = 0.32 * safezoneH + safezoneY;
            w = 0.23 * safezoneW;
            h = 0.023 * safezoneH;
            columns[] = {-0.01, 0.35, 0.85};
            disableOverflow = 1;
            idcLeft = -1;
            idcRight = -1;
            font = "PuristaBold";
            sizeEx = ((safezoneH / 100) * 2);

            class Items {
                class Name {
                    text = "Name";
                };

                class UID {
                    text = "UID";
                };

                class Timer {
                    text = "Timer";
                };
            };
        };

        class InA_PilotGrounding_GroundedListFrame: RscPicture {
            idc = 18104;
            text = "#(argb,8,8,3)color(0.05,0.05,0.05,1)";
            x = 0.385 * safezoneW + safezoneX;
            y = 0.345 * safezoneH + safezoneY;
            w = 0.23 * safezoneW;
            h = 0.114 * safezoneH;
        };

        class InA_PilotGrounding_GroundedList: RscListNBox {
            idc = 18105;
            x = 0.385 * safezoneW + safezoneX;
            y = 0.345 * safezoneH + safezoneY;
            w = 0.23 * safezoneW;
            h = 0.114 * safezoneH;
            rowHeight = 0.019 * safezoneH;
            columns[] = {-0.01, 0.35, 0.85};
            disableOverflow = 1;
            idcLeft = -1;
            idcRight = -1;
            font = "PuristaMedium";
            sizeEx = ((safezoneH / 100) * 1.75);
            onLBSelChanged = "_this call AW_fnc_pilot_grounding_onLBSelChanged;";
        };

        class InA_PilotGrounding_GroundedBtnExtend: RscButton {
            idc = 18106;
            style = ST_CENTER + ST_VCENTER;
            text = "Extend timer";
            font = "PuristaBold";
            sizeEx = ((safezoneH / 100) * 1.75);
            tooltip = "Extend grounding timer with 30 minutes";
            x = 0.385 * safezoneW + safezoneX;
            y = 0.465 * safezoneH + safezoneY;
            w = 0.06 * safezoneW;
            h = 0.04 * safezoneH;
            onButtonClick = "['_EXTEND_', [18105]] call AW_fnc_pilot_grounding_handleClick;";
        };

        class InA_PilotGrounding_GroundedBtnReset: RscButton {
            idc = 18107;
            style = ST_CENTER + ST_VCENTER;
            text = "Reset timer";
            font = "PuristaBold";
            sizeEx = ((safezoneH / 100) * 1.75);
            tooltip = "Reset grounding timers";
            x = 0.555 * safezoneW + safezoneX;
            y = 0.465 * safezoneH + safezoneY;
            w = 0.06 * safezoneW;
            h = 0.04 * safezoneH;
            onButtonClick = "['_RESET_', [18105]] call AW_fnc_pilot_grounding_handleClick;";
        };


        // Active list
        class InA_PilotGrounding_ActiveText: InA_PilotGrounding_GroundedText {
            idc = 18201;
            text = "Active pilots:";
            y = 0.515 * safezoneH + safezoneY;
        };

        class InA_PilotGrounding_ActiveHeaderFrame: InA_PilotGrounding_GroundedHeaderFrame {
            idc = 18202;
            text = "#(argb,8,8,3)color(0.2,0.5,0.2,1)";
            x = 0.385 * safezoneW + safezoneX;
            y = 0.585 * safezoneH + safezoneY;
            w = 0.23 * safezoneW;
            h = 0.023 * safezoneH;
        };

        class InA_PilotGrounding_ActiveHeader: InA_PilotGrounding_GroundedHeader {
            idc = 18203;
            y = 0.585 * safezoneH + safezoneY;
            columns[] = {-0.01, 0.4};
            
            class Items {
                class Name {
                    text = "Name";
                };

                class UID {
                    text = "UID";
                };
            };
        };

        class InA_PilotGrounding_ActiveListFrame: InA_PilotGrounding_GroundedListFrame {
            idc = 18204;
            y = 0.61 * safezoneH + safezoneY;
            h = 0.095 * safezoneH;
        };
        
        class InA_PilotGrounding_ActiveList: InA_PilotGrounding_GroundedList {
            idc = 18205;
            y = 0.61 * safezoneH + safezoneY;
            columns[] = {-0.01, 0.4};
            h = 0.095 * safezoneH;
        };

        class InA_PilotGrounding_ActiveBtnGround: InA_PilotGrounding_GroundedBtnReset {
            idc = 18206;
            text = "Ground";
            tooltip = "Ground selected pilot for 60 minutes";
            y = 0.711 * safezoneH + safezoneY;
            onButtonClick = "['_GROUND_', [18205]] call AW_fnc_pilot_grounding_handleClick;";
        };
        
        class InA_PilotGrounding_BtnExit: RscButton {
            idc = 18004;
            style = ST_CENTER + ST_VCENTER;
            text = "Exit";
            font = "PuristaBold";
            sizeEx = ((safezoneH / 100) * 2.25);
            x = 0.46 * safezoneW + safezoneX;
            y = 0.772 * safezoneH + safezoneY;
            w = 0.08 * safezoneW;
            h = 0.05 * safezoneH;
            onButtonClick = "closeDialog 1;";
        };
    };
};
