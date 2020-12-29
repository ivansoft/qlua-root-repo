::!C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\Common7\Tools\LaunchDevCmd.bat

@echo off

set GENERATOR=Visual Studio 16 2019

::if not defined platform set platform=x64
::if "%platform%" EQU "x64" (set GENERATOR=%GENERATOR% Win64)

IF NOT "x%1" == "x" GOTO :%1

GOTO :build

:build
echo "%GENERATOR%"
cmake -H. -Bbuild -G"%GENERATOR%" -A Win32
::LuaRocks installler is 32 bit only
::cmake -H. -Bbuild -G"%GENERATOR%" -A x64
cmake --build build --config Release
::COPY build\Release\lua.exe .
COPY /y /v /b build\Release\lua.exe bin
COPY /y /v /b build\Release\luac.exe bin
COPY /y /v /b build\Release\lua54.dll bin
COPY /y /v /b build\Release\lua.lib lib
COPY /y /v /b build\Release\lua54.lib lib
GOTO :end

:clean
::IF EXIST build RMDIR /S /Q build
::IF EXIST lua.exe DEL /F /Q lua.exe
IF EXIST build RMDIR /S /Q build
IF EXIST bin\lua.exe DEL /F /Q bin\lua.exe
IF EXIST bin\luac.exe DEL /F /Q bin\luac.exe
IF EXIST bin\lua54.dll DEL /F /Q bin\lua54.dll
IF EXIST lib\lua.lib DEL /F /Q lib\lua.lib
IF EXIST lib\lua54.lib DEL /F /Q lib\lua54.lib
GOTO :end

:end