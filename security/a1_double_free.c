/*
 * Based on Double Free by STAM
 * Adapted by Mert Side for Texas Tech University
 *
 * Key Notes:
 * 
 * The code creates a shared resource that includes dynamically allocated memory
 *  and a mutex for synchronization. Each thread attempts to free the shared 
 *  memory. The mutex ensures that only one thread can access the shared memory 
 *  at a time, and setting the pointer to NULL after freeing it helps prevent 
 *  the second thread from attempting a double-free.
 * 
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <pthread.h>
#include "xbrtime_morello.h"

// Structure for shared data between threads
typedef struct {
  char *data;
  pthread_mutex_t lock;
} shared_resource_t;

// Function to be executed by threads
void *thread_func(void *arg) {
  shared_resource_t *resource = (shared_resource_t *)arg;
  
  // Locking the shared resource
  pthread_mutex_lock(&resource->lock);
  if (resource->data != NULL) {
    printf("PE %d: Freeing memory\n", xbrtime_mype());
    free(resource->data);
    resource->data = NULL;  // To prevent double-free by the second thread
  } else {
    printf("PE %d: Memory already freed\n", xbrtime_mype());
  }
  // Unlocking the shared resource
  pthread_mutex_unlock(&resource->lock);

  return NULL;
}

int main() {
  xbrtime_init();

  printf("Starting Test: Double Free\n");

  shared_resource_t resource;
  pthread_mutex_init(&resource.lock, NULL);
  resource.data = malloc(sizeof(char) * 84);	
  strcpy(resource.data, "Hello World!Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod");

  // Creating two threads to simulate potential double-free vulnerability
  pthread_t threads[2];
  for (int i = 0; i < 2; i++) {
    if(pthread_create(&threads[i], NULL, thread_func, &resource) != 0) {
      fprintf(stderr, "Error creating thread\n");
      return 1;
    }
  }

  // Joining threads
  for (int i = 0; i < 2; i++) {
    if(pthread_join(threads[i], NULL) != 0) {
      fprintf(stderr, "Error joining thread\n");
      return 1;
    }
  }

  printf("Test Complete: Double Free\n\n");

  pthread_mutex_destroy(&resource.lock);
  xbrtime_close();

  return 0;
}
