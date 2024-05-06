/*
 * Based on Null Pointer Dereference not on Heap by STAM
 * Adapted by Mert Side for Texas Tech University
 * 
 */

int main() {

  printf("Starting test: Null pointer dereference\n");

  char *complete = "Hello World!";
  char *bad_ptr;

  bad_ptr = complete;

  printf("Printing hex characters of known string:\n");
  for(int i=0;i<12;i++) {
          printf("%x", bad_ptr[i]);
  }
  printf("%c", '\n');

  bad_ptr = NULL;

  printf("Printing hex characters of NULL string:\n");
  for(int i=0;i<12;i++) {
         printf("%x", bad_ptr[i]); 
  }

  printf("%c", '\n');

  printf("Test Failed: Null pointer dereference\n\n");

  return 0;
}
