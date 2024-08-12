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

#define PUBLIC_SIZE 6
#define PRIVATE_SIZE 14

int main() {
  printf("Starting test: Out of Bounds Write\n");

  // Allocate a single buffer large enough to hold both 'public' and 'private' data
  char* buffer = malloc(PUBLIC_SIZE + PRIVATE_SIZE);
  if (buffer == NULL) {
    printf("Memory allocation failed\n");
  }

  // Set 'public' and 'private' pointers within the buffer
  char* public = buffer;
  char* private = buffer + PUBLIC_SIZE;

  // Initialize the 'public' segment
  strcpy(public, "public");

  // Display initial state of the buffer
  printf("Initial buffer content: %s\n", buffer);

  // Simulate an out-of-bounds write by writing beyond the 'public' segment
  printf("Performing out-of-bounds write\n");
  for (int i = 0; i < PRIVATE_SIZE; i++) {
    public[PUBLIC_SIZE + i] = 'A' + i;  // OOB write here
  }

  // Display modified state of the buffer to show impact of the OOB write
  printf("Modified buffer content: %s\n", buffer);

  // Free the allocated buffer
  free(buffer);

  printf("Test complete: Out of Bounds Write\n");

  return 0;
}
