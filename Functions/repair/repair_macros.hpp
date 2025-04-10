#define MODULE InA_Service

#define DOUBLES(var1,var2) var1##_##var2

#define QUOTE(var) #var
#define GVAR(var) DOUBLES(MODULE,var)
#define QGVAR(var) QUOTE(GVAR(var))
