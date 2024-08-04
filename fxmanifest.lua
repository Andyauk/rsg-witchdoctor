fx_version 'adamant'
games {'rdr3'}
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

description 'rsg-witchdoctor'
version '1.0.3'

client_scripts {
    'client/client.lua'
}

server_scripts {
    'server/server.lua'
}

shared_scripts {
    'config.lua',
    '@ox_lib/init.lua'
}

dependencies {
    'rsg-core',
    'rsg-medic',
    'ox_lib'
}

lua54 'yes'
