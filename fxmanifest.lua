fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'faux-onboard'
author 'Codex'
description 'QBCore multi-page city onboarding UI'
version '0.1.0'

dependencies {
    'qb-core',
    'oxmysql'
}

ui_page 'html/index.html'

shared_scripts {
    'config.lua'
}

client_scripts {
    'client/main.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/main.lua'
}

files {
    'html/index.html',
    'html/app.js',
    'html/style.css',
    'html/img/*.avif',
    'html/img/*.png',
    'html/img/*.jpg',
    'html/img/*.jpeg',
    'html/img/*.webp',
    'html/img/*.svg'
}
