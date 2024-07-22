/*  Benchmark: HeartBleed - Out-of-Bounds Read with length input
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <pthread.h>
#include "xbrtime_morello.h"

// Global variables to be accessed by all threads
char *hb_input;
char *rsa_key;
int offset;
int test_status = 1;
pthread_mutex_t lock;

// Function to be executed by each thread
void *heartbleed_test(void *arg) {
  int thread_id = *(int *)arg;

  // Length of heartbeat message + RSA key
  int num = 6 + offset + 7; 
  // Divide the work into chunks for each thread
  int chunk_size = num / 4; 
  // Start index for each thread  
  int start = thread_id * chunk_size; 
  // Last thread handles remaining characters
  int end = (thread_id == 3) ? num : start + chunk_size; 

  printf("Responding to heartbeat request with %d characters:\n", num);
  for (int i = start; i < end; i++) {
    printf("%c", hb_input[i]); // Send the heartbeat message
    
    // Check if the RSA key is leaked
    if (i > (6 + offset) && hb_input[i] == rsa_key[i - offset]) {
      pthread_mutex_lock(&lock);
      test_status = 0; // Test failed
      pthread_mutex_unlock(&lock);
    }
  }

  return NULL;
}

int main() {
  xbrtime_init();
  int num_pes = xbrtime_num_pes();
  // pthread_t threads[4];
  int thread_ids[num_pes];
  
  printf("Starting test: HeartBleed Example\n");

  // Simulate input heartbeat request
  hb_input = (char *)malloc(6);
  strcpy(hb_input, "HB MSG");

  // Sensitive information stored in memory
  rsa_key = (char *)malloc(7);
  strcpy(rsa_key, "RSA KEY");

  offset = rsa_key - hb_input;

  for( int i = 0; i < num_pes; i++ ){
    bool check = false;

    thread_ids[i] = i;
    printf("Thread ID: %d\n", thread_ids[i]);
    check = tpool_add_work( threads[i].thread_queue, 
                            heartbleed_test, 
                            thread_ids[i]);
  }

  printf("\n");

  if (test_status == 0)
    printf("Test Failed: HeartBleed\n\n");

  xbrtime_close();

  // Free allocated memory
  free(hb_input);
  free(rsa_key);

  return 0;
}
