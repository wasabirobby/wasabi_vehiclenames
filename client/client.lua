-----------------For support, scripts, and more----------------
----------------- https://discord.gg/XJFNyMy3Bv ---------------
---------------------------------------------------------------
ESX = nil
local sqlVehicles = {}
local framework = ''

CreateThread(function()
    if Config.Cars then
        for k,v in pairs(Config.Cars) do
            AddTextEntry(k, v)
        end
    end
end)

CreateThread(function()
    if Config.UseSQL then
        while ESX == nil do 
            TriggerEvent("esx:getSharedObject", function(obj) 
                ESX = obj 
            end)
            Wait(500)
        end
        ESX.TriggerServerCallback('wasabi_vehiclenames:getVehicles', function(cb)          
            if cb then
                for k,v in pairs(cb) do
                    AddTextEntry(v.model, v.name)
                end
            end
        end)
    end
end)

RegisterNetEvent('wasabi_vehiclenames:sendVehicleList')
AddEventHandler('wasabi_vehiclenames:sendVehicleList', function(_vehicles)
    for k,v in ipairs(_vehicles) do
        AddTextEntry(v.model, v.name)
    end
end)
