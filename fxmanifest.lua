-----------------For support, scripts, and more----------------
----------------- https://discord.gg/XJFNyMy3Bv ---------------
---------------------------------------------------------------
fx_version 'cerulean'

game 'gta5'

author 'wasabirobby#5110'

description 'ESX / QBCore vehicle name script'

version '1.0.0'

shared_script 'config.lua'

client_script 'client/*.lua'

server_scripts {
    'server/*.lua',
    '@mysql-async/lib/MySQL.lua', -- Feel free to comment out if you use 'oxmysql'
    '@oxmysql/lib/MySQL.lua', -- Feel free to comment out if you use 'mysql-async'
}