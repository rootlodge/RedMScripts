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
            local enemyCoords = GetEntityCoords(npcped)
            local truedistance = GetDistanceBetweenCoords(playerCoords, enemyCoords, true)
            
            if truedistance <= 25.0 and not isLooting then
                local lootingtext = "Looting"
                local label = CreateVarString(10, 'LITERAL_STRING', lootingtext)
                PromptSetActiveGroupThisFrame(prompts, label)
                if Citizen.InvokeNative(0xC92AC953F0A982AE, openWagons) then
                    isLooting = true
                    Animations.startAnimation("craft")
                    NotifyRightTip("Looting the wagon...", 15000)
                    Citizen.Wait(15000)
                    StartLooting(npcped)  -- Perform the looting
                    Animations.endAnimation("craft")
                    NotifyRightTip("You have looted the wagon", 5000)
                    Citizen.Wait(5000)
                    PayPlayerClient()
                    isLooting = false
                    hasLooted = true
                end
            elseif truedistance >= 50.0 and hasLooted then
                -- Cleanup when the player is far enough away
                CleanupAfterLooting(npcped)
                hasLooted = false  -- Reset looting flag after cleanup
                CenterBottomNotify('The law may arrive soon, get out of there partner!', 5000)
            end
        end
    end
end)
