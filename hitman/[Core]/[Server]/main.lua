--------------------------------------------------------------------------------
----------------------------------- RootLodge -----------------------------------
--------------------------------------------------------------------------------
local VorpCore = {}
TriggerEvent("getCore", function(core) VorpCore = core end)
function Wait(args) Citizen.Wait(args) end
function Invoke(args, bool) Citizen.InvokeNative(args, bool) end
--------------------------------------------------------------------------------
-- Event Register
RegisterServerEvent('RootLodge:BountyHunter:S:PayDay')
RegisterServerEvent('RootLodge:BountyHunter:S:CheckJob')
--------------------------------------------------------------------------------
-- Core
--------------------------------------------------------------------------------
-- Variables
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
AddEventHandler('RootLodge:BountyHunter:S:PayDay', function(KillCount)
  local BPK = Payment.Money.BPK
  local XPK = Payment.XP.XPK
  local mMin = Payment.Money.Min
  local mMax = Payment.Money.Max
  local xMin = Payment.XP.Min
  local xMax = Payment.XP.Max
  local vMoney = Payment.Money.Static
  local vEXP = Payment.XP.Static

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

  TriggerClientEvent('RootLodge:BountyHunter:C:ResetTotalKills', source)
  TriggerClientEvent("vorp:TipRight", source, "You received $"..mPay..' and '..xPay..' XP', 5000)
end)



AddEventHandler('RootLodge:BountyHunter:S:CheckJob', function()
  local User = VorpCore.getUser(source)
  if User ~= nil then
    local Character = User.getUsedCharacter
    local _Job = Character.job
    TriggerClientEvent('RootLodge:BountyHunter:C:SetUpMission', source, _Job)
  end
end)


print("Hitman Script has been loaded!")
print("Made by RootLodge")
print("https://rootlodge.com")
print("https://discord.gg/3ZU6zj3")





























--------------------------------------------------------------------------------