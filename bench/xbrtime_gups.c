#include <stdio.h>
#include <stdlib.h>
#include "xbrtime_morello.h"
#include "tpool.h"
#include <sys/time.h>

#define TABLE_SIZE (1 << 24)  // Example: 16M elements
#define NUM_UPDATES (1 << 26) // Example: 64M updates

typedef long long int int64_t;

typedef struct {
  int64_t *table;
  int64_t remote_index;
  int target_pe;
} work_t;

// Timer function
double get_time() {
  struct timeval tv;
  gettimeofday(&tv, NULL);
  return tv.tv_sec + tv.tv_usec * 1e-6;
}

// Worker function for thread pool
void update_remote_value(void *arg) {
  work_t *work = (work_t *)arg;
  int64_t remote_value = xbrtime_longlong_get(&work->table[work->remote_index], work->target_pe);
  remote_value += 1;
  xbrtime_longlong_put(&work->table[work->remote_index], &remote_value, work->target_pe, sizeof(int64_t));
  free(work);
}

int main(int argc, char *argv[]) {
  xbrtime_init();
  int me = xbrtime_mype();
  int npes = xbrtime_num_pes();
  threadpool_t *pool = tpool_create(4); // Create a thread pool with 4 threads

  // Allocate symmetric shared memory table
  int64_t *table = (int64_t *) xbrtime_malloc(TABLE_SIZE * sizeof(int64_t));
  if (!table) {
    fprintf(stderr, "PE %d: Failed to allocate memory\n", me);
    xbrtime_finalize();
    return EXIT_FAILURE;
  }

  // Initialize table with zeros
  for (size_t i = 0; i < TABLE_SIZE; i++) {
    table[i] = 0;
  }
  xbrtime_barrier();

  // Start benchmark
  double start_time = get_time();
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
    
    // Enqueue work into thread pool
    tpool_add_work(pool, update_remote_value, work);
  }
  
  // Wait for all tasks to complete
  tpool_wait(pool);
  xbrtime_barrier();
  double end_time = get_time();

  // Calculate GUPS
  double elapsed_time = end_time - start_time;
  double updates_per_second = (double)NUM_UPDATES / elapsed_time;
  double gups = updates_per_second / 1e9;

  if (me == 0) {
    printf("GUPS: %lf\n", gups);
  }

  // Cleanup
  tpool_destroy(pool);
  xbrtime_free(table);
  xbrtime_finalize();
  return EXIT_SUCCESS;
}
