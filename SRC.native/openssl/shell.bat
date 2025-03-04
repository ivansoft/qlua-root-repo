@call "C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\VC\Auxiliary\Build\vcvars64.bat"

set PATH=%~dp0\nasm-2.16.03-bin;%PATH%
call "%~dp0\strawberry-perl-5.40.0.1-bin\portableshell.bat" /SETENV

perl -MConfig -e "print(qq{Perl executable: $^X\nPerl version   : $^V / $Config{archname}\n\n})" 2>nul
if ERRORLEVEL==1 echo FATAL ERROR: 'perl' does not work; check if your strawberry pack is complete!

:: https://github.com/openssl/openssl/blob/master/NOTES-WINDOWS.md
pushd "%~dp0\openssl"
	perl Configure VC-WIN64A
	nmake
popd
