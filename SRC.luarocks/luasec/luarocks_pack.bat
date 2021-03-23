::@echo off
setlocal

set OPENSSL_INCDIR=C:\FX\LUA\SRC.external\openssl-OpenSSL_1_1_1i\include
set OPENSSL_LIBDIR=C:\FX\LUA\SRC.external\openssl-OpenSSL_1_1_1i

luarocks pack luasec-0.9-1.rockspec

exit /b %ERRORLEVEL%