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

local function CreateWagonBlip(wagon)
    if GetBlipFromEntity(wagon) ~= 0 then return end
    local wagonBlip = Citizen.InvokeNative(0x23F74C2FDA6E7C61, `BLIP_STYLE_MP_PLAYER`, wagon)
    SetBlipSprite(wagonBlip, `blip_mp_player_wagon`, true)
    SetBlipScale(wagonBlip, 1.0)
    Citizen.InvokeNative(0x9CB1A1623062F402, wagonBlip, "Cash Wagon") --SetBlipName
end

-- Move code from OnResourceStart to a function
-- Create a function to spawn the loot wagons
function SpawnLootWagons()
    for _, wagonConfig in ipairs(Config.Wagons) do
        local wagonModel = GetHashKey(wagonConfig.WagonModel)
        requestmodel23(wagonModel)
        print('Model loaded: ' .. wagonConfig.WagonModel)
        local rawPedModel = Config.PedsInWagons[math.random(#Config.PedsInWagons)]
        local pedModel = GetHashKey(rawPedModel)
        requestmodel23(pedModel)

        local spawnIndex = math.random(#Config.WagonSpawnLocations)
        local spawnPoint = Config.WagonSpawnLocations[spawnIndex]

        print('Location: ' .. spawnPoint.x .. ', ' .. spawnPoint.y .. ', ' .. spawnPoint.z .. ', ' .. spawnPoint.h)

        --local rawped = CreatePed(pedModel, spawnPoint.x, spawnPoint.y, spawnPoint.z, true, false)
        --vector4(-263.79, 784.93, 118.31, 88.84)
        local pedcoords = { x = -263.79, y = 784.93, z = 118.31, h = 88.84}
        local notRawWagonped = VORPutils.Peds:Create(rawPedModel, pedcoords.x, pedcoords.y, pedcoords.z, pedcoords.h, 'world', false)
        local rawped = notRawWagonped:GetPed()
        SetEntityVisible(rawped, true)
        Wait(100)
        local wagonVehicle = CreateVehicle(wagonModel, spawnPoint.x, spawnPoint.y, spawnPoint.z, spawnPoint.h, true, true)
        SetEntityVisible(wagonVehicle, true)
        --CreatePedInsideVehicle(wagonVehicle, rawped, -1)
        TaskWarpPedIntoVehicle(rawped, wagonVehicle, -1)
        SetEntityAsMissionEntity(wagonVehicle, true, true)
        SetEntityAsMissionEntity(rawped, true, true)
        Wait(50)
        TaskVehicleDriveWander(rawped, wagonVehicle, 25.0, 786603)
        CreateWagonBlip(wagonVehicle)
        --BlipAddForEntity(675509286, wagonVehicle)
        print('Wagon and ped created and blipped')
        Wait(5000)
    end
end

local doneonce = false
Citizen.CreateThread(function()
    -- Spawn the loot wagons if doneonce is false
    if not doneonce then
        SpawnLootWagons()
        doneonce = true
    end
end)