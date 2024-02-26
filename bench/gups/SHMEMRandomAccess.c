/* -*- mode: C; tab-width: 2; indent-tabs-mode: nil; -*- */

/*
 * This code has been contributed by the DARPA HPCS program.  Contact
 * David Koester <dkoester@mitre.org> or Bob Lucas <rflucas@isi.edu>
 * if you have questions.
 *
 *
 * GUPS (Giga UPdates per Second) is a measurement that profiles the memory
 * architecture of a system and is a measure of performance similar to MFLOPS.
 * The HPCS HPCchallenge RandomAccess benchmark is intended to exercise the
 * GUPS capability of a system, much like the LINPACK benchmark is intended to
 * exercise the MFLOPS capability of a computer.  In each case, we would
 * expect these benchmarks to achieve close to the "peak" capability of the
 * memory system. The extent of the similarities between RandomAccess and
 * LINPACK are limited to both benchmarks attempting to calculate a peak system
 * capability.
 *
 * GUPS is calculated by identifying the number of memory locations that can be
 * randomly updated in one second, divided by 1 billion (1e9). The term "randomly"
 * means that there is little relationship between one address to be updated and
 * the next, except that they occur in the space of one half the total system
 * memory.  An update is a read-modify-write operation on a table of 64-bit words.
 * An address is generated, the value at that address read from memory, modified
 * by an integer operation (add, and, or, xor) with a literal value, and that
 * new value is written back to memory.
 *
 * We are interested in knowing the GUPS performance of both entire systems and
 * system subcomponents --- e.g., the GUPS rating of a distributed memory
 * multiprocessor the GUPS rating of an SMP node, and the GUPS rating of a
 * single processor.  While there is typically a scaling of FLOPS with processor
 * count, a similar phenomenon may not always occur for GUPS.
 *
 *
 */

#define MAXTHREADS 256
#include "xbrtime.h"
#include <hpcc.h>
#include <stdio.h>
#include "RandomAccess.h"

void
do_abort(char* f)
{
  fprintf(stderr, "%s\n", f);
}

u64Int srcBuf[] = {
  0xb1ffd1da
};
u64Int targetBuf[sizeof(srcBuf) / sizeof(u64Int)];

/* Allocate main table (in global memory) */
u64Int *HPCC_Table;

