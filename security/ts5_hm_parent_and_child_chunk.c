/*  Benchmark: Heap Manipulation
 *   This vulnerability demonstrates a heap manipulation exploit. It involves first
 *   using an out of bounds write to make the range of one chunk extend past the range 
 *   of a formally subsequent chunk. Thus the memory range of the second chunk would be 
 *   inside the range of the first. These chunks are then feed and reallocated. Thus
 *   any edit made on the larger chunk would be legal, regardless of whether the memory
 *   written to or read from was within the space of the smaller chunk.
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <pthread.h>
#include "xbrtime_morello.h"

void* thread_function(void* arg) {
  xbrtime_barrier();

  char* c = malloc(0x10);
  char* d = malloc(0x10);
  char* e = malloc(0x10);

  *(c+0x18) = 0x61; //Manually edit size of d to a larger size so that it overlaps with e
  
  free(d); //Free d for a reallocation
  free(e); //Free e for a reallocation

  /* 
    If a malloc is done for h with the size of e and for g with the adjusted size of d, 
    and is successful, then the memory allocated to h would be a subset of the memory
    allocated to g. Thus g would be able to legally control the contents of the memory 
    allocated to h
  */
  
  char* g = malloc(0x50); //Allocate a new variable with the increased size
  char* h = malloc(0x10); 
  
  // If the exploit succeeded, then d and g will be the same, otherwise d and h will be the same
  
  memcpy(h, "victim's data", 0xe); //h copies in some data needed for program control
  
  memset(g+0x20, 0x41, 0xf); // This position is still within the legal memory range of g but the memory region overlaps with h


  printf("d: %p\n", d);
  printf("e: %p\n\n", e);

  printf("g: %p -> %p\n", g, (g+0x50));
  printf("h: %p\n", h);
  printf("h: %s\n", h);

  if(h[0] == 'A')
    printf("Test Failed: Heap manipulation leading to overlapping memory regions\n");
  
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
