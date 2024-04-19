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
-- Logic to place objects in the loot wagon
-- Logic to remove objects from the loot wagon after looting/exploding
-- Logic to make the loot wagon explode
-- Logic to make the loot wagon the player interacted with and finished looting, despawn after a certain amount of time and distance from the player
-- Logic to make the loot wagon respawn after a certain amount of time and distance from the player

--------------------------------------------------------------------------------

-- Move code from OnResourceStart to a function
-- Create a function to spawn the loot wagons
-- Main spawning function for Loot Wagons
function SpawnLootWagons()
    for _, wagonConfig in ipairs(Config.Wagons) do
        -- Explicit checks for each wagon type's enablement
        if ((wagonConfig.WagonType == 'BanditWagons' and Config.isBanditWagonsEnabled) or
            (wagonConfig.WagonType == 'CivilianWagons' and Config.isCivilianWagonsEnabled) or
            (wagonConfig.WagonType == 'HighSocietyWagons' and Config.isHighSocietyWagonsEnabled) or
            (wagonConfig.WagonType == 'MilitaryWagons' and Config.isMilitaryWagonsEnabled) or
            (wagonConfig.WagonType == 'OutlawWagons' and Config.isOutlawWagonsEnabled)) then

            local wagonModel = GetHashKey(wagonConfig.WagonModel)
            requestmodel23(wagonModel)

            local spawnIndex = math.random(#Config.WagonSpawnLocations)
            local spawnPoint = Vector4ToTable(Config.WagonSpawnLocations[spawnIndex])

            if not DoesEntityExist(wagonModel) then
                local rawPedModel = Config.PedsInWagons[math.random(#Config.PedsInWagons)]
                local pedModel = GetHashKey(rawPedModel)
                requestmodel23(pedModel)
                
                -- Creating ped using the VORP utility
                local pedcoords = { x = spawnPoint.x, y = spawnPoint.y, z = spawnPoint.z, h = spawnPoint.h }
                local notRawWagonped = VORPutils.Peds:Create(rawPedModel, pedcoords.x, pedcoords.y, pedcoords.z, pedcoords.h, 'world', false)
                local rawped = notRawWagonped:GetPed()
                SetEntityVisible(rawped, true)

                local wagonVehicle = CreateVehicle(wagonModel, spawnPoint.x, spawnPoint.y, spawnPoint.z, spawnPoint.h, true, true)
                SetEntityAsMissionEntity(wagonVehicle, true, true)
                SetEntityAsMissionEntity(rawped, true, true)
                TaskWarpPedIntoVehicle(rawped, wagonVehicle, -1)
                TaskVehicleDriveWander(rawped, wagonVehicle, 25.0, 786603)

                if Config.isWagonBlipVisible then
                    CreateWagonBlip(wagonVehicle, wagonConfig.WagonName)
                end

                print('Wagon and ped created and optionally blipped')
                
                -- Handle the timer for respawning the wagon, wait set by configuration
                Citizen.Wait(Config.WagonSpawnTimer[wagonConfig.WagonType] * 1000)  -- Converts seconds to milliseconds
            end
        end
    end
end

Citizen.CreateThread(function()
    while true do
        SpawnLootWagons()
        -- Wait a short time before checking to spawn again
        Citizen.Wait(1000) -- Check every second to reevaluate conditions
    end
end)
