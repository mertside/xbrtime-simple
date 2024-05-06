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

// Define a global pointer that threads will manipulate
char *global_ptr = "Hello World!";

// Function that each thread will execute
void *null_pointer_dereference(void *arg) {
  int pe_id = xbrtime_mype();
  if(pe_id == 0) {
      // PE 0 will print hex characters of the known string
      printf("PE %d printing hex characters of known string:\n", pe_id);
      for(int i = 0; i < 12; i++) {
          printf("%x ", global_ptr[i]);
      }
      printf("\n");
  } else if(pe_id == 1) {
      // PE 1 will attempt to dereference a NULL pointer
      global_ptr = NULL;
      printf("PE %d attempting to dereference NULL pointer:\n", pe_id);
      for(int i = 0; i < 12; i++) {
          // This operation is unsafe and demonstrates the vulnerability
          printf("%x ", global_ptr[i]);
      }
      printf("\n");
  }
  return NULL;
}

int main() {
  xbrtime_init();
  int num_pes = xbrtime_num_pes();
  pthread_t threads[num_pes];

  printf("Starting test: Null pointer dereference\n");


  for( int i = 0; i < num_pes; i++ ){
    bool check = false;
    check = tpool_add_work( threads[i].thread_queue, 
                            null_pointer_dereference, 
                            NULL);
  }

  // // Creating threads
  // for(int i = 0; i < num_pes; i++) {
  //     if(pthread_create(&threads[i], NULL, null_pointer_dereference, NULL) != 0) {
  //         fprintf(stderr, "Error creating thread\n");
  //         return 1;
  //     }
  // }

  // // Joining threads
  // for(int i = 0; i < num_pes; i++) {
  //     if(pthread_join(threads[i], NULL) != 0) {
  //         fprintf(stderr, "Error joining thread\n");
  //         return 1;
  //     }
  // }

  printf("Test Complete: Null pointer dereference\n\n");
  xbrtime_close();

  return 0;
}
