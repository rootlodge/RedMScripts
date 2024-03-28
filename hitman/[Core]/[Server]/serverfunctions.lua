-- Server functions 

function devserverdebug(text)
    if Config.Debug then
        print('^1[Hitman Contracts] ^7' .. text)
    end
end