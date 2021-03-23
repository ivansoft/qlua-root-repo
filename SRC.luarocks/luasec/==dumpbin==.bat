@echo off

@call "C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\VC\Auxiliary\Build\vcvars32.bat"
:: @call "C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\VC\Auxiliary\Build\vcvars64.bat"

pushd "cmake-build-release-x86"

    dumpbin /headers libcrypto-1_1.dll > libcrypto-1_1.dll.headers.txt
    dumpbin /exports libcrypto-1_1.dll > libcrypto-1_1.dll.exports.txt
    dumpbin /dependents libcrypto-1_1.dll > libcrypto-1_1.dll.dependents.txt
    dumpbin /imports libcrypto-1_1.dll > libcrypto-1_1.dll.imports.txt

    dumpbin /headers libssl-1_1.dll > libssl-1_1.dll.headers.txt
    dumpbin /exports libssl-1_1.dll > libssl-1_1.dll.exports.txt
    dumpbin /dependents libssl-1_1.dll > libssl-1_1.dll.dependents.txt
    dumpbin /imports libssl-1_1.dll > libssl-1_1.dll.imports.txt

    dumpbin /headers ssl.dll > ssl.dll.headers.txt
    dumpbin /exports ssl.dll > ssl.dll.exports.txt
    dumpbin /dependents ssl.dll > ssl.dll.dependents.txt
    dumpbin /imports ssl.dll > ssl.dll.imports.txt

popd

pushd "cmake-build-release-x64"

    dumpbin /headers libcrypto-1_1-x64.dll > libcrypto-1_1-x64.dll.headers.txt
    dumpbin /exports libcrypto-1_1-x64.dll > libcrypto-1_1-x64.dll.exports.txt
    dumpbin /dependents libcrypto-1_1-x64.dll > libcrypto-1_1-x64.dll.dependents.txt
    dumpbin /imports libcrypto-1_1-x64.dll > libcrypto-1_1-x64.dll.imports.txt

    dumpbin /headers libssl-1_1-x64.dll > libssl-1_1-x64.dll.headers.txt
    dumpbin /exports libssl-1_1-x64.dll > libssl-1_1-x64.dll.exports.txt
    dumpbin /dependents libssl-1_1-x64.dll > libssl-1_1-x64.dll.dependents.txt
    dumpbin /imports libssl-1_1-x64.dll > libssl-1_1-x64.dll.imports.txt

    dumpbin /headers ssl.dll > ssl.dll.headers.txt
    dumpbin /exports ssl.dll > ssl.dll.exports.txt
    dumpbin /dependents ssl.dll > ssl.dll.dependents.txt
    dumpbin /imports ssl.dll > ssl.dll.imports.txt

popd

