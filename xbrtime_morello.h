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

#define XBGAS_DEBUG 1

#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include <pthread.h>                               // From xbgas-runtime-thread
#include <unistd.h>                                // From xbgas-runtime-thread
// #include "test.h"
/* ---------------------------------------- REQUIRED HEADERS */
#include "xbMrtime-types.h"
// #include "xbMrtime-api.h"
#include "xbMrtime-alloc.h"
// #include "xbrtime-version.h"
#include "xbMrtime-macros.h"
// #include "xbrtime-collectives.h"
// #include "xbrtime-atomics.h"
#include "threadpool.h"                            // From xbgas-runtime-thread
#include <cheri.h>
//#include <cheriintrin.h>

/* ------------------------------------------------------------------------- */
/* ========================================================================= */
/* ------------------------------------------------------------------------- */
/* ========================================================================= */

/* _XBRTIME_CTOR_C_ */

#define INIT_ADDR 0xBB00000000000000ull 
#define END_ADDR 0xAA00000000000000ull

#define MAX_NUM_OF_THREADS 16                      // From xbgas-runtime-thread

volatile uint64_t *xb_barrier;
volatile tpool_work_queue_t *pool;                 // From xbgas-runtime-thread

// ------------------------------------------------------------------- STRUCTS
//typedef struct args{
//  uint64_t thread_id;
//  volatile uint64_t trampoline_memory;
//} args;

//typedef enum {false, true} bool;

// ---------------------------------------------------------- GLOBAL VARIABLES
// Handles for each thread thread
//pthread_t thread_handles[MAX_NUM_OF_THREADS];

// Args struct for each thread
//args thread_args[MAX_NUM_OF_THREADS];

// Indicates whether threads are done
//volatile bool done = false;

/* ------------------------------------------------- FUNCTION PROTOTYPES */
// void __xbrtime_ctor_reg_reset();

