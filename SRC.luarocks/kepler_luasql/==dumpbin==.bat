@echo off

setlocal

    call "C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\VC\Auxiliary\Build\vcvars32.bat"

    pushd "cmake-build-release-x86"

        dumpbin /headers luasql.sqlite3.dll > luasql.sqlite3.dll.headers.txt
        dumpbin /exports luasql.sqlite3.dll > luasql.sqlite3.dll.exports.txt
        dumpbin /dependents luasql.sqlite3.dll > luasql.sqlite3.dll.dependents.txt
        dumpbin /imports luasql.sqlite3.dll > luasql.sqlite3.dll.imports.txt

        dumpbin /headers sqlite3.dll > sqlite3.dll.headers.txt
        dumpbin /exports sqlite3.dll > sqlite3.dll.exports.txt
        dumpbin /dependents sqlite3.dll > sqlite3.dll.dependents.txt
        dumpbin /imports sqlite3.dll > sqlite3.dll.imports.txt

    popd

    pushd "sqlite_bin\x86"

        dumpbin /headers sqlite3.dll > sqlite3.dll.headers.txt
        dumpbin /exports sqlite3.dll > sqlite3.dll.exports.txt
        dumpbin /dependents sqlite3.dll > sqlite3.dll.dependents.txt
        dumpbin /imports sqlite3.dll > sqlite3.dll.imports.txt

    popd

endlocal


setlocal

    call "C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\VC\Auxiliary\Build\vcvars64.bat"

    pushd "cmake-build-release-x64"

        dumpbin /headers luasql.sqlite3.dll > luasql.sqlite3.dll.headers.txt
        dumpbin /exports luasql.sqlite3.dll > luasql.sqlite3.dll.exports.txt
        dumpbin /dependents luasql.sqlite3.dll > luasql.sqlite3.dll.dependents.txt
        dumpbin /imports luasql.sqlite3.dll > luasql.sqlite3.dll.imports.txt

        dumpbin /headers sqlite3.dll > sqlite3.dll.headers.txt
        dumpbin /exports sqlite3.dll > sqlite3.dll.exports.txt
        dumpbin /dependents sqlite3.dll > sqlite3.dll.dependents.txt
        dumpbin /imports sqlite3.dll > sqlite3.dll.imports.txt

    popd

    pushd "sqlite_bin\x64"

        dumpbin /headers sqlite3.dll > sqlite3.dll.headers.txt
        dumpbin /exports sqlite3.dll > sqlite3.dll.exports.txt
        dumpbin /dependents sqlite3.dll > sqlite3.dll.dependents.txt
        dumpbin /imports sqlite3.dll > sqlite3.dll.imports.txt

    popd

endlocal


