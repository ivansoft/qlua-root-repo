-- 
-- https://github.com/luarocks/luarocks/wiki/Config-file-format
-- 

--[[
rocks_trees (array of strings or tables)

The path to the local rocks trees, where rocks are installed. 

When installing rocks, LuaRocks tries to pick a location to store the rock starting from the bottom of the list.
When loading rocks in runtime, LuaRocks scans from the top of the list.
--]]
rocks_trees = {
	"C:\\FX\\LUA\\lua-5.4.1\\.luarocks"
	-- { root = "", bin_dir = "", lib_dir = "", lua_dir ="" }
}


--[[
variables (table) - string-to-string key-value pairs

LuaRocks can substitute the entries of this table in strings containing references written $(LIKE_THIS).
"make" expects the LIBFLAG, so, in Linux systems, variables["LIBFLAG"] = "-shared".
--]]
variables = {
	LUA = "C:\\FX\\LUA\\lua-5.4.1\\bin\\lua.exe",
	LUA_BINDIR = "C:\\FX\\LUA\\lua-5.4.1\\bin",
	LUA_INCDIR = "C:\\FX\\LUA\\lua-5.4.1\\include",
	LUA_LIBDIR = "C:\\FX\\LUA\\lua-5.4.1\\lib",
}


--[[
rocks_servers (array of strings)

Default is { "http://luarocks.org/repositories/rocks" }.

Remote URLs or local pathnames of rocks servers: directories containing .rock or .rockspec files,
and a "manifest" file, generated by the luarocks-admin make_manifest command.
--]]
-- rocks_servers = {}


--[[
external_deps_dirs (array of strings)

Default is { "/usr/local", "/usr" } on Unix; { "c:\\external" } on Windows.

Where to look for external dependencies,
when a prefix is not set for a specific dependency in the _variables_ table or through the command-line.
--]]
-- external_deps_dirs = {}


--[[
external_deps_subdirs (table with string keys and string values)

Default is { bin = "bin", lib = "lib", include = "include" }.

Subdirectories to be used in conjunction with external_deps_dirs.
Specifies where to look for specific types external dependencies.
--]]
-- external_deps_subdirs = {}


--[[
runtime_external_deps_subdirs (table with string keys and string values)
Same as external_deps_subdirs, to be used with luarocks install.
--]]
-- runtime_external_deps_subdirs = {}


--[[
lib_modules_path (string)
The path where modules with native C extensions will be installed.
If you are using a x86_64 *nix OS: lib_modules_path="/lib64/lua/"..lua_version.
--]]
-- lib_modules_path = {}


-- upload_server = ""
-- upload_user = ""
-- upload_password = ""
-- upload_servers = { rocks = { http = "www.example.com/rocks", sftp = "example.com/var/rocks" } }
