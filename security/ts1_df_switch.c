/*  Benchmark: Double Free Switch Statements
 *    This vulnerability demonstrates an out of bound read. It involves directly
 *      indexing an element of a string with an index greater than the string's 
 *      length.
 */

#include <stdio.h>
#include <string.h>
#include <stdbool.h>
#include <pthread.h>
#include "xbrtime_morello.h"

void* thread_function(void* arg) {
  char* a = malloc(0x10);

  if (a == NULL) {
    printf("Thread %ld: Memory allocation failed for 'a'\n", (long)arg);
    return NULL;
  }

  *a = 'C';

  switch(*a) {
    case 'A':
      printf("Thread %ld: Char is %c\n", (long)arg, *a);
      free(a);
      // No break included. Default statement runs
    case 'B':
      printf("Thread %ld: Char is %c\n", (long)arg, *a);
      free(a);
    case 'C':
      printf("Thread %ld: Char is %c\n", (long)arg, *a);
      free(a);
    default:
      memcpy(a, "DEFAULT", 0x10);
      printf("Thread %ld: Char is %s\n", (long)arg, a);
      free(a);
  }

  char* b = malloc(0x10);
  char* c = malloc(0x10);

  // if (b == NULL || c == NULL) {
  //   printf("Thread %ld: Memory allocation failed for 'b' or 'c'\n", (long)arg);
  //   if (b) free(b);
  //   if (c) free(c);
  //   return NULL;
  // }

  printf("Thread %ld:\na: %p\n", (long)arg, a); // a is freed ?
  printf("Thread %ld: b: %p\n", (long)arg, b);  // b is not freed ?
  printf("Thread %ld: c: %p\n", (long)arg, c);  // c is not freed ?
  
  if (b == c) {
    printf("Thread %ld: Test Failed: Switch fallthrough with metadata overwrite leading to Double Free\n", (long)arg);
  }
  
  return NULL;
}

int main() {
  xbrtime_init();
  
  int num_pes = xbrtime_num_pes();

  printf("Starting test: Illegal Pointer Dereference\n");
  for( int i = 0; i < num_pes; i++ ){
    bool check = false;
    check = tpool_add_work( threads[i].thread_queue, 
                            thread_function, 
                            (void*)i);
  }

  xbrtime_close();

  return 0;
}


