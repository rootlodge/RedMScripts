--------------------------------------------------------------------------------
----------------------------------- RootLodge -----------------------------------
--------------------------------------------------------------------------------
function Wait(args) Citizen.Wait(args) end
--------------------------------------------------------------------------------
-- Varables
local InRange = false
local ActiveMenu = nil
local MenuOpen = false
local Location = nil

RegisterNetEvent('RootLodge:HitContracts:C:StartMission')
--------------------------------------------------------------------------------
-- Core
--------------------------------------------------------------------------------

function addBlipForCoords(blipname,bliphash,coords)
	local blip = Citizen.InvokeNative(0x554D9D53F696D002,1664425300, coords[1], coords[2], coords[3])
	SetBlipSprite(blip,bliphash,true)
	SetBlipScale(blip,0.2)
	Citizen.InvokeNative(0x9CB1A1623062F402, blip, blipname)
end


Citizen.CreateThread(function()
  for _, board in ipairs(Config.HandlerLocations) do
      local blipName = board.City
      local blipHash = GetHashKey("blip_summer_guard") -- Replace with your blip style
      addBlipForCoords(blipName, blipHash, {board.x, board.y, board.z})
  end
end)


-- Check player disctance from coords.
Citizen.CreateThread(function()
  while true do Wait(2000)
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    for k, v in pairs(Config.HandlerLocations) do

      local dist = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, v.x, v.y, v.z)

      if Location == nil and (dist <= 5) then Location = v.City end
      if Location == v.City then

        -- Set user if out of range
        if (dist > 5) and InRange then
          InRange = false
          Location = nil
          WarMenu.CloseMenu()
          Wait(1000)
        end

        -- Set user if in range
        if (dist <= 5) and not InRange then
          InRange = true
          Location = v.City
          TriggerEvent('RootLodge:HitContracts:C:StartMission')
        end
      end
    end
  end
end)

-- Check players distance from the stores.
AddEventHandler('RootLodge:HitContracts:C:StartMission', function()
  local ped = PlayerPedId()
  while InRange do Wait(1)
    local coords = GetEntityCoords(ped)
    for k, v in pairs(Config.HandlerLocations) do
      local x, y, z = v.x, v.y, v.z
      local dist = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, x, y, z)

      -- Turn cirle red when not in range
      if (dist > 2) and not OpenMenu then DrawCircle(x, y, z, 217, 17, 17, 50) end

      if (dist <= 2) then
        -- Turn cirle green if in range
        if not OpenMenu then DrawCircle(x, y, z, 17, 217, 27, 50) end
        if not MenuOpen then DrawInfo('Press [ ~e~SPACE~q~ ] to open the menu', 0.5, 0.95, 0.75) end
        if IsControlJustPressed(0, Config.Keys['SPACEBAR']) then
          MenuOpen = true
          ActiveMenu = 'BountyMenu'
          WarMenu.OpenMenu('BountyMenu')
        end

        if IsControlJustPressed(0, Config.Keys['BACKSPACE']) then
          if ActiveMenu == 'BountyMenu' then WarMenu.CloseMenu() ActiveMenu = nil MenuOpen = false Location = nil
          elseif ActiveMenu == 'PVEMenu' then WarMenu.OpenMenu('BountyMenu') ActiveMenu = 'BountyMenu'
          elseif ActiveMenu == 'PVPMenu' then WarMenu.OpenMenu('BountyMenu') ActiveMenu = 'BountyMenu'
          end
        end
      end
    end
  end
end)

local iamalwaystrue = true

