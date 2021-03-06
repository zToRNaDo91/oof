ui_page 'oof/client/ui/index.html'

client_scripts {
    -- OOF module, nothing should precede this module
    'oof/shared/overloads.lua',
    'oof/shared/utilities/*.lua',
    'oof/shared/object-oriented/class.lua', -- no class instances on initial frame before this file
    'oof/shared/object-oriented/shGetterSetter.lua', -- getter_setter, getter_setter_encrypted
    'oof/shared/standalone-data-structures/*', -- Enum, IdPool
    'oof/shared/math/*.lua',
    '**/shared/enums/*Enum.lua', -- load all Enums
    '**/client/enums/*Enum.lua',
    'oof/shared/Events.lua',
    'oof/client/cNetwork.lua',
    'oof/shared/ValueStorage.lua',
    'oof/client/TypeCheck.lua',
    'oof/client/AssetRequester.lua',
    'oof/shared/Timer.lua',
    'oof/client/cEntity.lua',
    'oof/client/cPlayer.lua',
    'oof/client/cPlayers.lua',
    'oof/client/cPlayerManager.lua',
    'oof/client/Ped.lua',
    'oof/client/Physics.lua',
    'oof/client/LocalPlayer.lua',
    'oof/shared/Color.lua',
    'oof/client/Render.lua',
    'oof/client/Camera.lua',
    'oof/client/ObjectManager.lua',
    'oof/client/Object.lua',
    'oof/client/ScreenEffects.lua',
    'oof/client/World.lua',
    'oof/client/Sound.lua',
    'oof/client/Light.lua',
    'oof/client/ParticleEffect.lua',
    'oof/client/Filter.lua',
    'oof/client/Explosion.lua',
    'oof/client/PauseMenu.lua',
    'oof/client/Hud.lua',
    'oof/client/Keypress.lua',
    'oof/client/Prompt.lua',
    'oof/client/Imap.lua',
    'oof/client/Marker.lua',
    'oof/client/Texture.lua',
    'oof/client/apitest.lua',
    'oof/client/localplayer_behaviors/*.lua',
    'oof/client/weapons/*.lua',
    'oof/client/ui/ui.lua',

    -- Add other modules here (client and shared)

    -- LOAD LAST
    'oof/shared/object-oriented/LOAD_ABSOLUTELY_LAST.lua'
}

server_scripts {
    -- OOF module, nothing should precede this module
    'oof/server/sConfig.lua',
    'oof/shared/overloads.lua', -- load order position does not matter because this is non-class code
    'oof/shared/utilities/*.lua',
    'oof/shared/object-oriented/class.lua', -- no class instances on initial frame before this file
    'oof/shared/object-oriented/shGetterSetter.lua',
    'oof/shared/math/*.lua',
    'oof/shared/standalone-data-structures/*', -- Enum, IdPool
    '**/shared/enums/*Enum.lua', -- load all the enums from all the modules
    '**/server/enums/*Enum.lua',
    'oof/shared/Color.lua',
    'oof/shared/Events.lua',
    'oof/server/sNetwork.lua',
    -- mysql enabler
    'oof/server/mysql-async/MySQLAsync.net.dll',
    'oof/server/mysql-async/lib/init.lua',
    'oof/server/mysql-async/lib/MySQL.lua',
    -- mysql wrapper
    'oof/server/MySQL.lua',
    'oof/shared/ValueStorage.lua',
    'oof/shared/Timer.lua',
    'oof/server/sPlayer.lua',
    'oof/server/sPlayers.lua',
    'oof/server/sPlayerManager.lua',
    'oof/server/sWorld.lua',
    'oof/server/JSONUtils.lua',

    -- Add other modules here (server and shared)

    -- Load last
    'oof/shared/object-oriented/LOAD_ABSOLUTELY_LAST.lua'
}

files {
    -- general ui
    'oof/client/ui/reset.css',
    'oof/client/ui/jquery.js',
    'oof/client/ui/events.js',
    'oof/client/ui/index.html'
    -- Add files that you need here, like html/css/js for UI
}

fx_version 'adamant'
games { 'rdr3', 'gta5' }
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'