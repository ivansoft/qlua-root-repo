cmake_minimum_required ( VERSION 3.6 )

project (
        luasql
        VERSION 2.6.0.1
        LANGUAGES C
)

# all configurations stored in DependInfo.cmake files
# see DependInfo.cmake to determine what options, flags .. really passed to compiler/linker
# set( CMAKE_VERBOSE_MAKEFILE on )

if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE "Release")
endif()

string( TOLOWER ${CMAKE_C_COMPILER_ARCHITECTURE_ID} ARCH )

set(LUA_HOME_PREFIX "C:/FX/LUA")

set(CMAKE_INSTALL_PREFIX ${PROJECT_SOURCE_DIR})

set ( SQLITE3_HOME "sqlite-3.34.1" )  # sqlite-3.34.1 --> C:\FX\LUA\SRC.external\sqlite-3.34.1
set ( SQLITE3_LIB sqlite-3.34.1/sqlite3.c )
set ( SQLITE3_CI sqlite-3.34.1/shell.c )
#set ( SQLITE3_BIN "sqlite_bin" )  # sqlite_bin --> C:\FX\LUA\SRC.external\sqllite_bin

set ( SRC_CORE
        src/luasql.c src/ls_sqlite3.c )

#/***
# * do not use sqlite3-objs, because we have !!different!! compiler options for sqlite3.exe and sqlite3.lib
# * for example, sqlite3.exe can use SQLITE_ENABLE_EXPLAIN_COMMENTS or even SQLITE_DEBUG for education
#
#    add_library( sqlite3-objs OBJECT ${SQLITE3_LIB} )
#    #target_compile_definitions( sqlite3-objs PUBLIC SQLITE_ENABLE_COLUMN_METADATA SQLITE_ENABLE_RTREE )
#    target_compile_definitions( sqlite3-objs PUBLIC SQLITE_DEFAULT_FOREIGN_KEYS=1 )
#
#    add_library ( libsqlite3dll SHARED $<TARGET_OBJECTS:sqlite3-objs> )
#    target_link_options(libsqlite3dll PRIVATE /DEF:${PROJECT_SOURCE_DIR}/${SQLITE3_BIN}/${ARCH}/sqlite3.def )
#    set_target_properties ( libsqlite3dll PROPERTIES OUTPUT_NAME sqlite3 )
# */

#
# https://www.sqlite.org/compile.html#recommended_compile_time_options
# When all of the recommended compile-time options above are used, the SQLite library will be approximately 3% smaller and use about 5% fewer CPU cycles.
set( RECOMMENDED_COMPILE_OPTIONS
        # https://www.sqlite.org/quirks.html#foreign_key_enforcement_is_off_by_default
        # https://www.sqlite.org/pragma.html#pragma_foreign_keys
        # https://www.sqlite.org/foreignkeys.html
        # The default setting for foreign key enforcement is OFF. However, that might change in a future release of SQLite.
        # By the time foreign key constraint enforcement was added, there were already countless millions of databases
        # that contained foreign key constraints, some of which were not correct.
        # To avoid breaking those legacy databases, foreign key constraint enforcement is turned off by default in SQLite.
        # https://www.sqlite.org/releaselog/3_6_19.html
        # - Added support for foreign key constraints. Foreign key constraints are disabled by default. Use the pragma to turn them on
        SQLITE_DEFAULT_FOREIGN_KEYS=1         # https://www.sqlite.org/compile.html#default_foreign_keys
        # Application developers are encouraged to compile using -DSQLITE_DQS=0
        # in order to disable the double-quoted string literal misfeature by default.
        SQLITE_DQS=0                          # https://www.sqlite.org/quirks.html#double_quoted_string_literals_are_accepted
        SQLITE_THREADSAFE=0  # single thread only # ++ performance
        SQLITE_DEFAULT_MEMSTATUS=0  # + performance
        SQLITE_DEFAULT_WAL_SYNCHRONOUS=1  # ++ performance in https://www.sqlite.org/wal.html
        SQLITE_LIKE_DOESNT_MATCH_BLOBS  # LIKE optimization, https://www.sqlite.org/optoverview.html#like_opt
        SQLITE_MAX_EXPR_DEPTH=0  # disables all checking of the expression  # + performance
#        SQLITE_OMIT_DECLTYPE  # do not return the declared type of columns from the result set of query   # used in ls_sqlite3.c create_cursor()
        SQLITE_OMIT_DEPRECATED  # reduce the library footprint
        SQLITE_OMIT_PROGRESS_CALLBACK  #
        SQLITE_OMIT_SHARED_CACHE  # ++ performance, https://www.sqlite.org/sharedcache.html
        SQLITE_USE_ALLOCA  # use stack instead of heap
#        SQLITE_OMIT_AUTOINIT  # must call sqlite3_initialize() manually
        )

