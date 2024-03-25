--------------------------------------------------------------------------------
----------------------------------- RootLodge -----------------------------------
--------------------------------------------------------------------------------
local VorpCore = {}
TriggerEvent("getCore", function(core) VorpCore = core end)
function Wait(args) Citizen.Wait(args) end
function Invoke(args, bool) Citizen.InvokeNative(args, bool) end
--------------------------------------------------------------------------------
-- Event Register
RegisterServerEvent('RootLodge:HitContracts:S:PayDay')
RegisterServerEvent('RootLodge:HitContracts:S:CheckCharacter')
--------------------------------------------------------------------------------
-- Core
--------------------------------------------------------------------------------
-- Variables
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
AddEventHandler('RootLodge:HitContracts:S:PayDay', function(KillCount)
  local BPK = Config.Payment.Money.BPK
  local XPK = Config.Payment.XP.XPK
  local mMin = Config.Payment.Money.Min
  local mMax = Config.Payment.Money.Max
  local xMin = Config.Payment.XP.Min
  local xMax = Config.Payment.XP.Max
  local vMoney = Config.Payment.Money.Static
  local vEXP = Config.Payment.XP.Static

  local Char = VorpCore.getUser(source).getUsedCharacter

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

  TriggerClientEvent('RootLodge:HitContracts:C:ResetTotalKills', source)
  TriggerClientEvent("vorp:TipRight", source, "You received $"..mPay..' and '..xPay..' XP', 5000)
end)



AddEventHandler('RootLodge:HitContracts:S:CheckCharacter', function()
  local User = VorpCore.getUser(source)
  if User ~= nil then
    local Character = User.getUsedCharacter
    TriggerClientEvent('RootLodge:HitContracts:C:SetUpMission', source)
  end
end)


print("Hitman Script has been loaded!")
print("Made by RootLodge")
print("https://rootlodge.com")
print("https://discord.gg/3ZU6zj3")





























--------------------------------------------------------------------------------