/*  Benchmark: Illegal Pointer
 *    This vulnerability demonstrates an illegal pointer dereference.
 *
 */

#include <stdio.h>
#include <string.h>
#include <stdbool.h>
#include <pthread.h>
#include "xbrtime_morello.h"

void* thread_function(void* arg) {
  // xbrtime_barrier();
  sleep(1);

  long int SIZE = 0x40000000000; // Larger than the max size for malloc
  int* c;                        // Uninitialized pointer

  c = malloc(SIZE); // Allocate memory

  printf("Thread %ld: Address of x: %p\n", (long)arg, c); // Address of x
  printf("Thread %ld: Value of x: %d\n", (long)arg, *c);  // Dereference c

  if (*c != 0) {
    // Test failed if we reach here
    printf("Thread %ld: Test Failed: Illegal pointer access caused by incorrect sized memory allocation\n", (long)arg);
  }

  free(c);

  sleep(1);
  // xbrtime_barrier();
  return NULL;
}

int main() {
  xbrtime_init();
  
  int num_pes = xbrtime_num_pes();

  printf("Starting test: Illegal Pointer Dereference\n");
  for( int i = 0; i < num_pes; i++ ){
    bool check = false;
    check = tpool_add_work( threads[i].thread_queue, 
                            thread_function, 
                            (void*)i);
  }

  xbrtime_close();
  
  return 0;
}
