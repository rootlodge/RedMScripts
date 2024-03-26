--------------------------------------------------------------------------------
----------------------------------- RootLodge -----------------------------------
--------------------------------------------------------------------------------
local VORPcore = {}
TriggerEvent("getCore", function(core) VorpCore = core end)
function Wait(args) Citizen.Wait(args) end

function DrawCircle(x, y, z, r, g, b, a)
  Citizen.InvokeNative(0x2A32FAA57B937173, 0x94FDAE17, x, y, z - 0.95, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 0.25, r, g, b, a, 0, 0, 2, 0, 0, 0, 0)
end

function Notify(text, time)
  VORPcore.NotifyRightTip(text,time)
end

function topbigNotification(text, time)
  VORPCORE.NotifyObjective(text, time)
end

function DrawInfo(text, x, y, size)
  local xc = x / 1.0;
  local yc = y / 1.0;
  SetScriptGfxDrawOrder(3)
  SetTextScale(size, size)
  SetTextCentre(true)
  SetTextColor(255, 255, 255, 100)
  SetTextFontForCurrentCommand(6)
  DisplayText(CreateVarString(10, 'LITERAL_STRING', text), xc, yc)
  SetScriptGfxDrawOrder(3)
end

function GetScreenCoordFromWorldCoord(worldX, worldY, worldZ)
  local _worldX = worldX
  local _worldY = worldY
  local _worldZ = worldZ
  local _screenX = 0
  local _screenY = 0
  local _onScreen = Citizen.InvokeNative(0xF9904D11F1ACBEC3, _worldX, _worldY, _worldZ, _screenX, _screenY)
  return _onScreen, _screenX, _screenY
end

function GetClosestPlayer()
  local players = GetActivePlayers()
  local closestDistance = -1
  local closestPlayer = -1
  local playerPed = PlayerPedId()
  local playerCoords = GetEntityCoords(playerPed)
  for _,playerId in ipairs(players) do
    local targetPed = GetPlayerPed(playerId)
    if targetPed ~= playerPed then
      local targetCoords = GetEntityCoords(targetPed)
      local distance = #(playerCoords - targetCoords)
      if closestDistance == -1 or closestDistance > distance then
        closestPlayer = playerId
        closestDistance = distance
      end
    end
  end
  return closestPlayer, closestDistance
end