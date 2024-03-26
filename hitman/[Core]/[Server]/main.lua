--------------------------------------------------------------------------------
----------------------------------- RootLodge -----------------------------------
--------------------------------------------------------------------------------
local VORPcore = {}
TriggerEvent("getCore", function(core) VORPcore = core end)
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

  TriggerClientEvent('RootLodge:HitContracts:C:ResetTotalKills', source)
  VORPcore.NotifyRightTip(source, "You received $"..mPay..' and '..xPay..' XP', 5000)
end)

AddEventHandler('RootLodge:HitContracts:S:CheckCharacter', function()
  local User = VORPcore.getUser(source)
  if User ~= nil then
    local Character = User.getUsedCharacter
    TriggerClientEvent('RootLodge:HitContracts:C:SetUpMission', source)
  end
end)


print("Hitman Script has been loaded!")
print("Made by RootLodge")
print("https://rootlodge.com")
print("https://discord.gg/3ZU6zj3")


local devmode = true
-- if devmode is true, the script will enable the ExecuteCommand("refresh") command by typing /devrefresh in the chat.
RegisterCommand("devrefresh", function()
  if devmode then
    ExecuteCommand("refresh")
  end
end, false)

RegisterCommand("pingp", function(source, args, rawCommand)
  -- If the source is > 0, then that means it must be a player.
  if (source > 0) then
  
      -- result (using the default GTA:O chat theme) https://i.imgur.com/TaCnG09.png
      TriggerClientEvent("chat:addMessage", -1, {
          args = {
              GetPlayerName(source),
              "PONG!"
          },
          color = { 5, 255, 255 }
      })
  
  -- If it's not a player, then it must be RCON, a resource, or the server console directly.
  else
      print("This command was executed by the server console, RCON client, or a resource.")
  end
end, false --[[this command is not restricted, everyone can use this.]])
























--------------------------------------------------------------------------------