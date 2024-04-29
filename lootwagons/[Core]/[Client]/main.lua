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

            -- Increment the wagon count for the wagon type
            IncreaseWagonCount(wagonConfig.WagonType)

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

-- count how many wagons should be spawned for each type
-- if wagon max spawn amount is 0, then it will spawn an wagon until the max amount of wagons has been spawned

Citizen.CreateThread(function()
    while true do

        Wait(500)
        if OilWagonCount < Config.WagonMaxSpawnAmount.Oil then
            SpawnLootWagons()
            Wait(500)
        end
        if CivilianWagonCount < Config.WagonMaxSpawnAmount.Civilian then
            SpawnLootWagons()
            Wait(500)
        end

        if HighSocietyWagonCount < Config.WagonMaxSpawnAmount.HighSociety then
            SpawnLootWagons()
            Wait(500)
        end

        if MilitaryWagonCount < Config.WagonMaxSpawnAmount.Military then
            SpawnLootWagons()
            Wait(500)
        end

        if OutlawWagonCount < Config.WagonMaxSpawnAmount.Outlaw then
            SpawnLootWagons()
            Wait(500)
        end

        if BankWagonCount < Config.WagonMaxSpawnAmount.Bank then
            SpawnLootWagons()
            Wait(500)
        end
        Wait(500)
    end
end)

-- Citizen thread to manage all wagon respawn timers
Citizen.CreateThread(function()
    while true do
        Wait(500) -- General wait time for the loop

        -- Check and manage the timers for each wagon category
        ManageTimer("Oil", OilTimer, WaitForOil)
        ManageTimer("Civilian", CivilianTimer, WaitForCivilian)
        ManageTimer("HighSociety", HighSocietyTimer, WaitForHighSociety)
        ManageTimer("Military", MilitaryTimer, WaitForMilitary)
        ManageTimer("Outlaw", OutlawTimer, WaitForOutlaw)
        ManageTimer("Bank", BankTimer, WaitForBank)
    end
end)