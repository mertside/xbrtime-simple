/*
 * _BROADCAST_DEMO_C_
 *
 * Copyright (C) 2017-2019 Tactical Computing Laboratories, LLC
 * All Rights Reserved
 * contact@tactcomplabs.com
 *
 * This file is a part of the XBGAS-RUNTIME package.  For license
 * information, see the LICENSE file in the top level directory
 * of the distribution.
 *
 */

 #include "xbrtime.h"

int main()
{
  xbrtime_init();
	int my_pe, *b_val;
	my_pe = xbrtime_mype();
	b_val = (int*) xbrtime_malloc(sizeof(int));
	*b_val = my_pe;

  // int row = 0;
  // int col = 0;
  // int num_pes = xbrtime_num_pes();
  // row         = num_pes;
  // col         = ne;

	printf("Pre-Broadcast - PE:%d B_Val: %d\n", my_pe, *b_val);

	xbrtime_barrier();

	xbrtime_int_broadcast(b_val, b_val, 1, 1, 4);

  // for( i = 0; i < row; i++ ){
  //   for( j = 0; j < col; j++ ){
  //     // remote access
  //     void* func_args = { (unsigned long long *)(&(shared[i*col + j])),
  //                         (unsigned long long *)(&(shared[i*col + j])),
  //                         1, 1, 1};                                 

  //     //tpool_add_work(pool, xbrtime_ulonglong_get, func_args);
  //     bool check = false;
  //     check = tpool_add_work( threads[i].thread_queue, 
  //                             xbrtime_int_broadcast, 
  //                             func_args);
  //   }
  // }

	xbrtime_barrier();

	printf("Post-Broadcast - PE:%d B_Val: %d\n", my_pe, *b_val);

	xbrtime_close();

    return 0;
}
