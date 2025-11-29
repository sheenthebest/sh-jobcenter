fx_version 'adamant'
game 'gta5'
lua54 'yes'

author 'sheen'
description 'Job Center'
version '2.0'

shared_scripts {
    '@ox_lib/init.lua',
}

server_scripts {
    'server/server.lua',
    'bridge/server/**.lua'
}

client_scripts {
    'client/client.lua',
}

ui_page 'html/index.html'
files { 
    'config.lua',
    
    'html/imgs/**.png',
    'html/index.html', 
    'html/script.js',
    'html/styles.css'
}
