#include <stdio.h>
#include <stdlib.h>
#include "xbrtime_morello.h"
#include "tpool.h"
#include <sys/time.h>

#define TABLE_SIZE (1 << 23)  // Example: 8M elements
#define NUM_UPDATES (1 << 25) // Example: 32M updates

typedef struct {
    long long *table;
    long long remote_index;
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
    long long remote_value = 0;

    xbrtime_longlong_get(&remote_value, &work->table[work->remote_index], 1, 0, work->target_pe);
    remote_value ^= work->remote_index;
    xbrtime_longlong_put(&work->table[work->remote_index], &remote_value, 1, 0, work->target_pe);

    free(work);
}

int main(int argc, char *argv[]) {
    xbrtime_init();
    int me = xbrtime_mype();
    int npes = xbrtime_num_pes();

    // Allocate shared memory
    long long *table = (long long *) xbrtime_malloc(TABLE_SIZE * sizeof(long long));
    if (!table) {
        fprintf(stderr, "PE %d: Failed to allocate memory\n", me);
        xbrtime_close();
        return EXIT_FAILURE;
    }

    // Initialize table with PE ID
    for (size_t i = 0; i < TABLE_SIZE; i++) {
        table[i] = me;
    }
    xbrtime_barrier_all();

    // Create thread pool
    threadpool_t *pool = tpool_create(4);
    if (!pool) {
        fprintf(stderr, "PE %d: Failed to create thread pool\n", me);
        xbrtime_free(table);
        xbrtime_close();
        return EXIT_FAILURE;
    }

    // Start benchmark
    double start_time = RTSEC();

    // Perform updates
    for (size_t i = 0; i < NUM_UPDATES / npes; i++) {
        long long index = rand() % TABLE_SIZE;
        int target_pe = index % npes;
        long long remote_index = index / npes;

        work_t *work = malloc(sizeof(work_t));
        if (!work) {
            fprintf(stderr, "PE %d: Memory allocation failed!\n", me);
            continue;
        }

        work->table = table;
        work->remote_index = remote_index;
        work->target_pe = target_pe;

        tpool_add_work(pool, update_remote_value, work);
    }

    // Ensure all tasks are completed
    tpool_wait(pool);
    xbrtime_barrier_all();

    double end_time = RTSEC();
    double elapsed_time = end_time - start_time;
    double updates_per_second = (double)NUM_UPDATES / elapsed_time;
    double gups = updates_per_second / 1e9;

    if (me == 0) {
        printf("GUPS: %lf\n", gups);
    }

    // Cleanup
    tpool_destroy(pool);
    xbrtime_free(table);
    xbrtime_close();
    return EXIT_SUCCESS;
}