int main(int argc, char **argv)
{
  int debug = 0;

  s64Int i;
  int NumProcs, logNumProcs, MyProc;
  u64Int GlobalStartMyProc;
  u64Int Top;               /* Number of table entries in top of Table */
  s64Int LocalTableSize;    /* Local table width */
  u64Int MinLocalTableSize; /* Integer ratio TableSize/NumProcs */
  u64Int logTableSize, TableSize;

  double CPUTime;               /* CPU  time to update table */
  double RealTime;              /* Real time to update table */

  double TotalMem;
  int PowerofTwo;

  double timeBound = -1;  /* OPTIONAL time bound for execution time */
  u64Int NumUpdates_Default; /* Number of updates to table (suggested: 4x number of table entries) */
  u64Int NumUpdates;  /* actual number of updates to table - may be smaller than
                       * NumUpdates_Default due to execution time bounds */
  s64Int ProcNumUpdates; /* number of updates per processor */
  s64Int *NumErrors, *GlbNumErrors;
#ifdef RA_TIME_BOUND
  s64Int GlbNumUpdates;  /* for reduction */
#endif

  long *llpSync;
  long long *llpWrk;

  long *ipSync;
  int *ipWrk;

  FILE *outFile = NULL;
  double *GUPs;
  double *temp_GUPs;


  int numthreads;
  int *sAbort, *rAbort;

  xbrtime_init();

  /*Allocate symmetric memory*/
  sAbort = (int *)xbrtime_malloc(sizeof(int));
  rAbort = (int *)xbrtime_malloc(sizeof(int));
  GUPs = (double *)xbrtime_malloc(sizeof(double));
  temp_GUPs = (double *)xbrtime_malloc(sizeof(double));
  GlbNumErrors = (s64Int *)xbrtime_malloc(sizeof(s64Int));
  NumErrors = (s64Int *)xbrtime_malloc(sizeof(s64Int));

  *GlbNumErrors = 0;
  *NumErrors = 0;
  *GUPs = -1;

  NumProcs = xbrtime_num_pes();
  MyProc = xbrtime_mype();

  if (0 == MyProc) {
    outFile = stdout;
    setbuf(outFile, NULL);
  }

  TotalMem = 20000000; /* max single node memory */
  TotalMem *= NumProcs;             /* max memory in NumProcs nodes */

  TotalMem /= sizeof(u64Int);

  /* calculate TableSize --- the size of update array (must be a power of 2) */
  for (TotalMem *= 0.5, logTableSize = 0, TableSize = 1;
       TotalMem >= 1.0;
       TotalMem *= 0.5, logTableSize++, TableSize <<= 1)
    ; /* EMPTY */


  MinLocalTableSize = (TableSize / NumProcs);
  LocalTableSize = MinLocalTableSize;
  GlobalStartMyProc = (MinLocalTableSize * MyProc);

  *sAbort = 0;

  /*Shmalloc HPCC_Table for RMA*/
  HPCC_Table = (u64Int *)xbrtime_malloc( sizeof(u64Int)*LocalTableSize );
  if (! HPCC_Table) *sAbort = 1;

  xbrtime_int_reduce_sum(rAbort, sAbort, 1, 1, 0);
  xbrtime_int_broadcast(rAbort, rAbort, 1, 1, 0);

  if (*rAbort > 0) {
    if (MyProc == 0) fprintf(outFile, "Failed to allocate memory for the main table.\n");
    /* check all allocations in case there are new added and their order changes */
    if (HPCC_Table) HPCC_free( HPCC_Table );
    goto failed_table;
  }

  /* Default number of global updates to table: 4x number of table entries */
  NumUpdates_Default = 4 * TableSize;
  ProcNumUpdates = 4*LocalTableSize;
  NumUpdates = NumUpdates_Default;

  if (MyProc == 0) {
    fprintf( outFile, "Running on %d processors%s\n", NumProcs, PowerofTwo ? " (PowerofTwo)" : "");
    fprintf( outFile, "Total Main table size = 2^" FSTR64 " = " FSTR64 " words\n",logTableSize, TableSize );
    if (PowerofTwo)
        fprintf( outFile, "PE Main table size = 2^" FSTR64 " = " FSTR64 " words/PE\n",
                 (logTableSize - logNumProcs), TableSize/NumProcs );
      else
        fprintf( outFile, "PE Main table size = (2^" FSTR64 ")/%d  = " FSTR64 " words/PE MAX\n",
                 logTableSize, NumProcs, LocalTableSize);

    fprintf( outFile, "Default number of updates (RECOMMENDED) = " FSTR64 "\tand actually done = %d\n", NumUpdates_Default,ProcNumUpdates*NumProcs);
  }

  /* Initialize main table */
  for (i=0; i<LocalTableSize; i++)
    HPCC_Table[i] = MyProc;

  xbrtime_barrier();

  int j,k;
  int logTableLocal,ipartner,iterate,niterate;
  int ndata,nkeep,nsend,nrecv,index,nlocalm1;
  int numthrds;
  u64Int datum,procmask;
  u64Int *data,*send;
  void * tstatus;
  int remote_proc, offset;
  u64Int *tb;
  s64Int remotecount;
  int thisPeId;
  int numNodes;
  int count2;

  s64Int *count;
  s64Int *updates;
  s64Int *all_updates;
  s64Int *ran;

  thisPeId = xbrtime_mype();
  numNodes = xbrtime_num_pes();

  count = (s64Int *) xbrtime_malloc(sizeof(s64Int));
  ran = (s64Int *) xbrtime_malloc(sizeof(s64Int));
  updates = (s64Int *) xbrtime_malloc(sizeof(s64Int) * numNodes); /* An array of length npes to avoid overwrites*/
  all_updates = (s64Int *) xbrtime_malloc(sizeof(s64Int) * numNodes); /*: An array to collect sum*/

  *ran = starts(4*GlobalStartMyProc);

  niterate = ProcNumUpdates;
  logTableLocal = logTableSize - logNumProcs;
  nlocalm1 = LocalTableSize - 1;


  for (j = 0; j < numNodes; j++){
    updates[j] = 0;
    all_updates[j] = 0;
  }
  int verify=1;
  u64Int remote_val;

  xbrtime_barrier();

  /* Begin timed section */
  RealTime = -RTSEC();
  for (iterate = 0; iterate < niterate; iterate++) {
      *ran = (*ran << 1) ^ ((s64Int) *ran < ZERO64B ? POLY : ZERO64B);
      remote_proc = (*ran >> logTableLocal) & (numNodes - 1);

      /*Forces updates to remote PE only*/
      if(remote_proc == MyProc)
        remote_proc = (remote_proc+1)/numNodes;

      xbrtime_longlong_get(&remote_val, &HPCC_Table[*ran & (LocalTableSize-1)], 1, 0, remote_proc);
      remote_val ^= *ran;

      xbrtime_longlong_put(&HPCC_Table[*ran & (LocalTableSize-1)], &remote_val, 1, 0, remote_proc);

      xbrtime_barrier();

      if(verify)
        xbrtime_longlong_atomic_add(&updates[thisPeId], 1, remote_proc);
  }

  xbrtime_barrier();

  /* End timed section */
  RealTime += RTSEC();

  /* Print timing results */
  if (MyProc == 0){
    *GUPs = 1e-9*NumUpdates / RealTime;
    fprintf( outFile, "Real time used = %.6f seconds\n", RealTime );
    fprintf( outFile, "%.9f Billion(10^9) Updates    per second [GUP/s]\n",
             *GUPs );
    fprintf( outFile, "%.9f Billion(10^9) Updates/PE per second [GUP/s]\n",
             *GUPs / NumProcs );
  }

  if(verify){

    s64Int pe_updates = 0;
    for (j = 0; j < numNodes; j++)
      pe_updates += updates[j];
    printf("PE%d updates:%d\n",MyProc,updates[0]);

    xbrtime_longlong_reduce_sum(all_updates, updates, NumProcs, 1, 0);
    xbrtime_longlong_broadcast(all_updates, all_updates, NumProcs, 1, 0);

    if(MyProc == 0){
      for (j = 1; j < numNodes; j++)
        all_updates[0] += all_updates[j];
      if(ProcNumUpdates*NumProcs == all_updates[0])
        printf("Verification passed!\n");
      else
        printf("Verification failed!\n");
    }
  }
  xbrtime_barrier();

  /* End verification phase */


  xbrtime_free(count);
  xbrtime_free(updates);
  xbrtime_free(ran);
  xbrtime_barrier();

  /* Deallocate memory (in reverse order of allocation which should
 *      help fragmentation) */

  xbrtime_free( HPCC_Table );
  failed_table:

  if (0 == MyProc) if (outFile != stderr) fclose( outFile );

  xbrtime_barrier();

  xbrtime_free(sAbort);
  xbrtime_free(rAbort);

  xbrtime_barrier();

  xbrtime_close();

  return 0;
}

/* Utility routine to start random number generator at Nth step */
s64Int
starts(u64Int n)
{
  /* s64Int i, j; */
  int i, j;
  u64Int m2[64];
  u64Int temp, ran;

  while (n < 0)
    n += PERIOD;
  while (n > PERIOD)
    n -= PERIOD;
  if (n == 0)
    return 0x1;

  temp = 0x1;
  for (i=0; i<64; i++)
    {
      m2[i] = temp;
      temp = (temp << 1) ^ ((s64Int) temp < 0 ? POLY : 0);
      temp = (temp << 1) ^ ((s64Int) temp < 0 ? POLY : 0);
    }

  for (i=62; i>=0; i--)
    if ((n >> i) & 1)
      break;

  ran = 0x2;

  while (i > 0)
    {
      temp = 0;
      for (j=0; j<64; j++)
        if ((ran >> j) & 1)
          temp ^= m2[j];
      ran = temp;
      i -= 1;
      if ((n >> i) & 1)
        ran = (ran << 1) ^ ((s64Int) ran < 0 ? POLY : 0);
    }

  return ran;
}
