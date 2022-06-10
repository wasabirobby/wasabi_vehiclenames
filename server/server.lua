-----------------For support, scripts, and more----------------
----------------- https://discord.gg/XJFNyMy3Bv ---------------
---------------------------------------------------------------
ESX = nil
local vehicles = {}

CreateThread(function()
    if Config.UseSQL then
        TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)
    end
end)

CreateThread(function()
    if Config.UseSQL then
        MySQL.Async.fetchAll('SELECT * FROM vehicles', {}, function(_vehicles)
            for k,v in ipairs(_vehicles) do
                table.insert(vehicles, {
                    model = v.model,
                    name = v.name
                })
            end
        end)
        TriggerClientEvent('wasabi_vehiclenames:sendVehicleList', -1, vehicles)
        print('wasabi_vehiclenames: Loaded '..#vehicles..' vehicle names from SQL database.')
    end
end)


ESX.RegisterServerCallback('wasabi_vehiclenames:getVehicles', function(source, cb)
    if vehicles then
        cb(vehicles)
    else
        cb(false)
    end
end)
