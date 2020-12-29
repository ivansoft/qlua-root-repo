::!C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\Common7\Tools\LaunchDevCmd.bat

@echo off

set GENERATOR=Visual Studio 16 2019
:: cmake --help
:: Generators
:: 
:: The following generators are available on this platform (* marks default):
:: * Visual Studio 16 2019        = Generates Visual Studio 2019 project files.
::                                  Use -A option to specify architecture.
::   Visual Studio 15 2017 [arch] = Generates Visual Studio 2017 project files.
::                                  Optional [arch] can be "Win64" or "ARM".
::   Visual Studio 14 2015 [arch] = Generates Visual Studio 2015 project files.
::                                  Optional [arch] can be "Win64" or "ARM".
::   Visual Studio 12 2013 [arch] = Generates Visual Studio 2013 project files.
::                                  Optional [arch] can be "Win64" or "ARM".
::   Visual Studio 11 2012 [arch] = Generates Visual Studio 2012 project files.
::                                  Optional [arch] can be "Win64" or "ARM".
::   Visual Studio 10 2010 [arch] = Generates Visual Studio 2010 project files.
::                                  Optional [arch] can be "Win64" or "IA64".
::   Visual Studio 9 2008 [arch]  = Generates Visual Studio 2008 project files.
::                                  Optional [arch] can be "Win64" or "IA64".

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
COPY /y /v /b build\Release\lua53.dll bin
COPY /y /v /b build\Release\lua.lib lib
COPY /y /v /b build\Release\lua53.lib lib
GOTO :end

:clean
::IF EXIST build RMDIR /S /Q build
::IF EXIST lua.exe DEL /F /Q lua.exe
IF EXIST build RMDIR /S /Q build
IF EXIST bin\lua.exe DEL /F /Q bin\lua.exe
IF EXIST bin\luac.exe DEL /F /Q bin\luac.exe
IF EXIST bin\lua53.dll DEL /F /Q bin\lua53.dll
IF EXIST lib\lua.lib DEL /F /Q lib\lua.lib
IF EXIST lib\lua53.lib DEL /F /Q lib\lua53.lib
GOTO :end

:end