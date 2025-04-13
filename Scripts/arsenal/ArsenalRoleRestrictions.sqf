/*
 * Author: Whigital, rewritten by Gustis40g to work with dynamic groups and better performance.
 *
 * Description: Applies precompiled arsenal restrictions based on player role
 *
 */

if (player getVariable ["AW_role", ""] == (player getVariable ["AW_lastProcessedRole", ""])) exitWith {
    InA_ArsenalRestrictionsInitialized = true;
};

// Wait for precompiled lists to be ready
if (isNil "InA_PrecompiledArsenalWhitelists") then {
    waitUntil {sleep 0.1; !isNil "InA_PrecompiledArsenalWhitelists"};
};

private _role = player getVariable ["AW_role", ""];

// Get precompiled whitelist for current role or use default if role not found
InA_ArsenalWhitelistArray = InA_PrecompiledArsenalWhitelists getOrDefault [_role, InA_DefaultArsenalWhitelist];

// ArsenalRestrictions initialized
InA_ArsenalRestrictionsInitialized = true;
player setVariable ["AW_lastProcessedRole", _role];