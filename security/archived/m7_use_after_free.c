/*  Benchmark: Use-After-Free
*/

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int main() {

  printf("Starting Test: Use-After-Free\n");

  char *complete  = malloc(sizeof(char) * 85);	
  strcpy(complete, "Hello World!Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod");


  printf("Printing characters of string before free:\n");
  for(int i=0;i<85;i++) {
          printf("%c", complete[i]);
  }
  printf("%c", '\n');

  free(complete);

  printf("Printing characters of string after free:\n");
  for(int i=0;i<85;i++) {
         printf("%c", complete[i]); 
  }

  printf("%c", '\n');

  printf("Test Failed: Use-After-Free\n\n");


  return 0;
}