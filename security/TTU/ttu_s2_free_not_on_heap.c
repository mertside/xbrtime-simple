/*
 * Based on Free of Buffer not on Heap by STAM
 * Adapted by Mert Side for Texas Tech University
 *
 * Key Notes:
 * 
 * This code involves creating a scenario where multiple threads attempt to free
 *  a statically allocated string (which should not be freed because it was not
 *  dynamically allocated).
 * 
 */

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <pthread.h>
#include "xbrtime_morello.h"

char *shared_string = "Hello World!";

// Function to be executed by threads
void *free_string(void *arg) {
    (void)arg; // Argument not used

    printf("PE %d attempting to free string not on heap\n", xbrtime_mype());
    free(shared_string);

    // Attempting to access string after erroneous free attempt
    printf("PE %d printing characters of string after free attempt:\n", xbrtime_mype());
    for(int i = 0; i < 12; i++) {
        printf("%c", shared_string[i]);
    }
    printf("%c", '\n');

    return NULL;
}

int main() {
    xbrtime_init();

    int num_pes = xbrtime_num_pes();
    pthread_t threads[num_pes];

    printf("Starting test: Free not on Heap\n");
    printf("Printing characters of string before free:\n");
    for(int i = 0; i < 12; i++) {
        printf("%c", shared_string[i]);
    }
    printf("\n");

    // Creating threads to simulate the vulnerability across PEs
    for (int i = 0; i < num_pes; i++) {
        if(pthread_create(&threads[i], NULL, free_string, NULL) != 0) {
            fprintf(stderr, "Error creating thread\n");
            return 1;
        }
    }

    // Joining threads
    for (int i = 0; i < num_pes; i++) {
        if(pthread_join(threads[i], NULL) != 0) {
            fprintf(stderr, "Error joining thread\n");
            return 1;
        }
    }

    printf("Test Complete: Free not on Heap\n\n");
    xbrtime_close();

    return 0;
}
