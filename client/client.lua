-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------

ESX = exports["es_extended"]:getSharedObject()

CreateThread(function()
    if Config.UseSQL then
        ESX.TriggerServerCallback('wasabi_vehiclenames:getVehicles', function(cb)
            if cb then
                for k,v in pairs(cb) do
                    AddTextEntry(v.model, v.name)
                end
            end
        end)
    end
end)

CreateThread(function()
    if Config.Cars then
        for k,v in pairs(Config.Cars) do
            AddTextEntry(k, v)
        end
    end
end)

RegisterNetEvent('wasabi_vehiclenames:sendVehicleList')
AddEventHandler('wasabi_vehiclenames:sendVehicleList', function(_vehicles)
    for k,v in ipairs(_vehicles) do
        AddTextEntry(v.model, v.name)
    end
end)