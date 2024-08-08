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
    printf("This is a benign function.\n");
}

void malicious_function() {
    printf("Control flow hijacked! This is a malicious function.\n");
}

void vulnerable_function() {
    char buffer[64];
    void (*func_ptr)() = benign_function;  // Initialize the function pointer to the benign function

    // Simulate filling the buffer with controlled data that overflows and alters the function pointer
    // We fill the buffer with 'A's then explicitly set the function pointer
    memset(buffer, 'A', sizeof(buffer));

    // Directly manipulate the function pointer to point to the malicious function
    // Calculate the position of the function pointer relative to the buffer start
    __intptr_t distance = (char *)&func_ptr - buffer;
    if (distance < sizeof(buffer)) {
        *(void **)(buffer + distance) = malicious_function;
    }

    func_ptr();  // Execute the function pointer
}

int main() {
    printf("Starting the control flow attack simulation without user input.\n");
    vulnerable_function();
    printf("Exiting the program.\n");
    return EXIT_SUCCESS;
}
