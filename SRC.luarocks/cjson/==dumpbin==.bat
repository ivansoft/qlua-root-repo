@echo off

setlocal

    call "C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\VC\Auxiliary\Build\vcvars32.bat"

    pushd "cmake-build-release-x86"

        dumpbin /headers cjson.dll > cjson.dll.headers.txt
        dumpbin /exports cjson.dll > cjson.dll.exports.txt
        dumpbin /dependents cjson.dll > cjson.dll.dependents.txt
        dumpbin /imports cjson.dll > cjson.dll.imports.txt

    popd

endlocal


setlocal

    call "C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\VC\Auxiliary\Build\vcvars64.bat"

    pushd "cmake-build-release-x64"

        dumpbin /headers cjson.dll > cjson.dll.headers.txt
        dumpbin /exports cjson.dll > cjson.dll.exports.txt
        dumpbin /dependents cjson.dll > cjson.dll.dependents.txt
        dumpbin /imports cjson.dll > cjson.dll.imports.txt

    popd

endlocal


