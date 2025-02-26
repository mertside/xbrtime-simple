#include <stdio.h>
#include <stdlib.h>
#include "xbrtime_morello.h"
#include <sys/time.h>

#define TABLE_SIZE (1 << 24)  // Example: 16M elements
#define NUM_UPDATES (1 << 26) // Example: 64M updates

typedef struct {
    int64_t *table;
    int64_t remote_index;
    int target_pe;
} work_t;

// Timer function
static double RTSEC() {
    struct timeval tp;
    gettimeofday(&tp, NULL);
    return tp.tv_sec + tp.tv_usec / (double)1.0e6;
}

// Worker function for thread pool
void update_remote_value(void *arg) {
    work_t *work = (work_t *)arg;
    int64_t remote_value = 0;

    // Fetch remote value, increment, and write back
    xbrtime_longlong_get(&remote_value, &work->table[work->remote_index], 1, 0, work->target_pe);
    remote_value += 1;
    xbrtime_longlong_put(&work->table[work->remote_index], &remote_value, 1, 0, work->target_pe);
    
    free(work);
}

int main(int argc, char *argv[]) {
    xbrtime_init();
    int me = xbrtime_mype();
    int npes = xbrtime_num_pes();

    // Allocate symmetric shared memory table
    int64_t *table = (int64_t *) xbrtime_malloc(TABLE_SIZE * sizeof(int64_t));
    if (!table) {
        fprintf(stderr, "PE %d: Failed to allocate memory\n", me);
        xbrtime_close();
        return EXIT_FAILURE;
    }

    // Initialize table with zeros
    for (size_t i = 0; i < TABLE_SIZE; i++) {
        table[i] = 0;
    }
    xbrtime_barrier();

    // Start benchmark
    double start_time = RTSEC();

    // Each PE submits tasks to its own thread pool
    for (int currentPE = 0; currentPE < npes; currentPE++) {
        for (size_t i = 0; i < NUM_UPDATES / npes; i++) {
            // Generate a random index in the table
            int64_t index = (rand() % TABLE_SIZE);
            int target_pe = index % npes; // Determine target PE
            int64_t remote_index = index / npes; // Remote offset

            // Create work task
            work_t *work = malloc(sizeof(work_t));
            work->table = table;
            work->remote_index = remote_index;
            work->target_pe = target_pe;
            
            // Enqueue work into the correct PE's thread queue
            tpool_add_work(threads[currentPE].thread_queue, update_remote_value, work);
        }
    }
    
    // Wait for all tasks to complete
    xbrtime_barrier();
    double end_time = RTSEC();

    // Calculate GUPS
    double elapsed_time = end_time - start_time;
    double updates_per_second = (double)NUM_UPDATES / elapsed_time;
    double gups = updates_per_second / 1e9;

    if (me == 0) {
        printf("GUPS: %lf\n", gups);
    }

    // Cleanup
    xbrtime_free(table);
    xbrtime_close();
    return EXIT_SUCCESS;
}