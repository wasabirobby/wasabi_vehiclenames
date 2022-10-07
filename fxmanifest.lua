-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------

fx_version 'cerulean'

game 'gta5'

lua54 'yes'

author 'wasabirobby#5110'

description 'ESX / QBCore vehicle name script'

version '1.0.1'

shared_script 'config.lua'

client_script 'client/*.lua'

server_scripts {
    'server/*.lua',
    '@mysql-async/lib/MySQL.lua'
}
