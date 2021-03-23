cmake_minimum_required ( VERSION 3.6 )

project(lpeg VERSION 1.0.2 LANGUAGES C)

# https://cmake.org/cmake/help/latest/manual/cmake-generator-expressions.7.html#debugging
# Since generator expressions are evaluated during generation of the buildsystem, and not during processing of CMakeLists.txt files, it is not possible to inspect their result with the message() command
#message( $<LOWER_CASE:${CMAKE_C_COMPILER_ARCHITECTURE_ID}> )
#message( $<LOWER_CASE:${CMAKE_SYSTEM_NAME}> )
# alternative way is to write debug messages to a file
file(GENERATE OUTPUT "${PROJECT_BINARY_DIR}/filename" CONTENT "Generators: output:
$<LOWER_CASE:${CMAKE_C_COMPILER_ARCHITECTURE_ID}>
$<LOWER_CASE:${CMAKE_SYSTEM_NAME}>
")

string( TOLOWER ${CMAKE_C_COMPILER_ARCHITECTURE_ID} ARCH )

#set ( LUA_HOME "C:/FX/LUA/lua-5.4.1/build/${ARCH}" )
set ( LUA_HOME "C:/FX/LUA/lua-5.3.5/build/${ARCH}" )

include_directories(${LUA_HOME}/include)

set ( SRC lpvm.c lpcap.c lptree.c lpcode.c lpprint.c )

# /TC /DWIN32 /D_WINDOWS /W3 /MD /O2 /Ob2 /DNDEBUG -Wall -Wextra -pedantic -std=c99 -fPIC /Be /Bd /EP

add_compile_options(
        -Wall
#        -Wextra                             # cl : invalid numeric argument
#        -pedantic                           # cl : ignoring unknown option
#        -Waggregate-return                  # cl : invalid numeric argument
#        -Wcast-align                        # cl : invalid numeric argument
#        -Wcast-qual                         # cl : invalid numeric argument
#        -Wdisabled-optimization             # cl : invalid numeric argument
#        -Wpointer-arith                     # cl : invalid numeric argument
#        -Wshadow                            # cl : invalid numeric argument
#        -Wsign-compare                      # cl : invalid numeric argument
#        -Wundef                             # cl : invalid numeric argument
#        -Wwrite-strings                     # cl : invalid numeric argument
#        -Wbad-function-cast                 # cl : invalid numeric argument
#        -Wdeclaration-after-statement       # cl : invalid numeric argument
#        -Wmissing-prototypes                # cl : invalid numeric argument
#        -Wnested-externs                    # cl : invalid numeric argument
#        -Wstrict-prototypes                 # cl : invalid numeric argument
#        -Wunreachable-code
)

add_compile_options(
#        -std=c99                            # cl : ignoring unknown option
#        -fPIC                               # cl : ignoring unknown option
)

add_library(lpeg SHARED ${SRC})
target_link_options(lpeg PRIVATE /EXPORT:luaopen_lpeg)
target_link_libraries(lpeg ${LUA_HOME}/lib/lua53.lib)

set(CMAKE_INSTALL_PREFIX "${PROJECT_SOURCE_DIR}")
install(TARGETS lpeg RUNTIME DESTINATION "build/lib/lua/5.3/${ARCH}")


