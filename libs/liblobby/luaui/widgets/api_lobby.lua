--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

function widget:GetInfo()
	return {
		name      = "LibLobby API",
		desc      = "LibLobby GUI Framework",
		author    = "gajop",
		date      = "WIP",
		license   = "GPLv2",
		version   = "0.2",
		layer     = -1000,
		enabled   = true,  --  loaded by default?
		handler   = true,
		api       = true,
		hidden    = true,
	}
end


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- LibLobby's location

LIB_LOBBY_DIRNAME = "libs/liblobby/lobby/"

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local config
if VFS.FileExists("luaui/configs/liblobby_configuration.lua") then
	config = VFS.Include("luaui/configs/liblobby_configuration.lua", nil, VFS.RAW_FIRST)
else
	config = VFS.Include("libs/liblobby/luaui/configs/liblobby_configuration.lua", nil, VFS.RAW_FIRST)
end

function widget:Initialize()
	LCS = loadstring(VFS.LoadFile("libs/lcs/LCS.lua"))
	LCS = LCS()

	VFS.Include(LIB_LOBBY_DIRNAME .. "observable.lua", nil, VFS.RAW_FIRST)
	WG.Server = config.server
	Spring.Utilities.TableEcho(WG.Server)
	if WG.Server.ZKServer then
		Interface = VFS.Include(LIB_LOBBY_DIRNAME .. "interface_zerok.lua", nil, VFS.RAW_FIRST)
		Wrapper = VFS.Include(LIB_LOBBY_DIRNAME .. "wrapper_zerok.lua", nil, VFS.RAW_FIRST)
	else
		Interface = VFS.Include(LIB_LOBBY_DIRNAME .. "interface.lua", nil, VFS.RAW_FIRST)
		Wrapper = VFS.Include(LIB_LOBBY_DIRNAME .. "wrapper.lua", nil, VFS.RAW_FIRST)
	end

	self.lobby = Wrapper()


	--// Export Widget Globals
	WG.LibLobby = {
	lobby = self.lobby -- instance (singleton)
	}

end

function widget:Shutdown()
	WG.LibLobby = nil
end

function widget:Update()
	WG.LibLobby.lobby:Update()
end
