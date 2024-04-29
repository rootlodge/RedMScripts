-- Monitors the activity of the wagons, and changes variables if they have been looted
local Animations = exports.vorp_animations.initiate()

-- rewrite the above thread to check if the player is within 25 units of a wagon, and if they are, it will trigger the looting animation and the looting progress bar
-- also checks if the player is within the loot wagon

local WagonPrompt = nil

Citizen.CreateThread(function()
    Wait(5000)
    local str = 'Start Looting'
    WagonPrompt = PromptRegisterBegin()
    PromptSetControlAction(WagonPrompt, Config.Keys['G'])
    str = CreateVarString(10, 'LITERAL_STRING', str)
    PromptSetText(WagonPrompt, str)
    PromptSetEnabled(WagonPrompt, 1)
    PromptSetVisible(WagonPrompt, 1)
    PromptSetStandardMode(WagonPrompt, 1)
    PromptSetHoldMode(WagonPrompt, 1)
    PromptSetGroup(WagonPrompt, prompts)
    Citizen.InvokeNative(0xC5F428EE08FA7F2C, WagonPrompt, true)
    PromptRegisterEnd(WagonPrompt)
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

function duringLooting(npcped)
    isLooting = true
    --Animations.startAnimation("craft")
    NotifyRightTip("Looting the wagon...", 15000)
    Wait(15000)
    StartLooting(npcped)  -- Perform the looting
    --Animations.endAnimation("craft")
    Wait(5000)
    PayPlayerClient()
    NotifyRightTip("You have been paid for looting the wagon", 5000)
    NotifyObjective("Wagon will explode in 10 seconds, leave the area!", 10000)
    Wait(10000)
    ExplodeVehicle(GetWagonFromPed(npcped))
    isLooting = false
    hasLooted = true
    canplayerloot = false
end

Citizen.CreateThread(function()
    while true do
        Wait(1)
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        
        for index, npcped in pairs(ActiveEnemyNpcs) do
            local enemyCoords = GetEntityCoords(ActiveEnemyNpcs[index])
            local truedistance = GetDistanceBetweenCoords(playerCoords, enemyCoords, true)
            
            if cantheyloot(truedistance) then
                --ShowthePrompt()
                local lootingtext = "Looting"
                local label = CreateVarString(10, 'LITERAL_STRING', lootingtext)
                PromptSetActiveGroupThisFrame(prompts, label)
                if Citizen.InvokeNative(0xC92AC953F0A982AE, WagonPrompt) then
                    duringLooting(npcped)
                    Wait(500)
                end
            elseif truedistance >= 11.0 and ifDeadPed(npcped) then
                -- Cleanup when the player is far enough away
                -- remove the ped from ActiveEnemyNpcs
                Wait(6000)
                CleanupAfterLooting(npcped)
                --UiPromptDelete(WagonPrompt)
                canplayerloot = true
                hasLooted = false  -- Reset looting flag after cleanup
                CenterBottomNotify('The law may arrive soon, get out of there partner!', 5000)
                dump(ActiveEnemyNpcs)
            end
        end
    end
end)
