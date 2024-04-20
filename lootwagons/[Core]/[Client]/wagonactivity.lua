-- Monitors the activity of the wagons, and changes variables if they have been looted

-- decrease the count of the wagon type if it has been looted 

-- check if player is within 25 units of a wagon
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local wagon = GetClosestObjectOfType(playerCoords, 25.0, GetHashKey('wagon05x'), false, false, false)
        local wagonCoords = GetEntityCoords(wagon)
        local distance = #(playerCoords - wagonCoords)
        if distance < 25.0 then
            wagonActivity('Bank')
        end
    end
end)


function DecreaseWagonCount(wagonType) 
    if wagonType == 'Oil' then
        OilWagonCount = OilWagonCount - 1
    elseif wagonType == 'Civilian' then
        CivilianWagonCount = CivilianWagonCount - 1
    elseif wagonType == 'HighSociety' then
        HighSocietyWagonCount = HighSocietyWagonCount - 1
    elseif wagonType == 'Military' then
        MilitaryWagonCount = MilitaryWagonCount - 1
    elseif wagonType == 'Outlaw' then
        OutlawWagonCount = OutlawWagonCount - 1
    elseif wagonType == 'Bank' then
        BankWagonCount = BankWagonCount - 1
    end
end

local function wagonActivity(wagonType) 
    if Wagons[wagonType] then
        if Wagons[wagonType].looted == false then
            Wagons[wagonType].looted = true
            DecreaseWagonCount(wagonType)
        end
    end
end


-- check if player is within 25 units of a wagon
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local wagon = GetClosestObjectOfType(playerCoords, 25.0, GetHashKey('wagon05x'), false, false, false)
        local wagonCoords = GetEntityCoords(wagon)
        local distance = #(playerCoords - wagonCoords)
        if distance < 25.0 then
            wagonActivity('Bank')
        end
    end
end)