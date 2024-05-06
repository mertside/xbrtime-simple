/*  Benchmark: Use-After-Free
 *  @author  : Secure, Trusted, and Assured Microelectronics (STAM) Center
 *
 */

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <pthread.h>
#include "xbrtime_morello.h"

#define BUFFER_SIZE 85

// Thread function to demonstrate use-after-free
void *use_after_free(void *arg) {
    printf("Starting Test: Use-After-Free\n");

    char *complete = malloc(sizeof(char) * BUFFER_SIZE);   
    strcpy(complete, "Hello World!Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod");

    printf("Printing characters of string before free:\n");
    for(int i = 0; i < BUFFER_SIZE; i++) {
            printf("%c", complete[i]);
    }
    printf("%c", '\n');

    free(complete);

    // Dangerous operation: using after free
    printf("Printing characters of string after free:\n");
    for(int i = 0; i < BUFFER_SIZE; i++) {
           printf("%c", complete[i]); 
    }

    printf("%c", '\n');
    printf("Test Failed: Use-After-Free\n\n");

    return NULL;
}

int main() {

  xbrtime_init();
  
  int num_pes = xbrtime_num_pes();

  for( int i = 0; i < num_pes; i++ ){
    bool check = false;
    check = tpool_add_work( threads[i].thread_queue, 
                            use_after_free, 
                            NULL);
  }

    // const int num_threads = 4; // Example for 4 PEs
    // pthread_t threads[num_threads];

    // // Create threads to simulate the use-after-free vulnerability across PEs
    // for(int i = 0; i < num_threads; i++) {
    //     pthread_create(&threads[i], NULL, use_after_free, NULL);
    // }

    // // Wait for all threads to complete
    // for(int i = 0; i < num_threads; i++) {
    //     pthread_join(threads[i], NULL);
    // }

    return 0;
}
