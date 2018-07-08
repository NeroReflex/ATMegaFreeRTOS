# ============= Target Specific ================
# Change this file to meet project specification

MCU_TARGET 	= atmega328p
#MCU_TARGET      = atmega2560
#MCU_TARGET     = atmega2561

MCU_TARGET_AVRDUDE = m328p

# DO NOT append UL after the H number
CLOCK_HZ	= 16000000

# ============ Compilation Options ==============
# Optimization Levels:
#	0 => No Optimization
#	1
#	2
#	s => Space Optimization
OPTIMIZATION_LEVEL	= 2

# ================= FreeRTOS ====================
FREERTOS_INCLUDE_DIR = FreeRTOS/include
FREERTOS_LIBRARY_NAME = FreeRTOS
# Hardware timer used to generate tick interrupts
FREERTOS_TICK_SOURCE_TIMER = 1
# Compile heap_x.c file
FREERTOS_HEAP_MANAGER = 3

# Change this to change target directories
BUILD_DIR = Build
TARGET_DIR = Build/$(MCU_TARGET)
LIBS_DIR = $(TARGET_DIR)/libs
DEMOS_DIR = $(TARGET_DIR)/bin

# ================= Toolchain ==================
CC			= avr-gcc
AR			= avr-ar
OBJCOPY		= avr-objcopy
AVRDUDE		= avrdude
PROGRAMMER 	= usbasp
SIZE 		= avr-size

CC_FLAGS = -Wl,--gc-sections --std=gnu99 -ffunction-sections -fdata-sections -fpack-struct -fshort-enums -mcall-prologues -mrelax -g -Wall -O$(OPTIMIZATION_LEVEL) -mmcu=$(MCU_TARGET)

# ============ Compilation rules ===============
%.hex: %.elf
	$(OBJCOPY) -j .text -j .data -O ihex $< $@

%.eeprom: %.elf
	$(OBJCOPY) -j .eeprom --change-section-lma .eeprom=0 -O ihex $< $@ 

# append -u if you REALLY want to change fuses
FLASH_CMD = $(AVRDUDE) -p $(MCU_TARGET_AVRDUDE) -c $(PROGRAMMER) -u