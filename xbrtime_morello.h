/*
 * _XBRTIME_H_
 *
 * Copyright (C) 2017-2018 Tactical Computing Laboratories, LLC
 * All Rights Reserved
 * contact@tactcomplabs.com
 *
 * This file is a part of the XBGAS-RUNTIME package.  For license
 * information, see the LICENSE file in the top level directory
 * of the distribution.
 *
 */

/*!   \file xbrtime.h
      \brief XBGAS Runtime Top-Level Header File

      The XBGAS Runtime provides C/CXX level function interfaces
      for applications to conveniently utilize the shared memory
      capabilities present in the xBGAS extension to the RISC-V
      specification
*/

#ifndef _XBRTIME_H_
#define _XBRTIME_H_

#ifdef __cplusplus
extern "C" {
#endif

// #define XBGAS_DEBUG 1
// #define XBGAS_PRINT 1
#define EXPERIMENTAL_A 1
#define EXPERIMENTAL_B 1

#include <math.h>
#include <pthread.h> // From xbgas-runtime-thread
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h> // From xbgas-runtime-thread

/* ---------------------------------------- REQUIRED HEADERS */
#include "xbMrtime-types.h"
// #include "xbMrtime-api.h"
#include "xbMrtime-alloc.h"
// #include "xbrtime-version.h"
#include "xbMrtime-macros.h"
// #include "xbrtime-collectives.h"
// #include "xbrtime-atomics.h"
#include "threadpool.h" // From xbgas-runtime-thread
#include <cheri.h>
// #include <cheriintrin.h>

#define INIT_ADDR 0xBB00000000000000ull
#define END_ADDR 0xAA00000000000000ull

#define MAX_NUM_OF_THREADS 16 // From xbgas-runtime-thread

volatile uint64_t *xb_barrier;
volatile tpool_thread_t *threads;

#ifdef EXPERIMENTAL_B
pthread_mutex_t barrier_mutex = PTHREAD_MUTEX_INITIALIZER;
pthread_cond_t barrier_cond = PTHREAD_COND_INITIALIZER;
int counter = 0; // To keep track of threads that have reached the barrier
#endif

pthread_mutex_t update_mutex = PTHREAD_MUTEX_INITIALIZER;
pthread_cond_t  update_cond  = PTHREAD_COND_INITIALIZER;

/* ------------------------------------------------------------- CONSTRUCTOR */
__attribute__((constructor)) void __xbrtime_ctor() {
#ifdef XBGAS_PRINT
  printf("[R] Entered __xbrtime_ctor()\n");
#endif

  xb_barrier = malloc(sizeof(uint64_t) * 2 * 10);

  //  ...   ...   ...   ...   ...   ...   ...   ...   ...   ...   numOfThreads
  int i = 0;
  int numOfThreads = MAX_NUM_OF_THREADS;

  // Get number of threads from the environment
  char *str = getenv("NUM_OF_THREADS");
  // Is the environment variable set appropriately?
  if (str == NULL || atoi(str) <= 0 || atoi(str) > MAX_NUM_OF_THREADS) {
    if (str == NULL) {
      // NOT found!
      fprintf(stderr, "\n[E][R] NUM_OF_THREADS not set; set environment!!!\n");
      fprintf(stderr, "\ne.g.:\texport NUM_OF_THREADS=4\n");
    } else {
      // NOT a reasonable number!
      fprintf(stderr, "\n[E][R] NUM_OF_THREADS should be between %d and %d\n",
              1, MAX_NUM_OF_THREADS);
    }
    // Set MAX number of threads as an environment variable
    const char *envName = "NUM_OF_THREADS";
    char envValue[10] = "";
    sprintf(envValue, "%d", numOfThreads);
    setenv(envName, envValue, 1);
  }
  numOfThreads = atoi(getenv("NUM_OF_THREADS"));

#if XBGAS_DEBUG
  fprintf(stdout, "[R] Number of threads: %d\n", numOfThreads);
  fflush(stdout);
#endif

  // ...   ...   ...   ...   ...   ...   ...   ...   ...   ...   ...   ...

  // Create a thread pool
  threads = tpool_create(numOfThreads);

  // printf("CTOR: Init\n");
}

/* -------------------------------------------------------------- DESTRUCTOR */
__attribute__((destructor)) void __xbrtime_dtor() {
#ifdef XBGAS_PRINT
  printf("[R] Entered __xbrtime_dtor()\n");
#endif

  // First, ensure that the thread pool finishes its work and is then destroyed.
  int numOfThreads = atoi(getenv("NUM_OF_THREADS"));
  for (int i = 0; i < numOfThreads; i++) {
    // Wait for each thread to finish its work
    tpool_wait(threads[i].thread_queue);
    // Destroy the thread pool
    // tpool_destroy(threads[i].thread_queue);
  }
  // Free the memory associated with the threads
  tpool_thread_free(threads);

  // ...   ...   ...   ...   ...   ...   ...   ...   ...   ...   ...   ...
  /* free_barrier */
  uint64_t end = 0;
  // *((uint64_t *)END_ADDR) = end;
  // printf("DTOR: Free\n");

  // Cleanup the allocated memory for `xb_barrier`
  free((void *)xb_barrier);

#if XBGAS_DEBUG
  fprintf(stdout, "[R] Destructor completed.\n");
  fflush(stdout);
#endif
}

/* ---------------------------------------- FUNCTION PROTOTYPES */

/*!   \fn int xbrtime_init()
      \brief Initializes the XBGAS Runtime environment
      \return 0 on success, nonzero otherwise
*/
int xbrtime_init();

/*!   \fn void xbrtime_close()
      \brief Closes the XBGAS Runtime environment
      \return void
*/
void xbrtime_close();

/*!   \fn int xbrtime_addr_accessible( const void *addr, int pe )
      \brief Checks to see whether the address on the target pe can be reached
      \param addr is a pointer to a valid address
      \param pe is the target processing element
      \return 1 on success, 0 otherwise
*/
extern int xbrtime_addr_accessible(const void *addr, int pe);

/*!   \fn void *xbrtime_malloc( size_t sz )
      \brief Allocates a block of contiguous shared memory of minimum size, 'sz'
      \param sz is the minimum size of the allocated block
      \return Valid pointer on success, NULL otherwise
*/
extern void *xbrtime_malloc(size_t sz);

/*!   \fn void xbrtime_free( void *ptr )
      \brief Free's a target memory block starting at ptr
      \param *ptr is a valid base pointer to an allocated block
      \return Void
*/
extern void xbrtime_free(void *ptr);

/*!   \fn int xbrtime_mype()
      \brief Returns the logical PE number of the calling entity
      \return Logical PE on success, nonzero otherwise
*/
extern int xbrtime_mype();

/*!   \fn int xbrtime_num_pes()
      \brief Returns the total number of configured PEs
      \return Total PEs on success, nonzero otherwise
*/
extern int xbrtime_num_pes();

/*!   \fn void xbrtime_barrier()
      \brief Performs a global barrier operation of all configured PEs
      \return Void
*/
extern void xbrtime_barrier();

/* ------------------------------------------------------------------------- */
/* ========================================================================= */
/* ------------------------------------------------------------------------- */
/* ========================================================================= */

/* _XBRTIME_INIT_C_ */

// extern volatile  uint64_t* barrier;
// #define INIT_ADDR 0xBB00000000000000ull // MERT – MOVED UP

/* ------------------------------------------------- GLOBALS */
XBRTIME_DATA *__XBRTIME_CONFIG;

/* ------------------------------------------------- FUNCTION PROTOTYPES */
size_t __xbrtime_asm_get_memsize();
int __xbrtime_asm_get_id();
int __xbrtime_asm_get_npes();
uint64_t __xbrtime_asm_get_startaddr();
void __xbrtime_asm_fence();

extern void xbrtime_close() {
#ifdef XBGAS_PRINT
  printf("[R] Entered xbrtime_close()\n");
#endif
  int i = 0;

  /* initiate a barrier */
  xbrtime_barrier();
  pthread_cond_destroy(&barrier_cond);

  if (__XBRTIME_CONFIG != NULL) {
    /* hard fence */
    __xbrtime_asm_fence();

    /* free all the remaining shared blocks */
    for (i = 0; i < _XBRTIME_MEM_SLOTS_; i++) {
      if (__XBRTIME_CONFIG->_MMAP[i].size != 0) {
        xbrtime_free((void *)(__XBRTIME_CONFIG->_MMAP[i].start_addr));
      }
    }

    if (__XBRTIME_CONFIG->_MAP != NULL) {
      free(__XBRTIME_CONFIG->_MAP);
      __XBRTIME_CONFIG->_MAP = NULL;
    }

    free(__XBRTIME_CONFIG);
  }
}

#ifdef EXPERIMENTAL_A
extern int xbrtime_init() {
  // Check if the XBGAS_PRINT flag is set to display debug info
#ifdef XBGAS_PRINT
  printf("[R] Entered xbrtime_init()\n");
#endif

  // Ensure that the global configuration isn't already initialized
  if (__XBRTIME_CONFIG) {
    fprintf(stderr, "Error: __XBRTIME_CONFIG is already initialized.\n");
    return -1;
  }

  // Allocate memory for the global configuration
  __XBRTIME_CONFIG = malloc(sizeof(XBRTIME_DATA));
  // Check if the memory allocation for the global config was successful
  if (!__XBRTIME_CONFIG) {
    fprintf(stderr, "Error: Failed to allocate memory for __XBRTIME_CONFIG.\n");
    return -1;
  }

  // Allocate memory for the memory map in the configuration
  __XBRTIME_CONFIG->_MMAP = malloc(sizeof(XBRTIME_MEM_T) * _XBRTIME_MEM_SLOTS_);
  // Check if the memory allocation for the memory map was successful
  if (!__XBRTIME_CONFIG->_MMAP) {
    fprintf(stderr, "Error: Failed to allocate memory for _MMAP.\n");
    free(__XBRTIME_CONFIG);
    // Free the previously allocated memory for the global config
    return -1;
  }

  // Assign values to the global configuration
  __XBRTIME_CONFIG->_ID = threads[0].thread_id; // Assign the thread ID
  __XBRTIME_CONFIG->_MEMSIZE = 4096 * 4096;     // Define the memory size
  __XBRTIME_CONFIG->_NPES = atoi(getenv("NUM_OF_THREADS"));
  // Get the number of threads from environment variable
  __XBRTIME_CONFIG->_START_ADDR = 0x00ull; // Initialize start address
  __XBRTIME_CONFIG->_SENSE = 0x00ull;      // Initialize sense
  __XBRTIME_CONFIG->_BARRIER = xb_barrier; // Set the barrier

  // Initialize barrier values
  for (int i = 0; i < 10; i++) {
    __XBRTIME_CONFIG->_BARRIER[i] = 0xfffffffffull;
    __XBRTIME_CONFIG->_BARRIER[10 + i] = 0xaaaaaaaaaull;
  }

  // If the XBGAS_DEBUG flag is set, display barrier values
#ifdef XBGAS_DEBUG
  printf("[XBGAS_DEBUG] PE:%d----BARRIER[0] = 0x%lx\n", __XBRTIME_CONFIG->_ID,
         __XBRTIME_CONFIG->_BARRIER[0]);
  printf("[XBGAS_DEBUG] PE:%d----BARRIER[1] = 0x%lx\n", __XBRTIME_CONFIG->_ID,
         __XBRTIME_CONFIG->_BARRIER[1]);
#endif

  // Ensure that the number of threads does not exceed the maximum allowed value
  if (__XBRTIME_CONFIG->_NPES > __XBRTIME_MAX_PE) {
    fprintf(stderr, "Error: Too many total PEs.\n");
    free(__XBRTIME_CONFIG->_MMAP); // Free memory map
    free(__XBRTIME_CONFIG);        // Free global config
    return -1;
  }

  // Allocate memory for the PE mapping block
  __XBRTIME_CONFIG->_MAP =
      malloc(sizeof(XBRTIME_PE_MAP) * __XBRTIME_CONFIG->_NPES);
  // Check if memory allocation for the PE mapping block was successful
  if (!__XBRTIME_CONFIG->_MAP) {
    fprintf(stderr, "Error: Failed to allocate memory for _MAP.\n");
    free(__XBRTIME_CONFIG->_MMAP); // Free memory map
    free(__XBRTIME_CONFIG);        // Free global config
    return -1;
  }

#ifdef XBGAS_PRINT
  printf("[R] init the pe mapping block\n");
#endif

  // Initialize the memory allocation slots to default values
  for (int i = 0; i < _XBRTIME_MEM_SLOTS_; i++) {
    __XBRTIME_CONFIG->_MMAP[i].start_addr = 0x00ull; // Default start address
    __XBRTIME_CONFIG->_MMAP[i].size = 0;             // Default size
  }

#ifdef XBGAS_PRINT
  printf("[R] init the memory allocation slots\n");
#endif

  // Initialize the PE mapping structure with logical and physical values
  for (int i = 0; i < __XBRTIME_CONFIG->_NPES; i++) {
    __XBRTIME_CONFIG->_MAP[i]._LOGICAL = i;      // Set logical value
    __XBRTIME_CONFIG->_MAP[i]._PHYSICAL = i + 1; // Set physical value
  }

#ifdef XBGAS_PRINT
  printf("[R] init the PE mapping structure\n");
#endif

  pthread_cond_init(&barrier_cond, NULL);

  return 0; // Return 0 to indicate successful initialization
}

#else
extern int xbrtime_init() {
#ifdef XBGAS_PRINT
  printf("[R] Entered xbrtime_init()\n");
#endif
  /* vars */
  int i = 0;

  /* allocate the structure in the local heap */
  __XBRTIME_CONFIG = NULL;
  __XBRTIME_CONFIG = malloc(sizeof(XBRTIME_DATA));
  if (__XBRTIME_CONFIG == NULL) {
    return -1;
  }

  // Getting thread id:
  // args *thread_args = (args*)(arg);
  // uint64_t my_id = thread_args->thread_id;

  __XBRTIME_CONFIG->_MMAP = malloc(sizeof(XBRTIME_MEM_T) * _XBRTIME_MEM_SLOTS_);
  __XBRTIME_CONFIG->_ID = threads[0].thread_id;
  // (uint64_t) pthread_self();
  // __xbrtime_asm_get_id();
  __XBRTIME_CONFIG->_MEMSIZE = 4096 * 4096;
  // __xbrtime_asm_get_memsize();
  __XBRTIME_CONFIG->_NPES = atoi(getenv("NUM_OF_THREADS"));
  //__xbrtime_asm_get_npes();
  __XBRTIME_CONFIG->_START_ADDR = 0x00ull;
  // __xbrtime_asm_get_startaddr();
  __XBRTIME_CONFIG->_SENSE = 0x00ull;
  // __xbrtime_asm_get_sense();
  __XBRTIME_CONFIG->_BARRIER = xb_barrier;
  // malloc(sizeof(uint64_t)*2*10);

  // MAX_PE_NUM = 1024, thus, MAX_Barrier buffer space = log2^1024 = 10
  for (i = 0; i < 10; i++) {
    __XBRTIME_CONFIG->_BARRIER[i] = 0xfffffffffull;
    __XBRTIME_CONFIG->_BARRIER[10 + i] = 0xaaaaaaaaaull;
  }

#ifdef XBGAS_DEBUG
  printf("[XBGAS_DEBUG] PE:%d----BARRIER[O] = 0x%lx\n", __XBRTIME_CONFIG->_ID,
         __XBRTIME_CONFIG->_BARRIER[0]);
  printf("[XBGAS_DEBUG] PE:%d----BARRIER[1] = 0x%lx\n", __XBRTIME_CONFIG->_ID,
         __XBRTIME_CONFIG->_BARRIER[1]);
#endif

  /* too many total PEs */
  if (__XBRTIME_CONFIG->_NPES > __XBRTIME_MAX_PE) {
    free(__XBRTIME_CONFIG);
    return -1;
  }

  /* init the pe mapping block */
  __XBRTIME_CONFIG->_MAP =
      malloc(sizeof(XBRTIME_PE_MAP) * __XBRTIME_CONFIG->_NPES);
  if (__XBRTIME_CONFIG->_MAP == NULL) {
    free(__XBRTIME_CONFIG);
    return -1;
  }
#ifdef XBGAS_PRINT
  printf("[R] init the pe mapping block\n");
#endif

  /* init the memory allocation slots */
  for (i = 0; i < _XBRTIME_MEM_SLOTS_; i++) {
    __XBRTIME_CONFIG->_MMAP[i].start_addr = 0x00ull;
    __XBRTIME_CONFIG->_MMAP[i].size = 0;
  }

#ifdef XBGAS_PRINT
  printf("[R] init the memory allocation slots\n");
#endif

  /* init the PE mapping structure */
  for (i = 0; i < __XBRTIME_CONFIG->_NPES; i++) {
    __XBRTIME_CONFIG->_MAP[i]._LOGICAL = i;
    __XBRTIME_CONFIG->_MAP[i]._PHYSICAL = i + 1;
  }

#ifdef XBGAS_PRINT
  printf("[R] init the PE mapping structure\n");
#endif

  // int init = 1;                    // MERT - COMMENTED OUT
  // *((uint64_t *)INIT_ADDR) = init; // MERT - COMMENTED OUT
  return 0;
}
#endif

// extern void xbrtime_free( void *ptr ){
//   if( ptr == NULL ){
//     return ;
//   } else {
//     free(ptr);
//     return ;
//   }

//   // if( ptr == NULL ){
//   //   return ;
//   // }else if( __XBRTIME_CONFIG == NULL ){
//   //   return ;
//   // }else if( __XBRTIME_CONFIG->_MMAP == NULL ){
//   //   return ;
//   // }
//   // __xbrtime_shared_free(ptr);
//   // __xbrtime_asm_quiet_fence();
// }

extern int xbrtime_mype() {
  if (__XBRTIME_CONFIG == NULL) {
    return -1;
  }
  return __XBRTIME_CONFIG->_ID;
}

extern int xbrtime_num_pes() {
  if (__XBRTIME_CONFIG == NULL) {
    return -1;
  }
  return __XBRTIME_CONFIG->_NPES;
}

/* ------------------------------------------------------------------------- */
/* ========================================================================= */
/* ------------------------------------------------------------------------- */
/* ========================================================================= */

/* _XBRTIME_API_C_ */

/* ------------------------------------------------- FUNCTION PROTOTYPES */
void __xbrtime_asm_fence();
void __xbrtime_asm_quiet_fence();

// ------------------------------------------------------- FUNCTION PROTOTYPES
void __xbrtime_get_u8_seq(uint64_t *base_src,
                          uint64_t *base_dest, // uint32_t pe,
                          uint32_t nelems, uint32_t stride);

// ----------------------------------------------------------- U8 GET FUNCTION
void xbrtime_ulonglong_get(unsigned long long *dest,
                           const unsigned long long *src, size_t nelems,
                           int stride, int pe) {
#ifdef XBGAS_PRINT
  // printf("[R] Entered xbrtime_ulonglong_get()\n");
  fflush(stdout);
  fprintf(stdout, "[R] Thread: \t%lu\n", (uint64_t)pthread_self());
  fprintf(stdout, "==================================xbrtime_ulonglong_get\n");
  fprintf(stdout,
          "DST:"
          // "address: %p\n"
          "\tbase  : %10lu"
          "\tlength: %10lu\n"
          "\toffset: %10lu"
          "\tperms : %10u"
          "\ttag   : %1d\n",
          // cheri_address_get(dest),
          cheri_base_get((void *)dest), cheri_length_get((void *)dest),
          cheri_offset_get((void *)dest), cheri_perms_get((void *)dest),
          (int)cheri_tag_get((void *)dest));
  fprintf(stdout, "=======================================================\n");
  fprintf(stdout,
          "SRC:"
          // "address: %p\n"
          "\tbase  : %10lu"
          "\tlength: %10lu\n"
          "\toffset: %10lu"
          "\tperms : %10u"
          "\ttag   : %1d\n",
          // cheri_address_get(dest),
          cheri_base_get((void *)src), cheri_length_get((void *)src),
          cheri_offset_get((void *)src), cheri_perms_get((void *)src),
          (int)cheri_tag_get((void *)src));
  fprintf(stdout, "=======================================================\n");
  fflush(stdout);
#endif

  if (nelems == 0) {
    return;
  } else /*if( (stride != 1) || (nelems == 1))*/ {
    /* sequential execution */
    // void* func_args = { (void*)src, (void*)dest, (void*)nelems,
    //                     (void*)(stride*sizeof(unsigned long long)) };
    //                   { (uint64_t*)src, (uint64_t*)(dest),
    //                   (uint32_t)(nelems),
    //                     (uint32_t)(stride*sizeof(unsigned long long)) };
    //  XXX: multiple arguments do not pass to work!
    // tpool_add_work(pool, __xbrtime_get_u8_seq, func_args);

    __xbrtime_get_u8_seq((uint64_t *)src, //__xbrtime_ltor((uint64_t)(src),pe),
                         (uint64_t *)(dest),
                         // xbrtime_decode_pe(pe),
                         (uint32_t)(nelems),
                         (uint32_t)(stride * sizeof(unsigned long long)));
  }
  __xbrtime_asm_fence();

#ifdef XBGAS_PRINT
  // printf("[M] Exiting \n");
#endif
}

// ------------------------------------------------------- FUNCTION PROTOTYPES
void __xbrtime_get_s8_seq(int64_t *base_src,
                          int64_t *base_dest, // uint32_t pe,
                          int32_t nelems, int32_t stride);

// ----------------------------------------------------------- S8 GET FUNCTION
void xbrtime_longlong_get(long long *dest, const long long *src, size_t nelems,
                          int stride, int pe) {
#ifdef XBGAS_PRINT
  // printf("[R] Entered xbrtime_ulonglong_get()\n");
  fflush(stdout);
  fprintf(stdout, "[R] Thread: \t%lu\n", (uint64_t)pthread_self());
  fprintf(stdout, "GET================================xbrtime_longlong_get\n");
  fprintf(stdout,
          "DST:"
          // "address: %p\n"
          "\tbase  : %10lu"
          "\tlength: %10lu\n"
          "\toffset: %10lu"
          "\tperms : %10u"
          "\ttag   : %1d\n",
          // cheri_address_get(dest),
          cheri_base_get((void *)dest), cheri_length_get((void *)dest),
          cheri_offset_get((void *)dest), cheri_perms_get((void *)dest),
          (int)cheri_tag_get((void *)dest));
  fprintf(stdout, "=======================================================\n");
  fprintf(stdout,
          "SRC:"
          // "address: %p\n"
          "\tbase  : %10lu"
          "\tlength: %10lu\n"
          "\toffset: %10lu"
          "\tperms : %10u"
          "\ttag   : %1d\n",
          // cheri_address_get(dest),
          cheri_base_get((void *)src), cheri_length_get((void *)src),
          cheri_offset_get((void *)src), cheri_perms_get((void *)src),
          (int)cheri_tag_get((void *)src));
  fprintf(stdout, "=======================================================\n");
  fflush(stdout);
#endif

  if (nelems == 0) {
    return;
  } else /* if( (stride != 1) || (nelems == 1))*/ {
    /* sequential execution */
    __xbrtime_get_s8_seq(
        (uint64_t *)(src), //__xbrtime_ltor((uint64_t)(src),pe),
        (uint64_t *)(dest),
        // xbrtime_decode_pe(pe),
        (uint32_t)(nelems), (uint32_t)(stride * sizeof(long long)));
  }
  __xbrtime_asm_fence();
}

// ------------------------------------------------------- FUNCTION PROTOTYPES
void __xbrtime_put_s8_seq(int64_t *base_src,
                          int64_t *base_dest, // uint32_t pe,
                          int32_t nelems, int32_t stride);

// ----------------------------------------------------------- S8 PUT FUNCTION
void xbrtime_longlong_put(long long *dest, const long long *src, size_t nelems,
                          int stride, int pe) {
#ifdef XBGAS_PRINT
  // printf("[R] Entered xbrtime_ulonglong_get()\n");
  fflush(stdout);
  fprintf(stdout, "[R] Thread: \t%lu\n", (uint64_t)pthread_self());
  fprintf(stdout, "===================================xbrtime_longlong_put\n");
  fprintf(stdout,
          "DST:"
          // "address: %p\n"
          "\tbase  : %10lu"
          "\tlength: %10lu\n"
          "\toffset: %10lu"
          "\tperms : %10u"
          "\ttag   : %1d\n",
          // cheri_address_get(dest),
          cheri_base_get((void *)dest), cheri_length_get((void *)dest),
          cheri_offset_get((void *)dest), cheri_perms_get((void *)dest),
          (int)cheri_tag_get((void *)dest));
  fprintf(stdout, "=======================================================\n");
  fprintf(stdout,
          "SRC:"
          // "address: %p\n"
          "\tbase  : %10lu"
          "\tlength: %10lu\n"
          "\toffset: %10lu"
          "\tperms : %10u"
          "\ttag   : %1d\n",
          // cheri_address_get(dest),
          cheri_base_get((void *)src), cheri_length_get((void *)src),
          cheri_offset_get((void *)src), cheri_perms_get((void *)src),
          (int)cheri_tag_get((void *)src));
  fprintf(stdout, "=======================================================\n");
  fflush(stdout);
#endif

  if (nelems == 0) {
    return;
  } else /* if( (stride != 1) || (nelems == 1))*/ {
    /* sequential execution */
    __xbrtime_put_s8_seq(
        (int64_t *)(src),
        (int64_t *)(dest), //__xbrtime_ltor((uint64_t)(dest),pe),
        // xbrtime_decode_pe(pe),
        (int32_t)(nelems), (int32_t)(stride * sizeof(long long)));
  }
  __xbrtime_asm_fence();
}

void xbrtime_reduce_sum_broadcast(long long *dest, long long *src, 
                                  size_t nelems, int stride, int root) {
  int updates_received = 0; 
  // to track number of threads that have sent their updates
  for (int thread_id = 0; thread_id < __XBRTIME_CONFIG->_NPES; thread_id++) {
    pthread_mutex_lock(&update_mutex);
    dest[0] += src[thread_id];
    updates_received++;
    if (thread_id == 0) {
      // If master thread, wait until updates from all threads are received
      while (updates_received < __XBRTIME_CONFIG->_NPES) {
        pthread_cond_wait(&update_cond, &update_mutex);
      }   
      // Now, broadcast dest to other threads
      for (int i = 0; i < __XBRTIME_CONFIG->_NPES; i++) {
        dest[i] = dest[0];  
        // Broadcast by simply copying to shared array (as an example)
      }
    } else {
      // If not the master thread, notify the master thread about the update
      pthread_cond_signal(&update_cond);
    }
    pthread_mutex_unlock(&update_mutex);
  }
}

void xbrtime_reduce_sum_broadcast_all(long long *dest, long long *src, 
                                      size_t nelems, int stride, int root) {
  void *func_args = { dest, src, nelems, stride, root };
  for (int currentPE = 0; currentPE < __XBRTIME_CONFIG->_NPES; currentPE++) {
    tpool_add_work(threads[currentPE].thread_queue, 
                   xbrtime_reduce_sum_broadcast, 
                   func_args);
  }
}

#ifdef EXPERIMENTAL_B
void xbrtime_barrier() {
  if (!__XBRTIME_CONFIG) {
    fprintf(stderr, "Error: __XBRTIME_CONFIG is not initialized. Call "
            "xbrtime_init() first.\n");
    return;
  }
  __xbrtime_asm_fence(); // Ensure all preceding instructions are complete

  pthread_mutex_lock(&barrier_mutex);

  counter++; // Increment the counter when a thread reaches the barrier

  // If not all threads have reached the barrier
  if (counter < __XBRTIME_CONFIG->_NPES) {
    // Wait until the last thread signals the conditional variable
    while (__XBRTIME_CONFIG->_BARRIER[__XBRTIME_CONFIG->_ID] !=
          (__XBRTIME_CONFIG->_SENSE == 0x00ull ? 0xfffffffffull : 0x00ull)) {
     pthread_cond_wait(&barrier_cond, &barrier_mutex);
    }
  } else {
    // The current thread is the last one to arrive. So, flip the sense for all 
    // barrier slots, effectively releasing all waiting threads
    uint64_t new_sense =
      (__XBRTIME_CONFIG->_SENSE == 0x00ull) ? 0xfffffffffull : 0x00ull;

    for (int i = 0; i < __XBRTIME_CONFIG->_NPES; i++) {
      __XBRTIME_CONFIG->_BARRIER[i] = new_sense;
    }

    // Also, flip the global sense
    __XBRTIME_CONFIG->_SENSE = new_sense;

    // Reset the counter for the next barrier call
    counter = 0;

    // Signal all waiting threads
    pthread_cond_broadcast(&barrier_cond);
  }
  __xbrtime_asm_fence(); 
  // Ensure all subsequent instructions wait for this barrier

  pthread_mutex_unlock(&barrier_mutex);
}
#else
extern void xbrtime_barrier() {
#ifdef XBGAS_PRINT
  printf("[R] Entered xbrtime_barrier()\n");
#endif

  // TODO: Implement thread-aware barrier

  /* force a heavy fence */
  __xbrtime_asm_fence(); /* wait for all the PEs to reach the barrier */

#ifdef XBGAS_DEBUG
  printf("[XBGAS_DEBUG] PE=%d; BARRIER COMPLETE\n", xbrtime_mype());
#endif
#ifdef XBGAS_PRINT
  printf("[R] Exiting xbrtime_barrier()\n");
#endif
}
#endif

void xbrtime_barrier_all() {
  for (int currentPE = 0; currentPE < __XBRTIME_CONFIG->_NPES; currentPE++) {
    tpool_add_work(threads[currentPE].thread_queue, xbrtime_barrier, NULL);
  }
}

#ifdef __cplusplus
}
#endif /* extern "C" */

#endif /* _XBRTIME_H_ */

/* EOF */
