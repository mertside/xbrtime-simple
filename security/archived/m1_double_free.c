/*
 * Based on Double Free by STAM
 * Adapted by Mert Side for Texas Tech University
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define BUFFER_SIZE 85

int main() {

  printf("Starting Test: Double Free\n");
  char* complete  = malloc(sizeof(char) * BUFFER_SIZE);	
  strcpy(complete, "Hello World!Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod");

  printf("Freeing memory(1)\n");
  free(complete);
  
  printf("Freeing memory(2)\n");
  free(complete);

  printf("Test Failed: Double Free\n\n");

  return 0;
}
