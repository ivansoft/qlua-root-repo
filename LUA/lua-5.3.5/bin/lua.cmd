::!C:\Windows\System32\cmd.exe

@echo off

setlocal EnableDelayedExpansion

set PATH=%~dp0;%PATH%
set LUAROCKS_CONFIG=%~dp0..\config-5.3.lua
:: set LUAROCKS_SYSCONFDIR=%~dp0..

:: Set search paths to user environment settings, followed by system path, and finally rocks_trees.
set save_LUA_PATH=%LUA_PATH%
set save_LUA_CPATH=%LUA_PATH%

:: call luarocks.cmd path
for /f "delims=" %%k in ('"luarocks53.exe path"') do (
	set s=%%k
	if "!s:~0,3!"=="SET" !s!
)

set LUA_PATH=%save_LUA_PATH%;%LUA_PATH%
set LUA_CPATH=%save_LUA_CPATH%;%LUA_CPATH%

lua.exe %*
