#define REWARD_DLG "InA_Rewards_Dialog"

#define DSPL_IDD 9000
#define CTRL_TREE_IDC 9003
#define BTN_BASE_IDC 9004
#define BTN_NEAR_IDC 9005
#define BTN_CUR_IDC 9006

#define MAIN_DSPL (findDisplay DSPL_IDD)
#define TREE_CTRL (MAIN_DSPL displayCtrl CTRL_TREE_IDC)

#define NEARPOSVAR "InA_Reward_nearPos"
#define CURPOSVAR "InA_Reward_curPos"

#define SETVIABLE(ctrl,state) ctrl setVariable ["isViable", state]
#define GETVIABLE(ctrl) ctrl getVariable ["isViable", true]
