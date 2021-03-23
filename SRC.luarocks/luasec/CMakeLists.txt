cmake_minimum_required ( VERSION 3.6 )

project (
        luasec
        VERSION 0.9.1
        LANGUAGES C
)

string( TOLOWER ${CMAKE_C_COMPILER_ARCHITECTURE_ID} ARCH )

#set ( LUA_HOME "C:/FX/LUA/lua-5.4.1" )
set ( LUA_HOME "C:/FX/LUA/lua-5.3.5" )
#set ( OPENSSL_HOME "C:/FX/LUA/SRC.external/openssl-OpenSSL_1_1_1i" )
set ( OPENSSL_HOME "openssl-1.1.1i" )  # openssl-1.1.1i --> C:\FX\LUA\SRC.external\openssl-OpenSSL_1_1_1i


set ( SRC_LIB
        src/luasocket/buffer.c src/luasocket/io.c src/luasocket/timeout.c src/luasocket/wsocket.c )

add_library ( libluasocket STATIC ${SRC_LIB} )
set_target_properties ( libluasocket PROPERTIES OUTPUT_NAME luasocket )
target_include_directories( libluasocket PRIVATE ${LUA_HOME}/include )


set ( SRC_CORE
        src/config.c src/context.c src/ec.c
        src/options.c src/ssl.c src/x509.c )

add_library ( luasec-objs OBJECT ${SRC_CORE} )
target_compile_definitions ( luasec-objs PUBLIC WITH_LUASOCKET _WIN32 )
target_include_directories( luasec-objs PRIVATE ${OPENSSL_HOME}/${ARCH}/include ${LUA_HOME}/include src )


#add_library ( libluasec STATIC $<TARGET_OBJECTS:luasec-objs> )
#set_target_properties ( libluasec PROPERTIES OUTPUT_NAME ssl )


add_library ( libluasecdll SHARED $<TARGET_OBJECTS:luasec-objs> )
set_target_properties ( libluasecdll PROPERTIES OUTPUT_NAME ssl )
target_link_libraries ( libluasecdll
        ${LUA_HOME}/build/${ARCH}/lib/lua53.lib
        ${PROJECT_SOURCE_DIR}/${OPENSSL_HOME}/${ARCH}/libssl.lib
        ${PROJECT_SOURCE_DIR}/${OPENSSL_HOME}/${ARCH}/libcrypto.lib
        libluasocket
        ws2_32.lib )