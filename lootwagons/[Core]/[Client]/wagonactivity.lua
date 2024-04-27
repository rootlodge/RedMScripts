-- Monitors the activity of the wagons, and changes variables if they have been looted






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
    -- get the wagon type
    local WagonHash, WagonType = GetWagonArray()
    local TypeWagon = WagonType
    -- syn_minigame
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

-- rewrite the above thread to check if the player is within 25 units of a wagon, and if they are, it will trigger the looting animation and the looting progress bar
-- also checks if the player is within the loot wagon

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        
        for k, v in pairs(ActiveEnemyNpcs) do
            local EnemyCoords = GetEntityCoords(ActiveEnemyNpcs[k])
            local distance = #(playerCoords - EnemyCoords)
            if distance < 25.0 then
                if IsControlJustPressed(0, Config.Keys['G']) then
                    LootWagon('Oil')
                end
            end
        end
    end
end)