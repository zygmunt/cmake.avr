#**************************************************************************************************
#*
#* Copyright Zygmunt Ptak <zygmuntptak@gmail.com> All Rights Reserved.
#*
#* Reviewed
#*
#*/

include("${CMAKE_AVR_PATH}/avr.base.cmake")

set_if(DFU_BIN_PATH "/usr/bin")
set_if(DFU          "dfu-programmer")
set_if(DFU_PROG     "${DFU_BIN_PATH}/${DFU}")



set(DFU_DEPENDS)
if(${FLASH_HEX})
    list(APPEND DFU_DEPENDS ${HEX_FILE})
endif(${FLASH_HEX})

if(${FLASH_EPP})
    list(APPEND DFU_DEPENDS ${EPP_FILE})
endif(${FLASH_EPP})

if(${FLASH_HEX}) 
    if(${FLASH_EPP}) 
        add_custom_target(
            flash
            COMMAND ${DFU_PROG} ${MCU} erase
            COMMAND ${DFU_PROG} ${MCU} flash ${HEX_FILE}
            COMMAND ${DFU_PROG} ${MCU} flash ${EPP_FILE}
            COMMAND ${DFU_PROG} ${MCU} reset
            DEPENDS ${DFU_DEPENDS}
            COMMENT "Flashing with dfu: ${AVRDUDE_DEPENDS}"
        )
    else(${FLASH_EPP})
        add_custom_target(
            flash
            COMMAND ${DFU_PROG} ${MCU} erase
            COMMAND ${DFU_PROG} ${MCU} flash ${HEX_FILE}
            COMMAND ${DFU_PROG} ${MCU} reset
            DEPENDS ${DFU_DEPENDS}
            COMMENT "Flashing with dfu: ${AVRDUDE_DEPENDS}"
        )
    endif(${FLASH_EPP})
else(${FLASH_HEX})
    if(${FLASH_EPP}) 
        add_custom_target(
            flash
            COMMAND ${DFU_PROG} ${MCU} erase
            COMMAND ${DFU_PROG} ${MCU} flash ${EPP_FILE}
            COMMAND ${DFU_PROG} ${MCU} reset
            DEPENDS ${DFU_DEPENDS}
            COMMENT "Flashing with dfu: ${AVRDUDE_DEPENDS}"
        )
    else(${FLASH_EPP})
        add_custom_target(
            flash
            COMMENT "Nothing to do in flashing..."
        )
    endif(${FLASH_EPP})
endif(${FLASH_HEX})




