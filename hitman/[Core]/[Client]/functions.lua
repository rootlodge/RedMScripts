--------------------------------------------------------------------------------
----------------------------------- RootLodge -----------------------------------
--------------------------------------------------------------------------------
local VORPcore = {}
TriggerEvent("getCore", function(core) VORPcore = core end)
function Wait(args) Citizen.Wait(args) end


-- DOCUMENTATION
-- can also use exports or declare notification file name in fxmanifest
--VORPcore.NotifyTip("title",4000)
--VORPcore.NotifyLeft("title","subtitle","dict","icon",4000,"color")
--VORPcore.NotifyRightTip("title",4000)
--VORPcore.NotifyObjective("title",4000)
--VORPcore.NotifyTop("title","location",4000)
--VORPcore.NotifySimpleTop("title","subtitle",4000)
--VORPcore.NotifyAvanced("title","dict","icon","color",4000)
--VORPcore.NotifyCenter("title",4000)
--VORPcore.NotifyBottomRight("title",4000)
--VORPcore.NotifyFail("title","subtitle",4000)
--VORPcore.NotifyDead("title","audioref","audioname",4000)
--VORPcore.NotifyUpdate("title","subtitle",4000)
--VORPcore.NotifyWarning("title","subtitle","audioref","audioname",4000)
--VORPcore.NotifyLeftRank("title","subtitle","dict","icon",4000,"color")




function DrawCircle(x, y, z, r, g, b, a)
  Citizen.InvokeNative(0x2A32FAA57B937173, 0x94FDAE17, x, y, z - 0.95, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 0.25, r, g, b, a, 0, 0, 2, 0, 0, 0, 0)
end

function Notify(text, time)
  -- small tip text on the right side of the screen
  VORPcore.NotifyRightTip(text,time)
end

function topbigNotification(text, time)
  --slightly larger text in the center bottom of the screen
  VORPcore.NotifyObjective(text, time)
end

-- function for the top notification
function topNotification(text, location, time)
  -- slightly larger text in the center top of the screen
  VORPcore.NotifyTop(text, location, time)
end

-- function for the fail notification
function failNotification(text, subtitle, time)
  -- larger text in the center of the screen
  VORPcore.NotifyFail(text, subtitle, time)
end

-- function for the dead notification
function deadNotification(text, audioref, audioname, time)
  -- larger text in the center of the screen
  VORPcore.NotifyDead(text, audioref, audioname, time)
end

-- function for the update notification
function updateNotification(text, subtitle, time)
  -- larger text in the center of the screen
  VORPcore.NotifyUpdate(text, subtitle, time)
end

-- function for the warning notification
function warningNotification(text, subtitle, audioref, audioname, time)
  -- larger text in the center of the screen
  VORPcore.NotifyWarning(text, subtitle, audioref, audioname, time)
end

-- function for the left notification
function leftNotification(text, subtitle, dict, icon, time, color)
  -- smaller text on the left side of the screen
  VORPcore.NotifyLeft(text, subtitle, dict, icon, time, color)
end

-- function for the right notification
function rightNotification(text, time)
  -- smaller text on the right side of the screen
  VORPcore.NotifyRightTip(text, time)
end

-- function for the center notification
function centerNotification(text, time)
  -- larger text in the center of the screen
  VORPcore.NotifyCenter(text, time)
end

-- function for the bottom right notification
function bottomRightNotification(text, time)
  -- smaller text in the bottom right of the screen
  VORPcore.NotifyBottomRight(text, time)
end

-- function for the simple top notification
function simpleTopNotification(text, subtitle, time)
  -- slightly larger text in the center top of the screen
  VORPcore.NotifySimpleTop(text, subtitle, time)
end

-- function for the advanced notification
function advancedNotification(text, dict, icon, color, time)
  -- larger text in the center of the screen
  VORPcore.NotifyAvanced(text, dict, icon, color, time)
end

-- function for the left rank notification
function leftRankNotification(text, subtitle, dict, icon, time, color)
  -- smaller text on the left side of the screen
  VORPcore.NotifyLeftRank(text, subtitle, dict, icon, time, color)
end

-- function for the tip notification
function tipNotification(text, time)
  -- small tip text on the right side of the screen
  VORPcore.NotifyTip(text, time)
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