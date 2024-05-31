/*
 * Based on Null Pointer Dereference not on Heap by STAM
 * Adapted by Mert Side for Texas Tech University
 *
 * Key Notes:
 * 
 * This code creates a set of threads where each thread performs a specific 
 *  operation based on its PE ID. Specifically, one thread (PE 0) prints the 
 *  hexadecimal characters of a known string, while another thread (PE 1) 
 *  attempts to dereference a NULL pointer. This example illustrates how a NULL 
 *  pointer dereference vulnerability might manifest in a multi-threaded, 
 *  distributed environment. 
 * 
 */

#include <stdio.h>
#include <string.h>
#include <pthread.h>
#include "xbrtime_morello.h"


// Function that each thread will execute
void *null_pointer_dereference(void *arg) {

  char *complete = "Hello World!";
  char *bad_ptr;

  bad_ptr = complete;

  printf("Printing hex characters of known string:\n");
  for(int i=0;i<12;i++) {
          printf("%x", bad_ptr[i]);
  }
  printf("%c", '\n');

  bad_ptr = NULL;

  printf("Printing hex characters of NULL string:\n");
  for(int i=0;i<12;i++) {
         printf("%x", bad_ptr[i]); 
  }

  printf("%c", '\n');

  return NULL;
}

int main() {
  xbrtime_init();
  int num_pes = xbrtime_num_pes();
  // pthread_t threads[num_pes];

  printf("Starting test: Null pointer dereference\n");


  for( int i = 0; i < num_pes; i++ ){
    bool check = false;
    check = tpool_add_work( threads[i].thread_queue, 
                            null_pointer_dereference, 
                            NULL);
  }

  printf("Test Complete: Null pointer dereference\n\n");
  xbrtime_close();

  return 0;
}
