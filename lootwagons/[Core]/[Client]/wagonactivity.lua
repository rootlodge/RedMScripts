-- Monitors the activity of the wagons, and changes variables if they have been looted
local Animations = exports.vorp_animations.initiate()




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

-- rewrite the above thread to check if the player is within 25 units of a wagon, and if they are, it will trigger the looting animation and the looting progress bar
-- also checks if the player is within the loot wagon
Citizen.CreateThread(function()
    Citizen.Wait(5000)
    local str = 'Press'
    openWagons = PromptRegisterBegin()
    PromptSetControlAction(openWagons, Config.Keys['G'])
    str = CreateVarString(10, 'LITERAL_STRING', str)
    PromptSetText(openWagons, str)
    PromptSetEnabled(openWagons, 1)
    PromptSetVisible(openWagons, 1)
    PromptSetStandardMode(openWagons, 1)
    PromptSetHoldMode(openWagons, 1)
    PromptSetGroup(openWagons, prompts)
    Citizen.InvokeNative(0xC5F428EE08FA7F2C, openWagons, true)
    PromptRegisterEnd(openWagons)
end)

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

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        
        for k, v in pairs(ActiveEnemyNpcs) do
            local EnemyCoords = GetEntityCoords(ActiveEnemyNpcs[k])
            local truedistance = GetDistanceBetweenCoords(playerCoords, EnemyCoords)
            if truedistance <= 25.0 then

                local lootingtext = "Looting"
                local label = CreateVarString(10, 'LITERAL_STRING', lootingtext)
                PromptSetEnabled(openWagons, 1)
                PromptSetVisible(openWagons, 1)
                PromptSetActiveGroupThisFrame(prompts, label)
                if Citizen.InvokeNative(0xC92AC953F0A982AE, openWagons) then
                    -- animation to begin looting
                    Animations.startAnimation("craft")
                    -- timer it takes to loot the wagon
                    NotifyRightTip("Looting the wagon...", 15000)
                    Wait(15000)
                    NotifyRightTip("You have looted the wagon", 5000)
                    OilWagonLoot()
                    Animations.endAnimation("craft")
                    Citizen.Wait(5000)
                    PromptSetEnabled(openWagons, 0)
                    PromptSetVisible(openWagons, 0)
                end
            end
            -- if distance is not less than 25 units, then it will reset the prompt
            if truedistance > 25.0 then
                PromptSetEnabled(openWagons, 0)
                PromptSetVisible(openWagons, 0)
                local Ped = ActiveEnemyNpcs[k]
                local PedHash = GetHashKey(Ped)
                local Wagon = GetVehiclePedIsIn(PedHash, true)
                local WagonHash = GetHashKey(Wagon)
                DeleteWagon(WagonHash)
                DeletePed(PedHash)
            end
        end
    end
end)