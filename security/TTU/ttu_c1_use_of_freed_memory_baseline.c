/*  Benchmark: Use of Freed Memory
 *  @author  : Mert Side for TTU
 *  @brief   : This example is a scenario where memory is freed and potentially 
 *             reused improperly, showing how such a vulnerability can be 
 *             exploited.
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char data[100];
} DataStructure;

void manipulate_data(DataStructure *ds) {
    strcpy(ds->data, "Sensitive data stored here.");
    printf("Initial data: %s\n", ds->data);
}

void exploit_vulnerability() {
    printf("Exploiting use of freed memory...\n");
    // Intentionally leaving this function empty to simulate potential malicious actions.
}

int main() {
    DataStructure *ds = malloc(sizeof(DataStructure));  // Allocate memory
    if (ds == NULL) {
        fprintf(stderr, "Memory allocation failed.\n");
        return EXIT_FAILURE;
    }

    manipulate_data(ds);  // Manipulate data in allocated memory

    free(ds);  // Free memory

    // The memory is freed, and now we accidentally reuse it.
    DataStructure *new_ds = malloc(sizeof(DataStructure));  // Reallocate memory
    if (new_ds == NULL) {
        fprintf(stderr, "Memory allocation failed.\n");
        return EXIT_FAILURE;
    }

    // Check if the newly allocated memory is at the same location as the freed memory
    if (ds == new_ds) {
        printf("Memory reused at the same location.\n");
        exploit_vulnerability();  // Exploit the use of freed memory
    } else {
        printf("Memory was not reused at the same location.\n");
    }

    strcpy(new_ds->data, "New data stored here.");  // Store new data
    printf("New data: %s\n", new_ds->data);

    free(new_ds);  // Free memory again

    return EXIT_SUCCESS;
}
