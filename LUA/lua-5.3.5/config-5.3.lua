rocks_trees = {
    { name = [[user]],
         root    = home..[[/luarocks]],
    },
    { name = [[system]],
         root    = [[C:\FX\LUA\lua-5.3.5\luarocks\systree]],
    },
}
variables = {
    MSVCRT = 'VCRUNTIME140',
    LUALIB = 'lua53.lib',
}
external_deps_dirs = {
	[[C:\FX\LUA\SRC.external]],
}
verbose = false   -- set to 'true' to enable verbose output
