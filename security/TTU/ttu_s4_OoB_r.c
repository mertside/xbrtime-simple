/*  Benchmark: Out-of-Bounds Read
 *  @author  : Mert Side for TTU
 *  @brief   : This benchmark is a simple test to demonstrate an out-of-bounds read.
 * 
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <pthread.h>
#include "xbrtime_morello.h"

#define PUBLIC_SIZE 6
#define PRIVATE_SIZE 14

void* out_of_bounds_read(void* arg) {
  // Allocate a single buffer large enough to hold both 'public' and 'private' data
  char* buffer = malloc(PUBLIC_SIZE + PRIVATE_SIZE);
  if (buffer == NULL) {
    printf("Thread %ld: Memory allocation failed\n", (long)arg);
    return NULL;
  }

  // Set 'public' and 'private' pointers within the buffer
  char* public = buffer;
  char* private = buffer + PUBLIC_SIZE;

  // Initialize the 'public' and 'private' segments
  strcpy(public, "public");
  strcpy(private, "secretpassword");

  // Simulate a safe print of the 'public' data
  printf("Thread %ld: Printing characters of public array\n", (long)arg);
  for (int i = 0; i < PUBLIC_SIZE; i++) {
    printf("%c", public[i]);
  }
  printf("\n");

  // Simulate an out-of-bounds read from the 'public' segment to access 'private' data
  printf("Thread %ld: Printing characters of private array from public array\n", (long)arg);
  for (int i = 0; i < PRIVATE_SIZE; i++) {
    printf("%c", public[PUBLIC_SIZE + i]);  // OOB read here
  }
  printf("\n");

  // Free the allocated buffer
  free(buffer);

  return NULL;
}

int main() {
  xbrtime_init();

  int num_pes = xbrtime_num_pes();

  printf("Starting test: Out of Bounds Read\n");

  for (int i = 0; i < num_pes; i++) {
    bool check = false;
    check = tpool_add_work(threads[i].thread_queue,
                            out_of_bounds_read,
                            i);
  }

  printf("Test Completed: Out-of-Bounds Read\n\n");

  xbrtime_close();

  return 0;
}
