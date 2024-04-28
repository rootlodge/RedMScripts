--------------------------------------------------------------------------------
----------------------------------- RootLodge -----------------------------------
--------------------------------------------------------------------------------
local VORPcore = {}
TriggerEvent("getCore", function(core) VORPcore = core end)
function Wait(args) Citizen.Wait(args) end
function Invoke(args, bool) Citizen.InvokeNative(args, bool) end
--------------------------------------------------------------------------------
-- Event Register
RegisterServerEvent('RootLodge:LootWagons:S:PayDay')
RegisterServerEvent('RootLodge:LootWagons:S:CheckCharacter')
RegisterServerEvent('RootLodge:LootWagons:S:AddItem')
--------------------------------------------------------------------------------
-- Core
--------------------------------------------------------------------------------
-- Variables
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
AddEventHandler('RootLodge:LootWagons:S:PayDay', function(KillCount)
  local BPK = Config.Payment.Money.BPK
  local XPK = Config.Payment.XP.XPK
  local mMin = Config.Payment.Money.Min
  local mMax = Config.Payment.Money.Max
  local xMin = Config.Payment.XP.Min
  local xMax = Config.Payment.XP.Max
  local vMoney = Config.Payment.Money.Static
  local vEXP = Config.Payment.XP.Static

  local Char = VORPcore.getUser(source).getUsedCharacter

  local mPay = nil
  local xPay = nil

  if BPK then
    local PayDay = (math.floor(math.random(mMin, mMax) * KillCount))
    Char.addCurrency(0, PayDay)
    mPay = PayDay
  else
    Char.addCurrency(0, vMoney)
    mPay = vMoney
  end

  if XPK then
    local rEXP = (math.floor(math.random(xMin, xMax) * KillCount))
    Char.addXp(rEXP)
    xPay = rEXP
  else
    Char.addXp(vEXP)
    xPay = vEXP
  end

  TriggerClientEvent('RootLodge:LootWagons:C:ResetTotalKills', _source)
  VORPcore.NotifyRightTip(_source, "You received $"..mPay..' and '..xPay..' XP', 5000)
end)

-- A helper function to print table contents
function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

-- Event Handler to Add Items
AddEventHandler('RootLodge:LootWagons:S:AddItem', function(Item, Amount)
  local User = VORPcore.getUser(source)
  if User ~= nil then
    local Character = User.getUsedCharacter
    exports['vorp_inventory']:addItem(source, Item, Amount)
    -- Log the entire item table to see its structure
    print("Item table:", dump(Item))
    --print("Added "..Amount.." of "..Item.." to "..Character.firstname.." "..Character.lastname.."'s inventory")
  end
end)


AddEventHandler('RootLodge:LootWagons:S:CheckCharacter', function()
  local User = VORPcore.getUser(source)
  if User ~= nil then
    local Character = User.getUsedCharacter
    TriggerClientEvent('RootLodge:LootWagons:C:Start', source)
  end
end)

print("Loot Wagon Script has been loaded!")
print("Made by RootLodge")
print("https://rootlodge.com")

local devmode = true
-- if devmode is true, the script will enable the ExecuteCommand("refresh") command by typing /devrefresh in the chat.
RegisterCommand("devrefresh", function()
  if devmode then
    ExecuteCommand("restart lootwagons")
  end
end, false)



--------------------------------------------------------------------------------