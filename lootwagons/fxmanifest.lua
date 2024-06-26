--------------------------------------------------------------------------------
----------------------------------- RootLodge -----------------------------------
--------------------------------------------------------------------------------
description 'A customizable Wagon Looting script for RedM'
author 'RootLodge Github'
fx_version "adamant"
games {"rdr3"}
version '1.0.1-BETA'

shared_script { 'config.lua', 'static-config.lua' }
client_scripts { 'config.lua', 'static-config.lua', '[Core]/[Client]/*.lua' }
server_scripts { 'config.lua', 'static-config.lua', '[Core]/[Server]/*.lua' }
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
