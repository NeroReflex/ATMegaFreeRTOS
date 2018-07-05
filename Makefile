include target.mk

all:

%:
	mkdir -p $(BUILD_DIR)
	mkdir -p $(TARGET_DIR)
	mkdir -p $(LIBS_DIR)
	mkdir -p $(DEMOS_DIR)
	@echo Compiling FreeRTOS....
	@echo
	$(MAKE) -C FreeRTOS $@
	@echo
	@echo Compiling Demo projects
	$(MAKE) -C Demos $@
	@echo
	@echo \"make $@\" completed.