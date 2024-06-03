/*
 * Based on Double Free by STAM
 * Adapted by Mert Side for Texas Tech University
 *
 * Key Notes:
 * 
 * The code creates a shared resource that includes dynamically allocated memory
 *  and a mutex for synchronization. Each thread attempts to free the shared 
 *  memory. The mutex ensures that only one thread can access the shared memory 
 *  at a time, and setting the pointer to NULL after freeing it helps prevent 
 *  the second thread from attempting a double-free.
 * 
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <pthread.h>
#include "xbrtime_morello.h"

#define BUFFER_SIZE 85

// Function to be executed by threads
void *double_free() {

  char* complete  = malloc(sizeof(char) * BUFFER_SIZE);	
  strcpy(complete, "Hello World!Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod");
  sleep(1);
  printf("Freeing memory(1)\n");
  free(complete);
  sleep(1);
  printf("Freeing memory(2)\n");
  free(complete);


  sleep(1);
  return NULL;
}

int main() {
  xbrtime_init();
  
  int num_pes = xbrtime_num_pes();

  printf("Starting Test: Double Free\n");

  for( int i = 0; i < num_pes; i++ ){
    bool check = false;
    check = tpool_add_work( threads[i].thread_queue, 
                            double_free, 
                            NULL);
  }
  printf("Test Complete: Double Free\n\n");

  xbrtime_close();

  return 0;
}
