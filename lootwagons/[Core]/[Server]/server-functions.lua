local usingVorp = true

if usingVorp() then
   VORPinv = exports.vorp_inventory
end

function addItemsToConfig()
    -- Adding items to BankLootItems
    table.insert(Config.BankLootItems, { Item = 'goldbar', Label = 'Gold Bar', Limit = 1, CanRemove = 1, Usable = 0, Description = 'A bar of gold' })
    table.insert(Config.BankLootItems, { Item = 'goldcoin', Label = 'Gold Coin', Limit = 50, CanRemove = 1, Usable = 0, Description = 'A gold coin' })
    -- Add more items as needed...

    -- Adding items to OilLootItems
    table.insert(Config.OilLootItems, { Item = 'weapon_pistol', Label = 'Pistol', Limit = 2, CanRemove = 1, Useable = 0, Description = 'A standard pistol' })
    table.insert(Config.OilLootItems, { Item = 'stolen_jewelry', Label = 'Stolen Jewelry', Limit = 5, CanRemove = 1, Usable = 0, Description = 'Jewelry stolen from unsuspecting victims' })
    -- Add more items as needed...

    -- Adding items to CivilianLootItems
    table.insert(Config.CivilianLootItems, { Item = 'gold_apple', Label = 'Apple', Limit = 50, CanRemove = 1, Useable = 0, Description = 'A fresh apple' })
    table.insert(Config.CivilianLootItems, { Item = 'shitty_water', Label = 'Water', Limit = 50, CanRemove = 1, Useable = 0, Description = 'A bottle of water' })
    -- Add more items as needed...

    -- Adding items to HighSocietyLootItems
    table.insert(Config.HighSocietyLootItems, { Item = 'gold_apple', Label = 'Apple', Limit = 50, CanRemove = 1, Useable = 0, Description = 'A fresh apple' })
    table.insert(Config.HighSocietyLootItems, { Item = 'shitty_water', Label = 'Water', Limit = 50, CanRemove = 1, Useable = 0, Description = 'A bottle of water' })
    -- Add more items as needed...

    -- Adding items to MilitaryLootItems
    table.insert(Config.MilitaryLootItems, { Item = 'gold_apple', Label = 'Apple', Limit = 50, CanRemove = 1, Useable = 0, Description = 'A fresh apple' })
    table.insert(Config.MilitaryLootItems, { Item = 'shitty_water', Label = 'Water', Limit = 50, CanRemove = 1, Useable = 0, Description = 'A bottle of water' })
    -- Add more items as needed...

    -- Adding items to OutlawLootItems
    table.insert(Config.OutlawLootItems, { Item = 'gold_apple', Label = 'Apple', Limit = 50, CanRemove = 1, Useable = 0, Description = 'A fresh apple' })
    table.insert(Config.OutlawLootItems, { Item = 'shitty_water', Label = 'Water', Limit = 50, CanRemove = 1, Useable = 0, Description = 'A bottle of water' })
    -- Add more items as needed...
end

function AddItem(source, item, amount)
    if usingVorp() then
    exports['vorp_inventory']:addItem(source, item, amount)
end

function RemoveItem(source, item, amount)
    if usingVorp() then
        local itemId = exports['vorp_inventory']:getItem(source, item)
        --TriggerClientEvent('vorpInventory:removeItem', source, item, itemId.id, amount)
        exports.vorp_inventory:RemoveItem(source, item, amount)
    end
end

function GetItemAmount(source, name)
if usingVorp() then
    local item = exports['vorp_inventory']:getItem(source, name)

    if item then
        return item.amount
    end

    return 0
end
end

function GiveMoney(source, count)
if usingVorp() then
    local Character = VORPcore.getUser(source)

    if Character then
        /*
            0 - money
            1 - gold
            2 - rol
        */
    TriggerEvent('vorp:addMoney', source, 0, count)
    end
end
end


-- if you dont want this, delete then, only allowed who have ace command allow or command.testscript
RegisterCommand('testscript', function (source, args, raw)
if usingVorp() then
    VORPinv:addItem(source, 'goldcoin', 2)
    VORPinv:addItem(source, 'goldbar', 2)
end
end, true)