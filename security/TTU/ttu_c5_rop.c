/*  Benchmark: Return-Oriented Programming (ROP) Attack
 *  @author  : Mert Side for TTU
 *  @brief   : For a more sophisticated control flow attack that tests both the 
 *             robustness of security mechanisms and the integrity of execution 
 *             flow, we implement a Return-Oriented Programming (ROP) attack. 
 *             This type of attack is a more advanced form of exploitation that 
 *             involves executing code snippets already present in a program's 
 *             memory, called "gadgets", without injecting any code.
 * 
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Prototype for functions/gadgets we are going to use as part of our payload
void gadget1() { printf("Gadget 1 executed\n"); }
void gadget2() { printf("Gadget 2 executed\n"); }
void final_function() { printf("Final function executed - payload complete\n"); }

void vulnerable_function() {
    char buffer[64];
    void (*return_address)() = NULL;

    // Simulate reading data into the buffer, overflowing it to overwrite the return address
    printf("Simulating buffer overflow to change the return address...\n");
    char *data = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABBBB";
    memcpy(buffer, data, strlen(data));

    // Overwrite the return address to point to our first gadget
    // In an actual attack scenario, this would require precise control over input to point
    // return_address to the address of gadget1 in memory
    return_address = gadget1;

    // For demonstration, we manually set it to show how control could be transferred
    return_address();
    gadget2();  // This would be the next gadget in a real ROP chain
    final_function();  // This would typically be the final payload or exit routine
}

int main() {
    vulnerable_function();
    return 0;
}

