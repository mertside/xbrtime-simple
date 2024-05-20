/*  Benchmark: HeartBleed - Out-of-Bounds Read with length input
 *  @author  : Secure, Trusted, and Assured Microelectronics (STAM) Center
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
  int num = 6 + offset + 7;
  int chunk_size = num / 4; // Divide the work into chunks for each thread
  int start = thread_id * chunk_size;
  int end = (thread_id == 3) ? num : start + chunk_size; // Last thread handles remaining characters

  printf("Responding to heartbeat request with %d characters:\n", num);
  for (int i = start; i < end; i++) {
    printf("%c", hb_input[i]);

    if (i > (6 + offset) && hb_input[i] == rsa_key[i - offset]) {
      pthread_mutex_lock(&lock);
      test_status = 0;
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

  // pthread_mutex_init(&lock, NULL);

  // // Create threads
  // for (int i = 0; i < 4; i++) {
  //   thread_ids[i] = i;
  //   if (pthread_create(&threads[i], NULL, heartbleed_test, &thread_ids[i]) != 0) {
  //     fprintf(stderr, "Error creating thread\n");
  //     return 1;
  //   }
  // }

  // // Join threads
  // for (int i = 0; i < 4; i++) {
  //   if (pthread_join(threads[i], NULL) != 0) {
  //     fprintf(stderr, "Error joining thread\n");
  //     return 1;
  //   }
  // }

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

  // pthread_mutex_destroy(&lock);
  xbrtime_close();

  // Free allocated memory
  free(hb_input);
  free(rsa_key);

  return 0;
}
