include("${CMAKE_AVR_PATH}/avr.base.cmake")

set_if(AVRDUDE_BIN_PATH    "/usr/bin")
set_if(AVRDUDE             "avrdude")
set_if(AVRDUDE_PROG        "${AVRDUDE_BIN_PATH}/${AVRDUDE}")

set_if(AVRDUDE_PROGRAMMER  "stk500")             # usbasp arduino

set_if(AVRDUDE_PORT        "/dev/ttyUSB0")         # /dev/ttyUSB0
set_if(AVRDUDE_BAUDRATE    "115200")               # 57600
set_if(AVRDUDE_CONF        "/etc/avrdude.conf")

set_if(AVRDUDE_USER_OPTIONS "")

get_filename_component(HEX_FILE_NAME ${HEX_FILE} NAME CACHE)
set(HEX_REMOTE_FILE /tmp/${HEX_FILE_NAME})
set(REMOTE_ACCOUNT root@rpi11)

# if(${FLASH_HEX})
    set(AVRDUDE_WRITE_FLASH  -U flash:w:${HEX_FILE})
    set(AVRDUDE_WRITE_REMOTE_FLASH  -U flash:w:${HEX_REMOTE_FILE})
    set(REMOTE_UPLOAD_FLASH_COMMAND echo put ${HEX_FILE} ${HEX_REMOTE_FILE} | sftp ${REMOTE_ACCOUNT})
# endif(${FLASH_HEX})

get_filename_component(EPP_FILE_NAME ${EPP_FILE} NAME CACHE)
set(EPP_REMOTE_FILE /tmp/${EPP_FILE_NAME})

# if(${FLASH_EPP})
    set(AVRDUDE_WRITE_EEPROM -U eeprom:w:${EPP_FILE})
    set(AVRDUDE_WRITE_REMOTE_EEPROM  -U eeprom:w:${EPP_REMOTE_FILE})
    set(REMOTE_UPLOAD_EEPROM_COMMAND echo put ${EPP_FILE} ${EPP_REMOTE_FILE} | sftp ${REMOTE_ACCOUNT})
# endif(${FLASH_EPP})



# Uncomment the following if you want avrdude's erase cycle counter.
# Note that this counter needs to be initialized first using -Yn,
# see avrdude manual.
# set_if(AVRDUDE_ERASE_COUNTER -y)

# Uncomment the following if you do /not/ wish a verification to be
# performed after programming the device.
# set_if(AVRDUDE_NO_VERIFY -V)

# Increase verbosity level.  Please use this when submitting bug
# reports about avrdude. See <http://savannah.nongnu.org/projects/avrdude>
# to submit bug reports.
# set_if(AVRDUDE_VERBOSE -v -v)



set_if(AVRDUDE_MCU ${MCU})

set(AVRDUDE_BASIC -p ${AVRDUDE_MCU} -c ${AVRDUDE_PROGRAMMER})
# set_if(AVRDUDE_BASIC ${_AVRDUDE_BASIC})

if(${AVRDUDE_PROGRAMMER} MATCHES "usbasp")
    set(AVRDUDE_EXT)
else()
    set(AVRDUDE_EXT -P ${AVRDUDE_PORT} -b ${AVRDUDE_BAUDRATE} -C ${AVRDUDE_CONF})
endif()

set(AVRDUDE_FLAGS
    ${AVRDUDE_BASIC} ${AVRDUDE_EXT}
    ${AVRDUDE_ERASE_COUNTER} ${AVRDUDE_NO_VERIFY} ${AVRDUDE_VERBOSE}
    ${AVRDUDE_USER_OPTIONS}
)

set(AVRDUDE_FLASH_COMMAND ${AVRDUDE} ${AVRDUDE_FLAGS} ${AVRDUDE_WRITE_FLASH} ${AVRDUDE_USER})

add_custom_target(
    flash
    COMMAND ${AVRDUDE_FLASH_COMMAND}
    DEPENDS ${HEX_FILE}
    COMMENT "Flashing FLASH with avrdude: ${HEX_FILE}"
)

set(AVRDUDE_FLASH_EEPROM_COMMAND ${AVRDUDE} ${AVRDUDE_FLAGS} ${AVRDUDE_WRITE_EEPROM} ${AVRDUDE_USER})

add_custom_target(
    flash_eeprom
    COMMAND ${AVRDUDE_FLASH_EEPROM_COMMAND}
    DEPENDS ${EPP_FILE}
    COMMENT "Flashing EEPROM with avrdude: ${EPP_FILE}"
)

# add_custom_target(
#     remote_flash
#     COMMAND ${REMOTE_UPLOAD_FLASH_COMMAND}
#     COMMAND ${REMOTE_UPLOAD_EEPROM_COMMAND}
#     COMMAND ssh ${REMOTE_ACCOUNT} ${AVRDUDE} ${AVRDUDE_FLAGS} ${AVRDUDE_WRITE_REMOTE_FLASH} ${AVRDUDE_WRITE_REMOTE_EEPROM} ${AVRDUDE_USER}
#     DEPENDS ${AVRDUDE_DEPENDS}
#     COMMENT "Remote Flashing with avrdude: ${AVRDUDE_DEPENDS}"
# )

add_custom_target(
    reset
    COMMAND ${AVRDUDE} ${AVRDUDE_FLAGS}
    COMMENT "Reset avr"
)

set(AVRDUDE_ERASE_COMMAND ${AVRDUDE} ${AVRDUDE_FLAGS} -e)

add_custom_target(
    erase
    COMMAND ${AVRDUDE_ERASE_COMMAND}
    COMMENT "Erase avr"
)

set(
    DISABLE_AUTO_RESET 
    # https://playground.arduino.cc/Main/DisablingAutoResetOnSerialConnection
    stty -F ${AVRDUDE_PORT} -hupcl
)

add_custom_target(
    noreset
    COMMAND ${DISABLE_AUTO_RESET}
    COMMENT "Disabling autoreset"
)

add_custom_target(
    flash_all
    COMMAND ${AVRDUDE_ERASE_COMMAND}
    COMMAND ${AVRDUDE_FLASH_EEPROM_COMMAND} -D
    COMMAND ${AVRDUDE_FLASH_COMMAND} -D
    COMMAND ${DISABLE_AUTO_RESET}
    DEPENDS ${EPP_FILE} ${HEX_FILE}
    COMMENT "Erasing and flashing ${EPP_FILE} ${HEX_FILE}"
)
