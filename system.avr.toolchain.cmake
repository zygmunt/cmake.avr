set_if(TOOLCHAIN_PATH               "/usr")

set_if(CMAKE_SYSTEM_INCLUDE_PATH    "${TOOLCHAIN_PATH}/avr/include" )
set_if(CMAKE_SYSTEM_LIBRARY_PATH    "${TOOLCHAIN_PATH}/avr/lib" )
set_if(CMAKE_SYSTEM_PROGRAM_PATH    "${TOOLCHAIN_PATH}/bin" )

set_if(CMAKE_C_COMPILER             "${TOOLCHAIN_PATH}/bin/avr-gcc")
#set_if(CMAKE_ASM_COMPILER           "${TOOLCHAIN_PATH}/bin/avr-gcc")
set_if(CMAKE_CXX_COMPILER           "${TOOLCHAIN_PATH}/bin/avr-g++")
set_if(SIZE_PROG                    "${TOOLCHAIN_PATH}/bin/avr-size")

set_if(AR_PROG                      "${TOOLCHAIN_PATH}/bin/avr-ar")
set_if(AS_PROG                      "${TOOLCHAIN_PATH}/bin/avr-as")
set_if(NM_PROG                      "${TOOLCHAIN_PATH}/bin/avr-nm")
set_if(OBJCOPY_PROG                 "${TOOLCHAIN_PATH}/bin/avr-objcopy")
set_if(OBJDUMP_PROG                 "${TOOLCHAIN_PATH}/bin/avr-objdump")
set_if(RANLIB_PROG                  "${TOOLCHAIN_PATH}/bin/avr-ranlib")
set_if(STRIP_PROG                   "${TOOLCHAIN_PATH}/bin/avr-strip")

add_definitions(-DAVR_PLATFORM)
