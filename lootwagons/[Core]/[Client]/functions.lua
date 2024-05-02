--------------------------------------------------------------------------------
----------------------------------- RootLodge -----------------------------------
--------------------------------------------------------------------------------
local VORPcore = {}
TriggerEvent("getCore", function(core) VORPcore = core end)
function Wait(args) Citizen.Wait(args) end


--Utility Functions

function arePlayersActive()
    local players = GetActivePlayers()
    return #players > 0
end

--function to convert vector4(-2476.13, -1297.48, 160.37, 283.96) to { x = -2476.13, y = -1297.48, z = 160.37, h = 283.96 }
function Vector4ToTable(vector4)
    return { x = vector4.x, y = vector4.y, z = vector4.z, h = vector4.h }
end

function requestmodel23(modelHash)
    RequestModel(modelHash)
    while not HasModelLoaded(modelHash) do
        Wait(1)
    end
end

function CreateWagonBlip(wagon, name)
    if GetBlipFromEntity(wagon) ~= 0 then return end
    local wagonBlip = Citizen.InvokeNative(0x23F74C2FDA6E7C61, `BLIP_STYLE_MP_PLAYER`, wagon)
    SetBlipSprite(wagonBlip, `blip_mp_player_wagon`, true)
    SetBlipScale(wagonBlip, 1.0)
    SetBlipFlashes(wagonBlip, true)
    Citizen.InvokeNative(0x9CB1A1623062F402, wagonBlip, name) --SetBlipName
end

function CreateEntityBlip(entity, sprite, name)
    if GetBlipFromEntity(entity) ~= 0 then return end
    local blip = Citizen.InvokeNative(0x23F74C2FDA6E7C61, `BLIP_STYLE_MP_PLAYER`, entity)
    SetBlipSprite(blip, sprite, true)
    SetBlipScale(blip, 1.0)
    Citizen.InvokeNative(0x9CB1A1623062F402, blip, name) --SetBlipName
end

function NPCList()
    local peds = {}
    for _, ped in ipairs(Config.PedsInWagons) do
        local pedModel = GetHashKey(ped)
        requestmodel23(pedModel)
        table.insert(peds, pedModel)
    end
    return peds
end

