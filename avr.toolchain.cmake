#**************************************************************************************************
#*
#* Copyright Zygmunt Ptak <zygmuntptak@gmail.com> All Rights Reserved.
#*
#* Reviewed
#*
#*/

if(NOT DEFINED ${CMAKE_AVR_PATH})
    message( "Using CMAKE_AVR_PATH = ${CMAKE_AVR_PATH}" )
else()
    message( FATAL_ERROR "CMAKE_AVR_PATH is not set" )
endif()

include("${CMAKE_AVR_PATH}/avr.base.cmake")

set(CMAKE_SYSTEM_NAME               Generic)
set(CMAKE_SYSTEM_VERSION            1)
set(CMAKE_SYSTEM_PROCESSOR          AVR)

set_if(AVR_TOOLCHAIN                "atmel.avr.toolchain.cmake")
include("${CMAKE_AVR_PATH}/${AVR_TOOLCHAIN}")

set_if(OPT__            "-Os")
set_if(WARN__           "-Wall") #-Werror
set_if(TUNNING__        "-ffunction-sections -fdata-sections")
                        # "-funsigned-char -funsigned-bitfields -fpack-struct -fshort-enums")

set_if(COPT             ${OPT__})
set_if(CSTANDARD        "-std=gnu99")
set_if(CDEBUG           "-gstabs")
set_if(CWARN            "${WARN__} -Wstrict-prototypes")
set_if(CTUNING          ${TUNNING__})

set_if(CXXOPT           ${OPT__})
set_if(CXXSTANDARD      "-std=c++11")
set_if(CXXWARN          "${WARN__} -Wshadow -pedantic -Wconversion")
set_if(CXXTUNING        ${TUNNING__})

set_if(LDFLAGS          "-Wl,--gc-sections")

set(OPT_MCU                         "-mmcu=")
set(OPT_F_CPU                       "-DF_CPU=")

set(MCU_VAL                         "${OPT_MCU}${MCU}")
set(F_CPU_VAL                       "${OPT_F_CPU}${F_CPU}")



set(CFLAGS                          "${MCU_VAL} ${F_CPU_VAL} ${COPT} ${CSTANDARD} ${CWARN} ${CTUNING} ${CDEBUG}")
set(CXXFLAGS                        "${MCU_VAL} ${F_CPU_VAL} ${CXXOPT} ${CXXSTANDARD} ${CXXWARN} ${CXXTUNING}")
set(ASM_FLAGS                       "${CFLAGS} -x assembler-with-cpp")

set(CMAKE_C_FLAGS   ${CFLAGS}       CACHE STRING "" FORCE)
set(CMAKE_ASM_FLAGS ${ASM_FLAGS}    CACHE STRING "" FORCE)
set(CMAKE_CXX_FLAGS ${CXXFLAGS}     CACHE STRING "" FORCE)

set(CMAKE_EXE_LINKER_FLAGS      ${LDFLAGS}  CACHE STRING "" FORCE)
set(CMAKE_MODULE_LINKER_FLAGS   ${LDFLAGS}  CACHE STRING "" FORCE)
set(CMAKE_SHARED_LINKER_FLAGS   ${LDFLAGS}  CACHE STRING "" FORCE)
set(CMAKE_STATIC_LINKER_FLAGS   ${LDFLAGS}  CACHE STRING "" FORCE)


add_custom_target(
    size
    DEPENDS ${PROJECT}
    COMMAND ${SIZE_PROG} -C -x --mcu=${MCU} ${PROJECT}
)



# #Additional libraries.
#
# # Minimalistic printf version
# set(PRINTF_LIB_MIN      -Wl,-u,vfprintf -lprintf_min)
#
# # Floating point printf version (requires MATH_LIB = -lm below)
# set(PRINTF_LIB_FLOAT    -Wl,-u,vfprintf -lprintf_flt)
#
# set(PRINTF_LIB          )
#
# # Minimalistic scanf version
# set(SCANF_LIB_MIN       -Wl,-u,vfscanf -lscanf_min)
#
# # Floating point + %[ scanf version (requires MATH_LIB = -lm below)
# set(SCANF_LIB_FLOAT     -Wl,-u,vfscanf -lscanf_flt)
#
# set(SCANF_LIB           )
#
# set(MATH_LIB            -lm)
#
#
#
# # set(ASFLAGS             -Wa,-adhlns=$(<:.S=.lst),-gstabs )
#
# # External memory options
#
# # 64 KB of external RAM, starting after internal RAM (ATmega128!),
# # used for variables (.data/.bss) and heap (malloc()).
# set(EXTMEMOPTS          -Wl,--section-start,.data=0x801100,--defsym=__heap_end=0x80ffff)
#
# # 64 KB of external RAM, starting after internal RAM (ATmega128!),
# # only used for heap (malloc()).
# set(EXTMEMOPTS          -Wl,--defsym=__heap_start=0x801100,--defsym=__heap_end=0x80ffff)
#
# set(EXTMEMOPTS          )
#
# set(LDMAP               ${LDFLAGS} -Wl,-Map=${PROJECT}.map,--cref)
# set(LDFLAGS             ${EXTMEMOPTS} ${LDMAP} ${PRINTF_LIB} ${SCANF_LIB} ${MATH_LIB})
#
# set(ALL_ASFLAGS         ${MCU_VAL} -I. -x assembler-with-cpp ${ASFLAGS})
