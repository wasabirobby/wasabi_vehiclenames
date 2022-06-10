-----------------For support, scripts, and more----------------
----------------- https://discord.gg/XJFNyMy3Bv ---------------
---------------------------------------------------------------
ESX, QBCore = nil, nil
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
        if framework == '' then
            if GetResourceState('es_extended') == "started" then
                framework = 'esx'
                while ESX == nil do 
                    TriggerEvent("esx:getSharedObject", function(obj) 
                        ESX = obj 
                    end)
                    Wait(500)
                end
            elseif GetResourceState('qb-core') == "started" then
                framework = 'qb'
                QBCore = exports["qb-core"]:GetCoreObject()
            end
        end
    end
end)

CreateThread(function()
    if Config.UseSQL and framework ~= '' then
        if framework == 'esx' then
            ESX.TriggerServerCallback('wasabi_vehiclenames:getVehicles', function(cb)          
                if cb then
                    for k,v in pairs(cb) do
                        AddTextEntry(v.model, v.name)
                    end
                end
            end)
        elseif framework == 'qb' then
            QBCore.Functions.TriggerCallback('wasabi_vehiclenames:getVehicles', function(cb)       
                if cb then
                    for k,v in pairs(cb) do
                        AddTextEntry(v.model, v.name)
                    end
                end
            end)
        end
    end
end)

RegisterNetEvent('wasabi_vehiclenames:sendVehicleList')
AddEventHandler('wasabi_vehiclenames:sendVehicleList', function(_vehicles)
    for k,v in ipairs(_vehicles) do
        AddTextEntry(v.model, v.name)
    end
end)
