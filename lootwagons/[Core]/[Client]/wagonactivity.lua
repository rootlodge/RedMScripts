-- Monitors the activity of the wagons, and changes variables if they have been looted
local Animations = exports.vorp_animations.initiate()

-- rewrite the above thread to check if the player is within 25 units of a wagon, and if they are, it will trigger the looting animation and the looting progress bar
-- also checks if the player is within the loot wagon

local openWagons = nil

Citizen.CreateThread(function()
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


function DeletePrompt(prompt)
    UiPromptDelete(prompt)
end

local paydayenabled = Config.ShouldBePaidForWagonLoot
function PayPlayerClient()
    if paydayenabled then
        -- pay the player for looting the wagon
        TriggerServerEvent('RootLodge:LootWagons:S:Payday')
    end
end

local canplayerloot = true

function cantheyloot(distance)
    if isLooting then
        return false
    end

    if canplayerloot then
        if distance <= 10.0 then
            return true
        end
    end
    return false
end

function ifDeadPed(ped)
    if IsEntityDead(ped) then
        return true
    end
    if hasLooted then
        return true
    end
    return false
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        
        for index, npcped in pairs(ActiveEnemyNpcs) do
            local enemyCoords = GetEntityCoords(ActiveEnemyNpcs[index])
            local truedistance = GetDistanceBetweenCoords(playerCoords, enemyCoords, true)
            
            if cantheyloot(truedistance) then
                --ShowthePrompt()
                local lootingtext = "Looting"
                local label = CreateVarString(10, 'LITERAL_STRING', lootingtext)
                UiPromptSetActiveGroupThisFrame(label, 1, 1, 1, openWagons)
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
                    NotifyRightTip("You have been paid for looting the wagon", 5000)
                    NotifyObjective("Wagon will explode in 10 seconds, leave the area!", 10000)
                    Citizen.Wait(10000)
                    ExplodeVehicle(GetWagonFromPed(npcped))
                    isLooting = false
                    hasLooted = true
                    canplayerloot = false
                end
            elseif truedistance >= 11.0 and ifDeadPed(npcped) then
                -- Cleanup when the player is far enough away
                -- remove the ped from ActiveEnemyNpcs
                CleanupAfterLooting(npcped)
                UiPromptDisablePromptsThisFrame()
                --UiPromptDelete(openWagons)
                canplayerloot = true
                hasLooted = false  -- Reset looting flag after cleanup
                CenterBottomNotify('The law may arrive soon, get out of there partner!', 5000)
                dump(ActiveEnemyNpcs)
            elseif truedistance >= 12.0 then
                UiPromptDisablePromptsThisFrame()    
            end
        end
    end
end)
