--------------------------------------------------------------------------------
----------------------------------- RootLodge -----------------------------------
--------------------------------------------------------------------------------
local VORPcore = {}
TriggerEvent("getCore", function(core) VORPcore = core end)
function Wait(args) Citizen.Wait(args) end

local VORPutils = {}
TriggerEvent("getUtils", function(utils)
    VORPutils = utils
end)

--------------------------------------------------------------------------------
-- Varables
local InRange = false
local Location = nil

-- Public variables
MissionStatus = false
WagonStatus = false
LootWagon = nil
hasLooted = false
isLooting = false
LootWagonBlip = nil

-- Register Net Event
--RegisterNetEvent('RootLodge:LootWagons:C:Start')


-- To do list
-- Add a check to see if the player is in the correct location
-- Logic to spawn the loot wagons
-- Logic to place objects in the loot wagon
-- Logic to remove objects from the loot wagon after looting/exploding
-- Logic to make the loot wagon explode
-- Logic to make the loot wagon the player interacted with and finished looting, despawn after a certain amount of time and distance from the player
-- Logic to make the loot wagon respawn after a certain amount of time and distance from the player

--------------------------------------------------------------------------------
-- Utility Functions
local function requestmodel23(modelHash)
    RequestModel(modelHash)
    while not HasModelLoaded(modelHash) do
        Citizen.Wait(1)
    end
end

-- Event to Start Resource
AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    print('Resource started: ' .. resourceName)

    for _, wagonConfig in ipairs(Config.Wagons) do
        local wagonModel = GetHashKey(wagonConfig.WagonModel)
        requestmodel23(wagonModel)
        print('Model loaded: ' .. wagonConfig.WagonModel)
        local pedModel = GetHashKey(Config.PedsInWagons[math.random(#Config.PedsInWagons)])
        requestmodel23(pedModel)

        local spawnIndex = math.random(#Config.WagonSpawnLocations)
        local spawnPoint = Config.WagonSpawnLocations[spawnIndex]

        print('Location: ' .. spawnPoint.x .. ', ' .. spawnPoint.y .. ', ' .. spawnPoint.z .. ', ' .. spawnPoint.h)

        local wagonPed = CreatePed(pedModel, spawnPoint.x, spawnPoint.y, spawnPoint.z, true, true, true, true)
        SetEntityVisible(wagonPed, true)
        local wagonVehicle = CreateVehicle(wagonModel, spawnPoint.x, spawnPoint.y, spawnPoint.z, spawnPoint.h, true, true)
        SetEntityVisible(wagonVehicle, true)
        
        TaskWarpPedIntoVehicle(wagonPed, wagonVehicle, -1)
        SetEntityAsMissionEntity(wagonVehicle, true, true)
        SetEntityAsMissionEntity(wagonPed, true, true)
        TaskVehicleDriveWander(wagonPed, wagonVehicle, 25.0, 786603)

        Citizen.InvokeNative(0x23f74c2fda6e7c61, 1012165077, wagonPed) -- Add blip for ped
        print('Wagon and ped created and blipped')
    end
end)