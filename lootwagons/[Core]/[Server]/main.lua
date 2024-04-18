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

  -- Logic for the lootwagons
  local LootMin = Config.Payment.Loot.Min
  local LootMax = Config.Payment.Loot.Max
  local LootAmountMin = Config.Payment.LootAmount.Min
  local LootAmountMax = Config.Payment.LootAmount.Max
  local LootAmount = math.random(LootAmountMin, LootAmountMax)
  local LootItem = Config.LootItems[math.random(1, #Config.LootItems)]
  local Item = LootItem.Item
  local ItemName = LootItem.Name
  local ItemLabel = LootItem.Label
  local ItemWeight = LootItem.Weight
  local ItemDesc = LootItem.Description
  local ItemValue = LootItem.Value
    --Char.addInventory(Item, LootAmount)

  TriggerClientEvent('RootLodge:LootWagons:C:ResetTotalKills', _source)
  VORPcore.NotifyRightTip(_source, "You received $"..mPay..' and '..xPay..' XP', 5000)
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
    ExecuteCommand("refresh")
  end
end, false)



--------------------------------------------------------------------------------