/*  Benchmark: Out-of-Bounds Read
 *  @author  : Mert Side for TTU
 *  @brief   : This benchmark is a simple test to demonstrate an out-of-bounds read.
 * 
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define PUBLIC_SIZE 6
#define PRIVATE_SIZE 14

int main() {
  printf("Starting test: Out of Bounds Read\n");

  int test_status = 1;

  // Allocate a single buffer large enough to hold both 'public' and 'private' data
  // char* buffer = malloc(PUBLIC_SIZE + PRIVATE_SIZE);
  // if (buffer == NULL) {
  //   printf("Memory allocation failed\n");
  // }

  // Set 'public' and 'private' pointers within the buffer
  // char* public = buffer;
  // char* private = buffer + PUBLIC_SIZE;

  // Allocate separate buffers for 'public' and 'private' data
  char* public  = (char *) malloc(PUBLIC_SIZE);
  char* private = (char *) malloc(PRIVATE_SIZE);

  // Initialize the 'public' and 'private' segments
  strcpy(public, "public");
  strcpy(private, "secretpassword");

  // Print the starting addresses of the 'public' and 'private' segments
  printf("  Address of public array:    %p\n", (void *)public);
  printf("  Address of private array:   %p\n", (void *)private);

  // Calculate the offset between the 'public' and 'private' segments
  __intptr_t offset = private - public;
  printf("  Offset of private array w.r.t public array: \t%ld\n", offset);

  // Simulate a safe print of the 'public' data
  printf("Printing characters of public array\n");
  for (int i = 0; i < PUBLIC_SIZE; i++) {
    printf("%c", public[i]);
  }
  printf("\n");

  // Simulate an out-of-bounds read from the 'public' segment to access 'private' data
  printf("Printing characters of private array from public array\n");
  for (int i = 0; i < PRIVATE_SIZE; i++) {
    // printf("%c", public[PUBLIC_SIZE + i]);    // OOB read here
    printf("%c", public[i + offset]);         // OOB read here

    // Check if the OOB read matches the corresponding 'private' data
    if (public[i + offset] == private[i]) {
      test_status = 0;
    }
  }
  printf("\n");

  // Free the allocated buffer
  // free(buffer);
  free(public);
  free(private); 

  // Print the test result
  if(test_status == 0)
    printf("Test: Out-of-Bounds Read: EXPLOITED!\n");
  else
    printf("Test: Out-of-Bounds Read: Mitigated!\n");

  return 0;
}
