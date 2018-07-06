include ../../target.mk

target = ../../$(DEMOS_DIR)/Blink
elf_target = $(target).elf

#--------------------------------------------------------------------------
# Do not change things past this point unless you know what you are doing 
#--------------------------------------------------------------------------

DEFS		= F_CPU=$(CLOCK_HZ) GCC_MEGA_AVR
INCLUDE		= ../../$(FREERTOS_INCLUDE_DIR)
CC			= avr-gcc
AR			= avr-ar

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
override CFLAGS        = -Wl,--gc-sections --std=gnu99 -ffunction-sections -fdata-sections -mcall-prologues -mrelax -g -Wall -O$(OPTIMIZATION_LEVEL) -mmcu=$(MCU_TARGET) $(addprefix -D,$(DEFS)) $(addprefix -I,$(INCLUDE))

$(elf_target): $(objs)
	$(CC) -mmcu=$(MCU_TARGET) -o $(elf_target) $(objs) -L ../../$(LIBS_DIR) -l$(FREERTOS_LIBRARY_NAME)

.PHONY:	all clean
	
all: $(elf_target)
	avr-size --format=avr --mcu=$(MCU_TARGET) $(elf_target)
	
clean:
	@rm -f $(objs) $(target) $(elf_target)
	@rm -rf *.d
