-- Looting Logic
-- Continually checks if the player is looting a wagon, and if they are, it will trigger the looting animation and the looting progress bar, also checks if the player is within the loot wagon


function OilWagonLoot()
    local lootItem = GetRandomOilLootItem()
    -- get random amount of loot items between 1 and 5
    local amount = GetRandomLootAmount()
    TriggerServerEvent('RootLodge:LootWagons:S:AddItem', lootItem, amount)
    CenterBottomNotify('You have looted the wagon', 5000)
end

function CivilianWagonLoot()
    local lootItem = GetRandomCivilianLootItem()
    -- get random amount of loot items between 1 and 5
    local amount = GetRandomLootAmount()
    TriggerServerEvent('RootLodge:LootWagons:S:AddItem', lootItem, amount)
    CenterBottomNotify('You have looted the wagon', 5000)
end

function BankWagonLoot()
    local lootItem = GetRandomBankLootItem()
    -- get random amount of loot items between 1 and 5
    local amount = GetRandomLootAmount()
    TriggerServerEvent('RootLodge:LootWagons:S:AddItem', lootItem, amount)
    CenterBottomNotify('You have looted the wagon', 5000)
end

function HighSocietyWagonLoot()
    local lootItem = GetRandomHighSocietyLootItem()
    -- get random amount of loot items between 1 and 5
    local amount = GetRandomLootAmount()
    TriggerServerEvent('RootLodge:LootWagons:S:AddItem', lootItem, amount)
    CenterBottomNotify('You have looted the wagon', 5000)
end

function MilitaryWagonLoot()
    local lootItem = GetRandomMilitaryLootItem()
    -- get random amount of loot items between 1 and 5
    local amount = GetRandomLootAmount()
    TriggerServerEvent('RootLodge:LootWagons:S:AddItem', lootItem, amount)
    CenterBottomNotify('You have looted the wagon', 5000)
end

function OutlawWagonLoot()
    local lootItem = GetRandomOutlawLootItem()
    -- get random amount of loot items between 1 and 5
    local amount = GetRandomLootAmount()
    TriggerServerEvent('RootLodge:LootWagons:S:AddItem', lootItem, amount)
    CenterBottomNotify('You have looted the wagon', 5000)
end