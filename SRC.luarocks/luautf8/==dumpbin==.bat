@echo off

setlocal

	call "C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\VC\Auxiliary\Build\vcvars32.bat"

	pushd "cmake-build-release-x86"

	    dumpbin /headers lua-utf8.dll > lua-utf8.dll.headers.txt
	    dumpbin /exports lua-utf8.dll > lua-utf8.dll.exports.txt
	    dumpbin /dependents lua-utf8.dll > lua-utf8.dll.dependents.txt
	    dumpbin /imports lua-utf8.dll > lua-utf8.dll.imports.txt

	popd

endlocal


setlocal

	call "C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\VC\Auxiliary\Build\vcvars64.bat"

	pushd "cmake-build-release-x64"

	    dumpbin /headers lua-utf8.dll > lua-utf8.dll.headers.txt
	    dumpbin /exports lua-utf8.dll > lua-utf8.dll.exports.txt
	    dumpbin /dependents lua-utf8.dll > lua-utf8.dll.dependents.txt
	    dumpbin /imports lua-utf8.dll > lua-utf8.dll.imports.txt

	popd

endlocal


