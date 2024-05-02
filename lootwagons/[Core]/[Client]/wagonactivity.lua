-- Monitors the activity of the wagons, and changes variables if they have been looted
local Animations = exports.vorp_animations.initiate()
local prompts = GetRandomIntInRange(0, 0xffffff)
RegisterNetEvent('RootLodge:LootWagons:C:MainMission')
-- rewrite the above thread to check if the player is within 25 units of a wagon, and if they are, it will trigger the looting animation and the looting progress bar
-- also checks if the player is within the loot wagon

--local WagonPrompt = nil

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

AddEventHandler("onResourceStop",
    function(resourceName)
    if resourceName == GetCurrentResourceName() then
        PromptDelete(prompts)
    end
end)


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
        if distance < 12.0 then
            return true
        end
    end
    return false
end

function isPedDead(ped)
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
    CenterBottomNotify("Wagon will explode in 10 seconds, leave the area!", 10000)
    Wait(10000)
    local wagon = GetWagonFromPed(npcped)
    ExplodeVehicle(wagon)
    isLooting = false
    hasLooted = true
    canplayerloot = false
end

local inMission = true
local completedmission = false
local dist = 0.0
local passthroughindex = nil
local passthroughnpcped = nil

AddEventHandler('RootLodge:LootWagons:C:MainMission', function()
    while inMission do Wait(1)
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        for index, npcped in pairs(ActiveEnemyNpcs) do
            local enemyCoords = GetEntityCoords(npcped)
            dist = GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, enemyCoords.x, enemyCoords.y, enemyCoords.z, 0)
            passthroughindex = index
            passthroughnpcped = npcped
            if dist < 10.0 then
                local lootingtext = "Looting"
                local label = CreateVarString(10, 'LITERAL_STRING', lootingtext)
                PromptSetActiveGroupThisFrame(prompts, label)
                if Citizen.InvokeNative(0xC92AC953F0A982AE, WagonPrompt) then
                    duringLooting(npcped)
                    completedmission = true
                    Wait(500)
                end
            end
            if dist > 20.0 and completedmission then
                Wait(500)
                CleanupAfterLooting(npcped)
                Wait(50)
                canplayerloot = true
                hasLooted = false
                CenterBottomNotify('The law may arrive soon, get out of there partner!', 5000)
                completedmission = false
            end
        end
    end
end)