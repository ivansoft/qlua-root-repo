@echo off

setlocal

	call "C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\VC\Auxiliary\Build\vcvars32.bat"

	pushd "cmake-build-release-x86"

	    dumpbin /headers socket\core.dll > socket\core.dll.headers.txt
	    dumpbin /exports socket\core.dll > socket\core.dll.exports.txt
	    dumpbin /dependents socket\core.dll > socket\core.dll.dependents.txt
	    dumpbin /imports socket\core.dll > socket\core.dll.imports.txt

	    dumpbin /headers mime\core.dll > mime\core.dll.headers.txt
	    dumpbin /exports mime\core.dll > mime\core.dll.exports.txt
	    dumpbin /dependents mime\core.dll > mime\core.dll.dependents.txt
	    dumpbin /imports mime\core.dll > mime\core.dll.imports.txt

	popd

endlocal


setlocal

	call "C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\VC\Auxiliary\Build\vcvars64.bat"

	pushd "cmake-build-release-x64"

	    dumpbin /headers socket\core.dll > socket\core.dll.headers.txt
	    dumpbin /exports socket\core.dll > socket\core.dll.exports.txt
	    dumpbin /dependents socket\core.dll > socket\core.dll.dependents.txt
	    dumpbin /imports socket\core.dll > socket\core.dll.imports.txt

	    dumpbin /headers mime\core.dll > mime\core.dll.headers.txt
	    dumpbin /exports mime\core.dll > mime\core.dll.exports.txt
	    dumpbin /dependents mime\core.dll > mime\core.dll.dependents.txt
	    dumpbin /imports mime\core.dll > mime\core.dll.imports.txt

	popd

endlocal


