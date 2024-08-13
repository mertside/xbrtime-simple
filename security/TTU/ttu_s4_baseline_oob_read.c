/*  Benchmark: Out-of-Bounds Read
 *  @author  : Mert Side for TTU
 *  @brief   : This benchmark is a simple test to demonstrate an out-of-bounds read.
 * 
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <pthread.h>

#define PUBLIC_SIZE 6
#define PRIVATE_SIZE 14

int main() {
  printf("Starting test: Out of Bounds Read\n");

  // Allocate a single buffer large enough to hold both 'public' and 'private' data
  // char* buffer = malloc(PUBLIC_SIZE + PRIVATE_SIZE);
  // if (buffer == NULL) {
  //   printf("Memory allocation failed\n");
  // }

  // Set 'public' and 'private' pointers within the buffer
  // char* public = buffer;
  // char* private = buffer + PUBLIC_SIZE;

  // Allocate separate buffers for 'public' and 'private' data
  char* public = malloc(PUBLIC_SIZE);
  char* private = malloc(PRIVATE_SIZE);

  // Initialize the 'public' and 'private' segments
  strcpy(public, "public");
  strcpy(private, "secretpassword");

  // Simulate a safe print of the 'public' data
  printf("Printing characters of public array\n");
  for (int i = 0; i < PUBLIC_SIZE; i++) {
    printf("%c", public[i]);
  }
  printf("\n");

  // Simulate an out-of-bounds read from the 'public' segment to access 'private' data
  printf("Printing characters of private array from public array\n");
  for (int i = 0; i < PRIVATE_SIZE; i++) {
    printf("%c", public[PUBLIC_SIZE + i]);  // OOB read here
  }
  printf("\n");

  // Free the allocated buffer
  free(buffer);

  printf("Test Completed: Out-of-Bounds Read\n\n");

  return 0;
}
