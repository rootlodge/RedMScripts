-- Root Lodge

--Utility Functions

--function to convert vector4(-2476.13, -1297.48, 160.37, 283.96) to { x = -2476.13, y = -1297.48, z = 160.37, h = 283.96 }
function Vector4ToTable(vector4)
    return { x = vector4.x, y = vector4.y, z = vector4.z, h = vector4.h }
end

function requestmodel23(modelHash)
    RequestModel(modelHash)
    while not HasModelLoaded(modelHash) do
        Citizen.Wait(1)
    end
end

function CreateWagonBlip(wagon, name)
    if GetBlipFromEntity(wagon) ~= 0 then return end
    local wagonBlip = Citizen.InvokeNative(0x23F74C2FDA6E7C61, `BLIP_STYLE_MP_PLAYER`, wagon)
    SetBlipSprite(wagonBlip, `blip_mp_player_wagon`, true)
    SetBlipScale(wagonBlip, 1.0)
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

-- For core loot functions

function GetRandomLootItem()
    return Config.LootItems[math.random(#Config.LootItems)]
end

function GetRandomBanditLootItem()
    return Config.BanditLootItems[math.random(#Config.BanditLootItems)]
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
