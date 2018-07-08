include ../target.mk

LIBNAME	= lib$(FREERTOS_LIBRARY_NAME).a
TARGET = ../$(LIBS_DIR)/$(LIBNAME)

DEFS		= F_CPU=$(CLOCK_HZ)UL GCC_MEGA_AVR portUSE_TIMER$(FREERTOS_TICK_SOURCE_TIMER)
INCLUDE		= ../$(FREERTOS_INCLUDE_DIR)

# Compiler flags
override CFLAGS   = $(CC_FLAGS) $(addprefix -D,$(DEFS)) $(addprefix -I,$(INCLUDE))

# Sources list
sources := heap_$(FREERTOS_HEAP_MANAGER).c croutine.c event_groups.c list.c queue.c tasks.c timers.c hooks.c port.c

# Make a list of object files
cfiles = $(filter %.c,$(sources))
sfiles = $(filter %.S,$(sources))

cobjs = $(subst .c,.o,$(cfiles))
sobjs = $(subst .S,.o,$(sfiles))

objs = $(cobjs)
objs += $(sobjs)

# override %.S rule to use our CC and CFLAGS
%.o: %.S
	$(CC) $(CFLAGS) -c $< -o $@ 

# pull in dependency info for *existing* .o files
-include $(OBJS:.o=.d)

# compile and create dependencies as we go
%.o: %.c
	$(CC) -c $(CFLAGS) $*.c -o $*.o
	@$(CC) -MM $(CFLAGS) $*.c > $*.d
	@mv -f $*.d $*.d.tmp
	@sed -e 's|.*:|$*.o:|' < $*.d.tmp > $*.d
	@sed -e 's/.*://' -e 's/\\$$//' < $*.d.tmp | fmt -1 | \
	sed -e 's/^ *//' -e 's/$$/:/' >> $*.d
	@rm -f $*.d.tmp

$(TARGET): $(objs)
	@$(AR) -rcs $(TARGET) $(objs)

.PHONY:	all clean

all: $(TARGET)

clean:
	@rm -f $(objs) $(TARGET)
	@rm -rf *.d