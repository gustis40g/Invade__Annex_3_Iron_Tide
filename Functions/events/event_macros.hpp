#define PREFIX InA
#define COMPONENT Event_System
#define ADDON DOUBLES(PREFIX,COMPONENT)

#define EVT_PREFIX InA_Event

#define DOUBLES(var1,var2) var1##_##var2

#define QUOTE(var) #var
#define GVAR(var) DOUBLES(ADDON,var)
#define QGVAR(var) QUOTE(GVAR(var))

#define QEVENT(event) QUOTE(DOUBLES(EVT_PREFIX,event))

#define EVT_HASH DOUBLES(ADDON,EventStore)
#define QEVT_HASH QUOTE(EVTHASH)

#define HASKEY(key) key in (keys EVT_HASH)

#define GET_EVT(event) EVT_HASH getOrDefault [event]
#define SET_EVT(event,code) EVT_HASH insert [[event, code]]
#define REM_EVT(event) EVT_HASH deleteAt event

#define ALLOWED_EVENTS [\
    QEVENT(UpdateBaseArray),\
    QEVENT(UpdateControlledZones),\
    QEVENT(UpdateCurrentAO),\
    QEVENT(ArsenalAdded),\
    QEVENT(HeadlessClientConnected),\
    QEVENT(SideChargePlanted),\
    QEVENT(SideIntelFound),\
    QEVENT(SideMissionUp),\
    QEVENT(SideMissionSuccess),\
    QEVENT(SideHostageFreed),\
    QEVENT(SideOfficerSurrender),\
    QEVENT(CodesAquired),\
    QEVENT(TransmissionsShutdown),\
    QEVENT(BunkerPoweredOff),\
    QEVENT(CacheChargePlanted),\
    QEVENT(MainAO_EndSubObj),\
    QEVENT(Sidemission_End),\
    QEVENT(Priomission_End),\
    QEVENT(ManualAO),\
    QEVENT(addBlacklistPos),\
    QEVENT(remBlacklistPos),\
    QEVENT(ToggleCodeExec),\
    QEVENT(PrioShore_shipLocationFound),\
    QEVENT(PrioSAM_RadarShutdown),\
    QEVENT(StatsCallback),\
    QEVENT(HCTransferServerCallback),\
    QEVENT(HCTransferWaitUntil)\
]

#define EVT_ALLOWED(event) event in ALLOWED_EVENTS
