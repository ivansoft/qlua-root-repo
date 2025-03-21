@echo off

@call "C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\VC\Auxiliary\Build\vcvars32.bat"
:: @call "C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\VC\Auxiliary\Build\vcvars64.bat"

pushd "cmake-build-vs2019-release-x86"

    dumpbin /headers lua.exe > lua.exe.headers.txt
    dumpbin /exports lua.exe > lua.exe.exports.txt
    dumpbin /dependents lua.exe > lua.exe.dependents.txt
    dumpbin /imports lua.exe > lua.exe.imports.txt

    dumpbin /headers luac.exe > luac.exe.headers.txt
    dumpbin /exports luac.exe > luac.exe.exports.txt
    dumpbin /dependents luac.exe > luac.exe.dependents.txt
    dumpbin /imports luac.exe > luac.exe.imports.txt

    dumpbin /headers lua53.dll > lua53.dll.headers.txt
    dumpbin /exports lua53.dll > lua53.dll.exports.txt
    dumpbin /dependents lua53.dll > lua53.dll.dependents.txt
    dumpbin /imports lua53.dll > lua53.dll.imports.txt

popd

pushd "cmake-build-vs2019-release-x64"

    dumpbin /headers lua.exe > lua.exe.headers.txt
    dumpbin /exports lua.exe > lua.exe.exports.txt
    dumpbin /dependents lua.exe > lua.exe.dependents.txt
    dumpbin /imports lua.exe > lua.exe.imports.txt

    dumpbin /headers luac.exe > luac.exe.headers.txt
    dumpbin /exports luac.exe > luac.exe.exports.txt
    dumpbin /dependents luac.exe > luac.exe.dependents.txt
    dumpbin /imports luac.exe > luac.exe.imports.txt

    dumpbin /headers lua53.dll > lua53.dll.headers.txt
    dumpbin /exports lua53.dll > lua53.dll.exports.txt
    dumpbin /dependents lua53.dll > lua53.dll.dependents.txt
    dumpbin /imports lua53.dll > lua53.dll.imports.txt

popd
