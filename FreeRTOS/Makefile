include ../target.mk

LIBNAME		= lib$(FREERTOS_LIBRARY_NAME).a

#--------------------------------------------------------------------------
# Do not change things past this point unless you know what you are doing 
#--------------------------------------------------------------------------

DEFS		= F_CPU=$(CLOCK_HZ) GCC_MEGA_AVR portUSE_TIMER$(TICK_SOURCE_TIMER)
INCLUDE		= ../$(FREERTOS_INCLUDE_DIR)
CC			= avr-gcc
AR			= avr-ar

target = ../$(LIBS_DIR)/$(LIBNAME)

# Sources located at the top of the source tree.
# Other sources are included by .mk files

sources := croutine.c event_groups.c list.c queue.c tasks.c timers.c

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

$(target) : $(objs)
	@$(AR) -rcs $(target) $(objs)
	
# Compiler flags
override CFLAGS        = --std=gnu99 -ffunction-sections -fdata-sections -mcall-prologues -mrelax -g -Wall -O$(OPTIMIZATION_LEVEL) -mmcu=$(MCU_TARGET) $(addprefix -D,$(DEFS)) $(addprefix -I,$(INCLUDE))

.PHONY:	all clean
	
all: $(target)

clean:
	@rm -f $(objs) $(target)
	@rm -rf *.d
