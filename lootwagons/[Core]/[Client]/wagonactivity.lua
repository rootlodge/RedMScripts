-- Monitors the activity of the wagons, and changes variables if they have been looted
local Animations = exports.vorp_animations.initiate()

-- rewrite the above thread to check if the player is within 25 units of a wagon, and if they are, it will trigger the looting animation and the looting progress bar
-- also checks if the player is within the loot wagon
Citizen.CreateThread(function()
    Citizen.Wait(5000)
    local str = 'Start Looting'
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

local paydayenabled = Config.ShouldBePaidForWagonLoot
function PayPlayerClient()
    if paydayenabled then
        -- pay the player for looting the wagon
        TriggerServerEvent('RootLodge:LootWagons:S:Payday')
        return
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        
        for k, npcped in pairs(ActiveEnemyNpcs) do
            local EnemyCoords = GetEntityCoords(npcped)
            local truedistance = GetDistanceBetweenCoords(playerCoords, EnemyCoords)
            local nomorethandistance = 55.0
            if truedistance <= 25.0 then

                InRange = true
                local lootingtext = "Looting"
                local label = CreateVarString(10, 'LITERAL_STRING', lootingtext)
                PromptSetActiveGroupThisFrame(prompts, label)
                if Citizen.InvokeNative(0xC92AC953F0A982AE, openWagons) then
                    isLooting = true
                    Wait(50)
                    if isLooting then
                        Animations.startAnimation("craft")
                        -- timer it takes to loot the wagon
                        NotifyRightTip("Looting the wagon...", 15000)
                        Wait(15000)
                        NotifyRightTip("You have looted the wagon", 5000)
                        OilWagonLoot()
                        Wait(50)
                        Animations.endAnimation("craft")
                        Wait(5)
                        hasLooted = true
                        PayPlayerClient()
                        isLooting = false
                    end
                end
            else
                if truedistance >= 50.0 then
                    InRange = false
                    if hasLooted then
                        -- if distance is greater than 55, end
                        local wagon = GetVehiclePedIsIn(npcped, true)
                        local wagonHash = GetHashKey(wagon)
                        print('WagonHash: ' .. wagonHash)
                        local blip = GetBlipFromEntity(wagon)
                        local blipHash = GetHashKey(blip)
                        local pedhash = GetHashKey(npcped)
                        print('BlipHash: ' .. blipHash)
                        RemovePedWagonBlip(pedhash, wagonHash, blipHash)
                        Wait(800)
                        isLooting = false
                        hasLooted = false
                        CenterBottomNotify('The law may arrive soon, get out of there partner!', 5000)
                    end
                end
            end
        end
    end
end)