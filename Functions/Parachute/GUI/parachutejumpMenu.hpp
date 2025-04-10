/* #Gokina
$[
	1.063,
	["paraJump",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[1200,"mapControl",[1,"#(argb,8,8,3)color(1,1,1,1)",["0.29375 * safezoneW + safezoneX","0.247 * safezoneH + safezoneY","0.4125 * safezoneW","0.506 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1000,"titel",[1,"PARACHUTE JUMP",["0.29375 * safezoneW + safezoneX","0.225 * safezoneH + safezoneY","0.4125 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1600,"buttonCancel",[1,"Cancel",["0.29375 * safezoneW + safezoneX","0.753 * safezoneH + safezoneY","0.103125 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1601,"buttonJump",[1,"-- PARACHUTE JUMP --",["0.603125 * safezoneW + safezoneX","0.753 * safezoneH + safezoneY","0.103125 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
]
*/

class AW_parachuteMenu
{
	idd=30000;
	name="AW_parachuteMenu";
	movingEnable=0;
	class controls {
        class title: RscText
        {
            idc = -1;
            text = "Parachute Jump Menu"; 
            style = ST_CENTER;
            x = 0.29375 * safezoneW + safezoneX;
            y = 0.225 * safezoneH + safezoneY;
            w = 0.4125 * safezoneW;
            h = 0.022 * safezoneH;
            colorText[] = {1,1,1,1};
            colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])",1};
        };   
        class ParaJumpMap: RscMapControl
        {
            idc = 30001;
            x = 0.29375 * safezoneW + safezoneX;
            y = 0.247 * safezoneH + safezoneY;
            w = 0.4125 * safezoneW;
            h = 0.506 * safezoneH;
        };
        class parachuteCancel: RscButton
        {
            idc = 30002;
            text = "Cancel"; 
            style = ST_CENTER;
            x = 0.29375 * safezoneW + safezoneX;
            y = 0.753 * safezoneH + safezoneY;
            w = 0.103125 * safezoneW;
            h = 0.022 * safezoneH;
            colorText[] = {1,1,1,1};
            colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])",1};
            action = "closeDialog 0;";
        };
        class buttonJump: RscButton
        {
            idc = 30003;
            style = ST_CENTER;
            text = "Deploy"; 
            x = 0.603125 * safezoneW + safezoneX;
            y = 0.753 * safezoneH + safezoneY;
            w = 0.103125 * safezoneW;
            h = 0.022 * safezoneH;
            colorText[] = {1,1,1,1};
            colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])",1};
            action = "dojump = 1;";
        };
    };
};