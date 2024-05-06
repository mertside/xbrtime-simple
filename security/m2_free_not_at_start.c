/*
 * Based on Free Not at Start of Buffer by STAM
 * Adapted by Mert Side for Texas Tech University
 *
 */

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define BUFFER_SIZE 85

int main() {

  printf("Starting Test: Free not at start\n");

  char *complete  = malloc(sizeof(char) * BUFFER_SIZE);	
  strcpy(complete, "Hello World! Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod");


  printf("Printing characters of string before free:\n");
  for(int i=0;i<83;i++) {
          printf("%c", complete[i]);
  }
  printf("\n");

  free(complete+8);

  printf("Printing characters of string after free:\n");
  for(int i=0;i<83;i++) {
         printf("%c", complete[i]); 
  }

  printf("\n");

  printf("Test Failed: Free not at start\n\n");

  return 0;
}