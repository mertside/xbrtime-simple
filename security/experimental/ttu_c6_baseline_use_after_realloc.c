/*  Benchmark: use-after-reallocation
 *  @author  : Mert Side for TTU
 *  @brief   : A use-after-reallocation vulnerability occurs when memory that 
 *             was freed and then reallocated for another purpose is still 
 *             being accessed using a pointer that references the old data. 
 *             This can lead to undefined behavior, data corruption, or 
 *             security exploits.
 * 
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void use_after_reallocation() {
  // Step 1: Allocate memory and initialize
  int *original_ptr = (int *)malloc(10 * sizeof(int));
  if (original_ptr == NULL) {
    printf("Memory allocation failed\n");
    return;
  }
  for (int i = 0; i < 10; i++) {
    original_ptr[i] = i * 10;
  }
  printf("Original data: ");
  for (int i = 0; i < 10; i++) {
    printf("%d ", original_ptr[i]);
  }
  printf("\n");

  // Print the address of original_ptr
  printf("Address of original_ptr: %p\n", (void *)original_ptr);

  // Step 2: Free the allocated memory
  free(original_ptr);

  // Step 3: Reallocate memory for a different purpose
  char *new_ptr = (char *)malloc(10 * sizeof(char));
  if (new_ptr == NULL) {
    printf("Memory allocation failed\n");
    return;
  }
  strcpy(new_ptr, "NewData");
  printf("New data: %s\n", new_ptr);

  // Print the address of new_ptr
  printf("Address of new_ptr: %p\n", (void *)new_ptr);

  // Calculate the distance between original_ptr and new_ptr
  ptrdiff_t distance = (char*)original_ptr - new_ptr;

  // Print the calculated distance
  printf("Calculated distance: %td bytes\n", distance);

  // Step 4: Use new_ptr to access the original data using the calculated distance
  printf("Accessing original data through new_ptr:\n");
  for (int i = 0; i < 10; i++) {
    int *access_ptr = (int *)(new_ptr + distance + i * sizeof(int));
    printf("%d ", *access_ptr);
  }
  printf("\n");

  // Clean up
  free(new_ptr);
}

int main() {
  use_after_reallocation();
  return 0;
}
