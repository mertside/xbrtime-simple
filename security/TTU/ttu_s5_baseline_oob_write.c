/*  Benchmark: Out-of-Bounds Write
 *  @author  : Mert Side for TTU
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

  int test_status = 1;

  // Allocate separate buffers for 'public' and 'private' data
  char* public  = (char *) malloc(PUBLIC_SIZE);
  char* private = (char *) malloc(PRIVATE_SIZE);

  // Initialize the 'public' and 'private' segments
  strcpy(public, "public");
  strcpy(private, "secretpassword");

  // Print the starting addresses of the 'public' and 'private' segments
  printf("  Address of public array:     %p\n", (void *)public);
  printf("  Address of private array:    %p\n", (void *)private);

  // Calculate the offset between the 'public' and 'private' segments
  __intptr_t offset = private - public;
  printf("  Offset of private to public: %p\n", (void *)offset);

  // Display initial state of the buffer
  printf("Initial buffer content: %s\n", buffer);

  // Simulate an out-of-bounds write by writing beyond the 'public' segment
  printf("Performing out-of-bounds write\n");
  for (int i = 0; i < PRIVATE_SIZE; i++) {
    public[PUBLIC_SIZE + offset] = 'A' + i;  // OOB write here

    // Check if the OOB write affects the 'private' data
    if (public[PUBLIC_SIZE + offset] == private[i]) {
      test_status = 0;
    }
  }

  // Display modified state of the buffer to show impact of the OOB write
  printf("Modified buffer content: %s\n", buffer);

  // Free the allocated buffer
  free(buffer);

  // Print the test result
  if(test_status == 0)
    printf("Test: Out-of-Bounds Write: EXPLOITED!\n");
  else
    printf("Test: Out-of-Bounds Write: Mitigated!\n");

  return 0;
}
