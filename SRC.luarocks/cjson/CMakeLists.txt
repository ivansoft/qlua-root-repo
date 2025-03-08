# If Lua is installed in a non-standard location, please set the LUA_DIR
# environment variable to point to prefix for the install. Eg:
#       Unix: export LUA_DIR=/home/user/pkg
#       Windows: set LUA_DIR=c:\lua51

cmake_minimum_required(VERSION 3.11)
project(lua-cjson C)

string( TOLOWER ${CMAKE_C_COMPILER_ARCHITECTURE_ID} ARCH )

# set(CMAKE_CURRENT_SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/src)

set ( LUA_HOME "../../LUA/lua-5.4.1" )
#set ( LUA_HOME "../../LUA/lua-5.3.5" )
cmake_path ( ABSOLUTE_PATH LUA_HOME NORMALIZE )
message(STATUS "Absolute path: ${LUA_HOME}")
set ( ENV{LUA_DIR} "${LUA_HOME}" )
message("LUA_DIR --> " $ENV{LUA_DIR})
set(LUA_VERSION "5.4")
#set(LUA_VERSION "5.3")
set(LUA_POSTFIX "54")
#set(LUA_POSTFIX "53")

option(USE_INTERNAL_FPCONV "Use internal strtod() / g_fmt() code for performance")
option(MULTIPLE_THREADS "Support multi-threaded apps with internal fpconv - recommended" ON)

if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Release CACHE STRING
        "Choose the type of build, options are: None Debug Release RelWithDebInfo MinSizeRel."
        FORCE)
endif()

#find_package(Lua REQUIRED)
set(LUA_INCLUDE_DIR "$ENV{LUA_DIR}/include")
set(LUA_LIBRARY "$ENV{LUA_DIR}/lib/lua${LUA_POSTFIX}.lib")
# message("LUA_FOUND --> ${LUA_FOUND} ${LUA_VERSION_STRING} ${LUA_INCLUDE_DIR} ${LUA_LIBRARIES} ${LUA_LIBRARY}")
message("LUA_FOUND --> ${LUA_VERSION_STRING} ${LUA_INCLUDE_DIR} ${LUA_LIBRARIES} ${LUA_LIBRARY}")
include_directories(${LUA_INCLUDE_DIR})

if(NOT USE_INTERNAL_FPCONV)
    # Use libc number conversion routines (strtod(), sprintf())
    set(FPCONV_SOURCES src/fpconv.c)
else()
    message("-DUSE_INTERNAL_FPCONV")
    # Use internal number conversion routines
    add_definitions(-DUSE_INTERNAL_FPCONV)
    set(FPCONV_SOURCES src/g_fmt.c src/dtoa.c)

    include(TestBigEndian)
    TEST_BIG_ENDIAN(IEEE_BIG_ENDIAN)
    if(IEEE_BIG_ENDIAN)
        add_definitions(-DIEEE_BIG_ENDIAN)
    endif()

    if(MULTIPLE_THREADS)
        message("MULTIPLE_THREADS")
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
CHECK_SYMBOL_EXISTS(isinf math.h HAVE_ISINF)
if(NOT HAVE_ISINF)
    message("-DUSE_INTERNAL_ISINF")
    add_definitions(-DUSE_INTERNAL_ISINF)
endif()

set(_MODULE_LINK "${CMAKE_THREAD_LIBS_INIT}")
get_filename_component(_lua_lib_dir ${LUA_LIBRARY} PATH)
message("_MODULE_LINK  --> " ${_MODULE_LINK})

if(APPLE)
    message("APPLE")
    set(CMAKE_SHARED_MODULE_CREATE_C_FLAGS
        "${CMAKE_SHARED_MODULE_CREATE_C_FLAGS} -undefined dynamic_lookup")
endif()

if(WIN32)
    message("WIN32")
    # Win32 modules need to be linked to the Lua library.
    set(_MODULE_LINK ${LUA_LIBRARY} ${_MODULE_LINK})
    set(_lua_module_dir "${_lua_lib_dir}")
    message("_MODULE_LINK --> " ${_MODULE_LINK})
    message("_lua_module_dir --> " ${_lua_module_dir})
    # Windows sprintf()/strtod() handle NaN/inf differently. Not supported.
    add_definitions(-DDISABLE_INVALID_NUMBERS)
else()
    set(_lua_module_dir "${_lua_lib_dir}/lua/5.1")
    message("_lua_module_dir --> " ${_lua_module_dir})
endif()

#add_definitions(-DENABLE_CJSON_GLOBAL)

add_library(cjson MODULE src/lua_cjson.c src/strbuf.c ${FPCONV_SOURCES})
set_target_properties(cjson PROPERTIES PREFIX "")
target_link_libraries(cjson ${_MODULE_LINK})
target_link_options(cjson PRIVATE /EXPORT:luaopen_cjson /EXPORT:luaopen_cjson_safe )
#install(TARGETS cjson DESTINATION "${_lua_module_dir}")

set(CMAKE_INSTALL_PREFIX "${PROJECT_SOURCE_DIR}")
install(TARGETS cjson DESTINATION "build/lua/${LUA_VERSION}/${ARCH}/")

# vi:ai et sw=4 ts=4:
