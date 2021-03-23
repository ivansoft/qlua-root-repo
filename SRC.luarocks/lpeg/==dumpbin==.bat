@echo off

setlocal

	call "C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\VC\Auxiliary\Build\vcvars32.bat"

	pushd "cmake-build-release-x86"

	    dumpbin /headers lpeg.dll > lpeg.dll.headers.txt
	    dumpbin /exports lpeg.dll > lpeg.dll.exports.txt
	    dumpbin /dependents lpeg.dll > lpeg.dll.dependents.txt
	    dumpbin /imports lpeg.dll > lpeg.dll.imports.txt

	popd

endlocal


setlocal

	call "C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\VC\Auxiliary\Build\vcvars64.bat"

	pushd "cmake-build-release-x64"

	    dumpbin /headers lpeg.dll > lpeg.dll.headers.txt
	    dumpbin /exports lpeg.dll > lpeg.dll.exports.txt
	    dumpbin /dependents lpeg.dll > lpeg.dll.dependents.txt
	    dumpbin /imports lpeg.dll > lpeg.dll.imports.txt

	popd

endlocal


