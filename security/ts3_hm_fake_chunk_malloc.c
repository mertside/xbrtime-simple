/*  Benchmark: Heap Manipulation
 *    This vulnerability demonstrates a heap allocation exploit. It involves freeing
 *    chunks onto the tcache and then performing a use-after-free to modify chunk address.
 *    Thus, a chunk is artificially added to the tcache and can be allocated during a malloc
 */

#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include "xbrtime_morello.h"

void* thread_function(void* arg) {
  xbrtime_barrier();

  unsigned long int *ptr0, *ptr1, *target;

  ptr0 = malloc(0x10);
  ptr1 = malloc(0x10);
  target = malloc(0x10);

  printf("ptr0: %p\n", ptr0);
  printf("ptr1: %p\n", ptr1);
  printf("Target: %p\n\n", target);

  free(ptr0);
  free(ptr1);

  // Address of previous chunk is stored in ptr1. Increment by 64 to change this value to 
  // the address of the target
  *ptr1 = *ptr1+64; 
  // *ptr1 = *ptr1-64; //Use this line if previous line returns an address different from target 

  unsigned long int *ptr_x, *ptr_y, *ptr_z;

  ptr_x = malloc(0x10);
  ptr_y = malloc(0x10);

  printf("ptr_x: %p\n", ptr_x);
  printf("ptr_y: %p\n", ptr_y); //Value would be same as target

  if(ptr_y == target)
    printf("Test Failed: Heap manipulation leading to allocation on specific address\n");

  xbrtime_barrier();
  return NULL;
}

int main() {
  xbrtime_init();
  
  int num_pes = xbrtime_num_pes();

  printf("Starting test: Heap manipulation leading to allocation on specific address\n");
  for( int i = 0; i < num_pes; i++ ){
    bool check = false;
    check = tpool_add_work( threads[i].thread_queue, 
                            thread_function, 
                            (void*)i);
  }

  xbrtime_close();

  return 0;
}
