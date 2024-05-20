/*  Benchmark: Data Oriented Programming – dop_overflowing_integer_buffer_on_stack
 *
 */

#include <stdio.h>
#include <string.h>
#include <stdbool.h>
#include <pthread.h>
#include "xbrtime_morello.h"

int exploit_input[10] = {55, 23, 45, 31, 88, 14, 32, 45, 32, 10};
int buffer[5];  // Small buffer
int adminAccess = 0;  // Variable controlling access

char* adminAccessPointer;
char* bufferAddress;
int bufferAccessDifference;
pthread_mutex_t lock;

// Function to be executed by each thread
void *perform_overflow(void *arg) {
  printf("Starting Test: Data Oriented Programming - Overflow into adjacent variable\n");

  int thread_id = *(int *)arg;
  int chunk_size = sizeof(exploit_input) / 4;
  int start = thread_id * chunk_size;
  int end = (thread_id == 3) ? sizeof(exploit_input) : start + chunk_size;

  printf("Thread %d: Writing to buffer\n", thread_id); 
  printf("Thread %d: Start: %d, End: %d\n", thread_id, start, end);
  // printf("Thread %d: Buffer Address: %p\n", thread_id, bufferAddress);
  // printf("Thread %d: Admin Access Address: %p\n", thread_id, adminAccessPointer);
  // printf("Thread %d: Buffer Access Difference: %d\n", thread_id, bufferAccessDifference);
  // printf("Thread %d: Admin Access: %d\n", thread_id, adminAccess);

  for (int i = start; i < end; i++) {
    pthread_mutex_lock(&lock);
    buffer[i + bufferAccessDifference] = exploit_input[i];
    pthread_mutex_unlock(&lock);
  }

  return NULL;
}

int main() {
  xbrtime_init();
  int num_pes = xbrtime_num_pes();

  // pthread_t threads[4];
  int thread_ids[num_pes];

  adminAccessPointer = (char*)&adminAccess;
  bufferAddress = (char*)buffer;
  bufferAccessDifference = adminAccessPointer - bufferAddress;

  // Print exploit input
  printf("Exploit Input: ");
  for (int i = 0; i < sizeof(exploit_input) / sizeof(exploit_input[0]); i++) {
    printf("%d ", exploit_input[i]);
  }

  // Create threads
  for( int i = 0; i < num_pes; i++ ){
    bool check = false;

    thread_ids[i] = i;

    printf("Thread ID: %d\n", thread_ids[i]);

    check = tpool_add_work( threads[i].thread_queue, 
                            perform_overflow, 
                            &thread_ids[i]);
  }

  // pthread_mutex_init(&lock, NULL);

  // // Create threads
  // for (int i = 0; i < 4; i++) {
  //   thread_ids[i] = i;
  //   if (pthread_create(&threads[i], NULL, perform_overflow, &thread_ids[i]) != 0) {
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

  if (adminAccess) {
    printf("Test Failed: Data Oriented Programming - Overflow into adjacent variable\n");
  } else {
    printf("Regular user access.\n");
  }

  // pthread_mutex_destroy(&lock);
  // xbrtime_finalize();
  xbrtime_close();

  return 0;
}
