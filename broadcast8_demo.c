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

 #include "xbrtime_morello.h"

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

	xbrtime_barrier();

	printf("Post-Broadcast - PE:%d B_Val: %d\n", my_pe, *b_val);

	xbrtime_close();

    return 0;
}
