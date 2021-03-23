cmake_minimum_required( VERSION 3.6 )

project( luautf8 VERSION 0.1.3.1 LANGUAGES C )

string( TOLOWER ${CMAKE_C_COMPILER_ARCHITECTURE_ID} ARCH )

#set ( LUA_HOME "C:/FX/LUA/lua-5.4.1/build/${ARCH}" )
set ( LUA_HOME "C:/FX/LUA/lua-5.3.5/build/${ARCH}" )

include_directories(${LUA_HOME}/include)

set ( SRC lutf8lib.c )

add_library(luautf8 SHARED ${SRC})
target_link_options(luautf8 PRIVATE ${LUA_HOME}/lib/lua53.lib )
set_target_properties(luautf8 PROPERTIES OUTPUT_NAME lua-utf8)


set(CMAKE_INSTALL_PREFIX "${PROJECT_SOURCE_DIR}")
install(TARGETS luautf8 RUNTIME DESTINATION "build/lib/lua/5.3/${ARCH}")

