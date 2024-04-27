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
LootWagons = {}
hasLooted = false
isLooting = false
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

BankTimer = false
OilTimer = false
CivilianTimer = false
HighSocietyTimer = false
MilitaryTimer = false
OutlawTimer = false

ActiveEnemyNpcs = {}
-- To do list
-- Add a check to see if the player is in the correct location
-- Logic to place objects in the loot wagon
-- Logic to remove objects from the loot wagon after looting/exploding
-- Logic to make the loot wagon explode
-- Logic to make the loot wagon the player interacted with and finished looting, despawn after a certain amount of time and distance from the player
-- Logic to make the loot wagon respawn after a certain amount of time and distance from the player

--------------------------------------------------------------------------------

-- logic function for checks if Config.isWagonTypeEnabled is true AND if the max amount of wagons has been spawned AND if the wagon type is finished or not
-- if the wagon type is finished, it will skip the wagon type and move to the next one
-- if the wagon type is not finished, it will spawn the wagon and increment the wagon count for that type
-- if the wagon type is not enabled, it will skip the wagon type and move to the next one


function SpawnLootWagons()
    for _, wagonConfig in ipairs(Config.Wagons) do
        -- Explicit checks for each wagon type's enablement
        if ((wagonConfig.WagonType == 'Oil' and WagonChecks(wagonConfig)) or
            (wagonConfig.WagonType == 'Civilian' and WagonChecks(wagonConfig)) or
            (wagonConfig.WagonType == 'Bank' and WagonChecks(wagonConfig)) or
            (wagonConfig.WagonType == 'HighSociety' and WagonChecks(wagonConfig)) or
            (wagonConfig.WagonType == 'Military' and WagonChecks(wagonConfig)) or
            (wagonConfig.WagonType == 'Outlaw' and WagonChecks(wagonConfig))) then

            local wagonModel = GetHashKey(wagonConfig.WagonModel)
            requestmodel23(wagonModel)

            local spawnIndex = math.random(#Config.WagonSpawnLocations)
            local spawnPoint = Config.WagonSpawnLocations[spawnIndex]

            local placeholderfalse = false

            if not placeholderfalse then
                local rawPedModel = Config.PedsInWagons[math.random(#Config.PedsInWagons)]
                local pedModel = GetHashKey(rawPedModel)
                requestmodel23(pedModel)
                
                -- Creating ped using the VORP utility
                local pedcoords = { x = spawnPoint.x, y = spawnPoint.y, z = spawnPoint.z, h = spawnPoint.h }
                local notRawWagonped = VORPutils.Peds:Create(rawPedModel, pedcoords.x, pedcoords.y, pedcoords.z, pedcoords.h, 'world', false)
                local rawped = notRawWagonped:GetPed()
                table.insert(ActiveEnemyNpcs, rawped)
                SetEntityVisible(rawped, true)

                local wagonVehicle = CreateVehicle(wagonModel, spawnPoint.x, spawnPoint.y, spawnPoint.z, spawnPoint.h, true, true)
                -- add WagonVehicle to the loot wagon table and add what type of wagon it is
                table.insert(LootWagons, { WagonVehicle = wagonVehicle, WagonType = wagonConfig.WagonType })
                SetEntityAsMissionEntity(wagonVehicle, true, true)
                SetEntityAsMissionEntity(rawped, true, true)
                TaskWarpPedIntoVehicle(rawped, wagonVehicle, -1)
                TaskVehicleDriveWander(rawped, wagonVehicle, 25.0, 786603)

                if Config.isWagonBlipVisible then
                    CreateWagonBlip(wagonVehicle, wagonConfig.WagonName)
                end

                print('Wagon and ped has been blipped')
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
        
        Wait(500)

        -- if Category Timer is true, then wait for the timer to respawn the wagons. Use Config.WagonSpawnTimer.Category to set the time in seconds
        if OilTimer then
            WaitForOil()
        end

        if CivilianTimer then
            WaitForCivilian()
        end
        
        if HighSocietyTimer then
            WaitForHighSociety()
        end

        if MilitaryTimer then
            WaitForMilitary()
        end

        if OutlawTimer then
            WaitForOutlaw()
        end

        if BankTimer then
            WaitForBank()
        end
    end
end)

-- Function to handle Oil wagon spawn timer
function WaitForOil()
    Wait(Config.WagonSpawnTimer.Oil)
    OilFinished = false
    OilTimer = false
end

-- Function to handle Civilian wagon spawn timer
function WaitForCivilian()
    Wait(Config.WagonSpawnTimer.Civilian)
    CivilianFinished = false
    CivilianTimer = false
end

-- Function to handle High Society wagon spawn timer
function WaitForHighSociety()
    Wait(Config.WagonSpawnTimer.HighSociety)
    HighSocietyFinished = false
    HighSocietyTimer = false
end

-- Function to handle Military wagon spawn timer
function WaitForMilitary()
    Wait(Config.WagonSpawnTimer.Military)
    MilitaryFinished = false
    MilitaryTimer = false
end

-- Function to handle Outlaw wagon spawn timer
function WaitForOutlaw()
    Wait(Config.WagonSpawnTimer.Outlaw)
    OutlawFinished = false
    OutlawTimer = false
end

-- Function to handle Bank wagon spawn timer
function WaitForBank()
    Wait(Config.WagonSpawnTimer.Bank)
    BankFinished = false
    BankTimer = false
end
