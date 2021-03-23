cmake_minimum_required(VERSION 3.17)
message("CMAKE_VERSION " ${CMAKE_VERSION})

project(luafs VERSION 1.8 LANGUAGES C)

#include(variable-list.cmake)

# Set default build type
if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE "Release")
endif()

string(TOLOWER ${CMAKE_C_COMPILER_ARCHITECTURE_ID} ARCH)

set(LUA_HOME_PREFIX "C:/FX/LUA")

#file(GLOB SRCS ${PROJECT_SOURCE_DIR}/src/*.c)
#message("SRCS " ${SRCS})
set(LFS_SRC src/lfs.c)

macro(BuildForLua luaVersion)

    string(REGEX MATCH "([0-9]+\\.[0-9]+)" LUA_VERSION ${luaVersion})
#    message("luaVersion "  ${luaVersion})
#    message("LUA_VERSION "  ${LUA_VERSION})

    ## Output directories
    set(REL_LIB_OUTPUT_DIR "build/lib/lua/${LUA_VERSION}/${ARCH}")
    set(REL_LUA_OUTPUT_DIR "build/share/lua/${LUA_VERSION}")
#    message("REL_LIB_OUTPUT_DIR " ${REL_LIB_OUTPUT_DIR})
#    message("REL_LUA_OUTPUT_DIR " ${REL_LUA_OUTPUT_DIR})

    set(LUA_HOME ${LUA_HOME_PREFIX}/lua-${luaVersion}/build/${ARCH})
#    message("LUA_HOME " ${LUA_HOME})

    file(GLOB LUA_LIBS ${LUA_HOME}/lib/*.lib)
#    message("LUA_LIBS " ${LUA_LIBS})

    add_library(lfs_${luaVersion} SHARED ${LFS_SRC})
    target_include_directories(lfs_${luaVersion} PUBLIC ${LUA_HOME}/include)
    target_link_options(lfs_${luaVersion} PUBLIC ${CMAKE_LINK_DEF_FILE_FLAG}${PROJECT_SOURCE_DIR}/src/lfs.def)
    target_link_libraries(lfs_${luaVersion} ${LUA_LIBS})

    # https://cmake.org/cmake/help/latest/manual/cmake-properties.7.html#target-properties
    set_target_properties(lfs_${luaVersion} PROPERTIES
            OUTPUT_NAME "lfs"
            ARCHIVE_OUTPUT_DIRECTORY ${luaVersion}
            LIBRARY_OUTPUT_DIRECTORY ${luaVersion}
            RUNTIME_OUTPUT_DIRECTORY ${luaVersion}
            PDB_OUTPUT_DIRECTORY ${luaVersion}
    )
#    message("SHARED_LIBRARY_OPTIONS " ${STATIC_LIBRARY_OPTIONS})
#    message("SHARED_LIBRARY_FLAGS " ${SHARED_LIBRARY_FLAGS})
#    message("LINK_OPTIONS " ${LINK_OPTIONS})


    file(GENERATE OUTPUT "${PROJECT_BINARY_DIR}/filename_${luaVersion}_${ARCH}.txt" CONTENT "
TARGET_OBJECTS:         $<TARGET_OBJECTS:lfs_${luaVersion}>
CUSTOM_KEYS:            $<TARGET_PROPERTY:lfs_${luaVersion},CUSTOM_KEYS>
CONFIG:DEBUG:           $<CONFIG:DEBUG>
CONFIG:RELEASE>:        $<CONFIG:RELEASE>
<CONFIG>:               $<CONFIG>
<CONFIGURATION>:        $<CONFIGURATION>
<PLATFORM_ID>:          $<PLATFORM_ID>
<C_COMPILER_ID>:        <C_COMPILER_ID>
<C_COMPILER_VERSION>:   <C_COMPILER_VERSION>
<COMPILE_LANGUAGE>:     <COMPILE_LANGUAGE>
$<LOWER_CASE:/DEF>
TARGET_FILE:            $<TARGET_FILE:lfs_${luaVersion}>
TARGET_FILE_NAME:       $<TARGET_FILE_NAME:lfs_${luaVersion}>
TARGET_FILE_DIR:        $<TARGET_FILE_DIR:lfs_${luaVersion}>
TARGET_LINKER_FILE:     $<TARGET_LINKER_FILE:lfs_${luaVersion}>
TARGET_PDB_FILE:        $<TARGET_PDB_FILE:lfs_${luaVersion}>
<HOST_LINK>
<DEVICE_LINK>
    ")
    #            $<TARGET_PROPERTY:lfs_${luaVersion},LINK_OPTIONS>
    #            $<TARGET_PROPERTY:LINK_OPTIONS>

#    cmake_path(...) # cmake 3.20+ only


    set(CMAKE_INSTALL_PREFIX ${PROJECT_SOURCE_DIR})
    install(TARGETS lfs_${luaVersion} RUNTIME DESTINATION ${REL_LIB_OUTPUT_DIR})

endmacro()


BuildForLua("5.3.5")
BuildForLua("5.4.1")