function GetRandomPed()
    local peds = NPCList()
    return peds[math.random(#peds)]
end

function DeleteWagon(WagonHash)
    -- delete the wagon
    DeleteEntity(WagonHash)
    -- remove the wagon from the LootWagons array
    table.remove(LootWagons, 1)
end

function DeletePed(PedHash)
    -- delete the ped
    DeleteEntity(PedHash)
end

function DeleteBlip(BlipHash)
    -- delete the blip
    RemoveBlip(BlipHash)
end

function RemovePedWagonBlip(PedHash, WagonHash, BlipHash)
    -- delete the ped
    DeleteEntity(PedHash)
    -- delete the wagon
    DeleteEntity(WagonHash)
    -- delete the blip
    RemoveBlip(BlipHash)
    return true
end

-- logic function for checks if Config.isWagonTypeEnabled is true AND if the max amount of wagons has been spawned AND if the wagon type is finished or not
-- if the wagon type is finished, it will skip the wagon type and move to the next one
-- if the wagon type is not finished, it will spawn the wagon and increment the wagon count for that type
-- if the wagon type is not enabled, it will skip the wagon type and move to the next one

function WagonChecks(wagonConfig)
    if ((wagonConfig.WagonType == 'Oil' and Config.isOilWagonsEnabled) or
        (wagonConfig.WagonType == 'Civilian' and Config.isCivilianWagonsEnabled) or
        (wagonConfig.WagonType == 'Bank' and Config.isBankWagonsEnabled) or
        (wagonConfig.WagonType == 'HighSociety' and Config.isHighSocietyWagonsEnabled) or
        (wagonConfig.WagonType == 'Military' and Config.isMilitaryWagonsEnabled) or
        (wagonConfig.WagonType == 'Outlaw' and Config.isOutlawWagonsEnabled)) then

        if OilWagonCount >= Config.WagonMaxSpawnAmount.Oil then
            OilFinished = true
            OilTimer = true
            return false
        end
        if CivilianWagonCount >= Config.WagonMaxSpawnAmount.Civilian then
            CivilianFinished = true
            CivilianTimer = true
            return false
        end
        if HighSocietyWagonCount >= Config.WagonMaxSpawnAmount.HighSociety then
            HighSocietyFinished = true
            HighSocietyTimer = true
            return false
        end
        if MilitaryWagonCount >= Config.WagonMaxSpawnAmount.Military then
            MilitaryFinished = true
            MilitaryTimer = true
            return false
        end
        if OutlawWagonCount >= Config.WagonMaxSpawnAmount.Outlaw then
            OutlawFinished = true
            OutlawTimer = true
            return false
        end
        if BankWagonCount >= Config.WagonMaxSpawnAmount.Bank then
            BankFinished = true
            BankTimer = true
            return false
        end
        return true
    end
end

-- decrease the count of the wagon type if it has been looted
function DecreaseWagonCount(wagonType) 
    if wagonType == 'Oil' then
        OilWagonCount = OilWagonCount - 1
    elseif wagonType == 'Civilian' then
        CivilianWagonCount = CivilianWagonCount - 1
    elseif wagonType == 'HighSociety' then
        HighSocietyWagonCount = HighSocietyWagonCount - 1
    elseif wagonType == 'Military' then
        MilitaryWagonCount = MilitaryWagonCount - 1
    elseif wagonType == 'Outlaw' then
        OutlawWagonCount = OutlawWagonCount - 1
    elseif wagonType == 'Bank' then
        BankWagonCount = BankWagonCount - 1
    end
end

function IncreaseWagonCount(wagonType) 
    if wagonType == 'Oil' then
        OilWagonCount = OilWagonCount + 1
    elseif wagonType == 'Civilian' then
        CivilianWagonCount = CivilianWagonCount + 1
    elseif wagonType == 'HighSociety' then
        HighSocietyWagonCount = HighSocietyWagonCount + 1
    elseif wagonType == 'Military' then
        MilitaryWagonCount = MilitaryWagonCount + 1
    elseif wagonType == 'Outlaw' then
        OutlawWagonCount = OutlawWagonCount + 1
    elseif wagonType == 'Bank' then
        BankWagonCount = BankWagonCount + 1
    end
end

function GetWagonArray()
    local WagonHash = nil
    local WagonType = nil
    -- get the LootWagons array in main.lua
    for _, wagon in ipairs(LootWagons) do
        WagonHash = GetHashKey(wagon.WagonVehicle)
        WagonType = wagon.WagonType
        -- return WagonHash and WagonType
        return WagonHash, WagonType
    end
    --console.log('WagonHash: ' .. WagonHash)
    --console.log('WagonType: ' .. WagonType)
    return WagonHash, WagonType
end

-- function to get random loot item for each category type and pass it to the server to add to the player's inventory

-- function to loot a wagon
function LootWagon(WagonType)
    -- if the wagon type is Oil, call the function OilWagonLoot
    if TypeWagon == 'Oil' then
        OilWagonLoot()
    end
    -- if the wagon type is Civilian, call the function CivilianWagonLoot
    if TypeWagon == 'Civilian' then
        CivilianWagonLoot()
    end
    -- if the wagon type is Bank, call the function BankWagonLoot
    if TypeWagon == 'Bank' then
        BankWagonLoot()
    end
    -- if the wagon type is HighSociety, call the function HighSocietyWagonLoot
    if TypeWagon == 'HighSociety' then
        HighSocietyWagonLoot()
    end
    -- if the wagon type is Military, call the function MilitaryWagonLoot
    if TypeWagon == 'Military' then
        MilitaryWagonLoot()
    end
    -- if the wagon type is Outlaw, call the function OutlawWagonLoot
    if TypeWagon == 'Outlaw' then
        OutlawWagonLoot()
    end
end

-- Function to handle timers for each wagon category
function ManageTimer(category, timerFlag, callback)
    if timerFlag then
        callback()
    end
end

-- Function definitions for waiting specific categories
function WaitForOil()
    Wait(Config.WagonSpawnTimer.Oil)
    OilFinished = false
    OilTimer = false
    print("Oil wagon timer reset.")
end

function WaitForCivilian()
    Wait(Config.WagonSpawnTimer.Civilian)
    CivilianFinished = false
    CivilianTimer = false
    print("Civilian wagon timer reset.")
end

function WaitForHighSociety()
    Wait(Config.WagonSpawnTimer.HighSociety)
    HighSocietyFinished = false
    HighSocietyTimer = false
    print("High Society wagon timer reset.")
end

function WaitForMilitary()
    Wait(Config.WagonSpawnTimer.Military)
    MilitaryFinished = false
    MilitaryTimer = false
    print("Military wagon timer reset.")
end

function WaitForOutlaw()
    Wait(Config.WagonSpawnTimer.Outlaw)
    OutlawFinished = false
    OutlawTimer = false
    print("Outlaw wagon timer reset.")
end

function WaitForBank()
    Wait(Config.WagonSpawnTimer.Bank)
    BankFinished = false
    BankTimer = false
    print("Bank wagon timer reset.")
end

function LootforEachCategoryType(wagonType)
    if wagonType == 'Oil' then
        OilWagonLoot()
    elseif wagonType == 'Civilian' then
        CivilianWagonLoot()
    elseif wagonType == 'Bank' then
        BankWagonLoot()
    elseif wagonType == 'HighSociety' then
        HighSocietyWagonLoot()
    elseif wagonType == 'Military' then
        MilitaryWagonLoot()
    elseif wagonType == 'Outlaw' then
        OutlawWagonLoot()
    end
end

function StartLooting(npcped)
    for id, data in pairs(activePeds) do
        if data.ped == npcped then  -- Match the ped being looted with the stored peds
            -- Call the function to handle looting based on the category type
            print('Looting wagon...')
            print('Loot type: ' .. data.loottype)
            -- print data.ped
            print('Ped: ' .. data.ped)
            LootforEachCategoryType(data.loottype)
            break  -- Exit the loop after handling the correct ped
        else
            print('Ped not found')
        end
    end
end

function CleanupAfterLooting(npcped)
    for id, data in pairs(activePeds) do
        if data.ped == npcped then
            -- Directly delete the ped and vehicle
            DeletePed(data.ped)
            DeleteVehicle(data.vehicle)
            if DoesBlipExist(GetBlipFromEntity(data.vehicle)) then
                RemoveBlip(GetBlipFromEntity(data.vehicle))  -- Remove blip if it exists
            end
            
            -- Remove the ped and vehicle data from activePeds table
            activePeds[id] = nil
            for i, ped in ipairs(ActiveEnemyNpcs) do
                if ped == npcped then
                    table.remove(ActiveEnemyNpcs, i)
                    for i, wagon in ipairs(LootWagons) do
                        if wagon.WagonVehicle == data.vehicle then
                            table.remove(LootWagons, i)
                            for i, wagon in ipairs(Config.WagonMaxSpawnAmount) do
                                if wagon.WagonType == data.loottype then
                                    DecreaseWagonCount(data.loottype)
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

--using the code from the above funciton, we can get the ped and return the wagon they belong to
function GetWagonFromPed(npcped)
    for id, data in pairs(activePeds) do
        if data.ped == npcped then
            return data.vehicle
        end
    end
end

-- get ped from wagon
function GetPedFromWagon(wagon)
    for id, data in pairs(activePeds) do
        if data.vehicle == wagon then
            return data.ped
        end
    end
end


-- For core loot functions

function GetRandomLootItem()
    return Config.LootItems[math.random(#Config.LootItems)]
end

function GetRandomBankLootItem()
    return Config.BankLootItems[math.random(#Config.BankLootItems)]
end

function GetRandomOilLootItem()
    return Config.OilLootItems[math.random(#Config.OilLootItems)]
end

function GetRandomCivilianLootItem()
    return Config.CivilianLootItems[math.random(#Config.CivilianLootItems)]
end

function GetRandomMilitaryLootItem()
    return Config.MilitaryLootItems[math.random(#Config.MilitaryLootItems)]
end

function GetRandomHighSocietyLootItem()
    return Config.HighSocietyLootItems[math.random(#Config.HighSocietyLootItems)]
end

function GetRandomOutlawLootItem()
    return Config.OutlawLootItems[math.random(#Config.OutlawLootItems)]
end

function GetRandomLootAmount()
    return math.random(Config.Payment.LootAmount.Min, Config.Payment.LootAmount.Max)
end


function CenterBottomNotify(text, time)
    --slightly larger text in the center bottom of the screen
    VORPcore.NotifyObjective(text, time)
end

function NotifyRightTip(text, time)
    --smaller text in the top right of the screen
    VORPcore.NotifyRightTip(text, time)
end

-- A helper function to print table contents
function dump(o)
    if type(o) == 'table' then
       local s = '{ '
       for k,v in pairs(o) do
          if type(k) ~= 'number' then k = '"'..k..'"' end
          s = s .. '['..k..'] = ' .. dump(v) .. ','
       end
       return s .. '} '
    else
       return tostring(o)
    end
end
