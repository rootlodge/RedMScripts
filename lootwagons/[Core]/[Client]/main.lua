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
InRange = false
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
activeWagons = {} -- table to store the active wagons
activeWagonIDCounter = 0 -- counter to keep track of the wagon ID
activePeds = {} -- table to store the active peds
activePedIDCounter = 0 -- counter to keep track of the ped ID
currentWagonCounts = {} -- table to store the current count of each wagon type
-- To do list
-- Logic to place objects in the loot wagon
-- Logic to remove objects from the loot wagon after looting/exploding
-- Logic to make the loot wagon explode
-- Logic to make the loot wagon the player interacted with and finished looting, despawn after a certain amount of time and distance from the player
-- Logic to make the loot wagon respawn after a certain amount of time and distance from the player

--------------------------------------------------------------------------------
-- put the SpawnLootWagons function into a client event
RegisterNetEvent('RootLodge:LootWagons:C:SpawnLootWagons')
AddEventHandler('RootLodge:LootWagons:C:SpawnLootWagons', function(wagonType, remainingAmount, wagonModel, wagonName)
    for _, wagonConfig in ipairs(Config.Wagons) do
        wagonModel = nil
        wagonName = nil
        if wagonConfig.WagonType == wagonType then
            wagonModel = wagonConfig.WagonModel
            wagonName = wagonConfig.WagonName
        end
        IncreaseWagonCount(wagonType)
        local wagonModel = GetHashKey(wagonModel)
        requestmodel23(wagonModel)
        local spawnIndex = math.random(#Config.WagonSpawnLocations)
        local spawnPoint = Config.WagonSpawnLocations[spawnIndex]
        local rawpedModel = Config.PedsInWagons[math.random(#Config.PedsInWagons)]
        local pedModel = GetHashKey(rawpedModel)
        requestmodel23(pedModel)
        local pedcoords = { x = spawnPoint.x, y = spawnPoint.y, z = spawnPoint.z, h = spawnPoint.h }
        local notRawWagonped = VORPutils.Peds:Create(rawpedModel, pedcoords.x, pedcoords.y, pedcoords.z, pedcoords.h, 'world', false)
        local rawped = notRawWagonped:GetPed()
        table.insert(ActiveEnemyNpcs, rawped)
        SetEntityVisible(rawped, true)
        local wagonVehicle = CreateVehicle(wagonModel, spawnPoint.x, spawnPoint.y, spawnPoint.z, spawnPoint.h, true, true)
        table.insert(LootWagons, { WagonVehicle = wagonVehicle, WagonType = wagonType })
        activeWagonIDCounter = activeWagonIDCounter + 1
        activeWagons[activeWagonIDCounter] = {
            id = activeWagonIDCounter,
            type = wagonType,
            vehicle = wagonVehicle,
        }
        activePedIDCounter = activePedIDCounter + 1
        activePeds[activePedIDCounter] = {
            id = activePedIDCounter,
            ped = rawped,
            vehicle = wagonVehicle,
            loottype = wagonType,
        }
        SetEntityAsMissionEntity(wagonVehicle, true, true)
        SetEntityAsMissionEntity(rawped, true, true)
        Wait(1)
        TaskWarpPedIntoVehicle(rawped, wagonVehicle, -1)
        Wait(1)
        TaskVehicleDriveWander(rawped, wagonVehicle, 25.0, 786603)
        if Config.isWagonBlipVisible then
            CreateWagonBlip(wagonVehicle, wagonName)
        end
        print('Wagon and ped has been blipped')
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(8000)  -- Check every 8 seconds
        local players = GetActivePlayers()
        if #players > 0 then  -- Only proceed if there are active players
            print('Players are active')
            for _, config in ipairs(Config.WagonMaxSpawnAmount) do
                local wagonType = config.WagonType
                local maxAmount = config.MaxAmount
                local currentCount = currentCountForCategory(wagonType)

                if currentCount < maxAmount then
                    local remainingAmount = maxAmount - currentCount
                    TriggerEvent('RootLodge:LootWagons:C:SpawnLootWagons', wagonType, remainingAmount)
                else
                    if currentCount == maxAmount then
                        print('Max amount of wagons spawned')
                    end
                end
            end
        end
    end
end)

function currentCountForCategory(wagonType)
    if wagonType == "Oil" then
        return OilWagonCount
    elseif wagonType == "Civilian" then
        return CivilianWagonCount
    elseif wagonType == "HighSociety" then
        return HighSocietyWagonCount
    elseif wagonType == "Military" then
        return MilitaryWagonCount
    elseif wagonType == "Outlaw" then
        return OutlawWagonCount
    elseif wagonType == "Bank" then
        return BankWagonCount
    end
end

-- Citizen thread to manage all wagon respawn timers
--Citizen.CreateThread(function()
    --while true do
        --Wait(500) -- General wait time for the loop

        -- Check and manage the timers for each wagon category
        --ManageTimer("Oil", OilTimer, WaitForOil)
        --ManageTimer("Civilian", CivilianTimer, WaitForCivilian)
        --ManageTimer("HighSociety", HighSocietyTimer, WaitForHighSociety)
        --ManageTimer("Military", MilitaryTimer, WaitForMilitary)
        --ManageTimer("Outlaw", OutlawTimer, WaitForOutlaw)
        --ManageTimer("Bank", BankTimer, WaitForBank)
    --end
--end)