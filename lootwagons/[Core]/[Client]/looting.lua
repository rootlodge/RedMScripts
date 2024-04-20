-- Looting Logic
-- Continually checks if the player is looting a wagon, and if they are, it will trigger the looting animation and the looting progress bar, also checks if the player is within the loot wagon


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