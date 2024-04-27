-- FXVersion Version
fx_version 'adamant'
games {"rdr3"}
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

shared_script { 'config.lua'}
client_scripts { 'config.lua', '[Core]/[Client]/*.lua' }
server_scripts { 'config.lua', '[Core]/[Server]/*.lua' }

-- NUI Default Page
ui_page "[Core]/[Client]/[ScriptRsrcs]/index.html"

-- Files needed for NUI
-- DON'T FORGET TO ADD THE SOUND FILES TO THIS!
files {
    "[Core]/[Client]/[ScriptRsrcs]/index.html",
    -- Begin Sound Files Here...
    -- client/html/sounds/ ... .ogg
    'client/html/sounds/demo.ogg'
}