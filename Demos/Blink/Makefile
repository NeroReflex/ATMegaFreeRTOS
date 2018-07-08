include ../../target.mk

TARGET = ../../$(DEMOS_DIR)/Blink

#--------------------------------------------------------------------------
# Do not change things past this point unless you know what you are doing 
#--------------------------------------------------------------------------

DEFS		= F_CPU=$(CLOCK_HZ)UL GCC_MEGA_AVR
INCLUDE		= ../../$(FREERTOS_INCLUDE_DIR)

# Sources located at the top of the source tree.
# Other sources are included by .mk files

sources := main.c

# Make a list of object files
cfiles = $(filter %.c,$(sources))
sfiles = $(filter %.S,$(sources))

cobjs = $(subst .c,.o,$(cfiles))
sobjs = $(subst .S,.o,$(sfiles))

objs = $(cobjs)
objs += $(sobjs)

# override %.S rule to use our CC and CFLAGS

%.o:	%.S	
	$(CC) $(CFLAGS) -c $< -o $@ 


# pull in dependency info for *existing* .o files
-include $(OBJS:.o=.d)

# compile and create dependencies as we go

%.o: %.c
	$(CC)  -c $(CFLAGS) $*.c -o $*.o
	@$(CC) -MM $(CFLAGS) $*.c > $*.d
	@mv -f $*.d $*.d.tmp
	@sed -e 's|.*:|$*.o:|' < $*.d.tmp > $*.d
	@sed -e 's/.*://' -e 's/\\$$//' < $*.d.tmp | fmt -1 | \
	sed -e 's/^ *//' -e 's/$$/:/' >> $*.d
	@rm -f $*.d.tmp


# Compiler flags
override CFLAGS   = $(CC_FLAGS) $(addprefix -D,$(DEFS)) $(addprefix -I,$(INCLUDE))
override LDFLAGS  = -Wl,--gc-sections,-Map,$(TARGET).map 

$(TARGET).elf: $(objs)
	$(CC) $(LDFLAGS) -mmcu=$(MCU_TARGET) -o $(TARGET).elf $(objs) -L ../../$(LIBS_DIR) -l$(FREERTOS_LIBRARY_NAME)

$(TARGET).hex: $(TARGET).elf

.PHONY:	all clean flash program

all: $(TARGET).hex $(TARGET).eeprom
	$(SIZE) --format=avr --mcu=$(MCU_TARGET) $(TARGET).elf

clean:
	@rm -f $(objs) $(TARGET).elf $(TARGET).hex $(TARGET).eeprom $(TARGET).map
	@rm -rf *.d

flash: $(TARGET).hex $(TARGET).eeprom
	$(FLASH_CMD) -U flash:w:$(TARGET).hex:i -U eeprom:w:$(TARGET).eeprom:i

program: flash
