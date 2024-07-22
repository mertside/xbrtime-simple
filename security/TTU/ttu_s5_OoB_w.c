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
