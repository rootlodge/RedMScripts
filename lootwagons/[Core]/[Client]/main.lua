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

TotalKilled = 0
-- To do list
-- Logic to place objects in the loot wagon
-- Logic to remove objects from the loot wagon after looting/exploding
-- Logic to make the loot wagon explode
-- Logic to make the loot wagon respawn after a certain amount of time and distance from the player
-- LOGIC TO REIMPLMENT THE TOTAL KILLED FUNCTIONALITY FOR PAYDAY
--------------------------------------------------------------------------------
RegisterNetEvent('RootLodge:LootWagons:C:SetupMission')
AddEventHandler('RootLodge:LootWagons:C:SetupMission', function()
    -- Iterate through each wagon configuration from the maximum spawn amount settings
    for _, config in ipairs(Config.WagonMaxSpawnAmount) do
        local wagonType = config.WagonType
        local maxAmount = config.MaxAmount
        local currentCount = currentCountForCategory(wagonType)

        -- Proceed only if the current count is less than the maximum allowed
        if currentCount < maxAmount then
            local remainingAmount = maxAmount - currentCount
            for _, wagonConfig in ipairs(Config.Wagons) do
                -- Skip this iteration if the wagon type doesn't match the target type
                if wagonConfig.WagonType ~= wagonType then
                    goto continue
                end

                -- Continue with the spawning process for matching wagon type
                local wagonModel = GetHashKey(wagonConfig.WagonModel)
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
                IncreaseWagonCount(wagonType)
                SetEntityAsMissionEntity(wagonVehicle, true, true)
                SetEntityAsMissionEntity(rawped, true, true)
                Wait(1)
                TaskWarpPedIntoVehicle(rawped, wagonVehicle, -1)
                Wait(1)
                TaskVehicleDriveWander(rawped, wagonVehicle, 25.0, 786603)
                if Config.isWagonBlipVisible then
                    CreateWagonBlip(wagonVehicle, wagonConfig.WagonName)
                end
                print('Wagon and ped have been deployed with blip')

                ::continue::
            end
        else
            if currentCount == maxAmount then
                print('Max amount of wagons spawned')
            end
        end
    end
end)


-- TO CHECK FOR PLAYERS WE CAN JUST CHECK IF THEY PRESS LITERALLY ANY BUTTON!!!!!!1
-- DO NOT FORGET TO ADD RESET KILL EVENT HANDLER

-- trigger the MainMission event when the player presses a button
TriggerEvent('RootLodge:LootWagons:C:SetupMission')
TriggerEvent('RootLodge:LootWagons:C:MainMission')

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