/*
fn_sendDiscordMessage.sqf

Description: sends a discord message
see: https://github.com/ConnorAU/SQFDiscordEmbedBuilder

params:
    _message: string: that what you want to send to discord
    _nameExtention: string: optional: something you want to add to the name of the hook
*/

if (!isServer) exitWith {
    _this remoteExec ["AW_fnc_sendDiscordMessage", 2];
};

if (isNil "DiscordEmbedBuilder_fnc_buildSqf") exitWith {};  //discord embed builder is not loaded on this machine

params ["_message", ["_nameExtention", ""]];

[
    "Hook",
    _message,
    "I&A3 " + _nameExtention,
    "",
    false
] call DiscordEmbedBuilder_fnc_buildSqf;
