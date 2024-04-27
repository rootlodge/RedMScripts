local usingVorp = true

if usingVorp() then
   VORPinv = exports.vorp_inventory
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
    return Character.addCurrency(0, count)
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