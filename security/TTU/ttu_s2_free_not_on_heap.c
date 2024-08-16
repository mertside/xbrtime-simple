/*
 * Based on Free of Buffer not on Heap by STAM
 * Adapted by Mert Side for Texas Tech University
 *
 * Key Notes:
 * 
 * This code involves creating a scenario where multiple threads attempt to free
 *  a statically allocated string (which should not be freed because it was not
 *  dynamically allocated).
 * 
 */

#include <stdio.h>
#include <stdlib.h>
#include "xbrtime_morello.h"

// Function to simulate the vulnerability
void* free_invalid_buffer(void* arg) {
  long tid = (long)arg;
  printf("[Thread %ld] Starting test: Free not on Heap\n", tid);

  // Static string (not on heap)
  char *complete  = "Hello World!";

  printf("[Thread %ld] Printing characters of string before free:\n", tid);
  for(int i = 0; i < 12; i++) {
    printf("%c", complete[i]);
  }
  printf("\n");

  printf("[Thread %ld] Attempting to free string not on heap\n", tid);
  free(complete);

  printf("[Thread %ld] Printing characters of string after free:\n", tid);
  for(int i = 0; i < 12; i++) {
    printf("%c", complete[i]);
  }
  printf("\n");

  printf("[Thread %ld] Test completed 
          (this message may not appear if the free causes a crash).\n", tid);

  return NULL;
}

int main() {
  xbrtime_init();

  int num_pes = xbrtime_num_pes();

  printf("Starting multi-threaded test: Free not on Heap\n");

  // Add work to each thread in the thread pool
  for (long i = 0; i < num_pes; i++) {
    tpool_add_work(threads[i].thread_queue, free_invalid_buffer, (void*)i);
  }

  // Wait for all threads to complete their work
  for (int i = 0; i < num_pes; i++) {
    tpool_wait(threads[i].thread_queue);
  }

  printf("Completed multi-threaded test: Free not on Heap\n");

  xbrtime_close();

  return 0;
}
