#**************************************************************************************************
#*
#* Copyright Zygmunt Ptak <zygmuntptak@gmail.com>
#*
#*/

cmake_minimum_required(VERSION 2.8)

set(PROJECT     example)
set(BOARD       "atmega2560")

set(FLASH_SETTINGS_SECTION "eeprom")

if(${BOARD} STREQUAL "atmega2560")
    set(MCU "atmega2560")
    set(F_CPU "16000000")

    set(AVRDUDE_PROGRAMMER  "wiring")
    set(AVRDUDE_PORT        "/dev/ttyACM0")
    set(AVRDUDE_BAUDRATE    "115200")
    set(AVRDUDE_USER_OPTIONS "-D")

else()
    message( FATAL_ERROR "Wrong board type")
endif()


set(CXXWARN         "-Wall -Wshadow") # -pedantic -Wconversion")

set(AVR_TOOLCHAIN   "system.avr.toolchain.cmake")

set(CXXSTANDARD     "-std=c++14")
set(CMAKE_AVR_PATH  ".")

include("${CMAKE_AVR_PATH}/avr.toolchain.cmake")
include("${CMAKE_AVR_PATH}/avr.flash.cmake")

set(AVRDUDE_USER_OPTIONS "-D")
include("${CMAKE_AVR_PATH}/avrdude.cmake")

project(${PROJECT})

include_directories(${TOOLCHAIN_PATH}/avr/include)

set(SOURCE_FILES
    example.cpp
)

add_executable(
    ${PROJECT}
    ${SOURCE_FILES}
)
