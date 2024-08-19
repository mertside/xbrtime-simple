/*
 * Benchmark: Illegal Pointer
 * Adapted for xBGAS by Mert Side for Texas Tech University
 * 
 * Key Notes:
 * This program demonstrates an illegal pointer dereference caused by 
 * an attempt to allocate an extremely large amount of memory.
 * This version is adapted to run in a multi-threaded xBGAS environment on 
 * Morello.
 * 
 */

#include <stdio.h>
#include <stdlib.h>
#include "xbrtime_morello.h"

#define SIZE 0x40000000000 // Larger than the max size for malloc

// Function to simulate the illegal pointer dereference vulnerability
void* illegal_pointer_dereference(void* arg) {
  long tid = (long)arg;
  printf("[Thread %ld] Starting test: Illegal Pointer Dereference\n", tid);

  int* c = malloc(SIZE);

  // Check if malloc failed
  if (c == NULL) {
    printf("[Thread %ld] Malloc failed: Could not allocate the requested memory size.\n", tid);
    return NULL;
  }

  printf("[Thread %ld] Address of c:      %p\n", tid, c);
  printf("[Thread %ld] Capability of c:   %#p\n", tid, (void *)c);
  printf("[Thread %ld] Value of c:        %d\n", tid, *c);

  if (*c != 0)
    printf("[Thread %ld] Test Failed: Illegal pointer access caused by incorrect sized memory allocation\n", tid);
  else
    printf("[Thread %ld] Test Passed: Illegal pointer access prevented by correct sized memory allocation\n", tid);

  // Free allocated memory if malloc succeeded
  free(c);

  return NULL;
}

int main() {
  xbrtime_init();
  int num_pes = xbrtime_num_pes();

  printf("Starting multi-threaded test: Illegal Pointer Dereference\n");

  // Add work to each thread in the thread pool
  for (long i = 0; i < num_pes; i++) {
    tpool_add_work(threads[i].thread_queue, 
                   illegal_pointer_dereference, 
                   (void*)i);
  }

  // Wait for all threads to complete their work
  for (int i = 0; i < num_pes; i++) {
    tpool_wait(threads[i].thread_queue);
  }

  printf("Completed test: Illegal Pointer Dereference:           EXPLOITED!\n");

  xbrtime_close();

  return 0;
}
