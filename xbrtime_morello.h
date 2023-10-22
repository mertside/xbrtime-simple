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
// #define EXPERIMENTAL_A 1
#define EXPERIMENTAL_B 1

#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include <pthread.h>                            // From xbgas-runtime-thread
#include <unistd.h>                             // From xbgas-runtime-thread

/* ---------------------------------------- REQUIRED HEADERS */
#include "xbMrtime-types.h"
// #include "xbMrtime-api.h"
#include "xbMrtime-alloc.h"
// #include "xbrtime-version.h"
#include "xbMrtime-macros.h"
// #include "xbrtime-collectives.h"
// #include "xbrtime-atomics.h"
#include "threadpool.h"                     // From xbgas-runtime-thread
#include <cheri.h>
//#include <cheriintrin.h>

#define INIT_ADDR 0xBB00000000000000ull 
#define END_ADDR 0xAA00000000000000ull

#define MAX_NUM_OF_THREADS 16                    // From xbgas-runtime-thread

volatile uint64_t *xb_barrier;
volatile tpool_thread_t *threads;

/* ------------------------------------------------------------- CONSTRUCTOR */
__attribute__((constructor)) void __xbrtime_ctor(){
#ifdef XBGAS_PRINT
  printf("[R] Entered __xbrtime_ctor()\n");
#endif

  xb_barrier = malloc(sizeof(uint64_t)*2*10);	

  //  ...   ...   ...   ...   ...   ...   ...   ...   ...   ...   numOfThreads
  int i = 0;
  int numOfThreads = MAX_NUM_OF_THREADS;

  // Get number of threads from the environment
  char *str = getenv("NUM_OF_THREADS");
  // Is the environment variable set appropriately?
  if(str == NULL || atoi(str) <= 0 || atoi(str) > MAX_NUM_OF_THREADS){
    if(str == NULL) {
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
__attribute__((destructor)) void __xbrtime_dtor(){
#ifdef XBGAS_PRINT
  printf("[R] Entered __xbrtime_dtor()\n");
#endif
  
  int i = 0;
  int numOfThreads = MAX_NUM_OF_THREADS;
  numOfThreads = atoi(getenv("NUM_OF_THREADS"));

  // Will return when there is no work
  // tpool_wait((tpool_work_queue_t *) pool);
  for(i = 0; i < numOfThreads; i++){
    tpool_wait(threads[i].thread_queue);
  }

  // Discard pending, clean queue, order stop, wait, destroy
  // tpool_destroy((tpool_work_queue_t *) pool); 
  for(i = 0; i < numOfThreads; i++){
    tpool_destroy(threads[i].thread_queue);
  }

  // ...   ...   ...   ...   ...   ...   ...   ...   ...   ...   ...   ...

  /* free_barrier */
	uint64_t end = 0;
	// *((uint64_t *)END_ADDR) = end;
  free ((void*)xb_barrier); 	
  // printf("DTOR: Free\n");
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
extern int xbrtime_addr_accessible( const void *addr, int pe );

/*!   \fn void *xbrtime_malloc( size_t sz )
      \brief Allocates a block of contiguous shared memory of minimum size, 'sz'
      \param sz is the minimum size of the allocated block
      \return Valid pointer on success, NULL otherwise
*/
extern void *xbrtime_malloc( size_t sz );

/*!   \fn void xbrtime_free( void *ptr )
      \brief Free's a target memory block starting at ptr
      \param *ptr is a valid base pointer to an allocated block
      \return Void
*/
extern void xbrtime_free( void *ptr );

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

extern void xbrtime_close(){
  int i = 0;

  /* initiate a barrier */
  //xbrtime_barrier();

  if( __XBRTIME_CONFIG != NULL ){
    /* hard fence */
    __xbrtime_asm_fence();

    /* free all the remaining shared blocks */
    for( i=0; i<_XBRTIME_MEM_SLOTS_; i++ ){
      if( __XBRTIME_CONFIG->_MMAP[i].size != 0 ){
        xbrtime_free((void *)(__XBRTIME_CONFIG->_MMAP[i].start_addr));
      }
    }

    if( __XBRTIME_CONFIG->_MAP != NULL ){
      free( __XBRTIME_CONFIG->_MAP );
      __XBRTIME_CONFIG->_MAP = NULL;
    }

    free( __XBRTIME_CONFIG );
  }
}

extern int xbrtime_init(){
#ifdef XBGAS_PRINT
  printf("[R] Entered xbrtime_init()\n");
#endif
  /* vars */
  int i = 0;

  /* allocate the structure in the local heap */
  __XBRTIME_CONFIG = NULL;
  __XBRTIME_CONFIG = malloc( sizeof( XBRTIME_DATA ) );
  if( __XBRTIME_CONFIG == NULL ){
    return -1;
  }

  // Getting thread id:
  //args *thread_args = (args*)(arg);
  //uint64_t my_id = thread_args->thread_id;

  __XBRTIME_CONFIG->_MMAP       = malloc(sizeof(XBRTIME_MEM_T) * 
                                         _XBRTIME_MEM_SLOTS_);
  __XBRTIME_CONFIG->_ID         = threads[0].thread_id; 
                              // (uint64_t) pthread_self(); 
                              // __xbrtime_asm_get_id();
  __XBRTIME_CONFIG->_MEMSIZE    = 4096 * 4096;
                              // __xbrtime_asm_get_memsize();
  __XBRTIME_CONFIG->_NPES       = atoi(getenv("NUM_OF_THREADS"));
                              //__xbrtime_asm_get_npes();
  __XBRTIME_CONFIG->_START_ADDR = 0x00ull;    
                              // __xbrtime_asm_get_startaddr();
  __XBRTIME_CONFIG->_SENSE      = 0x00ull;    
                              // __xbrtime_asm_get_sense();
  __XBRTIME_CONFIG->_BARRIER 		= xb_barrier; 
                              // malloc(sizeof(uint64_t)*2*10);
	
  // MAX_PE_NUM = 1024, thus, MAX_Barrier buffer space = log2^1024 = 10
	for( i = 0; i < 10; i++){
  	__XBRTIME_CONFIG->_BARRIER[i] 		= 0xfffffffffull;
  	__XBRTIME_CONFIG->_BARRIER[10+i] 	= 0xaaaaaaaaaull;
	}

#ifdef XBGAS_DEBUG
	printf("[XBGAS_DEBUG] PE:%d----BARRIER[O] = 0x%lx\n", 
         __XBRTIME_CONFIG->_ID, __XBRTIME_CONFIG->_BARRIER[0]);
	printf("[XBGAS_DEBUG] PE:%d----BARRIER[1] = 0x%lx\n", 
         __XBRTIME_CONFIG->_ID, __XBRTIME_CONFIG->_BARRIER[1]);
#endif
  
  /* too many total PEs */
  if( __XBRTIME_CONFIG->_NPES > __XBRTIME_MAX_PE ){
    free( __XBRTIME_CONFIG );
    return -1;
  }

  /* init the pe mapping block */
  __XBRTIME_CONFIG->_MAP = malloc( sizeof( XBRTIME_PE_MAP ) *
                                   __XBRTIME_CONFIG->_NPES );
  if( __XBRTIME_CONFIG->_MAP == NULL ){
    free( __XBRTIME_CONFIG );
    return -1;
  }
#ifdef XBGAS_PRINT
  printf("[R] init the pe mapping block\n");
#endif

  /* init the memory allocation slots */
  for( i=0;i<_XBRTIME_MEM_SLOTS_; i++ ){
    __XBRTIME_CONFIG->_MMAP[i].start_addr = 0x00ull;
    __XBRTIME_CONFIG->_MMAP[i].size       = 0;
  }

#ifdef XBGAS_PRINT
  printf("[R] init the memory allocation slots\n");
#endif

  /* init the PE mapping structure */
  for( i=0; i<__XBRTIME_CONFIG->_NPES; i++ ){
    __XBRTIME_CONFIG->_MAP[i]._LOGICAL   = i;
    __XBRTIME_CONFIG->_MAP[i]._PHYSICAL  = i+1;
  }

#ifdef XBGAS_PRINT
  printf("[R] init the PE mapping structure\n");
#endif

  // int init = 1;                    // MERT - COMMENTED OUT
  // *((uint64_t *)INIT_ADDR) = init; // MERT - COMMENTED OUT
  return 0;
}

extern int xbrtime_mype(){
  if( __XBRTIME_CONFIG == NULL ){
    return -1;
  }
  return __XBRTIME_CONFIG->_ID;
}

extern int xbrtime_num_pes(){
  if( __XBRTIME_CONFIG == NULL ){
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
void __xbrtime_get_u8_seq(uint64_t* base_src, uint64_t* base_dest,//uint32_t pe,
                          uint32_t nelems, uint32_t stride );


// ----------------------------------------------------------- U8 GET FUNCTION
void xbrtime_ulonglong_get(unsigned long long *dest, 
                           const unsigned long long *src, 
                           size_t nelems, int stride, int pe){
#ifdef XBGAS_PRINT
  //printf("[R] Entered xbrtime_ulonglong_get()\n");
  fflush(stdout);
  fprintf(stdout, "[R] Thread: \t%lu\n", (uint64_t) pthread_self());  
  fprintf(stdout, "==================================xbrtime_ulonglong_get\n");
  fprintf(stdout, "DST:"
      // "address: %p\n"
          "\tbase  : %10lu"
          "\tlength: %10lu\n"
          "\toffset: %10lu"
          "\tperms : %10u"
          "\ttag   : %1d\n",
      // cheri_address_get(dest),
        cheri_base_get((void *) dest),
        cheri_length_get((void *) dest),
        cheri_offset_get((void *) dest),
        cheri_perms_get((void *) dest),
        (int) cheri_tag_get((void *) dest));
  fprintf(stdout, "=======================================================\n");
  fprintf(stdout, "SRC:"
      // "address: %p\n"
          "\tbase  : %10lu"
          "\tlength: %10lu\n"
          "\toffset: %10lu"
          "\tperms : %10u"
          "\ttag   : %1d\n",
      // cheri_address_get(dest),
        cheri_base_get((void *) src),
        cheri_length_get((void *) src),
        cheri_offset_get((void *) src),
        cheri_perms_get((void *) src),
        (int) cheri_tag_get((void *) src));
  fprintf(stdout, "=======================================================\n");
  fflush(stdout);
#endif

  if(nelems == 0){
    return;
  }else /*if( (stride != 1) || (nelems == 1))*/{
    /* sequential execution */
    //void* func_args = { (void*)src, (void*)dest, (void*)nelems,
    //                    (void*)(stride*sizeof(unsigned long long)) };
    //                  { (uint64_t*)src, (uint64_t*)(dest), (uint32_t)(nelems),
    //                    (uint32_t)(stride*sizeof(unsigned long long)) };
    // XXX: multiple arguments do not pass to work!
    //tpool_add_work(pool, __xbrtime_get_u8_seq, func_args);
    
    __xbrtime_get_u8_seq((uint64_t*)src,//__xbrtime_ltor((uint64_t)(src),pe),
                         (uint64_t*)(dest),
                         //xbrtime_decode_pe(pe),
                         (uint32_t)(nelems),
                         (uint32_t)(stride*sizeof(unsigned long long)));
  }
  __xbrtime_asm_fence();

#ifdef XBGAS_PRINT
  //printf("[M] Exiting \n");
#endif
}

// ----------------------------------------------------------- S8 GET FUNCTION
void xbrtime_longlong_get(long long *dest, 
                          const long long *src,
                          size_t nelems, int stride, int pe){
#ifdef XBGAS_PRINT
  //printf("[R] Entered xbrtime_ulonglong_get()\n");
  fflush(stdout);
  fprintf(stdout, "[R] Thread: \t%lu\n", (uint64_t) pthread_self());
  fprintf(stdout, "GET================================xbrtime_longlong_get\n");
  fprintf(stdout, "DST:"
      // "address: %p\n"
          "\tbase  : %10lu"
          "\tlength: %10lu\n"
          "\toffset: %10lu"
          "\tperms : %10u"
          "\ttag   : %1d\n",
      // cheri_address_get(dest),
        cheri_base_get((void *) dest),
        cheri_length_get((void *) dest),
        cheri_offset_get((void *) dest),
        cheri_perms_get((void *) dest),
        (int) cheri_tag_get((void *) dest));
  fprintf(stdout, "=======================================================\n");
  fprintf(stdout, "SRC:"
      // "address: %p\n"
          "\tbase  : %10lu"
          "\tlength: %10lu\n"
          "\toffset: %10lu"
          "\tperms : %10u"
          "\ttag   : %1d\n",
      // cheri_address_get(dest),
        cheri_base_get((void *) src),
        cheri_length_get((void *) src),
        cheri_offset_get((void *) src),
        cheri_perms_get((void *) src),
        (int) cheri_tag_get((void *) src));
  fprintf(stdout, "=======================================================\n");
  fflush(stdout);
#endif

  if(nelems == 0){
    return;
  }else/* if( (stride != 1) || (nelems == 1))*/{
    /* sequential execution */
    __xbrtime_get_s8_seq((uint64_t*)(src),//__xbrtime_ltor((uint64_t)(src),pe),
                         (uint64_t*)(dest),
                         //xbrtime_decode_pe(pe),
                         (uint32_t)(nelems),
                         (uint32_t)(stride*sizeof(long long)));
  }
  __xbrtime_asm_fence();
}

// ----------------------------------------------------------- S8 PUT FUNCTION
void xbrtime_longlong_put(long long *dest, 
                          const long long *src,
                          size_t nelems, int stride, int pe){
#ifdef XBGAS_PRINT
  //printf("[R] Entered xbrtime_ulonglong_get()\n");
  fflush(stdout);
  fprintf(stdout, "[R] Thread: \t%lu\n", (uint64_t) pthread_self());
  fprintf(stdout, "===================================xbrtime_longlong_put\n");
  fprintf(stdout, "DST:"
      // "address: %p\n"
          "\tbase  : %10lu"
          "\tlength: %10lu\n"
          "\toffset: %10lu"
          "\tperms : %10u"
          "\ttag   : %1d\n",
      // cheri_address_get(dest),
        cheri_base_get((void *) dest),
        cheri_length_get((void *) dest),
        cheri_offset_get((void *) dest),
        cheri_perms_get((void *) dest),
        (int) cheri_tag_get((void *) dest));
  fprintf(stdout, "=======================================================\n");
  fprintf(stdout, "SRC:"
      // "address: %p\n"
          "\tbase  : %10lu"
          "\tlength: %10lu\n"
          "\toffset: %10lu"
          "\tperms : %10u"
          "\ttag   : %1d\n",
      // cheri_address_get(dest),
        cheri_base_get((void *) src),
        cheri_length_get((void *) src),
        cheri_offset_get((void *) src),
        cheri_perms_get((void *) src),
        (int) cheri_tag_get((void *) src));
  fprintf(stdout, "=======================================================\n");
  fflush(stdout);
#endif

  if(nelems == 0){
    return;
  }else/* if( (stride != 1) || (nelems == 1))*/{
    /* sequential execution */
    __xbrtime_put_s8_seq((uint64_t*)(src),
                         (uint64_t*)(dest),//__xbrtime_ltor((uint64_t)(dest),pe),
                         //xbrtime_decode_pe(pe),
                         (uint32_t)(nelems),
                         (uint32_t)(stride*sizeof(long long)));
  }
  __xbrtime_asm_fence();
}

#ifdef EXPERIMENTAL_B
#define SENSE __XBRTIME_CONFIG->_SENSE

static pthread_mutex_t barrier_lock = PTHREAD_MUTEX_INITIALIZER;
static pthread_cond_t barrier_cond = PTHREAD_COND_INITIALIZER;
static int barrier_counter = 0;

extern void xbrtime_barrier() {
    int num_threads = xbrtime_num_pes(); // assumption: returns number of threads
    static volatile int sense = 1;  // local sense

    pthread_mutex_lock(&barrier_lock);

    barrier_counter++;  // Increase the counter as a thread reaches the barrier

    if (barrier_counter == num_threads) {  // If all threads have reached the barrier
        barrier_counter = 0; // Reset the counter
        sense = 1 - sense;  // Toggle the sense
        pthread_cond_broadcast(&barrier_cond);  // Wake up all waiting threads
    } else {
        while (SENSE != sense) {  // Wait until sense is toggled
            pthread_cond_wait(&barrier_cond, &barrier_lock);
        }
    }

    pthread_mutex_unlock(&barrier_lock);
}
#else
extern void xbrtime_barrier(){
#ifdef XBGAS_PRINT
  printf("[R] Entered xbrtime_barrier()\n");
#endif

  // TODO: Implement thread-aware barrier

  /* force a heavy fence */
  __xbrtime_asm_fence(); /* wait for all the PEs to reach the barrier */

#ifdef XBGAS_DEBUG
  printf( "[XBGAS_DEBUG] PE=%d; BARRIER COMPLETE\n", xbrtime_mype() );
#endif
#ifdef XBGAS_PRINT
  printf("[R] Exiting xbrtime_barrier()\n");
#endif
}
#endif

#ifdef __cplusplus
}
#endif  /* extern "C" */

#endif /* _XBRTIME_H_ */

/* EOF */
