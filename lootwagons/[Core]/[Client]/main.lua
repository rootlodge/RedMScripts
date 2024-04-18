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
local NPCLocations = Config.NPCLocations
-- wagon spawn locations WSL.x, WSL.y, WSL.z, WSL.h defined by Config.WagonSpawnLocations
local WSL.x, WSL.y, WSL.z, WSL.h = Config.WagonSpawnLocations[1].x, Config.WagonSpawnLocations[1].y, Config.WagonSpawnLocations[1].z, Config.WagonSpawnLocations[1].h

-- Public variables
MissionStatus = false
WagonStatus = false
LootWagon = nil
hasLooted = false
isLooting = false
LootWagonBlip = nil

-- Register Net Event
RegisterNetEvent('RootLodge:LootWagons:C:Start')


-- To do list
-- Add a check to see if the player is in the correct location
-- Logic to spawn the loot wagons
-- Logic to place objects in the loot wagon
-- Logic to remove objects from the loot wagon after looting/exploding
-- Logic to make the loot wagon explode
-- Logic to make the loot wagon the player interacted with and finished looting, despawn after a certain amount of time and distance from the player
-- Logic to make the loot wagon respawn after a certain amount of time and distance from the player

--RootLodge:LootWagons:C:Start
AddEventHandler('RootLodge:LootWagons:C:Start', function()
    local playerped = PlayerPedId()
    local coords = GetEntityCoords(playerped)
    --spawn loot wagons regardless of player location
    for _, wagonType in ipairs(Config.Wagons) do
        for _, wagon in ipairs(wagonType) do
            --request wagon model
            local wagonModel = GetHashKey(wagon.Model)
            RequestModel(wagonModel)
            while not HasModelLoaded(wagonModel) do
                Wait(1)
            end
            -- request ped model
            local pedModel = GetHashKey(Config.PedsInWagons[math.random(1, #Config.PedsInWagons)])
            RequestModel(pedModel)
            while not HasModelLoaded(pedModel) do
                Wait(1)
            end

            local wagonObject = CreatePedInsideVehicle(wagonModel, pedModel, -1, false, false, false)
            SetEntityAsMissionEntity(wagonObject, true, true)
            SetEntityHeading(wagonObject, WSL.h)
            SetEntityInvincible(wagonObject, false)
            SetEntityCanBeDamaged(wagonObject, true)
            TaskVehicleDriveWander(wagonObject, wagonModel, 25.0, 786603)
            -- Set Blip
            Citizen.InvokeNative(0x23f74c2fda6e7c61, 1012165077, pedModel) -- Add blip to ped
            Wait(50)
        end
    end
end)


-- Create Thread to start the mission
Citizen.CreateThread(function()
    while true do Wait(2000)
        TriggerEvent('RootLodge:LootWagons:C:Start')
    end
end)