set (SQLITE3_ADDONS
        SQLITE_ENABLE_FTS5  # full-text search engine
        SQLITE_ENABLE_JSON1  # https://www.sqlite.org/json1.html
        SQLITE_ENABLE_MATH_FUNCTIONS  # https://www.sqlite.org/lang_mathfunc.html
        SQLITE_ENABLE_DESERIALIZE  # https://www.sqlite.org/c3ref/serialize.html
        SQLITE_ENABLE_RTREE  # R*Tree search engine for storing 2d-like structures (like Cartography), https://www.sqlite.org/rtree.html
        SQLITE_ENABLE_GEOPOLY  # addon to R*Tree search engine, https://www.sqlite.org/geopoly.html
        SQLITE_ENABLE_SESSION  # enables https://www.sqlite.org/sessionintro.html
        SQLITE_ENABLE_SNAPSHOT  # https://www.sqlite.org/c3ref/snapshot.html
        SQLITE_ENABLE_STAT4  # additional logic to the ANALYZE command and to the query planner, https://www.sqlite.org/optoverview.html
        )

# compile sqlite3.exe - sqlite3 lib sources + sqlite3 CI sources
add_executable( sqlite3shell ${SQLITE3_CI} ${SQLITE3_LIB} )
target_compile_definitions( sqlite3shell PUBLIC
        ${RECOMMENDED_COMPILE_OPTIONS}
        SQLITE_ENABLE_EXPLAIN_COMMENTS        # https://www.sqlite.org/compile.html#enable_explain_comments
        SQLITE_DEBUG                          # https://www.sqlite.org/compile.html#debug (3x slower!)
        SQLITE_MEMDEBUG                       # heavy wrapper around system malloc(), realloc(), and free()
        )
set_target_properties(sqlite3shell PROPERTIES OUTPUT_NAME "sqlite3" )

# compile static sqlite3.lib to be embedded to luasql 5.3.5/5.4.1 dlls - sqlite3 lib sources
add_library ( libsqlite3 STATIC ${SQLITE3_LIB} )
# https://www.sqlite.org/compile.html#recommended_compile_time_options
target_compile_definitions( libsqlite3 PUBLIC
        ${RECOMMENDED_COMPILE_OPTIONS}
        # if you dont need load_extension() SQL function
        SQLITE_OMIT_LOAD_EXTENSION            # https://sqlite.org/howtocompile.html#compiling_the_command_line_interface
        SQLITE_TEMP_STORE=3     # https://www.sqlite.org/tempfiles.html#tempstore

        )
set_target_properties(libsqlite3 PROPERTIES OUTPUT_NAME "libsqlite3" )

macro(BuildForLua luaVersion)
    string(REGEX MATCH "([0-9]+\\.[0-9]+)" LUA_VERSION ${luaVersion})
    set(REL_LIB_OUTPUT_DIR "build/lib/lua/${LUA_VERSION}/${ARCH}/luasql")
    set(REL_LUA_OUTPUT_DIR "build/share/lua/${LUA_VERSION}")
    set(LUA_HOME ${LUA_HOME_PREFIX}/lua-${luaVersion}/build/${ARCH})
    file(GLOB LUA_LIBS ${LUA_HOME}/lib/*.lib)
    message("LUA_LIBS " ${LUA_LIBS})

    # compile luasql/sqlite.dll - luasql sources + sqlite static lib
    add_library ( libluasqldll_${luaVersion} SHARED ${SRC_CORE} )
    target_include_directories( libluasqldll_${luaVersion} PRIVATE ${LUA_HOME}/include ${SQLITE3_HOME} )
    target_link_options(libluasqldll_${luaVersion} PRIVATE /DEF:${PROJECT_SOURCE_DIR}/src/sqlite3.def )
    target_link_libraries ( libluasqldll_${luaVersion} ${LUA_LIBS} libsqlite3 )
    set_target_properties(libluasqldll_${luaVersion} PROPERTIES
            OUTPUT_NAME "sqlite3"
            ARCHIVE_OUTPUT_DIRECTORY ${luaVersion}/luasql
            LIBRARY_OUTPUT_DIRECTORY ${luaVersion}/luasql
            RUNTIME_OUTPUT_DIRECTORY ${luaVersion}/luasql
            PDB_OUTPUT_DIRECTORY ${luaVersion}/luasql
            )

    install(TARGETS libluasqldll_${luaVersion} RUNTIME DESTINATION ${REL_LIB_OUTPUT_DIR})
endmacro()


BuildForLua("5.3.5")
BuildForLua("5.4.1")

install(TARGETS sqlite3shell RUNTIME DESTINATION build)


#set ( CMAKE_FIND_NO_INSTALL_PREFIX ${CMAKE_SOURCE_DIR}/build )

message( "CMAKE_FIND_NO_INSTALL_PREFIX --> " ${CMAKE_FIND_NO_INSTALL_PREFIX} )
message( "ARCH --> " ${ARCH} )
message( "DESTINATION --> " ${CMAKE_FIND_NO_INSTALL_PREFIX}/lua/5.3/${ARCH} )

#install(TARGETS libluasqldll EXPORT luasql.sqlite
#        CONFIGURATIONS Release
#        LIBRARY DESTINATION ${CMAKE_SOURCE_DIR}/build/lua/5.3/${ARCH})

#add_custom_command(
#        OUTPUT ${CMAKE_FIND_NO_INSTALL_PREFIX}/lua/5.3/${ARCH}/luasql.sqlite3
#        COMMAND
#)
