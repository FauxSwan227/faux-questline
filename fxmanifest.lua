fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'faux-questline'
author 'Codex'
description 'QBCore questline progression UI and starter workflow'
version '0.1.0'

dependencies {
    'qb-core',
    'ox_inventory'
}

ui_page 'html/index.html'

shared_scripts {
    'config.lua'
}

client_scripts {
    'client/main.lua'
}

server_scripts {
    'server/inventory.lua',
    'server/main.lua'
}

files {
    'html/index.html',
    'html/app.js',
    'html/style.css',
    'html/img/contract-bg.avif'
}
