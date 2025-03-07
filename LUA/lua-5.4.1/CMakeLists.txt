cmake_minimum_required ( VERSION 3.30 )
project ( lua C )

# set ( CMAKE_GENERATOR "NMake Makefiles" CACHE INTERNAL "Generate NMake instead of VS Project." FORCE )
set(CMAKE_BUILD_TYPE "Release" CACHE STRING "")
# https://cmake.org/cmake/help/latest/prop_tgt/WINDOWS_EXPORT_ALL_SYMBOLS.html
# automatically create .def file with all global symbols found in the input .obj files for a SHARED library
# set(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS YES CACHE BOOL "Export all symbols")

set ( LUA_DIR src.lua CACHE PATH "Where to search Lua sources." )
set ( LUAC_DIR src.luac CACHE PATH "Where to search Luac sources." )

# see makefile
set ( SRC_CORE lapi.c lcode.c lctype.c ldebug.c ldo.c ldump.c lfunc.c lgc.c llex.c
  lmem.c lobject.c lopcodes.c lparser.c lstate.c lstring.c ltable.c
  ltm.c lundump.c lvm.c lzio.c )  # ltests.c
set ( SRC_AUX lauxlib.c )
set ( SRC_LIB lbaselib.c ldblib.c liolib.c lmathlib.c loslib.c ltablib.c lstrlib.c
  lutf8lib.c loadlib.c lcorolib.c linit.c )

# generator expressions result is not exactly known at configuration stage, it becomes known only at the build! stage
# message ( STATUS "SRC_CORE $<LIST:TRANSFORM,${SRC_CORE},PREPEND,${LUA_DIR}/>" )
# file will be written only at the end of the configuration stage
# file( GENERATE OUTPUT "debug_GENERATE.txt" CONTENT "SRC_CORE $<LIST:TRANSFORM,${SRC_CORE},PREPEND,${LUA_DIR}/>\n" )

set ( SRC_LUA ${LUA_DIR}/lua.c )
set ( SRC_LUAC ${LUAC_DIR}/luac.c )

include_directories ( ${LUA_DIR} )

add_compile_options( /W4 )

# https://cmake.org/cmake/help/latest/policy/CMP0076.html
#   target_sources command converts relative paths to absolute
cmake_policy ( SET CMP0076 OLD )

add_library ( objcore INTERFACE )
add_library ( objaux INTERFACE )
target_sources ( objcore INTERFACE $<LIST:TRANSFORM,${SRC_CORE},PREPEND,${CMAKE_CURRENT_SOURCE_DIR}/${LUA_DIR}/> )
target_sources ( objaux INTERFACE $<LIST:TRANSFORM,${SRC_AUX},PREPEND,${CMAKE_CURRENT_SOURCE_DIR}/${LUA_DIR}/> )

add_library ( libluadll SHARED $<LIST:TRANSFORM,${SRC_LIB},PREPEND,${LUA_DIR}/> )
target_link_libraries ( libluadll PRIVATE objcore objaux )
target_compile_definitions ( libluadll PRIVATE LUA_BUILD_AS_DLL )
set_target_properties ( libluadll PROPERTIES OUTPUT_NAME lua54 )

add_executable ( lua ${SRC_LUA} )
target_link_libraries ( lua PRIVATE libluadll )

add_executable ( luac ${SRC_LUAC} )
target_link_libraries ( luac PRIVATE objcore objaux )

install( TARGETS libluadll RUNTIME DESTINATION bin )
install( TARGETS lua RUNTIME DESTINATION bin )
install( TARGETS luac RUNTIME DESTINATION bin )
