::!C:\Windows\System32\cmd.exe

@echo off

setlocal EnableDelayedExpansion

set PATH=%~dp0;%PATH%
set LUAROCKS_CONFIG=%~dp0..\config-5.3.lua
:: set LUAROCKS_SYSCONFDIR=%~dp0..

:: luarocks53.exe %*
for /f "delims=" %%k in ('"luarocks53.exe %*"') do (
	set s=%%k
	if "!s:~0,3!"=="SET" (
		!s!
	) else (
		echo !s!
	)
)

:: echo %LUA_PATH%
:: echo %LUA_CPATH%
