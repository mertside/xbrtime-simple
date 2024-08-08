/*  Benchmark: Control Flow Attack Using Function Pointer
 *  @author  : Mert Side for TTU
 *  @brief   : A control flow attack typically involves manipulating the 
 *             execution path of a program to execute unintended or malicious 
 *             code. This type of attack exploits vulnerabilities related to how 
 *             control flow data (like function pointers or return addresses) is 
 *             handled in memory
 * 
 * Explanation of the Code
 * - Data Structure Setup:
 *    The DataStructure struct includes a character buffer and a function 
 *    pointer. This setup closely resembles real-world applications where 
 *    buffers and function pointers may coexist in structures, making it 
 *    relevant for educational purposes.
 * - Function Pointers:
 *    Two functions, benign_function and malicious_function, are defined to 
 *    represent normal and malicious behavior, respectively.
 * - Vulnerability Simulation:
 *    The simulate_vulnerability function sets up a scenario where a buffer 
 *    overflow can overwrite the adjacent function pointer. The user's input via 
 *    gets() can overflow the buffer, potentially altering the function pointer
 *    if enough data is entered.
 * - Security Implications:
 *    If an attacker inputs a crafted payload that overflows the buffer and 
 *    modifies the function pointer to point to malicious_function, the program 
 *    will execute the malicious function, demonstrating a control flow hijack.
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Function declarations for the benign and malicious functions
void benign_function() {
    printf("This is a benign function.\n");
}

void malicious_function() {
    printf("Control flow hijacked! This is a malicious function.\n");
}

// Function simulating a vulnerable scenario
void vulnerable_function() {
    char buffer[64];
    void (*func_ptr)() = benign_function;  // Function pointer initialized to point to a benign function

    printf("Enter some text: ");
    fgets(buffer, sizeof(buffer), stdin);  // Safer input function but still used unsafely

    // Example of manual overwrite for demonstration:
    // Calculate the distance from the start of the buffer to the location of the function pointer
    intptr_t distance = (char *)&func_ptr - buffer;
    printf("Distance to function pointer: %ld bytes\n", distance);

    // Check if the calculated distance is within the bounds of the buffer
    if (distance >= 0 && distance < sizeof(buffer)) {
        // Place the address of malicious_function into the calculated correct location
        *(void **)(buffer + distance) = malicious_function;
    }

    func_ptr();  // Call function via function pointer
}

int main() {
    printf("Starting the control flow attack simulation.\n");
    vulnerable_function();
    printf("Exiting the program.\n");
    return EXIT_SUCCESS;
}

