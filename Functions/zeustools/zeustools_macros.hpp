#define MODULE InA_ZeusTools

#define DOUBLES(var1,var2) var1##_##var2

#define QUOTE(var) #var
#define GVAR(var) DOUBLES(MODULE,var)
#define QGVAR(var) QUOTE(GVAR(var))

#define MENU(var) DOUBLES(GVAR(Menu),var)
#define QMENU(var) QUOTE(MENU(var))

#define USERMENU(var) format ["#USER:%1", QMENU(var)]

#define IDD_NEXTAO_DLG 20000
#define IDC_NEXTAO_LB 20004
#define IDC_NEXTAO_MAP 20006

#define IDD_VEHRESPAWN_DLG 21000
#define IDC_VEHRESPAWN_LB 21006
#define IDC_VEHRESPAWN_BTN 21007
