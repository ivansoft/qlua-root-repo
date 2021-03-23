project(luasocket C)

cmake_minimum_required( VERSION 3.6 )

#set( CMAKE_VERBOSE_MAKEFILE on )
#set(ALLOW_DUPLICATE_CUSTOM_TARGETS TRUE)

message(${CMAKE_C_FLAGS_RELEASE})

string( TOLOWER ${CMAKE_C_COMPILER_ARCHITECTURE_ID} ARCH )

set ( LUA_HOME "C:/FX/LUA/lua-5.4.1/build/${ARCH}" )
#set ( LUA_HOME "C:/FX/LUA/lua-5.3.5/build/${ARCH}" )

include_directories(${LUA_HOME}/include)
#add_compile_definitions("LUASOCKET_API=__declspec(dllexport)")

set ( SOCKET_CORE src/luasocket.c src/timeout.c src/buffer.c src/io.c src/auxiliar.c
        src/options.c src/inet.c src/except.c src/select.c src/tcp.c src/udp.c src/compat.c
        src/wsocket.c )

set ( MIME_CORE src/mime.c src/compat.c )  # src/compat.c


# https://cmake.org/cmake/help/latest/command/install.html
# ARCHIVE - Target artifacts of this kind include: Static libraries
# LIBRARY - Shared libraries, except DLLs
# RUNTIME - Executables, DLLs

add_library( socketcoredll SHARED ${SOCKET_CORE} )
set_target_properties ( socketcoredll PROPERTIES
        ARCHIVE_OUTPUT_DIRECTORY socket
        RUNTIME_OUTPUT_DIRECTORY socket
#        LIBRARY_OUTPUT_DIRECTORY socket
        OUTPUT_NAME core )
target_link_libraries( socketcoredll ${LUA_HOME}/lib/lua54.lib ws2_32.lib )


add_library( mimedll SHARED ${MIME_CORE} )
set_target_properties ( mimedll PROPERTIES
        ARCHIVE_OUTPUT_DIRECTORY mime
        RUNTIME_OUTPUT_DIRECTORY mime
#        LIBRARY_OUTPUT_DIRECTORY mime
        OUTPUT_NAME core )
target_link_libraries( mimedll ${LUA_HOME}/lib/lua54.lib )

set(CMAKE_INSTALL_PREFIX "${PROJECT_SOURCE_DIR}")
install(TARGETS socketcoredll RUNTIME DESTINATION "build/lib/lua/5.4/${ARCH}/socket")
install(TARGETS mimedll RUNTIME DESTINATION "build/lib/lua/5.4/${ARCH}/mime" )
