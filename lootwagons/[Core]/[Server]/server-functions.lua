local usingVorp = true

if IsVorp() then
   VORPinv = exports.vorp_inventory
end

function AddItem(source, item, amount)
    if IsVorp() then
    exports['vorp_inventory']:addItem(source, item, amount)
end

function RemoveItem(source, item, amount)
    if IsVorp() then
        local itemId = exports['vorp_inventory']:getItem(source, item)
        --TriggerClientEvent('vorpInventory:removeItem', source, item, itemId.id, amount)
        exports.vorp_inventory:RemoveItem(source, item, amount)
    end
end

function GetItemAmount(source, name)
if IsVorp() then
    local item = exports['vorp_inventory']:getItem(source, name)

    if item then
        return item.amount
    end

    return 0
end
end

function GiveMoney(source, count)
if IsVorp() then
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
if IsVorp() then
    VORPinv:addItem(source, 'p_haze_seed', 2)
    VORPinv:addItem(source, Shared.items.pot, 2)
    VORPinv:addItem(source, Shared.items.water, 2)
    VORPinv:addItem(source, Shared.items.fertilizer, 2)
end
end, true)