https://www.lua.org/ftp/

https://www.lua.org/ftp/lua-5.3.5.tar.gz (2018-06-26)
https://www.lua.org/ftp/lua-5.4.1.tar.gz (2020-09-30)
...
https://www.lua.org/ftp/lua-5.4.6.tar.gz (2023-05-02)


https://github.com/luarocks/luarocks/wiki/Rockspec-format

https://lunarmodules.github.io/ldoc/manual/manual.md.html - LDoc

===========================
IDE
===========================

https://github.com/Roffild/qlua-annotations

https://marketplace.visualstudio.com/items?itemName=sumneko.lua (рекомендую)

===========================

https://github.com/MegaBedder/my-awesome-lua?tab=readme-ov-file#ide-plugins-and-text-editor


https://studio.zerobrane.com/   (Lua 5.4 is supported)
https://eclipse.dev/ldt/        (Warning: LDT is a usable tool but it is not maintained anymore.)

===========================

https://studio.zerobrane.com/doc-lua54-debugging

If lua iterpreter is embedded into your application (statically compiled on Windows), put lua54.dll proxy DLL into the folder with your executable.

http://lua-users.org/wiki/LuaProxyDllFour
it needs:
- real Lua DLL
- pexports utility from the mingw distribution (it would be possible to use DUMPBIN /EXPORTS from MSVC, but parsing the output is a lot harder)
- MSVC compiler

all calls to Lua 5.4 interpreter be forwarded to your statically compiled interpreter

===========================

https://studio.zerobrane.com/doc-remote-debugging

example
http://notebook.kulchenko.com/zerobrane/debugging-wireshark-lua-scripts-with-zerobrane-studio


===========================
