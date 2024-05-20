/*  Benchmark: Use After Free on function pointer leads to code reuse attack
 *
 */

#include <stdio.h>
#include <string.h>
#include <stdbool.h>
#include <pthread.h>
#include "xbrtime_morello.h"

struct s_user {
    void (*func_ptr)(void);
    char username[8];
};

int count = 0;
pthread_mutex_t count_mutex;

void print_count() {
    pthread_mutex_lock(&count_mutex);
    printf("Count: %d\n", count);
    pthread_mutex_unlock(&count_mutex);
}

void gadget(void) {
    printf("Test Failed: UAF to Code Reuse\n\n");
    exit(0);
}

void* thread_function(void* arg) {
    printf("Starting test: UAF to Code Reuse\n");

    struct s_user *user = (struct s_user *)malloc(sizeof(struct s_user));
    pthread_mutex_lock(&count_mutex);
    count++;
    pthread_mutex_unlock(&count_mutex);

    user->func_ptr = &print_count;
    strcpy(user->username, "Hedwig");

    user->func_ptr();

    // Free the struct object
    free(user);
    pthread_mutex_lock(&count_mutex);
    count--;
    pthread_mutex_unlock(&count_mutex);

    // Realloc same buffer to long value
    unsigned long *value = (unsigned long *)malloc(sizeof(unsigned long));
    
    // Simulated user input: Address to code segment to be reused
    *value = (unsigned long)&gadget;

    // Use after free
    user->func_ptr();

    printf("Test Complete: UAF to Code Reuse\n\n");

    free(value);

    return NULL;
}

int main(void) {
  xbrtime_init();
  
  int num_pes = xbrtime_num_pes();

  printf("Starting test: UAF to Code Reuse\n");
  for( int i = 0; i < num_pes; i++ ){
    bool check = false;
    check = tpool_add_work( threads[i].thread_queue, 
                            thread_function, 
                            NULL);
  }

  // pthread_t threads[4];
  // pthread_mutex_init(&count_mutex, NULL);

  // for(int i = 0; i < 4; i++) {
  //     pthread_create(&threads[i], NULL, thread_function, NULL);
  // }

  // for(int i = 0; i < 4; i++) {
  //     pthread_join(threads[i], NULL);
  // }

  // pthread_mutex_destroy(&count_mutex);

  xbrtime_close();

  return 0;
}

