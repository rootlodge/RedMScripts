-- Server functions 

function devserverdebug(text)
    if Config.DevMode then
        print('^1[Hitman Contracts] ^7' .. text)
    end
end


--------------------------------------------------------------------------------
----------------------------------- RootLodge -----------------------------------
--------------------------------------------------------------------------------
local VORPcore = {}
TriggerEvent("getCore", function(core) VORPcore = core end)
function Wait(args) Citizen.Wait(args) end
function Invoke(args, bool) Citizen.InvokeNative(args, bool) end
--------------------------------------------------------------------------------
-- Event Register
RegisterServerEvent('RootLodge:HitContracts:S:DevDebug')
--------------------------------------------------------------------------------

AddEventHandler('RootLodge:HitContracts:S:DevDebug', function(text)
    if Config.DevMode then
        print('^1[Hitman Contracts] ^7' .. text)
    end
end)