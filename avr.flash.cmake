#**************************************************************************************************
#*
#* Copyright Zygmunt Ptak <zygmuntptak@gmail.com> All Rights Reserved.
#*
#* Reviewed
#*
#*/

include("${CMAKE_AVR_PATH}/avr.base.cmake")

set_if(FORMAT   "ihex")
set_if(HEX_FILE ${PROJECT}.hex)
set_if(EPP_FILE ${PROJECT}.epp)

set_if(FLASH_SETTINGS_SECTION "eeprom") # persistent_settings
set(_SETTINGS_SECTION ".${FLASH_SETTINGS_SECTION}")

set(OBJCOPY_HEX_OPT_COMMON -O ${FORMAT} -R .fuse -R .lock -R .signature)
set(OBJCOPY_HEX_OPT ${OBJCOPY_HEX_OPT_COMMON} -R ${_SETTINGS_SECTION})

add_custom_command(
    OUTPUT  ${HEX_FILE}
    COMMAND ${OBJCOPY_PROG} ${OBJCOPY_HEX_OPT} ${PROJECT} ${HEX_FILE}
    DEPENDS ${PROJECT}
)

set(OBJCOPY_EPP_OPT
    # http://www.avrfreaks.net/forum/memory-segments-eeprom
    -O ${FORMAT} -j ${_SETTINGS_SECTION} --set-section-flags=${_SETTINGS_SECTION}="alloc,load" --change-section-lma ${_SETTINGS_SECTION}=0 --no-change-warnings
)

add_custom_command(
    OUTPUT  ${EPP_FILE}
    COMMAND ${OBJCOPY_PROG} ${OBJCOPY_EPP_OPT} ${PROJECT} ${EPP_FILE}
    DEPENDS ${PROJECT}
)

set_directory_properties(ADDITIONAL_MAKE_CLEAN_FILES ${HEX_FILE} ${EPP_FILE} )

add_custom_target(ALL DEPENDS ${EPP_FILE} ${HEX_FILE})
add_custom_target(hex DEPENDS ${HEX_FILE})
add_custom_target(epp DEPENDS ${EPP_FILE})
