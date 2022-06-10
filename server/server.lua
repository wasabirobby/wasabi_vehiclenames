-----------------For support, scripts, and more----------------
----------------- https://discord.gg/XJFNyMy3Bv ---------------
---------------------------------------------------------------
ESX, QBCore = nil, nil
local framework = ''
local vehicles = {}

CreateThread(function()
    if Config.UseSQL then
        if framework == '' then
            if GetResourceState('es_extended') == "started" then
                framework = 'esx'
                TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)
                print('wasabi_vehiclenames: Framework found - ESX')
            elseif GetResourceState('qb-core') == "started" then
                framework = 'qb'
                QBCore = exports["qb-core"]:GetCoreObject()
                print('wasabi_vehiclenames: Framework found - QBCore')
            elseif GetResourceState('qb-core') ~= "started" and GetResourceState('es_extended') ~= "started" then
                print('wasabi_vehiclenames: Unable to load SQL vehicles - Reason: Framework not found')
            end
        end
    end
end)

CreateThread(function()
    if Config.UseSQL and framework ~= '' then
        MySQL.Async.fetchAll('SELECT * FROM vehicles', {}, function(_vehicles)
            for k,v in ipairs(_vehicles) do
                table.insert(vehicles, {
                    model = v.model,
                    name = v.name
                })
            end
        end)
        if framework == 'esx' then
            TriggerEvent('wasabi_vehiclenames:startESX')
        elseif framework == 'qb' then
            TriggerEvent('wasabi_vehiclenames:startQB')
        end
    end
end)



AddEventHandler('wasabi_vehiclenames:startESX', function()
    CreateThread(function()
        if framework ~= 'esx' then
            print('wasabi_vehiclenames: Did not load ESX properly! Make sure this script starts after framework!')
            return
        end
        ESX.RegisterServerCallback('wasabi_vehiclenames:getVehicles', function(source, cb)
            if vehicles then
                cb(vehicles)
            else
                cb(false)
            end
        end)
        TriggerClientEvent('wasabi_vehiclenames:sendVehicleList', -1, vehicles)
        print('wasabi_vehiclenames: Loaded '..#vehicles..' vehicle names from SQL database.')
    end)
end)

AddEventHandler('wasabi_vehiclenames:startQB', function()
    CreateThread(function()
        if framework ~= 'qb' then
            print('wasabi_vehiclenames: Did not load QB properly! Make sure this script starts after framework!')
            return
        end
        QBCore.Functions.CreateCallback('wasabi_vehiclenames:getVehicles', function(source, cb)
            if vehicles then
                cb(vehicles)
            else
                cb(false)
            end
        end)
        TriggerClientEvent('wasabi_vehiclenames:sendVehicleList', -1, vehicles)
        print('wasabi_vehiclenames: Loaded '..#vehicles..' vehicle names from SQL database.')
    end)
end)
