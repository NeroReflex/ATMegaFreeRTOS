#include <avr/io.h>
#include <stdlib.h>

#include "FreeRTOS.h" /* Must come first. */
#include "task.h"     /* RTOS task related API prototypes. */
#include "queue.h"    /* RTOS queue related API prototypes. */
#include "timers.h"   /* Software timer related API prototypes. */
#include "semphr.h"   /* Semaphore related API prototypes. */

int main(int argc, char** argv) {
	
	/* Start the tasks and timer running. */
    vTaskStartScheduler();
	
	
	return 1;
}