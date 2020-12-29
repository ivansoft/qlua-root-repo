
This is Lua 5.3.5, released on 26 Jun 2018.

For installation instructions, license details, and
further information about Lua, see doc/readme.html.


= = = =

https://gist.github.com/squeek502/0706332efb18edd0601a4074762b0b9a

Lua 5.3.x Windows CMake build script

* Add CMakeLists.txt and make.bat to a Lua 5.3.x source code download from here: https://www.lua.org/ftp/
* Execute make.bat

= = = =

make.bat updated

  set GENERATOR=Visual Studio 16 2019
  cmake -H. -Bbuild -G"%GENERATOR%" -A Win32

see cmake --help
