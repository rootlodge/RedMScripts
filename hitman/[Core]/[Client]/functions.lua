--------------------------------------------------------------------------------
----------------------------------- RootLodge -----------------------------------
--------------------------------------------------------------------------------
function DrawCircle(x, y, z, r, g, b, a)
  Citizen.InvokeNative(0x2A32FAA57B937173, 0x94FDAE17, x, y, z - 0.95, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 0.25, r, g, b, a, 0, 0, 2, 0, 0, 0, 0)
end

function Notify(text, time)
  --VORPcore.NotifyRightTip(text,time)
  TriggerEvent("vorp:TipRight", text, time)
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

function DrawText3D(x,y,z, text)
  local onScreen,_x,_y=GetScreenCoordFromWorldCoord(x,y,z)
  local px,py,pz=table.unpack(GetGameplayCamCoord())
  local str = CreateVarString(10, "LITERAL_STRING", text, Citizen.ResultAsLong())
  SetTextScale(0.35, 0.35)
  SetTextFontForCurrentCommand(7)
  SetTextColor(255, 255, 255, 215)
  SetTextCentre(1)
  DisplayText(str,_x,_y)
  local factor = (string.len(text)) / 370
  DrawRect(_x,_y+0.0125, 0.085+ factor, 0.03, 41, 11, 41, 68)
end

function DrawText(text, x, y, fontscale, fontsize, r, g, b, alpha, textcentred, shadow)
  local str = CreateVarString(10, "LITERAL_STRING", text)
  SetTextScale(fontscale, fontsize)
  SetTextColor(r, g, b, alpha)
  SetTextCentre(textcentred)
  if shadow then 
    SetTextDropshadow(1, 0, 0, 255)
  end
  SetTextFontForCurrentCommand(1)
  DisplayText(str, x, y)
end