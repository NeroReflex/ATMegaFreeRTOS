#include <avr/io.h>
#include <avr/sleep.h>
#include <avr/interrupt.h>

#include "FreeRTOS.h" /* RTOS main include file and configuration */
#include "task.h"     /* RTOS task related API prototypes. */
#include "queue.h"    /* RTOS queue related API prototypes. */
#include "timers.h"   /* Software timer related API prototypes. */
#include "semphr.h"   /* Semaphore related API prototypes. */

void appSetupHook(void) {
	
}

#if ( configUSE_IDLE_HOOK == 1 )
void appIdleHook(void) {
	#if defined(__AVR_ATmega2560__) || defined(__AVR_ATmega2561__) || defined(__AVR_ATmega1280__) || defined(__AVR_ATmega640__)
	// before putting MCU to sleep interrupt MUST be enabled, or it won't wake up
	sei();
	
	// put the MCU to sleep, so that only a timer interrupt can wake it up
	set_sleep_mode( SLEEP_MODE_IDLE );
	sleep_mode();
	#endif
}
#endif

#if ( configUSE_MALLOC_FAILED_HOOK == 1 )
void appMallocFailedHook(void) {
	
}
#endif

#if ( configCHECK_FOR_STACK_OVERFLOW >= 1 )
void appStackOverflowHook(TaskHandle_t xTask __attribute__((unused)), portCHAR *pcTaskName __attribute__((unused))) {
	
}
#endif