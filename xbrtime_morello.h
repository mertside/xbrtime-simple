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

#include <stdlib.h>
#include <stdio.h>
#include <math.h>

/* ---------------------------------------- REQUIRED HEADERS */
#include "xbMrtime-types.h"
// #include "xbMrtime-api.h"
#include "xbMrtime-alloc.h"
// #include "xbrtime-version.h"
#include "xbMrtime-macros.h"
// #include "xbrtime-collectives.h"
// #include "xbrtime-atomics.h"

/* ------------------------------------------------------------------------- */
/* ========================================================================= */
/* ------------------------------------------------------------------------- */
/* ========================================================================= */

//#define INIT_ADDR 0xBB00000000000000ull
#define END_ADDR 0xAA00000000000000ull

volatile uint64_t *barrier;


/* ------------------------------------------------- FUNCTION PROTOTYPES */
// void __xbrtime_ctor_reg_reset();

__attribute__((constructor)) void __xbrtime_ctor(){
  /* initialize the unnecessary registers */
  __xbrtime_ctor_reg_reset();
	// As max PE = 1024, at most 10 rounds are needed in the synchronizatino  
  barrier = malloc(sizeof(uint64_t)*2*10);	
  // printf("CTOR: Init\n");
}
__attribute__((destructor)) void __xbrtime_dtor(){
  /* free_barrier */
	uint64_t end = 0;
	*((uint64_t *)END_ADDR) = end;
  free ((void*)barrier); 	
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
extern int xbrtime_init();

/*!   \fn void xbrtime_close()
      \brief Closes the XBGAS Runtime environment
      \return void
*/
extern void xbrtime_close();

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
#define INIT_ADDR 0xBB00000000000000ull

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

  /* vars */
  int i = 0;

  /* allocate the structure in the local heap */
  __XBRTIME_CONFIG = NULL;
  __XBRTIME_CONFIG = malloc( sizeof( XBRTIME_DATA ) );
  if( __XBRTIME_CONFIG == NULL ){
    return -1;
  }

  __XBRTIME_CONFIG->_MMAP       = malloc(sizeof(XBRTIME_MEM_T) * _XBRTIME_MEM_SLOTS_);
  __XBRTIME_CONFIG->_ID         = 0;              // __xbrtime_asm_get_id();
  __XBRTIME_CONFIG->_MEMSIZE    = 4096 * 4096;    // __xbrtime_asm_get_memsize();
  __XBRTIME_CONFIG->_NPES       = 8;              // __xbrtime_asm_get_npes();
  __XBRTIME_CONFIG->_START_ADDR = 0x00ull;        // __xbrtime_asm_get_startaddr();
  __XBRTIME_CONFIG->_SENSE      = 0x00ull;
  __XBRTIME_CONFIG->_BARRIER 		= barrier;
	// MAX_PE_NUM = 1024, thus, MAX_Barrier buffer space = log2^1024 = 10
	for( i = 0; i < 10; i++){
  	__XBRTIME_CONFIG->_BARRIER[i] 		= 0xfffffffffull;
  	__XBRTIME_CONFIG->_BARRIER[10+i] 	= 0xaaaaaaaaaull;
	}
#ifdef XBGAS_DEBUG
	printf("PE:%d----BARRIER[O] = 0x%lx\n", __XBRTIME_CONFIG->_ID, __XBRTIME_CONFIG->_BARRIER[0]);
	printf("PE:%d----BARRIER[1] = 0x%lx\n", __XBRTIME_CONFIG->_ID, __XBRTIME_CONFIG->_BARRIER[1]);
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

  /* init the memory allocation slots */
  for( i=0;i<_XBRTIME_MEM_SLOTS_; i++ ){
    __XBRTIME_CONFIG->_MMAP[i].start_addr = 0x00ull;
    __XBRTIME_CONFIG->_MMAP[i].size       = 0;
  }

  /* init the PE mapping structure */
  for( i=0; i<__XBRTIME_CONFIG->_NPES; i++ ){
    __XBRTIME_CONFIG->_MAP[i]._LOGICAL   = i;
    __XBRTIME_CONFIG->_MAP[i]._PHYSICAL  = i+1;
  }


  int init = 1;
  *((uint64_t *)INIT_ADDR) = init;
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
void __xbrtime_get_u8_seq( uint64_t base_src, uint64_t base_dest,//uint32_t pe,
                           uint32_t nelems, uint32_t stride );


// ----------------------------------------------------------- U8 GET FUNCTION
void xbrtime_ulonglong_get(unsigned long long *dest, 
                           const unsigned long long *src, 
                           size_t nelems, int stride, int pe){
  if(nelems == 0){
    return;
  }else /*if( (stride != 1) || (nelems == 1))*/{
    /* sequential execution */
    __xbrtime_get_u8_seq(src,//__xbrtime_ltor((uint64_t)(src),pe),
                         (uint64_t)(dest),
                         //xbrtime_decode_pe(pe),
                         (uint32_t)(nelems),
                         (uint32_t)(stride*sizeof(unsigned long long)));
  }
  __xbrtime_asm_fence();
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