/* ------------------------------------------------------------- CONSTRUCTOR */
__attribute__((constructor)) void __xbrtime_ctor(){
  printf("[M] Entered __xbrtime_ctor()\n");

  /* initialize the unnecessary registers */
  // __xbrtime_ctor_reg_reset();
	// As max PE = 1024, at most 10 rounds are needed in the synchronizatino  
  xb_barrier = malloc(sizeof(uint64_t)*2*10);	
  //printf("CTOR: Init\n");
	//int init = 0;
  //*((uint64_t *)INIT_ADDR) = init;
	//init = 0;	

  //  ...   ...   ...   ...   ...   ...   ...   ...   ...   ...   numOfThreads
  int i = 0;
  int numOfThreads = MAX_NUM_OF_THREADS;

  // Get number of threads from the environment
  char *str = getenv("NUM_OF_THREADS");
  // Is the environment variable set appropriately?
  if(str == NULL || atoi(str) <= 0 || atoi(str) > MAX_NUM_OF_THREADS){
    if(str == NULL) {
      // NOT found!
      fprintf(stderr, "\nNUM_OF_THREADS not set; set environment first!\n");
    } else {
      // NOT a reasonable number!
      fprintf(stderr, "\nNUM_OF_THREADS should be between %d and %d\n",
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
  fprintf(stdout, "[M] Number of threads: %d\n", numOfThreads);
  fflush(stdout);
#endif

  /*
  // initialize thread args
  for( i=0; i<numOfThreads; i++ ){
    thread_args[i].thread_id = i;
    thread_args[i].trampoline_memory = 0x00ull;
  }

#if XBGAS_DEBUG
  fprintf(stdout, "\nAddresses of trampolines: \n");
  for(i = 0; i< numOfThreads; i++){
    fprintf(stdout, "\tThread %lu: %p\t", thread_args[i].thread_id, 
           &(thread_args[i].trampoline_memory));
    if(i % 2 == 1) fprintf(stdout,"\n");
  }
  fprintf(stdout, "\nValues of trampolines: \n");
  for(i = 0; i< numOfThreads; i++){
    fprintf(stdout, "\tThread %lu: %p\t", thread_args[i].thread_id, 
           (void *) thread_args[i].trampoline_memory);
    if(i % 2 == 1) fprintf(stdout,"\n");
  }
  fprintf(stdout, "\n");
#endif
  
  fflush(stdout);
  */

  // ...   ...   ...   ...   ...   ...   ...   ...   ...   ...   ...   ...
  
  // Create a thread pool
  // tpool_work_queue_t *pool; // Redefined globally  
  pool = tpool_create(numOfThreads);

  // printf("CTOR: Init\n");
}

/* -------------------------------------------------------------- DESTRUCTOR */
__attribute__((destructor)) void __xbrtime_dtor(){
  printf("[M] Entered __xbrtime_dtor()\n");
  
  // Will return when there is no work
  tpool_wait((tpool_work_queue_t *) pool);

  // Discard pending, clean queue, order stop, wait, destroy
  tpool_destroy((tpool_work_queue_t *) pool); 

  // ...   ...   ...   ...   ...   ...   ...   ...   ...   ...   ...   ...

  /* free_barrier */
	uint64_t end = 0;
	// *((uint64_t *)END_ADDR) = end;
  free ((void*)xb_barrier); 	
  // printf("DTOR: Free\n");
}

/* ------------------------------------------------------------------------- */
/* ========================================================================= */
/* ------------------------------------------------------------------------- */
/* ========================================================================= */

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
  printf("[M] Entered xbrtime_init()\n");
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

  __XBRTIME_CONFIG->_MMAP       = malloc(sizeof(XBRTIME_MEM_T) * _XBRTIME_MEM_SLOTS_);
  __XBRTIME_CONFIG->_ID         = pool->threads[0].thread_id; 
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
  printf("[M] init the pe mapping block\n");

  /* init the memory allocation slots */
  for( i=0;i<_XBRTIME_MEM_SLOTS_; i++ ){
    __XBRTIME_CONFIG->_MMAP[i].start_addr = 0x00ull;
    __XBRTIME_CONFIG->_MMAP[i].size       = 0;
  }
  printf("[M] init the memory allocation slots\n");

  /* init the PE mapping structure */
  for( i=0; i<__XBRTIME_CONFIG->_NPES; i++ ){
    __XBRTIME_CONFIG->_MAP[i]._LOGICAL   = i;
    __XBRTIME_CONFIG->_MAP[i]._PHYSICAL  = i+1;
  }
  printf("[M] init the PE mapping structure\n");

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
  //printf("[M] Entered xbrtime_ulonglong_get()\n");

  printf("================================================================\n");
  printf("  DEST:\n"
      // "address: %p\n"
          "\tbase  : %lu\n"
          "\tlength: %lu\t"
          "\toffset: %lu\n"
          "\tperms : %u\t"
          "\ttag   : %d\n",
      // cheri_address_get(dest),
        cheri_base_get((void *) dest),
        cheri_length_get((void *) dest),
        cheri_offset_get((void *) dest),
        cheri_perms_get((void *) dest),
        (int) cheri_tag_get((void *) dest));
  printf("================================================================\n");
  printf("  SRC:\n"
      // "address: %p\n"
          "\tbase  : %lu\n"
          "\tlength: %lu\t"
          "\toffset: %lu\n"
          "\tperms : %u\t"
          "\ttag   : %d\n",
      // cheri_address_get(dest),
        cheri_base_get((void *) src),
        cheri_length_get((void *) src),
        cheri_offset_get((void *) src),
        cheri_perms_get((void *) src),
        (int) cheri_tag_get((void *) src));
  printf("================================================================\n");

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


  //printf("[M] Exiting \n");
}

/* ------------------------------------------------------------------------- */
/* ========================================================================= */
/* ------------------------------------------------------------------------- */
/* ========================================================================= */

extern void xbrtime_barrier(){
  printf("[M] Entered xbrtime_barrier()\n");

  // MERT – skip the following code due to unimplemented SENSE

  // /* local variables */
	// int64_t 	i 							= 0; 
	// int64_t		stride 					= 1;
  // volatile 	uint64_t sense 	= SENSE;
  // uint64_t 	target 					= 0x00ull;
  // uint64_t 	addr 						= 0x00ull;
	// int64_t	 	num_pe 					= xbrtime_num_pes();
	
  // /* sanity check */
  // if( num_pe == 1 ){
  //   return ;
  // }
	
	// /*Get the total iterations */
	// int64_t  mype   = xbrtime_mype();
	// int64_t	 iter   = (int64_t)(log(num_pe)/log(2));
	// if (iter < log(num_pe)/log(2))
	// 	iter++;

  /* force a heavy fence */
  __xbrtime_asm_fence(); /* wait for all the PEs to reach the barrier */

  // MERT – skip the following code due to unimplemented functions
// #ifdef XBGAS_DEBUG
// 	printf("XBGAS_DEBUG:: PE = %d, sense = %ld, complete __xbrtime_asm_fence()\n",xbrtime_mype(), sense);
// #endif
// 	while(i < iter){
//   	/* derive the correct target pe */
// 		target 	= (mype + stride)%num_pe; 
// #ifdef XBGAS_DEBUG
//   	printf( "XBGAS_DEBUG : PE=%d; BARRIER TARGET=%d\n", xbrtime_mype(),
//           (int)(target) );
// #endif
//   	target 	= (uint64_t)(xbrtime_decode_pe((int)(target)));
//   	addr 		= (uint64_t)(&__XBRTIME_CONFIG->_BARRIER[sense*10+i]);
// #ifdef XBGAS_DEBUG
//   	printf( "XBGAS_DEBUG : PE=%d; TOUCHING REMOTE ADDRESS ON PHYSICAL TARGET=%d\n",
//           xbrtime_mype(),
//           (int)(target) );
// #endif
//   	__xbrtime_remote_touch( addr, target, stride);	
// #ifdef XBGAS_DEBUG
// 		printf("\033[1m\033[32m XBGAS_DEBUG:: PE = %d, complete remote touch, sense = %ld, addr = 0x%lx, __XBRTIME_CONFIG->_BARRIER[sense]=%lx \033[0m \n",xbrtime_mype(), sense, addr,  __XBRTIME_CONFIG->_BARRIER[sense]);
//   	printf( "XBGAS_DEBUG : PE=%d; SUCCESS TOUCHING REMOTE ADDRESS\n", xbrtime_mype() );
// #endif


//   	/* spinwait on local value */
//  		while( __XBRTIME_CONFIG->_BARRIER[SENSE*10+i] != stride ){
// #ifdef XBGAS_DEBUG
// 			printf("XBGAS_DEBUG:: PE = %d, sense = %ld, local barrier var = 0x%lx\n",xbrtime_mype(), sense, __XBRTIME_CONFIG->_BARRIER[SENSE]);
// #endif
// 		}


// 		stride *= 2;
// 		i++;

// 	}

  //__xbrtime_asm_quiet_fence();

  //tmp = __sync_add_and_fetch(&__XBRTIME_CONFIG->_BARRIER[sense],0);
  //__sync_fetch_and_add(&__XBRTIME_CONFIG->_BARRIER[SENSE],0);

  /* spinwait on local value */
#if 0
  tmp = __XBRTIME_CONFIG->_BARRIER;
  while( tmp != sense ){
    tmp = __XBRTIME_CONFIG->_BARRIER;
  }
#endif

  // /* switch the sense */
	// for (i = 0; i < iter; i++)
  // 	__XBRTIME_CONFIG->_BARRIER[SENSE*10+i] = 0xdeadbeefull;
	// // Flip the Sense
  // SENSE = 1 - SENSE;

#ifdef XBGAS_DEBUG
  printf( "[XBGAS_DEBUG] PE=%d; BARRIER COMPLETE\n", xbrtime_mype() );
#endif
  printf("[M] Exiting xbrtime_barrier()\n");
}

/* ------------------------------------------------------------------------- */
/* ========================================================================= */
/* ------------------------------------------------------------------------- */
/* ========================================================================= */

#ifdef __cplusplus
}
#endif  /* extern "C" */

#endif /* _XBRTIME_H_ */

/* EOF */
