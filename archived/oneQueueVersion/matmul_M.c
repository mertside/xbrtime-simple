/* _xBGAS_matmul.c__
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

#include <stdio.h>
#include <inttypes.h>
#include "xbrtime_morello.h"
#include "test.h"

#define _XBGAS_ALLOC_SIZE_ 8
//#define _XBGAS_ALLOC_NELEMS_ 4

int main( int argc, char **argv ){
	printf("[M]"GRN " Entered Main matmul...\n"RESET);

	/* vars */
  int 			rtn 			= 0;
  size_t 		sz 				= _XBGAS_ALLOC_SIZE_;
  size_t 		ne 				= _XBGAS_ALLOC_NELEMS_;
  uint64_t 	i   			= 0;
  uint64_t 	*private  = NULL;
	uint64_t 	*shared  	= NULL;
	/* statistic gathering var */
	double 		t_mem	  	= 0;
	double 		t_start  	= 0;
	double 		t_end  		= 0;

  /*
  unsigned long long x = 11;
  unsigned long long y = 22;
  printf("=================================================================\n");
  printf("  X:\n"
      //  "address: %p\n"
         "\tbase  : %p\n"
         "\tlength: %lu\t"
         "\toffset: %lu\n"
         "\tperms : %lu\t"
         "\ttag   : %lu\n",
      // cheri_address_get(dest),
        cheri_base_get(&x),
        cheri_length_get(&x),
        cheri_offset_get(&x),
        cheri_perms_get(&x),
        cheri_tag_get(&x));
  printf("=================================================================\n");
  printf("  Y:\n"
      // "address: %p\n"
          "\tbase  : %p\n"
          "\tlength: %lu\t"
          "\toffset: %lu\n"
          "\tperms : %lu\t"
          "\ttag   : %lu\n",
      // cheri_address_get(dest),
        cheri_base_get(&y),
        cheri_length_get(&y),
        cheri_offset_get(&y),
        cheri_perms_get(&y),
        cheri_tag_get(&y));
  printf("=================================================================\n");
  */

	printf("[M]"GRN " Passed vars\n"RESET);

	/* init */
	private = malloc( sizeof( uint64_t ) * ne );
	printf("[M]"GRN " Passed malloc\n"RESET);

  rtn = xbrtime_init();
	printf("[M]"GRN " Passed xbrtime_init()\n"RESET); 

  shared = (uint64_t *)(xbrtime_malloc( sz*ne ));
	printf("[M]"GRN " Passed xbrtime_malloc()\n"RESET); 

#ifdef DEBUG
  printf( "PE=%d; *SHARED = 0x%"PRIu64"\n", xbrtime_mype(), (uint64_t)(shared) );
#endif
 	for( i = 0; i< ne; i++ ){
		shared[i] 	= (uint64_t)(i + xbrtime_mype());
		private[i] 	= 1;
	}

	printf("[M]"GRN " Passed shared[] & private[] init\n"RESET);

  /* perform a barrier */
#ifdef DEBUG
  printf( "PE=%d; EXECUTING BARRIER\n", xbrtime_mype() );
#endif
  xbrtime_barrier();

	if(xbrtime_mype() == 0){
		printf("========================\n");
		printf(" xBGAS Matmul Benchmark\n");
		printf("========================\n");
		printf(" Data type: uint64_t\n");
		printf(" Element #: %lu\n", ne);
  	printf(" Data size: %lu bytes\n",  (uint64_t)(sz) * (uint64_t)(ne) );
		printf(" PE #     : %d\n", xbrtime_num_pes());
    printf("========================\n");

		t_start = mysecond();
	}

  /* fetch via loop */
  if(xbrtime_mype() == 0){
    //xbrtime_ulonglong_get(&x,&y,1,1,1);
    for(i = 0; i < ne; i++){
      // remote access
      void* func_args = {(unsigned long long *)(&(shared[i])),
                         (unsigned long long *)(&(shared[i])),
                         1, 1, 1};                                 

      tpool_add_work(pool, xbrtime_ulonglong_get, func_args);

      /*
      xbrtime_ulonglong_get((unsigned long long *)(&(shared[i])), // dest
                            (unsigned long long *)(&(shared[i])), // src
                            1,                                    // ne
                            1,                                    // stride
                            1);                                   // pe
      */
      // shared[i] = i;
      printf("[M] "BYEL"Completed iter: %lu\n"RESET, i+1);
    }
    printf("[M] "BGRN"Passed xbrtime_ulonglong_get()\n"RESET);
  }

  /* perform a barrier */
#ifdef DEBUG
  printf( "PE=%d; EXECUTING BARRIER\n", xbrtime_mype() );
#endif
  xbrtime_barrier();

	if(xbrtime_mype() == 0){
		t_end = mysecond();
		t_mem = t_end - t_start;
		printf("--------------------------------------------\n");
		printf("Time cost"BRED	" (raw transactions):       %f\n"RESET, t_mem);
		printf("--------------------------------------------\n");
		t_start = mysecond();
	}

 	// if(xbrtime_mype() == 0){
	// 	// remote access
  //   xbrtime_ulonglong_get((unsigned long long *)(&(shared[0])), // dest
  //                         (unsigned long long *)(&(shared[0])), // src
  //                         ne,																	 // ne
  //                         1,																		 // stride
  //                         1);									 								 // pe
	// }

  xbrtime_barrier();

	if(xbrtime_mype() == 0){
		t_end = mysecond();
		t_mem = t_end - t_start;
		// printf("Time cost"BGRN " (coalesced transactions): %f\n"RESET, t_mem);
		printf("--------------------------------------------\n");
		t_start = mysecond();
	}

	for( i = 0; i < ne; i ++)
		private[i] *= shared[i];                           // matrix multiplication

	if(xbrtime_mype() == 0){
		t_end = mysecond();
		t_mem = t_end - t_start;
		printf("Time cost"BMAG " (matrix multiplication):  %f\n"RESET, t_mem);
		printf("--------------------------------------------\n");
	}

	free(private);
  xbrtime_free( shared );
  xbrtime_close();

#ifdef DEBUG
  printf( "xBGAS is Closed\n" );
#endif

	printf("[M]"GRN " Returning Main matmul...\n"RESET);
  return rtn;
}

/* EOF */
