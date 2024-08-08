/*  Benchmark: Out-of-Bounds Read
 *  @author  : Mert Side for TTU
 *  @brief   : This benchmark is a simple test to demonstrate an out-of-bounds read.
 * 
 */


#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include "xbrtime_morello.h"

// Function to be executed by each thread
void* out_of_bounds_read(void* arg) {
  long thread_id = (long)arg;
  int array[5];  // Array of 5 integers
  int i;

  // Initialize array
  for (i = 0; i < 5; i++) {
      array[i] = i * 10;  // Set array values
  }

  // Simulate out-of-bounds read
  int out_of_bounds_index = 5 + thread_id; // Deliberately out of bounds
  int read_value = array[out_of_bounds_index]; // Out-of-bounds read

  printf("Thread %ld: Reading out-of-bounds index %d, value: %d\n", 
          thread_id, out_of_bounds_index, read_value);

  return NULL;
}

int main() {
  xbrtime_init();
  int num_pes = xbrtime_num_pes();

  printf("Starting test: Out-of-Bounds Read\n");

  for( int i = 0; i < num_pes; i++ ){
    bool check = false;
    check = tpool_add_work( threads[i].thread_queue, 
                            out_of_bounds_read, 
                            i);
  }

  printf("Test Completed: Out-of-Bounds Read\n\n");
  xbrtime_close();

  return 0;
}



// ---

/*

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <pthread.h>
#include "xbrtime_morello.h"


// Function to be executed by threads
void *oob_r() {

  int test_status = 1;

  char *public     = (char *)malloc(6);
  strcpy(public, "public");

  char *private    = (char *)malloc(14);
  strcpy(private, "secretpassword");

  int offset = private-public;
  //  printf("Offset of private array w.r.t public array: %d\n", offset);
 
  printf("Printing characters of public array\n");
  for(int i=0;i<6;i++) {
          printf("%c", public[i]);
  }
  printf("\n");

  printf("Printing characters of private array from public array\n");
  for(int i=0;i<14;i++) {
          printf("%c", public[i+offset]);
	  if(public[i+offset] == private[i])
	    test_status = 0;
  }
  printf("\n");

  sleep(1);
  return NULL;
}

int main() {
  xbrtime_init();
  
  int num_pes = xbrtime_num_pes();

  printf("Starting test: OOB Read\n");

  for( int i = 0; i < num_pes; i++ ){
    bool check = false;
    check = tpool_add_work( threads[i].thread_queue, 
                            oob_r, 
                            NULL);
  }
  printf("Test Complete: OOB Read\n\n");

  xbrtime_close();

  return 0;
}

*/