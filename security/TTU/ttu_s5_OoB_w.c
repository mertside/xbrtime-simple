/*  Benchmark: Out-of-Bounds Write
 *  @author  : Secure, Trusted, and Assured Microelectronics (STAM) Center
 *             Adaptated by Mert Side for TTU
 *  @brief   : This benchmark is a simple test to demonstrate an out-of-bounds write.
 * 
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <pthread.h>
#include "xbrtime_morello.h"

#define PUBLIC_SIZE 6
#define PRIVATE_SIZE 14

void* out_of_bounds_write(void* arg) {
  // Allocate a single buffer large enough to hold both 'public' and 'private' data
  char* buffer = malloc(PUBLIC_SIZE + PRIVATE_SIZE);
  if (buffer == NULL) {
    printf("Thread %ld: Memory allocation failed\n", (long)arg);
    return NULL;
  }

  // Set 'public' and 'private' pointers within the buffer
  char* public = buffer;
  char* private = buffer + PUBLIC_SIZE;

  // Initialize the 'public' segment
  strcpy(public, "public");

  // Display initial state of the buffer
  printf("Thread %ld: Initial buffer content: %s\n", (long)arg, buffer);

  // Simulate an out-of-bounds write by writing beyond the 'public' segment
  printf("Thread %ld: Performing out-of-bounds write\n", (long)arg);
  for (int i = 0; i < PRIVATE_SIZE; i++) {
    public[PUBLIC_SIZE + i] = 'A' + i;  // OOB write here
  }

  // Display modified state of the buffer to show impact of the OOB write
  printf("Thread %ld: Modified buffer content: %s\n", (long)arg, buffer);

  // Free the allocated buffer
  free(buffer);

  return NULL;
}

int main() {
  xbrtime_init();

  int num_pes = xbrtime_num_pes();

  printf("Starting test: Out of Bounds Write\n");

  for (int i = 0; i < num_pes; i++) {
      bool check = false;
      check = tpool_add_work(threads[i].thread_queue,
                              out_of_bounds_write,
                              i);
  }

  printf("Test complete: Out of Bounds Write\n");
  
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
void *oob_w() {

  int test_status = 1;

  char *public  = malloc(sizeof(char) * 5);	
  strcpy(public, "FIRST");

  char *private = malloc(sizeof(char) * 6);
  strcpy(private, "SECOND");

  int offset = private-public;

  printf("Updating value of first string with ?. \n");
  printf("Original value: %s\n", public);
  for(int i=0;i<5;i++) {
	  public[i] = '?';
  }
  printf("New value: %s\n", public);

  printf("Updating value of second string with ? from first string pointer\n");
  printf("Original value: %s\n", private);
  for(int i=0;i<6;i++) {
	  public[i+offset] = '?';
	  if(private[i] == '?')
	    test_status = 0;
  }
  printf("New value: %s\n", private);

  sleep(1);
  return NULL;
}

int main() {
  xbrtime_init();
  
  int num_pes = xbrtime_num_pes();

  printf("Starting test: OOB Write\n");

  for( int i = 0; i < num_pes; i++ ){
    bool check = false;
    check = tpool_add_work( threads[i].thread_queue, 
                            oob_w, 
                            NULL);
  }
  printf("Test Complete: OOB Write\n\n");

  xbrtime_close();

  return 0;
}
*/