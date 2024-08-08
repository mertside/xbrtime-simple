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

// Function declarations
void benign_function();
void malicious_function();

// Structure to simulate more complex data structures and control flow
typedef struct {
    char buffer[64];
    void (*func_ptr)();
} DataStructure;

// Benign function
void benign_function() {
    printf("This is a benign function.\n");
}

// Malicious function
void malicious_function() {
    printf("Control flow hijacked! This is a malicious function.\n");
}

// Function simulating a vulnerable scenario
void simulate_vulnerability() {
    DataStructure ds;
    ds.func_ptr = benign_function;  // Initialize function pointer to benign function

    printf("Enter some text (be careful, it's not safe!): ");
    gets(ds.buffer);  // Vulnerable function that can lead to buffer overflow

    // Call function via function pointer
    ds.func_ptr();
}

int main() {
    printf("Starting the control flow attack simulation.\n");
    simulate_vulnerability();
    printf("Exiting the program.\n");
    return EXIT_SUCCESS;
}
