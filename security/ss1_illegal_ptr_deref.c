/*  Benchmark: Double Free Switch Statements
 *    This vulnerability demonstrates an out of bound read. It involves directly
 *      indexing an element of a string with an index greater than the string's 
 *      length.
 *
 */

#include <stdio.h>
#include <string.h>
#include <stdbool.h>
#include <pthread.h>
#include "xbrtime_morello.h"

void* thread_function(void* arg) {
    long int SIZE = 0x40000000000; // Larger than the max size for malloc
    int* c;                        // Uninitialized pointer

    c = malloc(SIZE); // Allocate memory

    if (c == NULL) {
        printf("Thread %ld: Memory allocation failed\n", (long)arg);
        return NULL;
    }

    printf("Thread %ld: Address of x: %p\n", (long)arg, c); // Address of x

    // Since malloc failed, we should not dereference c
    printf("Thread %ld: Value of x: %d\n", (long)arg, *c); // Dereference c

    if (*c != 0) {
      // Test failed if we reach here
      printf("Thread %ld: Test Failed: Illegal pointer access caused by incorrect sized memory allocation\n", (long)arg);
    }

    free(c);

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
