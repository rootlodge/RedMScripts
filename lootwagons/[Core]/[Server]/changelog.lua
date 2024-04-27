function Wait(args) Citizen.Wait(args) end
if Config.CheckForUpdates then
    local function ChangeLog(_type, log)
        local color = _type == 'success' and '^2' or '^1'
        print(('^8[Loot Wagons]%s %s^7'):format(color, log))
    end

    local function CheckChangeLog()
        PerformHttpRequest('https://raw.githubusercontent.com/rootlodge/RedMScripts/master/lootwagons-changelog.txt', function(err, text, headers)
            if not text then
                ChangeLog('error', 'Currently unable to run a Change check.')
                return
            end
            ChangeLog('success', ('Latest Changes: %s'):format(text))
            if text:gsub("%s+", "") == currentChange:gsub("%s+", "") then
                ChangeLog('success', 'Please update if you have not!')
            else
                ChangeLog('error', ('Unkown ChangeLog error, please contact Root Lodge Script Support! %s'):format(text))
            end
        end)
    end

    Wait(45000)
    CheckChangeLog()
end