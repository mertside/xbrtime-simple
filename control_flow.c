/*
 * control_flow.c
 * 
 * control-flow-pointer_buffer-overflow-fnptr.c
 * a simple example of a control flow pointer buffer overflow
 * 
 * SPDX-License-Identifier: BSD-2-Clause-DARPA-SSITH-ECATS-HR0011-18-C-0016
 * Copyright (c) 2020 SRI International
 * 
 * Adaptated by Mert Side for TTU
 * 
 */
#include <stdio.h>
#include <inttypes.h>
#include "xbrtime_morello.h"
#include "test.h"

struct buf {
	size_t length;
	int buffer[30];
	size_t (*callback)(struct buf *);
};

void
fill_buf(struct buf *bp)
{
	bp->length = sizeof(bp->buffer)/sizeof(*bp->buffer);
	for (size_t i = 0; i <= bp->length; i++)
		bp->buffer[i] = 0xAAAAAAAA;
}

size_t
count_screams(struct buf *bp)
{
	int screams = 0;

	for (size_t i = 0; i < bp->length; i++)
		screams += bp->buffer[i] == 0xAAAAAAAA ? 1 : 0;
	return screams;
}

struct buf b = {.callback = count_screams};

int
main(void)
{
  int num_pes = xbrtime_num_pes();

  for( int i = 0; i < num_pes; i++ ){
    bool check = false;
    check = tpool_add_work( threads[i].thread_queue, 
                            fill_buf, 
                            &b);
    // fill_buf(&b);

    printf("Words of screaming in b.buffer %zu\n", b.callback(&b));
  }

	return 0;
}

// #include "asserts.inc"
