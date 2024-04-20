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

OilFinished = false
CivilianFinished = false
HighSocietyFinished = false
MilitaryFinished = false
OutlawFinished = false
BankFinished = false 

-- logic to count the number of wagons spawned for each type
OilWagonCount = 0
CivilianWagonCount = 0
HighSocietyWagonCount = 0
MilitaryWagonCount = 0
OutlawWagonCount = 0
BankWagonCount = 0

-- logic function for checks if Config.isWagonTypeEnabled is true AND if the max amount of wagons has been spawned AND if the wagon type is finished or not
-- if the wagon type is finished, it will skip the wagon type and move to the next one
-- if the wagon type is not finished, it will spawn the wagon and increment the wagon count for that type
-- if the wagon type is not enabled, it will skip the wagon type and move to the next one
local function WagonChecks(wagonConfig)
    if ((wagonConfig.WagonType == 'Oil' and Config.isOilWagonsEnabled) or
        (wagonConfig.WagonType == 'Civilian' and Config.isCivilianWagonsEnabled) or
        (wagonConfig.WagonType == 'Bank' and Config.isBankWagonsEnabled) or
        (wagonConfig.WagonType == 'HighSociety' and Config.isHighSocietyWagonsEnabled) or
        (wagonConfig.WagonType == 'Military' and Config.isMilitaryWagonsEnabled) or
        (wagonConfig.WagonType == 'Outlaw' and Config.isOutlawWagonsEnabled)) then

        if OilWagonCount >= Config.WagonMaxSpawnAmount.Oil then
            OilFinished = true
            return false
        end
        if CivilianWagonCount >= Config.WagonMaxSpawnAmount.Civilian then
            CivilianFinished = true
            return false
        end
        if HighSocietyWagonCount >= Config.WagonMaxSpawnAmount.HighSociety then
            HighSocietyFinished = true
            return false
        end
        if MilitaryWagonCount >= Config.WagonMaxSpawnAmount.Military then
            MilitaryFinished = true
            return false
        end
        if OutlawWagonCount >= Config.WagonMaxSpawnAmount.Outlaw then
            OutlawFinished = true
            return false
        end
        if BankWagonCount >= Config.WagonMaxSpawnAmount.Bank then
            BankFinished = true
            return false
        end
        return true
    end
end

function SpawnLootWagons()
    for _, wagonConfig in ipairs(Config.Wagons) do
        -- Explicit checks for each wagon type's enablement
        if ((wagonConfig.WagonType == 'Oil' and WagonChecks(wagonConfig)) or
            (wagonConfig.WagonType == 'Civilian' and WagonChecks(wagonConfig)) or
            (wagonConfig.WagonType == 'Bank' and WagonChecks(wagonConfig)) or
            (wagonConfig.WagonType == 'HighSociety' and WagonChecks(wagonConfig)) or
            (wagonConfig.WagonType == 'Military' and WagonChecks(wagonConfig)) or
            (wagonConfig.WagonType == 'Outlaw' and WagonChecks(wagonConfig))) then

            -- logic to add a wagon to the count for what type of wagon it is
            if wagonConfig.WagonType == 'Oil' then
                OilWagonCount = OilWagonCount + 1
            elseif wagonConfig.WagonType == 'Civilian' then
                CivilianWagonCount = CivilianWagonCount + 1
            elseif wagonConfig.WagonType == 'HighSociety' then
                HighSocietyWagonCount = HighSocietyWagonCount + 1
            elseif wagonConfig.WagonType == 'Military' then
                MilitaryWagonCount = MilitaryWagonCount + 1
            elseif wagonConfig.WagonType == 'Outlaw' then
                OutlawWagonCount = OutlawWagonCount + 1
            elseif wagonConfig.WagonType == 'Bank' then
                BankWagonCount = BankWagonCount + 1
            end

            -- logic to end the wagon type if the max amount of wagons has been spawned
            if OilWagonCount >= Config.WagonMaxSpawnAmount.Oil then
                OilFinished = true
            end
            if CivilianWagonCount >= Config.WagonMaxSpawnAmount.Civilian then
                CivilianFinished = true
            end
            if HighSocietyWagonCount >= Config.WagonMaxSpawnAmount.HighSociety then
                HighSocietyFinished = true
            end
            if MilitaryWagonCount >= Config.WagonMaxSpawnAmount.Military then
                MilitaryFinished = true
            end
            if OutlawWagonCount >= Config.WagonMaxSpawnAmount.Outlaw then
                OutlawFinished = true
            end
            if BankWagonCount >= Config.WagonMaxSpawnAmount.Bank then
                BankFinished = true
            end

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
                
                --Citizen.Wait(Config.WagonSpawnTimer[wagonConfig.WagonType])  -- Converts seconds to milliseconds
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


-- citizen thread to check if WagonType is finished and if the max amount of wagons has been spawned, and if so, to wait for the timer to respawn the wagons IF one of the wagons has been looted and/or exploded/destroyed
Citizen.CreateThread(function()
    while true do
        if OilFinished and CivilianFinished and HighSocietyFinished and MilitaryFinished and OutlawFinished and BankFinished then
            Wait(1000)
        end

        -- Wait a short time before checking to spawn again
        -- start a timer to respawn the wagons, actively checking if any have been looted or exploded/destroyed to replenish the count
        local timer = 0
        while timer < 1000 do
            if hasLooted or WagonStatus then
                timer = 0
                hasLooted = false
                WagonStatus = false
            end
            timer = timer + 1
            Wait(1)
        end
    end
end)