Citizen.CreateThread(function()
    while true do
        Wait(1)
        if iamalwaystrue then
            for k, v in pairs(Config.HandlerLocations) do
                local locx, locy, locz = v.x, v.y, v.z
                local locw = 100.41544342041 -- Assuming this is the heading, adjust as needed

                local spawned = false
                print("Checking for NPC spawn: " .. v.City)

                for cityname, npcData in pairs(Config.HandlerNPC) do
                  print ("Cityname: " .. cityname)
                    if cityname == v.City and not spawned then
                        local npcname = npcData.NPC
                        print("Spawning NPC: " .. npcname .. " at " .. locx .. ", " .. locy .. ", " .. locz .. ", " .. locw)
                        local pedHash = GetHashKey(npcname)
                        print("Hash: " .. pedHash)
                        RequestModel(pedHash)
                        while not HasModelLoaded(pedHash) do
                            Wait(100)
                        end
                        print("Model loaded")
                        --local spawnrec = CreatePed(pedHash, locx, locy, locz, locw, false, true, true, true)
                        --SetEntityNoCollisionEntity(PlayerPedId(), spawnrec, false)
                        --SetEntityCanBeDamaged(spawnrec, false)
                        --SetEntityInvincible(spawnrec, true)
                        --Wait(1000)
                        --FreezeEntityPosition(spawnrec, true)
                        --SetBlockingOfNonTemporaryEvents(spawnrec, true)
                        --TaskStartScenarioAtPosition(spawnrec, Config.HandlerScenario, locx, locy, locz, locw, -1, false, true)
                        --Wait(1000)
                        spawned = true -- Mark as spawned for this location
                        break
                    end
                end
            end
        end
    end
end)

-- Warmenu
Citizen.CreateThread(function()
  CreateMenus()
  while true do Wait(1)
    local War = WarMenu.IsMenuOpened
    if War('BountyMenu') then BountyMenu()
    elseif War('PVEMenu') then PVEMenu()
    elseif War('PVPMenu') then PVPMenu()
    end
  end
end)


function CreateMenus()
  WarMenu.CreateMenu('BountyMenu', 'Bounty Board')
  WarMenu.SetSubTitle('BountyMenu', 'Made By RootLodge')
  WarMenu.CreateMenu('PVEMenu', 'Bounty Board')
  WarMenu.SetSubTitle('PVEMenu', 'Hunt NPCs')
  WarMenu.CreateMenu('PVPMenu', 'Bounty Board')
  WarMenu.SetSubTitle('PVPMenu', 'Hunt Humans')
end

--------------------------------------------------------------------------------
-- Page 1 - Home Page
--------------------------------------------------------------------------------
function BountyMenu ()
  ActiveMenu = 'BountyMenu'
  local Pve = WarMenu.Button('PVE Menu', '', '')
  local Pvp = WarMenu.Button('PVP Menu', '', '')
  if Pve then WarMenu.OpenMenu('PVEMenu') end
  if Pvp then Beta() end--WarMenu.OpenMenu('PVPMenu') end
  WarMenu.Display()
end

--------------------------------------------------------------------------------
-- Page 2 - Category Section
--------------------------------------------------------------------------------
function PVEMenu ()
  ActiveMenu = 'PVEMenu'
  local hunt = WarMenu.Button('Hunt a Bounty', '', 'Your daily basic needs')
  local payment = WarMenu.Button('Receive Payment', '', 'Other Items')

  if hunt then
   Location = nil
   TriggerServerEvent('RootLodge:HitContracts:S:CheckCharacter')
  end

  if payment and (TotalKilled > 0)then
    TriggerServerEvent('RootLodge:HitContracts:S:PayDay', TotalKilled)
    TotalKilled = 0
    SetGpsMultiRouteRender(false)
    Location = nil
    ActiveMenu = nil
    MenuOpen = false
    WarMenu.CloseMenu()
  elseif payment and (TotalKilled == 0) then
    Location = nil
    Notify("You've no recorded bounty kills, partner!", 5000)
  end
  WarMenu.Display()
end

function PVPMenu ()
  ActiveMenu = 'PVPMenu'
  local bounty = WarMenu.Button('Hunt a Bounty', '', '')
  local sbounty = WarMenu.Button('Set a Bounty', '', '')
  local payment = WarMenu.Button('Receive Payment', '', '')
  if bounty then end
  if sbounty then end
  if payment then end
  WarMenu.Display()
end

function Beta()
  Notify('This feature is currently being build!')
  Notify('and will be released in a later version.')
end