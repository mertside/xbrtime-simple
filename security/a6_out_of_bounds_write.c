/*  
 * Based on Out-of-Bounds Write by STAM
 * Adapted by Mert Side for Texas Tech University
 *
 *  
 * 
 * 
 */

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <pthread.h>
#include "xbrtime_morello.h"

// #define NUM_THREADS 2

typedef struct {
  char *public;
  char *private;
  int offset;
  int test_status;
} shared_data_t;

void *update_strings(void *arg) {
  shared_data_t *data = (shared_data_t *)arg;
  
  if (xbrtime_mype() == 0) {
    // First PE: Update 'public' string
    printf("PE 0: Updating value of first string with ?. \n");
    printf("PE 0: Original value: %s\n", data->public);
    for(int i = 0; i < 5; i++) {
      data->public[i] = '?';
    }
    printf("PE 0: New value: %s\n", data->public);
  } else {
    // Second PE: Update 'private' string using offset from 'public'
    printf("PE 1: Updating value of second string with ? from first string pointer\n");
    printf("PE 1: Original value: %s\n", data->private);
    for(int i = 0; i < 6; i++) {
      data->public[i + data->offset] = '?';
      if(data->private[i] == '?')
        data->test_status = 0;
    }
    printf("PE 1: New value: %s\n", data->private);
  }

  return NULL;
}

int main() {
  xbrtime_init();

  printf("Starting Test: OOB Write\n");

  shared_data_t data;
  data.public = malloc(sizeof(char) * 5);
  strcpy(data.public, "FIRST");
  data.private = malloc(sizeof(char) * 6);
  strcpy(data.private, "SECOND");
  data.offset = data.private - data.public;
  data.test_status = 1;
  
  int num_pes = xbrtime_num_pes();

  for( int i = 0; i < num_pes; i++ ){
    bool check = false;
    check = tpool_add_work( threads[i].thread_queue, 
                            update_strings, 
                            (void *) data);
  }

  // // Parallel execution
  // pthread_t threads[NUM_THREADS];
  // for (int i = 0; i < NUM_THREADS; i++) {
  //   pthread_create(&threads[i], NULL, update_strings, &data);
  // }

  // // Join threads
  // for (int i = 0; i < NUM_THREADS; i++) {
  //   pthread_join(threads[i], NULL);
  // }

  if (data.test_status == 0)
    printf("Test Failed: OOB Write\n\n");

  // Cleanup
  free(data.public);
  free(data.private);
  xbrtime_close();

  return 0;
}
