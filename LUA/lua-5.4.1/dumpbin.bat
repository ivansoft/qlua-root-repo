@echo off
setlocal

call "C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\VC\Auxiliary\Build\vcvars64.bat"

pushd "cmake-build-release-x64"

    dumpbin /headers lua.exe > lua.exe.headers.txt
    dumpbin /exports lua.exe > lua.exe.exports.txt
    dumpbin /dependents lua.exe > lua.exe.dependents.txt
    dumpbin /imports lua.exe > lua.exe.imports.txt

    dumpbin /headers luac.exe > luac.exe.headers.txt
    dumpbin /exports luac.exe > luac.exe.exports.txt
    dumpbin /dependents luac.exe > luac.exe.dependents.txt
    dumpbin /imports luac.exe > luac.exe.imports.txts

    dumpbin /headers lua54.dll > lua54.dll.headers.txt
    dumpbin /exports lua54.dll > lua54.dll.exports.txt
    dumpbin /dependents lua54.dll > lua54.dll.dependents.txt
    dumpbin /imports lua54.dll > lua54.dll.imports.txt

popd

endlocal
