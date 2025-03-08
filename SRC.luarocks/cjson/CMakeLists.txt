# If Lua is installed in a non-standard location, please set the LUA_DIR
# environment variable to point to prefix for the install. Eg:
#       Unix: export LUA_DIR=/home/user/pkg
#       Windows: set LUA_DIR=c:\lua51

cmake_minimum_required(VERSION 3.5)
project(lua-cjson C)

set(LUA_HOME "../../LUA/lua-5.4.1")
cmake_path(ABSOLUTE_PATH LUA_HOME NORMALIZE)
set(ENV{LUA_DIR} "${LUA_HOME}")  # see header ^^

option(USE_INTERNAL_FPCONV "Use internal strtod() / g_fmt() code for performance")
option(MULTIPLE_THREADS "Support multi-threaded apps with internal fpconv - recommended" ON)

if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Release CACHE STRING
        "Choose the type of build, options are: None Debug Release RelWithDebInfo MinSizeRel."
        FORCE)
endif()

# find_package(Lua51 REQUIRED)
# C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\Common7\IDE\CommonExtensions\Microsoft\CMake\CMake\share\cmake-3.30\Modules\FindLua51.cmake
set(LUA_VERSION_STRING "5.4.1" CACHE STRING "Lua Includes")
set(LUA_INCLUDE_DIR "${LUA_HOME}/include" CACHE STRING "Lua Includes")
set(LUA_LIBRARY "${LUA_HOME}/lib/lua54.lib" CACHE STRING "Lua Library")
set(LUA_LIBRARIES "${LUA_LIBRARY}" CACHE STRING "Lua Libraries")
include_directories(${LUA_INCLUDE_DIR})

if(NOT USE_INTERNAL_FPCONV)
    # Use libc number conversion routines (strtod(), sprintf())
    set(FPCONV_SOURCES src/fpconv.c)
else()
    # Use internal number conversion routines
    add_definitions(-DUSE_INTERNAL_FPCONV)
    set(FPCONV_SOURCES src/g_fmt.c src/dtoa.c)

    include(TestBigEndian)
    TEST_BIG_ENDIAN(IEEE_BIG_ENDIAN)
    if(IEEE_BIG_ENDIAN)
        add_definitions(-DIEEE_BIG_ENDIAN)
    endif()

    if(MULTIPLE_THREADS)
        set(CMAKE_THREAD_PREFER_PTHREAD TRUE)
        find_package(Threads REQUIRED)
        if(NOT CMAKE_USE_PTHREADS_INIT)
            message(FATAL_ERROR
                    "Pthreads not found - required by MULTIPLE_THREADS option")
        endif()
        add_definitions(-DMULTIPLE_THREADS)
    endif()
endif()

# Handle platforms missing isinf() macro (Eg, some Solaris systems).
include(CheckSymbolExists)
CHECK_SYMBOL_EXISTS(isinf src/math.h HAVE_ISINF)
if(NOT HAVE_ISINF)
    add_definitions(-DUSE_INTERNAL_ISINF)
endif()

set(_MODULE_LINK "${CMAKE_THREAD_LIBS_INIT}")
get_filename_component(_lua_lib_dir ${LUA_LIBRARY} PATH)

if(APPLE)
    set(CMAKE_SHARED_MODULE_CREATE_C_FLAGS
        "${CMAKE_SHARED_MODULE_CREATE_C_FLAGS} -undefined dynamic_lookup")
endif()

if(WIN32)
    # Win32 modules need to be linked to the Lua library.
    set(_MODULE_LINK ${LUA_LIBRARY} ${_MODULE_LINK})
    set(_lua_module_dir "${_lua_lib_dir}")
    # Windows sprintf()/strtod() handle NaN/inf differently. Not supported.
    add_definitions(-DDISABLE_INVALID_NUMBERS)
else()
    set(_lua_module_dir "${_lua_lib_dir}/lua/5.1")
endif()

if(MSVC)
    add_definitions(-D_CRT_SECURE_NO_WARNINGS)
    add_definitions(-Dinline=__inline)
    # add_definitions(-Dsnprintf=_snprintf)  # fatal error C1189: Macro definition conflicts
    add_definitions(-Dstrncasecmp=_strnicmp)
endif()

message(STATUS "cjson MODULE SRC src/lua_cjson.c src/strbuf.c ${FPCONV_SOURCES}")
message(STATUS "cjson MODULE LINK ${_MODULE_LINK}")
message(STATUS "cjson DESTINATION ${_lua_module_dir}")
add_library(cjson MODULE src/lua_cjson.c src/strbuf.c ${FPCONV_SOURCES})
set_target_properties(cjson PROPERTIES PREFIX "")
target_link_libraries(cjson ${_MODULE_LINK})
# install(TARGETS cjson DESTINATION "${_lua_module_dir}")
install(TARGETS cjson DESTINATION "bin")

# vi:ai et sw=4 ts=4:
