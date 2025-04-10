#define IDD_MAIN 13371

#define UI_XPOSR 0.575 * safezoneW + safezoneX
#define UI_XPOSL 0.41 * safezoneW + safezoneX
#define UI_XPOSLL 0.4 * safezoneW + safezoneX

#define IDC_CB_MARK_CAP 3101
#define IDC_CB_MARK_HOST 3102
#define IDC_CB_MARK_ALL 3103

#define IDC_CB_CHEM 4101
#define IDC_CB_SLING 4102
#define IDC_CB_GHD 4103

#define IDC_CB_HUD 5001

#define IDC_SWAY_VALUE 6001
#define IDC_SWAY_SLD 6002

#define IDC_ATT_VALUE 6101
#define IDC_ATT_SLD 6102

#define SWAY_MIN 25
#define SWAY_MAX 100
#define SWAY_STEP 5
#define SWAY_VALUE (InA_Client_AimingCoef * 100)

#define ATT_MIN 20
#define ATT_MAX 100
#define ATT_STEP 5
#define ATT_VALUE (InA_Client_EarplugsAttenuation * 100)
