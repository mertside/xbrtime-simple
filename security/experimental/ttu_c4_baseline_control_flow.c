/*  Benchmark: Control Flow Attack Using Function Pointer
 *  @author  : Mert Side for TTU
 *  @brief   : A control flow attack typically involves manipulating the 
 *             execution path of a program to execute unintended or malicious 
 *             code. This type of attack exploits vulnerabilities related to how 
 *             control flow data (like function pointers or return addresses) is 
 *             handled in memory
 * 
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void benign_function() {
  printf("Executing benign function.\n");
}

void malicious_function() {
  printf("Executing malicious function. Control flow hijacked!\n");
}

void vulnerable_function() {
  char buffer[64];
  void (*func_ptr)() = benign_function;  // Initialize the function pointer to the benign function

  // Fill the buffer with 'A's to simulate a controlled overflow
  memset(buffer, 'A', sizeof(buffer));

  // Calculate the distance from the start of the buffer to the function pointer
  __intptr_t distance = (char *)&func_ptr - buffer;
  printf("Function pointer initially points to: %p\n", (void *)func_ptr);
  printf("Buffer starts at: %p\n", (void *)buffer);
  printf("Function pointer is at offset: %ld\n", distance);

  // Check if we can safely manipulate the function pointer within the buffer bounds
  // if (distance < sizeof(buffer)) {
  //   *(void **)(buffer + distance) = malicious_function;  // Overwrite function pointer
  //   printf("Function pointer modified to point to: %p\n", (void *)malicious_function);
  // } else {
  //   printf("Function pointer location is outside of buffer bounds, cannot overwrite safely.\n");
  // }

  *(void **)(buffer + distance) = malicious_function;  // Overwrite function pointer

  // Output the current buffer state near the function pointer location for debugging
  printf("Buffer state near function pointer location: ");
  for (int i = distance - 10; i < distance + 10; ++i) {
    if (i >= 0 && i < sizeof(buffer)) {
      printf("%02X ", buffer[i] & 0xFF);
    }
  }
  printf("\n");

  func_ptr();  // Execute the function pointer
}

int main() {
  printf("Starting the control flow attack simulation without user input.\n");
  vulnerable_function();
  printf("Exiting the program.\n");
  return EXIT_SUCCESS;
}

/*

  #include <stdio.h>
  #include <stdlib.h>

  // Benign function
  void benign_function() {
      printf("This is a benign function.\n");
  }

  // Malicious function
  void malicious_function() {
      printf("This is a malicious function. Control flow has been hijacked!\n");
  }

  void vulnerable_function() {
      void (*func_ptr)() = benign_function;  // Function pointer initialized to point to a benign function
      char buffer[64];

      printf("Enter some text: ");
      gets(buffer);  // Vulnerable function that can lead to buffer overflow

      func_ptr();  // Call function via function pointer
  }

  int main() {
      vulnerable_function();
      return 0;
  }

*/