@echo off
setlocal

call "C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\VC\Auxiliary\Build\vcvars64.bat"

rem set "CMAKE_BINARY_DIR=..\cmake-build-debug-x64"
set "CMAKE_BINARY_DIR=..\cmake-build-release-x64"

pushd %~dp0
mkdir cmake-dump-release-x64

pushd "cmake-dump-release-x64"

    dumpbin /headers %CMAKE_BINARY_DIR%\lua.exe > lua.exe.headers.txt
    dumpbin /exports %CMAKE_BINARY_DIR%\lua.exe > lua.exe.exports.txt
    dumpbin /dependents %CMAKE_BINARY_DIR%\lua.exe > lua.exe.dependents.txt
    dumpbin /imports %CMAKE_BINARY_DIR%\lua.exe > lua.exe.imports.txt

    dumpbin /headers %CMAKE_BINARY_DIR%\luac.exe > luac.exe.headers.txt
    dumpbin /exports %CMAKE_BINARY_DIR%\luac.exe > luac.exe.exports.txt
    dumpbin /dependents %CMAKE_BINARY_DIR%\luac.exe > luac.exe.dependents.txt
    dumpbin /imports %CMAKE_BINARY_DIR%\luac.exe > luac.exe.imports.txt

    dumpbin /headers %CMAKE_BINARY_DIR%\lua54.dll > lua54.dll.headers.txt
    dumpbin /exports %CMAKE_BINARY_DIR%\lua54.dll > lua54.dll.exports.txt
    dumpbin /dependents %CMAKE_BINARY_DIR%\lua54.dll > lua54.dll.dependents.txt
    dumpbin /imports %CMAKE_BINARY_DIR%\lua54.dll > lua54.dll.imports.txt

popd
popd

endlocal
