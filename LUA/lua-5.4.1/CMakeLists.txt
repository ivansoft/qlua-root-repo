cmake_minimum_required ( VERSION 3.30 )
project ( lua C )
set ( CMAKE_C_STANDARD 99 )
set ( CMAKE_C_STANDARD_REQUIRED True )

add_compile_options( /W4 )  # -Wall

set(CMAKE_BUILD_TYPE "Release" CACHE STRING "")

set ( LUA_DIR src.lua CACHE PATH "Where to search Lua sources." )
set ( LUAC_DIR src.luac CACHE PATH "Where to search Luac sources." )

# see makefile
set ( SRC_CORE lapi.c lcode.c lctype.c ldebug.c ldo.c ldump.c lfunc.c lgc.c llex.c
  lmem.c lobject.c lopcodes.c lparser.c lstate.c lstring.c ltable.c
  ltm.c lundump.c lvm.c lzio.c )  # ltests.c
set ( SRC_AUX lauxlib.c )
set ( SRC_LIB lbaselib.c ldblib.c liolib.c lmathlib.c loslib.c ltablib.c lstrlib.c
  lutf8lib.c loadlib.c lcorolib.c linit.c )
set ( SRC_LUA lua.c )
set ( SRC_LUAC luac.c )


macro ( prepend_with_path path var )
  set ( ${var} "$<LIST:TRANSFORM,${ARGN},PREPEND,${path}/>" )
endmacro()

prepend_with_path ( ${LUA_DIR} SRC_CORE ${SRC_CORE} )
prepend_with_path ( ${LUA_DIR} SRC_LIB ${SRC_LIB} )
prepend_with_path ( ${LUA_DIR} SRC_AUX ${SRC_AUX} )
prepend_with_path ( ${LUA_DIR} SRC_LUA ${SRC_LUA} )
prepend_with_path ( ${LUAC_DIR} SRC_LUAC ${SRC_LUAC} )


include_directories ( ${LUA_DIR} )

add_library ( libluadll SHARED ${SRC_LIB} ${SRC_CORE} ${SRC_AUX} )
target_compile_definitions ( libluadll PRIVATE LUA_BUILD_AS_DLL )
set_target_properties ( libluadll PROPERTIES OUTPUT_NAME lua54 )

add_executable ( lua ${SRC_LUA} )
target_link_libraries ( lua PRIVATE libluadll )

add_executable ( luac ${SRC_LUAC} ${SRC_CORE} ${SRC_AUX} )


install( TARGETS libluadll RUNTIME )
install( TARGETS lua RUNTIME )
install( TARGETS luac RUNTIME )
install(FILES ${CMAKE_CURRENT_BINARY_DIR}/lua54.lib DESTINATION lib RENAME lua.lib)
