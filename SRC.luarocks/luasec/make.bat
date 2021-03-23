::!C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\Common7\Tools\LaunchDevCmd.bat

@echo off

set GENERATOR=Visual Studio 16 2019
:: cmake --help
:: Generators

IF NOT "x%1" == "x" GOTO :%1

GOTO :build

:build
echo "%GENERATOR%"
cmake -H. -Bbuild -G"%GENERATOR%" -A Win32
::LuaRocks installler is 32 bit only
::cmake -H. -Bbuild -G"%GENERATOR%" -A x64
cmake --build build --config Release

GOTO :end

:clean

GOTO :end

:end