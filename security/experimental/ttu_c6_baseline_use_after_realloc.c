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

// Function to demonstrate use-after-reallocation
void use_after_reallocation() {
  // Step 1: Allocate memory and initialize
  int *original_ptr = (int *)malloc(10 * sizeof(int));
  printf("original_ptr starts at: %p\n", (void *)original_ptr);

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
  
  // Step 2: Free the allocated memory
  free(original_ptr);

  // Step 3: Reallocate memory for a different purpose
  char *new_ptr = (char *)malloc(10 * sizeof(char));
  printf("new_ptr starts at: %p\n", (void *)new_ptr);

  if (new_ptr == NULL) {
    printf("Memory allocation failed\n");
    return;
  }
  strcpy(new_ptr, "NewData");
  printf("New data: %s\n", new_ptr);

  // Step 4: Use after reallocation - accessing old data
  printf("Use after reallocation (original pointer): ");
  for (int i = 0; i < 10; i++) {
    printf("%d ", original_ptr[i]);  // Accessing freed memory
  }
  printf("\n");

  // Clean up
  free(new_ptr);
}

int main() {
  use_after_reallocation();
  return 0;
}
