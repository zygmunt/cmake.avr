set_if(TOOLCHAIN_PATH               "/home/zygmunt/Home/System/Apps/CrossTools/avr8-gnu-toolchain-linux_x86_64")
#set_if(TOOLCHAIN_PATH               "/usr")

set_if(CMAKE_SYSTEM_INCLUDE_PATH    "${TOOLCHAIN_PATH}/avr/include" )
set_if(CMAKE_SYSTEM_LIBRARY_PATH    "${TOOLCHAIN_PATH}/avr/lib" )
set_if(CMAKE_SYSTEM_PROGRAM_PATH    "${TOOLCHAIN_PATH}/avr/bin" )

set_if(CMAKE_C_COMPILER             "${TOOLCHAIN_PATH}/bin/avr-gcc")
#set_if(CMAKE_ASM_COMPILER           "${TOOLCHAIN_PATH}/bin/avr-gcc")
set_if(CMAKE_CXX_COMPILER           "${TOOLCHAIN_PATH}/bin/avr-g++")
set_if(SIZE_PROG                    "${TOOLCHAIN_PATH}/bin/avr-size")

set_if(AR_PROG                      "${CMAKE_SYSTEM_PROGRAM_PATH}/ar")
set_if(AS_PROG                      "${CMAKE_SYSTEM_PROGRAM_PATH}/as")
set_if(NM_PROG                      "${CMAKE_SYSTEM_PROGRAM_PATH}/nm")
set_if(OBJCOPY_PROG                 "${CMAKE_SYSTEM_PROGRAM_PATH}/objcopy")
set_if(OBJDUMP_PROG                 "${CMAKE_SYSTEM_PROGRAM_PATH}/objdump")
set_if(RANLIB_PROG                  "${CMAKE_SYSTEM_PROGRAM_PATH}/ranlib")
set_if(STRIP_PROG                   "${CMAKE_SYSTEM_PROGRAM_PATH}/strip")

add_definitions(-DAVR_PLATFORM)
